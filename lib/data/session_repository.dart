import '../domain/models.dart';
import 'local/app_database.dart';

class SessionRepository {
  SessionRepository(this._database);

  final AppDatabase _database;

  Stream<List<WorkSession>> watchDay(String userId, DateTime localDay) {
    final start = DateTime(localDay.year, localDay.month, localDay.day);
    final end = start.add(const Duration(days: 1));
    return _database.watchSessions(userId, start.toUtc(), end.toUtc());
  }

  Future<void> save(WorkSession session) async {
    await _database.upsertSession(session.copyWith(isDirty: false));
  }

  Future<void> editActivity(WorkSession session, String activity) async {
    final value = activity.trim();
    if (value.isEmpty) throw ArgumentError('Activity cannot be empty.');
    await _database.upsertSession(
      session.copyWith(
        activity: value,
        updatedAt: DateTime.now().toUtc(),
        isDirty: false,
      ),
    );
  }

  Future<void> setCategory(
    WorkSession session,
    String categoryId, {
    ActivityCategorySource source = ActivityCategorySource.manual,
  }) => _database.upsertSession(
    session.copyWith(
      categoryId: categoryId,
      categorySource: source,
      categoryConfidence: source == ActivityCategorySource.manual ? 1 : null,
      updatedAt: DateTime.now().toUtc(),
      isDirty: false,
    ),
  );

  Future<void> delete(WorkSession session) =>
      _database.hardDeleteSession(session.id);

  Future<List<WorkSession>> all(String userId) => _database.allSessions(userId);
}

class SettingsRepository {
  SettingsRepository(this._database);

  final AppDatabase _database;

  Stream<PomodoroSettings> watch(String userId) =>
      _database.watchSettings(userId);

  Future<PomodoroSettings> get(String userId) => _database.settings(userId);

  Future<void> save(String userId, PomodoroSettings settings) =>
      _database.saveSettings(userId, settings, markDirty: false);
}
