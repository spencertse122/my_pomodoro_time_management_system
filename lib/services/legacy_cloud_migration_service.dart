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
  LegacyCloudMigrationService(this._database, this._firestore);

  final AppDatabase _database;
  final FirestoreRestClient _firestore;

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
          final session = _sessionFromDocument(document, userId);
          if (session == null) continue;
          if (session.isDeleted) {
            await _database.hardDeleteSession(session.id);
            continue;
          }
          final local = await _database.sessionById(session.id);
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
      for (final document in remoteSessions) {
        await _firestore.deleteDocument(
          '${_sessionsPath(userId)}/${document.id}',
        );
      }
      if (remoteSettings != null) {
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

  WorkSession? _sessionFromDocument(FirestoreDocument document, String userId) {
    final data = document.fields;
    try {
      final plannedSeconds = (data['plannedSeconds'] as num).toInt();
      final actualSeconds = (data['actualSeconds'] as num).toInt();
      if (plannedSeconds <= 0 ||
          actualSeconds < 0 ||
          actualSeconds > plannedSeconds) {
        return null;
      }
      final activity = data['activity'] as String? ?? '';
      if (activity.length > 160) return null;
      return WorkSession(
        id: document.id,
        userId: userId,
        cycleId: data['cycleId'] as String? ?? '',
        phase: TimerPhase.values.byName(data['phase'] as String),
        activity: activity,
        plannedSeconds: plannedSeconds,
        actualSeconds: actualSeconds,
        startedAt: _utcFromMilliseconds(data['startedAtMs']),
        endedAt: _utcFromMilliseconds(data['endedAtMs']),
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
