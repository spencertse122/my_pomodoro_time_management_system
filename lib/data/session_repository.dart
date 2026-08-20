import 'dart:async';

import '../domain/models.dart';
import 'local/app_database.dart';
import 'sync_service.dart';

class SessionRepository {
  SessionRepository(this._database, [this._syncService]);

  final AppDatabase _database;
  final SyncService? _syncService;

  Stream<List<WorkSession>> watchDay(String userId, DateTime localDay) {
    final start = DateTime(localDay.year, localDay.month, localDay.day);
    final end = start.add(const Duration(days: 1));
    return _database.watchSessions(userId, start.toUtc(), end.toUtc());
  }

  Future<void> save(WorkSession session) async {
    await _database.upsertSession(session.copyWith(isDirty: true));
    unawaited(sync(session.userId));
  }

  Future<void> editActivity(WorkSession session, String activity) async {
    final value = activity.trim();
    if (value.isEmpty) throw ArgumentError('Activity cannot be empty.');
    await _database.upsertSession(
      session.copyWith(
        activity: value,
        updatedAt: DateTime.now().toUtc(),
        isDirty: true,
      ),
    );
    unawaited(sync(session.userId));
  }

  Future<void> delete(WorkSession session) async {
    await _database.upsertSession(
      session.copyWith(
        isDeleted: true,
        updatedAt: DateTime.now().toUtc(),
        isDirty: true,
      ),
    );
    unawaited(sync(session.userId));
  }

  Future<void> sync(String userId) async {
    final syncService = _syncService;
    if (syncService == null) return;
    try {
      await syncService.syncUser(userId);
    } on Object {
      // Local data remains authoritative and dirty records retry later.
    }
  }
}

class SettingsRepository {
  SettingsRepository(this._database, [this._syncService]);

  final AppDatabase _database;
  final SyncService? _syncService;

  Stream<PomodoroSettings> watch(String userId) =>
      _database.watchSettings(userId);

  Future<PomodoroSettings> get(String userId) => _database.settings(userId);

  Future<void> save(String userId, PomodoroSettings settings) async {
    await _database.saveSettings(userId, settings, markDirty: true);
    unawaited(sync(userId));
  }

  Future<void> sync(String userId) async {
    final syncService = _syncService;
    if (syncService == null) return;
    try {
      await syncService.syncUser(userId);
    } on Object {
      // Settings will synchronize on the next successful sync.
    }
  }
}
