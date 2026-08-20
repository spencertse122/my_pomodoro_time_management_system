import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../domain/models.dart';

part 'app_database.g.dart';

class SessionEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get cycleId => text()();
  TextColumn get phase => text()();
  TextColumn get activity => text()();
  IntColumn get plannedSeconds => integer()();
  IntColumn get actualSeconds => integer()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  TextColumn get outcome => text()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class TimerEntries extends Table {
  TextColumn get userId => text()();
  TextColumn get state => text()();
  TextColumn get phase => text()();
  TextColumn get activity => text()();
  TextColumn get cycleId => text()();
  IntColumn get completedFocusesInCycle => integer()();
  IntColumn get plannedSeconds => integer()();
  IntColumn get accumulatedSeconds => integer()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get deadline => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {userId};
}

class SettingsEntries extends Table {
  TextColumn get userId => text()();
  IntColumn get focusMinutes => integer().withDefault(const Constant(25))();
  IntColumn get shortBreakMinutes => integer().withDefault(const Constant(5))();
  IntColumn get longBreakMinutes => integer().withDefault(const Constant(15))();
  IntColumn get longBreakInterval => integer().withDefault(const Constant(4))();
  BoolColumn get soundEnabled => boolean().withDefault(const Constant(true))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {userId};
}

class AuthEntries extends Table {
  TextColumn get userId => text()();
  TextColumn get email => text()();
  TextColumn get refreshToken => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {userId};
}

@DriftDatabase(
  tables: [SessionEntries, TimerEntries, SettingsEntries, AuthEntries],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.defaults() : super(driftDatabase(name: 'focus_flow'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) await migrator.createTable(authEntries);
    },
  );

  Future<StoredAuth?> storedAuth() async {
    final row = await select(authEntries).getSingleOrNull();
    return row == null
        ? null
        : StoredAuth(
            userId: row.userId,
            email: row.email,
            refreshToken: row.refreshToken,
          );
  }

  Future<void> saveAuth(StoredAuth auth) async {
    await transaction(() async {
      await delete(authEntries).go();
      await into(authEntries).insert(
        AuthEntriesCompanion.insert(
          userId: auth.userId,
          email: auth.email,
          refreshToken: auth.refreshToken,
          updatedAt: DateTime.now().toUtc(),
        ),
      );
    });
  }

  Future<void> clearAuth() => delete(authEntries).go();

  Stream<List<WorkSession>> watchSessions(
    String userId,
    DateTime startUtc,
    DateTime endUtc,
  ) {
    final query = select(sessionEntries)
      ..where(
        (row) =>
            row.userId.equals(userId) &
            row.isDeleted.equals(false) &
            row.startedAt.isSmallerThanValue(endUtc) &
            row.endedAt.isBiggerThanValue(startUtc),
      )
      ..orderBy([(row) => OrderingTerm.asc(row.startedAt)]);
    return query.watch().map((rows) => rows.map(_sessionFromRow).toList());
  }

  Future<List<WorkSession>> allSessions(String userId) async {
    final rows = await (select(
      sessionEntries,
    )..where((row) => row.userId.equals(userId))).get();
    return rows.map(_sessionFromRow).toList();
  }

  Future<List<WorkSession>> dirtySessions(String userId) async {
    final rows =
        await (select(sessionEntries)..where(
              (row) => row.userId.equals(userId) & row.isDirty.equals(true),
            ))
            .get();
    return rows.map(_sessionFromRow).toList();
  }

  Future<WorkSession?> sessionById(String id) async {
    final row = await (select(
      sessionEntries,
    )..where((entry) => entry.id.equals(id))).getSingleOrNull();
    return row == null ? null : _sessionFromRow(row);
  }

  Future<void> upsertSession(WorkSession session) =>
      into(sessionEntries).insertOnConflictUpdate(_sessionToCompanion(session));

  Future<void> markSessionSynced(String id) =>
      (update(sessionEntries)..where((row) => row.id.equals(id))).write(
        const SessionEntriesCompanion(isDirty: Value(false)),
      );

  Future<TimerSnapshot?> activeTimer(String userId) async {
    final row = await (select(
      timerEntries,
    )..where((entry) => entry.userId.equals(userId))).getSingleOrNull();
    return row == null ? null : _timerFromRow(row);
  }

  Future<void> saveTimer(TimerSnapshot timer) =>
      into(timerEntries).insertOnConflictUpdate(_timerToCompanion(timer));

  Future<void> deleteTimer(String userId) =>
      (delete(timerEntries)..where((row) => row.userId.equals(userId))).go();

  Stream<PomodoroSettings> watchSettings(String userId) {
    return (select(
      settingsEntries,
    )..where((row) => row.userId.equals(userId))).watchSingleOrNull().map(
      (row) => row == null ? const PomodoroSettings() : _settingsFromRow(row),
    );
  }

  Future<PomodoroSettings> settings(String userId) async {
    final row = await (select(
      settingsEntries,
    )..where((entry) => entry.userId.equals(userId))).getSingleOrNull();
    return row == null ? const PomodoroSettings() : _settingsFromRow(row);
  }

  Future<void> saveSettings(
    String userId,
    PomodoroSettings settings, {
    bool markDirty = true,
  }) {
    return into(settingsEntries).insertOnConflictUpdate(
      SettingsEntriesCompanion.insert(
        userId: userId,
        focusMinutes: Value(settings.focusMinutes),
        shortBreakMinutes: Value(settings.shortBreakMinutes),
        longBreakMinutes: Value(settings.longBreakMinutes),
        longBreakInterval: Value(settings.longBreakInterval),
        soundEnabled: Value(settings.soundEnabled),
        isDirty: Value(markDirty),
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Future<void> markSettingsSynced(String userId) =>
      (update(settingsEntries)..where((row) => row.userId.equals(userId)))
          .write(const SettingsEntriesCompanion(isDirty: Value(false)));

  WorkSession _sessionFromRow(SessionEntry row) => WorkSession(
    id: row.id,
    userId: row.userId,
    cycleId: row.cycleId,
    phase: TimerPhase.values.byName(row.phase),
    activity: row.activity,
    plannedSeconds: row.plannedSeconds,
    actualSeconds: row.actualSeconds,
    startedAt: row.startedAt,
    endedAt: row.endedAt,
    outcome: SessionOutcome.values.byName(row.outcome),
    updatedAt: row.updatedAt,
    isDeleted: row.isDeleted,
    isDirty: row.isDirty,
  );

  SessionEntriesCompanion _sessionToCompanion(WorkSession session) =>
      SessionEntriesCompanion.insert(
        id: session.id,
        userId: session.userId,
        cycleId: session.cycleId,
        phase: session.phase.name,
        activity: session.activity,
        plannedSeconds: session.plannedSeconds,
        actualSeconds: session.actualSeconds,
        startedAt: session.startedAt,
        endedAt: session.endedAt,
        outcome: session.outcome.name,
        updatedAt: session.updatedAt,
        isDeleted: Value(session.isDeleted),
        isDirty: Value(session.isDirty),
      );

  TimerSnapshot _timerFromRow(TimerEntry row) => TimerSnapshot(
    userId: row.userId,
    state: TimerRunState.values.byName(row.state),
    phase: TimerPhase.values.byName(row.phase),
    activity: row.activity,
    cycleId: row.cycleId,
    completedFocusesInCycle: row.completedFocusesInCycle,
    plannedSeconds: row.plannedSeconds,
    accumulatedSeconds: row.accumulatedSeconds,
    startedAt: row.startedAt,
    deadline: row.deadline,
    updatedAt: row.updatedAt,
  );

  TimerEntriesCompanion _timerToCompanion(TimerSnapshot timer) =>
      TimerEntriesCompanion.insert(
        userId: timer.userId,
        state: timer.state.name,
        phase: timer.phase.name,
        activity: timer.activity,
        cycleId: timer.cycleId,
        completedFocusesInCycle: timer.completedFocusesInCycle,
        plannedSeconds: timer.plannedSeconds,
        accumulatedSeconds: timer.accumulatedSeconds,
        startedAt: Value(timer.startedAt),
        deadline: Value(timer.deadline),
        updatedAt: timer.updatedAt,
      );

  PomodoroSettings _settingsFromRow(SettingsEntry row) => PomodoroSettings(
    focusMinutes: row.focusMinutes,
    shortBreakMinutes: row.shortBreakMinutes,
    longBreakMinutes: row.longBreakMinutes,
    longBreakInterval: row.longBreakInterval,
    soundEnabled: row.soundEnabled,
    isDirty: row.isDirty,
  );
}

class StoredAuth {
  const StoredAuth({
    required this.userId,
    required this.email,
    required this.refreshToken,
  });

  final String userId;
  final String email;
  final String refreshToken;
}
