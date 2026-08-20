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
