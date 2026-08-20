import '../domain/models.dart';
import '../services/firestore_rest_client.dart';
import 'local/app_database.dart';

class SyncService {
  SyncService(this._database, this._firestore);

  final AppDatabase _database;
  final FirestoreRestClient _firestore;
  final Set<String> _pendingUsers = {};
  Future<void>? _activeSync;

  Future<void> syncUser(String userId) async {
    _pendingUsers.add(userId);
    final active = _activeSync;
    if (active != null) return active;

    final operation = _drainSyncQueue();
    _activeSync = operation;
    try {
      await operation;
    } finally {
      _activeSync = null;
    }
  }

  Future<void> _drainSyncQueue() async {
    while (_pendingUsers.isNotEmpty) {
      final userId = _pendingUsers.first;
      _pendingUsers.remove(userId);
      await _pushSessions(userId);
      await _pullSessions(userId);
      await _syncSettings(userId);
    }
  }

  String _sessions(String userId) => 'users/$userId/sessions';

  Future<void> _pushSessions(String userId) async {
    for (final session in await _database.dirtySessions(userId)) {
      await _firestore.setDocument('${_sessions(userId)}/${session.id}', {
        'id': session.id,
        'userId': session.userId,
        'cycleId': session.cycleId,
        'phase': session.phase.name,
        'activity': session.activity,
        'plannedSeconds': session.plannedSeconds,
        'actualSeconds': session.actualSeconds,
        'startedAtMs': session.startedAt.millisecondsSinceEpoch,
        'endedAtMs': session.endedAt.millisecondsSinceEpoch,
        'outcome': session.outcome.name,
        'updatedAtMs': session.updatedAt.millisecondsSinceEpoch,
        'isDeleted': session.isDeleted,
        'serverUpdatedAt': DateTime.now().toUtc(),
      });
      await _database.markSessionSynced(session.id);
    }
  }

  Future<void> _pullSessions(String userId) async {
    final documents = await _firestore.listDocuments(_sessions(userId));
    for (final document in documents) {
      final remote = _sessionFromMap(document.id, userId, document.fields);
      if (remote == null) continue;
      final local = await _database.sessionById(remote.id);
      if (local == null ||
          (!local.isDirty && !local.updatedAt.isAfter(remote.updatedAt))) {
        await _database.upsertSession(remote.copyWith(isDirty: false));
      }
    }
  }

  WorkSession? _sessionFromMap(
    String id,
    String userId,
    Map<String, dynamic> data,
  ) {
    try {
      return WorkSession(
        id: id,
        userId: userId,
        cycleId: data['cycleId'] as String? ?? '',
        phase: TimerPhase.values.byName(data['phase'] as String),
        activity: data['activity'] as String? ?? '',
        plannedSeconds: (data['plannedSeconds'] as num).toInt(),
        actualSeconds: (data['actualSeconds'] as num).toInt(),
        startedAt: DateTime.fromMillisecondsSinceEpoch(
          (data['startedAtMs'] as num).toInt(),
          isUtc: true,
        ),
        endedAt: DateTime.fromMillisecondsSinceEpoch(
          (data['endedAtMs'] as num).toInt(),
          isUtc: true,
        ),
        outcome: SessionOutcome.values.byName(data['outcome'] as String),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(
          (data['updatedAtMs'] as num).toInt(),
          isUtc: true,
        ),
        isDeleted: data['isDeleted'] as bool? ?? false,
        isDirty: false,
      );
    } on Object {
      return null;
    }
  }

  Future<void> _syncSettings(String userId) async {
    final local = await _database.settings(userId);
    final path = 'users/$userId/settings/pomodoro';
    if (local.isDirty) {
      await _firestore.setDocument(path, {
        'focusMinutes': local.focusMinutes,
        'shortBreakMinutes': local.shortBreakMinutes,
        'longBreakMinutes': local.longBreakMinutes,
        'longBreakInterval': local.longBreakInterval,
        'soundEnabled': local.soundEnabled,
        'serverUpdatedAt': DateTime.now().toUtc(),
      });
      await _database.markSettingsSynced(userId);
      return;
    }

    final remote = await _firestore.getDocument(path);
    final data = remote?.fields;
    if (data == null) return;
    await _database.saveSettings(
      userId,
      PomodoroSettings(
        focusMinutes: (data['focusMinutes'] as num? ?? 25).toInt(),
        shortBreakMinutes: (data['shortBreakMinutes'] as num? ?? 5).toInt(),
        longBreakMinutes: (data['longBreakMinutes'] as num? ?? 15).toInt(),
        longBreakInterval: (data['longBreakInterval'] as num? ?? 4).toInt(),
        soundEnabled: data['soundEnabled'] as bool? ?? true,
      ),
      markDirty: false,
    );
  }
}
