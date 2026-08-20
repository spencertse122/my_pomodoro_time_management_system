import 'package:drift/drift.dart' show Variable;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/data/activity_repository.dart';
import 'package:my_pomodoro_time_management_system/data/session_repository.dart';
import 'package:my_pomodoro_time_management_system/domain/models.dart';

void main() {
  late AppDatabase database;
  late SessionRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = SessionRepository(database);
  });

  tearDown(() => database.close());

  test('sessions are isolated by user and local calendar day', () async {
    final start = DateTime(2026, 8, 20, 10).toUtc();
    await repository.save(_session('one', 'user-1', start));
    await repository.save(_session('two', 'user-2', start));

    final result = await repository
        .watchDay('user-1', DateTime(2026, 8, 20))
        .first;

    expect(result.map((session) => session.id), ['one']);
  });

  test(
    'editing keeps timestamps immutable and deletion removes local data',
    () async {
      final original = _session('one', 'user-1', DateTime.now().toUtc());
      await repository.save(original);
      await repository.editActivity(original, 'Updated label');

      final edited = await database.sessionById('one');
      expect(edited!.activity, 'Updated label');
      expect(
        edited.startedAt.millisecondsSinceEpoch ~/ 1000,
        original.startedAt.millisecondsSinceEpoch ~/ 1000,
      );
      expect(
        edited.endedAt.millisecondsSinceEpoch ~/ 1000,
        original.endedAt.millisecondsSinceEpoch ~/ 1000,
      );

      await repository.delete(edited);
      final deleted = await database.sessionById('one');
      expect(deleted, isNull);
    },
  );

  test('privacy onboarding and tracking controls persist locally', () async {
    final tracking = TrackingSettingsRepository(database);
    const settings = TrackingSettings(
      trackingEnabled: true,
      captureIntervalMinutes: 7,
      idleThresholdMinutes: 9,
      onboardingComplete: true,
      privacyNoticeVersion: 1,
      diagnosticsEnabled: false,
      excludedAppIds: ['com.example.private'],
    );

    await tracking.save('user-1', settings);
    final restored = await tracking.get('user-1');

    expect(restored.trackingEnabled, isTrue);
    expect(restored.captureIntervalMinutes, 7);
    expect(restored.onboardingComplete, isTrue);
    expect(restored.privacyNoticeVersion, 1);
    expect(restored.diagnosticsEnabled, isFalse);
    expect(restored.excludedAppIds, ['com.example.private']);
  });

  test(
    'account deletion clears every user-scoped table only for that user',
    () async {
      final now = DateTime.utc(2026, 8, 20, 12);
      await repository.save(_session('user-one-session', 'user-1', now));
      await repository.save(_session('user-two-session', 'user-2', now));
      await database.saveTimer(TimerSnapshot.idle('user-1'));
      await database.saveSettings('user-1', const PomodoroSettings());
      final categories = CategoryRepository(database);
      await categories.ensureDefaults('user-1');
      final activities = ActivityRepository(database);
      await activities.saveSample(
        ActivitySample(
          id: 'sample-1',
          userId: 'user-1',
          capturedAt: now,
          startedAt: now.subtract(const Duration(minutes: 5)),
          endedAt: now,
          appId: 'com.example.private',
          appName: 'Private app',
          windowTitle: 'Private title',
          processingState: ActivityProcessingState.metadataOnly,
          updatedAt: now,
        ),
      );
      await database.upsertCategoryRule(
        CategoryRule(
          id: 'rule-1',
          userId: 'user-1',
          appId: 'com.example.private',
          categoryId: (await categories.get('user-1')).first.id,
          updatedAt: now,
        ),
      );
      await database.saveDailyInsight(
        DailyInsight(
          userId: 'user-1',
          localDate: now,
          summary: 'Private summary',
          patterns: const ['Private pattern'],
          discrepancies: const [],
          modelVersion: 'test',
          promptVersion: 'test',
          sourceUpdatedAt: now,
          generatedAt: now,
        ),
      );
      await TrackingSettingsRepository(
        database,
      ).save('user-1', const TrackingSettings(onboardingComplete: true));
      await database.saveLegacyMigrationState(
        LegacyMigrationState.notStarted('user-1'),
      );

      await database.deleteUserData('user-1');

      for (final table in const [
        'session_entries',
        'timer_entries',
        'settings_entries',
        'activity_sample_entries',
        'activity_block_entries',
        'category_rule_entries',
        'category_entries',
        'daily_insight_entries',
        'tracking_settings_entries',
        'migration_state_entries',
      ]) {
        final count = await database
            .customSelect(
              'SELECT count(*) AS records FROM $table WHERE user_id = ?',
              variables: const [Variable<String>('user-1')],
            )
            .getSingle();
        expect(count.read<int>('records'), 0, reason: table);
      }
      expect(
        (await database.sessionById('user-two-session'))?.userId,
        'user-2',
      );
    },
  );
}

WorkSession _session(String id, String userId, DateTime start) => WorkSession(
  id: id,
  userId: userId,
  cycleId: 'cycle',
  phase: TimerPhase.focus,
  activity: 'Test activity',
  plannedSeconds: 1500,
  actualSeconds: 1500,
  startedAt: start,
  endedAt: start.add(const Duration(minutes: 25)),
  outcome: SessionOutcome.completed,
  updatedAt: start,
);
