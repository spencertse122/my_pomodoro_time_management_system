import 'dart:convert';

import 'package:drift/drift.dart';

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
  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();
  TextColumn get categoryId => text().nullable()();
  TextColumn get categorySource => text().nullable()();
  RealColumn get categoryConfidence => real().nullable()();
  TextColumn get alignment =>
      text().withDefault(const Constant('unverified'))();

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
  TextColumn get refreshToken => text().withDefault(const Constant(''))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {userId};
}

class ActivitySampleEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get capturedAt => dateTime()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  TextColumn get appId => text()();
  TextColumn get appName => text()();
  TextColumn get windowTitle => text()();
  TextColumn get activityLabel => text().nullable()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get categorySource => text().nullable()();
  RealColumn get confidence => real().nullable()();
  TextColumn get secondaryContextJson =>
      text().withDefault(const Constant('[]'))();
  TextColumn get processingState => text()();
  TextColumn get modelVersion => text().nullable()();
  TextColumn get promptVersion => text().nullable()();
  TextColumn get failureCode => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ActivityBlockEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  TextColumn get appId => text()();
  TextColumn get appName => text()();
  TextColumn get activityLabel => text()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get categorySource => text()();
  RealColumn get confidence => real()();
  IntColumn get sampleCount => integer()();
  TextColumn get secondaryContextJson =>
      text().withDefault(const Constant('[]'))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CategoryEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  IntColumn get colorValue => integer()();
  IntColumn get sortOrder => integer()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CategoryRuleEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get appId => text()();
  TextColumn get titleContains => text().nullable()();
  TextColumn get categoryId => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class DailyInsightEntries extends Table {
  TextColumn get userId => text()();
  TextColumn get localDate => text()();
  TextColumn get summary => text()();
  TextColumn get patternsJson => text()();
  TextColumn get discrepanciesJson => text()();
  TextColumn get modelVersion => text()();
  TextColumn get promptVersion => text()();
  DateTimeColumn get sourceUpdatedAt => dateTime()();
  DateTimeColumn get generatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {userId, localDate};
}

class TrackingSettingsEntries extends Table {
  TextColumn get userId => text()();
  BoolColumn get trackingEnabled =>
      boolean().withDefault(const Constant(false))();
  IntColumn get captureIntervalMinutes =>
      integer().withDefault(const Constant(5))();
  IntColumn get idleThresholdMinutes =>
      integer().withDefault(const Constant(5))();
  BoolColumn get launchAtLogin =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get captureAllDisplays =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get diagnosticsEnabled =>
      boolean().withDefault(const Constant(true))();
  TextColumn get excludedAppIdsJson =>
      text().withDefault(const Constant('[]'))();
  BoolColumn get onboardingComplete =>
      boolean().withDefault(const Constant(false))();
  IntColumn get privacyNoticeVersion =>
      integer().withDefault(const Constant(0))();
  DateTimeColumn get pausedUntil => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {userId};
}

class MigrationStateEntries extends Table {
  TextColumn get userId => text()();
  TextColumn get state => text()();
  IntColumn get importedSessionCount =>
      integer().withDefault(const Constant(0))();
  BoolColumn get cloudVerifiedEmpty =>
      boolean().withDefault(const Constant(false))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {userId};
}

class DiagnosticsCounterEntries extends Table {
  TextColumn get dayUtc => text()();
  TextColumn get event => text()();
  TextColumn get outcome => text()();
  TextColumn get durationBucket => text()();
  IntColumn get count => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {
    dayUtc,
    event,
    outcome,
    durationBucket,
  };
}

@DriftDatabase(
  tables: [
    SessionEntries,
    TimerEntries,
    SettingsEntries,
    AuthEntries,
    ActivitySampleEntries,
    ActivityBlockEntries,
    CategoryEntries,
    CategoryRuleEntries,
    DailyInsightEntries,
    TrackingSettingsEntries,
    MigrationStateEntries,
    DiagnosticsCounterEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) await migrator.createTable(authEntries);
      if (from < 3) {
        await migrator.addColumn(sessionEntries, sessionEntries.categoryId);
        await migrator.addColumn(sessionEntries, sessionEntries.categorySource);
        await migrator.addColumn(
          sessionEntries,
          sessionEntries.categoryConfidence,
        );
        await migrator.addColumn(sessionEntries, sessionEntries.alignment);
        await migrator.createTable(activitySampleEntries);
        await migrator.createTable(activityBlockEntries);
        await migrator.createTable(categoryEntries);
        await migrator.createTable(categoryRuleEntries);
        await migrator.createTable(dailyInsightEntries);
        await migrator.createTable(trackingSettingsEntries);
        await migrator.createTable(migrationStateEntries);
        await migrator.createTable(diagnosticsCounterEntries);
      }
      if (from >= 3 && from < 4) {
        await migrator.addColumn(
          trackingSettingsEntries,
          trackingSettingsEntries.onboardingComplete,
        );
        await migrator.addColumn(
          trackingSettingsEntries,
          trackingSettingsEntries.privacyNoticeVersion,
        );
      }
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
          refreshToken: Value(auth.refreshToken),
          updatedAt: DateTime.now().toUtc(),
        ),
      );
    });
  }

  Future<void> clearAuth() => delete(authEntries).go();

  Future<void> deleteUserData(String userId) async {
    await transaction(() async {
      await (delete(
        sessionEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        timerEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        settingsEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        activitySampleEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        activityBlockEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        categoryRuleEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        categoryEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        dailyInsightEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        trackingSettingsEntries,
      )..where((row) => row.userId.equals(userId))).go();
      await (delete(
        migrationStateEntries,
      )..where((row) => row.userId.equals(userId))).go();
    });
  }

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

  Future<WorkSession?> sessionById(String id) async {
    final row = await (select(
      sessionEntries,
    )..where((entry) => entry.id.equals(id))).getSingleOrNull();
    return row == null ? null : _sessionFromRow(row);
  }

  Future<void> upsertSession(WorkSession session) =>
      into(sessionEntries).insertOnConflictUpdate(_sessionToCompanion(session));

  Future<void> hardDeleteSession(String id) =>
      (delete(sessionEntries)..where((row) => row.id.equals(id))).go();

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

  Stream<PomodoroSettings> watchSettings(String userId) =>
      (select(
        settingsEntries,
      )..where((row) => row.userId.equals(userId))).watchSingleOrNull().map(
        (row) => row == null ? const PomodoroSettings() : _settingsFromRow(row),
      );

  Future<PomodoroSettings> settings(String userId) async {
    final row = await (select(
      settingsEntries,
    )..where((entry) => entry.userId.equals(userId))).getSingleOrNull();
    return row == null ? const PomodoroSettings() : _settingsFromRow(row);
  }

  Future<void> saveSettings(
    String userId,
    PomodoroSettings settings, {
    bool markDirty = false,
  }) => into(settingsEntries).insertOnConflictUpdate(
    SettingsEntriesCompanion.insert(
      userId: userId,
      focusMinutes: Value(settings.focusMinutes),
      shortBreakMinutes: Value(settings.shortBreakMinutes),
      longBreakMinutes: Value(settings.longBreakMinutes),
      longBreakInterval: Value(settings.longBreakInterval),
      soundEnabled: Value(settings.soundEnabled),
      isDirty: const Value(false),
      updatedAt: DateTime.now().toUtc(),
    ),
  );

  Stream<List<ActivitySample>> watchActivitySamples(
    String userId,
    DateTime startUtc,
    DateTime endUtc,
  ) {
    final query = select(activitySampleEntries)
      ..where(
        (row) =>
            row.userId.equals(userId) &
            row.startedAt.isSmallerThanValue(endUtc) &
            row.endedAt.isBiggerThanValue(startUtc),
      )
      ..orderBy([(row) => OrderingTerm.asc(row.startedAt)]);
    return query.watch().map((rows) => rows.map(_sampleFromRow).toList());
  }

  Future<List<ActivitySample>> activitySamples(
    String userId,
    DateTime startUtc,
    DateTime endUtc,
  ) async {
    final rows =
        await (select(activitySampleEntries)
              ..where(
                (row) =>
                    row.userId.equals(userId) &
                    row.startedAt.isSmallerThanValue(endUtc) &
                    row.endedAt.isBiggerThanValue(startUtc),
              )
              ..orderBy([(row) => OrderingTerm.asc(row.startedAt)]))
            .get();
    return rows.map(_sampleFromRow).toList();
  }

  Future<void> upsertActivitySample(ActivitySample sample) => into(
    activitySampleEntries,
  ).insertOnConflictUpdate(_sampleToCompanion(sample));

  Stream<List<ActivityBlock>> watchActivityBlocks(
    String userId,
    DateTime startUtc,
    DateTime endUtc,
  ) {
    final query = select(activityBlockEntries)
      ..where(
        (row) =>
            row.userId.equals(userId) &
            row.startedAt.isSmallerThanValue(endUtc) &
            row.endedAt.isBiggerThanValue(startUtc),
      )
      ..orderBy([(row) => OrderingTerm.asc(row.startedAt)]);
    return query.watch().map((rows) => rows.map(_blockFromRow).toList());
  }

  Future<void> replaceActivityBlocks(
    String userId,
    DateTime startUtc,
    DateTime endUtc,
    List<ActivityBlock> blocks,
  ) async {
    await transaction(() async {
      await (delete(activityBlockEntries)..where(
            (row) =>
                row.userId.equals(userId) &
                row.startedAt.isSmallerThanValue(endUtc) &
                row.endedAt.isBiggerThanValue(startUtc),
          ))
          .go();
      if (blocks.isNotEmpty) {
        await batch((batch) {
          batch.insertAll(
            activityBlockEntries,
            blocks.map(_blockToCompanion).toList(),
            mode: InsertMode.insertOrReplace,
          );
        });
      }
    });
  }

  Stream<List<ActivityCategory>> watchCategories(String userId) {
    final query = select(categoryEntries)
      ..where((row) => row.userId.equals(userId))
      ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]);
    return query.watch().map((rows) => rows.map(_categoryFromRow).toList());
  }

  Future<List<ActivityCategory>> categories(String userId) async {
    final rows =
        await (select(categoryEntries)
              ..where((row) => row.userId.equals(userId))
              ..orderBy([(row) => OrderingTerm.asc(row.sortOrder)]))
            .get();
    return rows.map(_categoryFromRow).toList();
  }

  Future<void> upsertCategory(ActivityCategory category) =>
      into(categoryEntries).insertOnConflictUpdate(
        CategoryEntriesCompanion.insert(
          id: category.id,
          userId: category.userId,
          name: category.name,
          description: category.description,
          colorValue: category.colorValue,
          sortOrder: category.sortOrder,
          isArchived: Value(category.isArchived),
          isSystem: Value(category.isSystem),
          updatedAt: DateTime.now().toUtc(),
        ),
      );

  Future<List<CategoryRule>> categoryRules(String userId) async {
    final rows = await (select(
      categoryRuleEntries,
    )..where((row) => row.userId.equals(userId))).get();
    return rows.map(_ruleFromRow).toList();
  }

  Future<void> upsertCategoryRule(CategoryRule rule) =>
      into(categoryRuleEntries).insertOnConflictUpdate(
        CategoryRuleEntriesCompanion.insert(
          id: rule.id,
          userId: rule.userId,
          appId: rule.appId,
          titleContains: Value(rule.titleContains),
          categoryId: rule.categoryId,
          updatedAt: rule.updatedAt,
        ),
      );

  Future<DailyInsight?> dailyInsight(String userId, DateTime localDate) async {
    final key = _dateKey(localDate);
    final row =
        await (select(dailyInsightEntries)..where(
              (entry) =>
                  entry.userId.equals(userId) & entry.localDate.equals(key),
            ))
            .getSingleOrNull();
    return row == null ? null : _insightFromRow(row);
  }

  Future<void> saveDailyInsight(DailyInsight insight) =>
      into(dailyInsightEntries).insertOnConflictUpdate(
        DailyInsightEntriesCompanion.insert(
          userId: insight.userId,
          localDate: _dateKey(insight.localDate),
          summary: insight.summary,
          patternsJson: jsonEncode(insight.patterns),
          discrepanciesJson: jsonEncode(insight.discrepancies),
          modelVersion: insight.modelVersion,
          promptVersion: insight.promptVersion,
          sourceUpdatedAt: insight.sourceUpdatedAt,
          generatedAt: insight.generatedAt,
        ),
      );

  Stream<TrackingSettings> watchTrackingSettings(String userId) =>
      (select(
        trackingSettingsEntries,
      )..where((row) => row.userId.equals(userId))).watchSingleOrNull().map(
        (row) => row == null
            ? const TrackingSettings()
            : _trackingSettingsFromRow(row),
      );

  Future<TrackingSettings> trackingSettings(String userId) async {
    final row = await (select(
      trackingSettingsEntries,
    )..where((entry) => entry.userId.equals(userId))).getSingleOrNull();
    return row == null
        ? const TrackingSettings()
        : _trackingSettingsFromRow(row);
  }

  Future<void> saveTrackingSettings(String userId, TrackingSettings settings) =>
      into(trackingSettingsEntries).insertOnConflictUpdate(
        TrackingSettingsEntriesCompanion.insert(
          userId: userId,
          trackingEnabled: Value(settings.trackingEnabled),
          captureIntervalMinutes: Value(settings.captureIntervalMinutes),
          idleThresholdMinutes: Value(settings.idleThresholdMinutes),
          launchAtLogin: Value(settings.launchAtLogin),
          captureAllDisplays: Value(settings.captureAllDisplays),
          diagnosticsEnabled: Value(settings.diagnosticsEnabled),
          excludedAppIdsJson: Value(jsonEncode(settings.excludedAppIds)),
          onboardingComplete: Value(settings.onboardingComplete),
          privacyNoticeVersion: Value(settings.privacyNoticeVersion),
          pausedUntil: Value(settings.pausedUntil),
          updatedAt: DateTime.now().toUtc(),
        ),
      );

  Future<LegacyMigrationState> legacyMigrationState(String userId) async {
    final row = await (select(
      migrationStateEntries,
    )..where((entry) => entry.userId.equals(userId))).getSingleOrNull();
    return row == null
        ? LegacyMigrationState.notStarted(userId)
        : LegacyMigrationState(
            userId: row.userId,
            state: row.state,
            importedSessionCount: row.importedSessionCount,
            cloudVerifiedEmpty: row.cloudVerifiedEmpty,
            lastError: row.lastError,
            updatedAt: row.updatedAt,
          );
  }

  Future<void> saveLegacyMigrationState(LegacyMigrationState state) =>
      into(migrationStateEntries).insertOnConflictUpdate(
        MigrationStateEntriesCompanion.insert(
          userId: state.userId,
          state: state.state,
          importedSessionCount: Value(state.importedSessionCount),
          cloudVerifiedEmpty: Value(state.cloudVerifiedEmpty),
          lastError: Value(state.lastError),
          updatedAt: state.updatedAt,
        ),
      );

  Future<void> incrementDiagnostic({
    required String event,
    required String outcome,
    required String durationBucket,
  }) async {
    final day = _dateKey(DateTime.now().toUtc());
    await customStatement(
      'INSERT INTO diagnostics_counter_entries '
      '(day_utc, event, outcome, duration_bucket, count) VALUES (?, ?, ?, ?, 1) '
      'ON CONFLICT(day_utc, event, outcome, duration_bucket) '
      'DO UPDATE SET count = count + 1',
      [day, event, outcome, durationBucket],
    );
  }

  Future<List<DiagnosticCounter>> diagnosticCounters() async {
    final rows = await select(diagnosticsCounterEntries).get();
    return rows
        .map(
          (row) => DiagnosticCounter(
            dayUtc: row.dayUtc,
            event: row.event,
            outcome: row.outcome,
            durationBucket: row.durationBucket,
            count: row.count,
          ),
        )
        .toList();
  }

  Future<void> deleteDiagnosticCounters(
    List<DiagnosticCounter> counters,
  ) async {
    await batch((batch) {
      for (final counter in counters) {
        batch.deleteWhere(
          diagnosticsCounterEntries,
          (row) =>
              row.dayUtc.equals(counter.dayUtc) &
              row.event.equals(counter.event) &
              row.outcome.equals(counter.outcome) &
              row.durationBucket.equals(counter.durationBucket),
        );
      }
    });
  }

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
    categoryId: row.categoryId,
    categorySource: row.categorySource == null
        ? null
        : ActivityCategorySource.values.byName(row.categorySource!),
    categoryConfidence: row.categoryConfidence,
    alignment: SessionAlignment.values.byName(row.alignment),
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
        isDirty: const Value(false),
        categoryId: Value(session.categoryId),
        categorySource: Value(session.categorySource?.name),
        categoryConfidence: Value(session.categoryConfidence),
        alignment: Value(session.alignment.name),
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
    isDirty: false,
  );

  ActivitySample _sampleFromRow(ActivitySampleEntry row) => ActivitySample(
    id: row.id,
    userId: row.userId,
    capturedAt: row.capturedAt,
    startedAt: row.startedAt,
    endedAt: row.endedAt,
    appId: row.appId,
    appName: row.appName,
    windowTitle: row.windowTitle,
    activityLabel: row.activityLabel,
    categoryId: row.categoryId,
    categorySource: row.categorySource == null
        ? null
        : ActivityCategorySource.values.byName(row.categorySource!),
    confidence: row.confidence,
    secondaryContext: _stringList(row.secondaryContextJson),
    processingState: ActivityProcessingState.values.byName(row.processingState),
    modelVersion: row.modelVersion,
    promptVersion: row.promptVersion,
    failureCode: row.failureCode,
    updatedAt: row.updatedAt,
  );

  ActivitySampleEntriesCompanion _sampleToCompanion(ActivitySample sample) =>
      ActivitySampleEntriesCompanion.insert(
        id: sample.id,
        userId: sample.userId,
        capturedAt: sample.capturedAt,
        startedAt: sample.startedAt,
        endedAt: sample.endedAt,
        appId: sample.appId,
        appName: sample.appName,
        windowTitle: sample.windowTitle,
        activityLabel: Value(sample.activityLabel),
        categoryId: Value(sample.categoryId),
        categorySource: Value(sample.categorySource?.name),
        confidence: Value(sample.confidence),
        secondaryContextJson: Value(jsonEncode(sample.secondaryContext)),
        processingState: sample.processingState.name,
        modelVersion: Value(sample.modelVersion),
        promptVersion: Value(sample.promptVersion),
        failureCode: Value(sample.failureCode),
        updatedAt: sample.updatedAt,
      );

  ActivityBlock _blockFromRow(ActivityBlockEntry row) => ActivityBlock(
    id: row.id,
    userId: row.userId,
    startedAt: row.startedAt,
    endedAt: row.endedAt,
    appId: row.appId,
    appName: row.appName,
    activityLabel: row.activityLabel,
    categoryId: row.categoryId,
    source: ActivityCategorySource.values.byName(row.categorySource),
    confidence: row.confidence,
    sampleCount: row.sampleCount,
    secondaryContext: _stringList(row.secondaryContextJson),
  );

  ActivityBlockEntriesCompanion _blockToCompanion(ActivityBlock block) =>
      ActivityBlockEntriesCompanion.insert(
        id: block.id,
        userId: block.userId,
        startedAt: block.startedAt,
        endedAt: block.endedAt,
        appId: block.appId,
        appName: block.appName,
        activityLabel: block.activityLabel,
        categoryId: Value(block.categoryId),
        categorySource: block.source.name,
        confidence: block.confidence,
        sampleCount: block.sampleCount,
        secondaryContextJson: Value(jsonEncode(block.secondaryContext)),
      );

  ActivityCategory _categoryFromRow(CategoryEntry row) => ActivityCategory(
    id: row.id,
    userId: row.userId,
    name: row.name,
    description: row.description,
    colorValue: row.colorValue,
    sortOrder: row.sortOrder,
    isArchived: row.isArchived,
    isSystem: row.isSystem,
  );

  CategoryRule _ruleFromRow(CategoryRuleEntry row) => CategoryRule(
    id: row.id,
    userId: row.userId,
    appId: row.appId,
    titleContains: row.titleContains,
    categoryId: row.categoryId,
    updatedAt: row.updatedAt,
  );

  DailyInsight _insightFromRow(DailyInsightEntry row) => DailyInsight(
    userId: row.userId,
    localDate: DateTime.parse(row.localDate),
    summary: row.summary,
    patterns: _stringList(row.patternsJson),
    discrepancies: _stringList(row.discrepanciesJson),
    modelVersion: row.modelVersion,
    promptVersion: row.promptVersion,
    sourceUpdatedAt: row.sourceUpdatedAt,
    generatedAt: row.generatedAt,
  );

  TrackingSettings _trackingSettingsFromRow(TrackingSettingsEntry row) =>
      TrackingSettings(
        trackingEnabled: row.trackingEnabled,
        captureIntervalMinutes: row.captureIntervalMinutes,
        idleThresholdMinutes: row.idleThresholdMinutes,
        launchAtLogin: row.launchAtLogin,
        captureAllDisplays: row.captureAllDisplays,
        diagnosticsEnabled: row.diagnosticsEnabled,
        excludedAppIds: _stringList(row.excludedAppIdsJson),
        onboardingComplete: row.onboardingComplete,
        privacyNoticeVersion: row.privacyNoticeVersion,
        pausedUntil: row.pausedUntil,
      );

  List<String> _stringList(String value) {
    try {
      return (jsonDecode(value) as List<dynamic>).cast<String>();
    } on Object {
      return const [];
    }
  }

  String _dateKey(DateTime value) =>
      '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-'
      '${value.day.toString().padLeft(2, '0')}';
}

class StoredAuth {
  const StoredAuth({
    required this.userId,
    required this.email,
    this.refreshToken = '',
  });

  final String userId;
  final String email;
  final String refreshToken;
}

class LegacyMigrationState {
  const LegacyMigrationState({
    required this.userId,
    required this.state,
    required this.importedSessionCount,
    required this.cloudVerifiedEmpty,
    required this.updatedAt,
    this.lastError,
  });

  factory LegacyMigrationState.notStarted(String userId) =>
      LegacyMigrationState(
        userId: userId,
        state: 'notStarted',
        importedSessionCount: 0,
        cloudVerifiedEmpty: false,
        updatedAt: DateTime.now().toUtc(),
      );

  final String userId;
  final String state;
  final int importedSessionCount;
  final bool cloudVerifiedEmpty;
  final String? lastError;
  final DateTime updatedAt;

  LegacyMigrationState copyWith({
    String? state,
    int? importedSessionCount,
    bool? cloudVerifiedEmpty,
    String? lastError,
    bool clearError = false,
  }) => LegacyMigrationState(
    userId: userId,
    state: state ?? this.state,
    importedSessionCount: importedSessionCount ?? this.importedSessionCount,
    cloudVerifiedEmpty: cloudVerifiedEmpty ?? this.cloudVerifiedEmpty,
    lastError: clearError ? null : (lastError ?? this.lastError),
    updatedAt: DateTime.now().toUtc(),
  );
}

class DiagnosticCounter {
  const DiagnosticCounter({
    required this.dayUtc,
    required this.event,
    required this.outcome,
    required this.durationBucket,
    required this.count,
  });

  final String dayUtc;
  final String event;
  final String outcome;
  final String durationBucket;
  final int count;
}
