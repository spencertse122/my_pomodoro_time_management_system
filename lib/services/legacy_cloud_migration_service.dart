import 'package:uuid/uuid.dart';

import '../data/local/app_database.dart';
import '../domain/models.dart';
import 'firestore_rest_client.dart';

class LegacyMigrationPreview {
  const LegacyMigrationPreview({
    required this.sessionCount,
    required this.hasPomodoroSettings,
    required this.state,
  });

  final int sessionCount;
  final bool hasPomodoroSettings;
  final LegacyMigrationState state;

  bool get hasCloudData => sessionCount > 0 || hasPomodoroSettings;
}

class LegacyCloudMigrationService {
  LegacyCloudMigrationService(this._database, this._firestore, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final AppDatabase _database;
  final FirestoreRestClient _firestore;
  final Uuid _uuid;

  String _sessionsPath(String userId) => 'users/$userId/sessions';
  String _settingsPath(String userId) => 'users/$userId/settings/pomodoro';

  Future<LegacyMigrationPreview> preview(String userId) async {
    final sessions = await _firestore.listDocuments(_sessionsPath(userId));
    final settings = await _firestore.getDocument(_settingsPath(userId));
    return LegacyMigrationPreview(
      sessionCount: sessions.length,
      hasPomodoroSettings: settings != null,
      state: await _database.legacyMigrationState(userId),
    );
  }

  /// Imports legacy cloud data, deletes it from Firestore, and verifies that
  /// the two legacy locations are empty. This is the only v2 workflow that
  /// talks to Firestore, and it never writes data to Firestore.
  Future<LegacyMigrationState> importAndPurge({
    required String userId,
    required bool confirmedPrimaryDevice,
    required bool confirmedPermanentPurge,
  }) async {
    if (!confirmedPrimaryDevice || !confirmedPermanentPurge) {
      throw ArgumentError(
        'Primary-device and permanent-purge confirmations are required.',
      );
    }
    var state = (await _database.legacyMigrationState(
      userId,
    )).copyWith(state: 'importing', clearError: true);
    await _database.saveLegacyMigrationState(state);

    try {
      final remoteSessions = await _firestore.listDocuments(
        _sessionsPath(userId),
      );
      final remoteSettings = await _firestore.getDocument(
        _settingsPath(userId),
      );
      var imported = 0;
      await _database.transaction(() async {
        for (final document in remoteSessions) {
          final storageId = await _availableStorageId(userId, document.id);
          final session = _sessionFromDocument(
            document,
            userId,
            storageId: storageId,
          );
          if (session == null) continue;
          if (session.isDeleted) {
            await _database.hardDeleteSessionForUser(userId, session.id);
            continue;
          }
          final local = await _database.sessionByIdForUser(userId, session.id);
          if (local == null || !local.updatedAt.isAfter(session.updatedAt)) {
            await _database.upsertSession(session.copyWith(isDirty: false));
            imported++;
          }
        }
        final data = remoteSettings?.fields;
        if (data != null) {
          await _database.saveSettings(
            userId,
            PomodoroSettings(
              focusMinutes: _boundedInt(data['focusMinutes'], 25, 1, 180),
              shortBreakMinutes: _boundedInt(
                data['shortBreakMinutes'],
                5,
                1,
                180,
              ),
              longBreakMinutes: _boundedInt(
                data['longBreakMinutes'],
                15,
                1,
                180,
              ),
              longBreakInterval: _boundedInt(
                data['longBreakInterval'],
                4,
                2,
                12,
              ),
              soundEnabled: data['soundEnabled'] as bool? ?? true,
            ),
          );
        }
      });

      state = state.copyWith(
        state: 'purging',
        importedSessionCount: state.importedSessionCount + imported,
      );
      await _database.saveLegacyMigrationState(state);
      await _purgeAndVerify(
        userId,
        sessions: remoteSessions,
        settings: remoteSettings,
      );
      state = state.copyWith(
        state: 'complete',
        cloudVerifiedEmpty: true,
        clearError: true,
      );
      await _database.saveLegacyMigrationState(state);
      return state;
    } on Object catch (error) {
      state = state.copyWith(
        state: 'failed',
        lastError: _safeMigrationError(error),
      );
      await _database.saveLegacyMigrationState(state);
      rethrow;
    }
  }

  /// Permanently removes legacy cloud data before a Firebase identity is
  /// deleted. Without this step those owner-only documents would become
  /// orphaned and impossible for the user to purge later.
  Future<void> purgeForAccountDeletion({
    required String userId,
    required bool confirmedPermanentDeletion,
  }) async {
    if (!confirmedPermanentDeletion) {
      throw ArgumentError(
        'Permanent account deletion confirmation is required.',
      );
    }
    final sessions = await _firestore.listDocuments(_sessionsPath(userId));
    final settings = await _firestore.getDocument(_settingsPath(userId));
    await _purgeAndVerify(userId, sessions: sessions, settings: settings);
  }

  Future<void> _purgeAndVerify(
    String userId, {
    required List<FirestoreDocument> sessions,
    required FirestoreDocument? settings,
  }) async {
    for (final document in sessions) {
      await _firestore.deleteDocument(
        '${_sessionsPath(userId)}/${document.id}',
      );
    }
    if (settings != null) {
      await _firestore.deleteDocument(_settingsPath(userId));
    }

    final remainingSessions = await _firestore.listDocuments(
      _sessionsPath(userId),
    );
    final remainingSettings = await _firestore.getDocument(
      _settingsPath(userId),
    );
    if (remainingSessions.isNotEmpty || remainingSettings != null) {
      throw const FirestoreException(
        'Cloud purge verification found remaining legacy data.',
      );
    }
  }

  Future<String> _availableStorageId(String userId, String remoteId) async {
    var candidate = remoteId;
    var attempt = 0;
    while (true) {
      final existing = await _database.sessionById(candidate);
      if (existing == null || existing.userId == userId) return candidate;
      candidate = _uuid.v5(
        Namespace.url.value,
        'focus-flow:legacy-session:$userId:$remoteId:${attempt++}',
      );
    }
  }

  WorkSession? _sessionFromDocument(
    FirestoreDocument document,
    String userId, {
    required String storageId,
  }) {
    final data = document.fields;
    try {
      if (document.id.trim().isEmpty || document.id.length > 128) return null;
      final plannedSeconds = (data['plannedSeconds'] as num).toInt();
      final actualSeconds = (data['actualSeconds'] as num).toInt();
      if (plannedSeconds <= 0 ||
          actualSeconds < 0 ||
          actualSeconds > plannedSeconds) {
        return null;
      }
      final activity = data['activity'] as String? ?? '';
      if (activity.length > 160) return null;
      final cycleId = data['cycleId'] as String? ?? '';
      if (cycleId.length > 128) return null;
      final startedAt = _utcFromMilliseconds(data['startedAtMs']);
      final endedAt = _utcFromMilliseconds(data['endedAtMs']);
      if (endedAt.isBefore(startedAt)) return null;
      return WorkSession(
        id: storageId,
        userId: userId,
        cycleId: cycleId,
        phase: TimerPhase.values.byName(data['phase'] as String),
        activity: activity,
        plannedSeconds: plannedSeconds,
        actualSeconds: actualSeconds,
        startedAt: startedAt,
        endedAt: endedAt,
        outcome: SessionOutcome.values.byName(data['outcome'] as String),
        updatedAt: _utcFromMilliseconds(data['updatedAtMs']),
        isDeleted: data['isDeleted'] as bool? ?? false,
        isDirty: false,
      );
    } on Object {
      // Malformed legacy documents are ignored instead of entering the local
      // database. They are still purged after the valid records are imported.
      return null;
    }
  }

  DateTime _utcFromMilliseconds(Object? value) =>
      DateTime.fromMillisecondsSinceEpoch((value as num).toInt(), isUtc: true);

  int _boundedInt(Object? value, int fallback, int minimum, int maximum) {
    final candidate = value is num ? value.toInt() : fallback;
    return candidate.clamp(minimum, maximum);
  }

  String _safeMigrationError(Object error) => switch (error) {
    FirestoreException exception => exception.message,
    _ => 'Legacy migration failed. Local data already imported remains safe.',
  };
}
