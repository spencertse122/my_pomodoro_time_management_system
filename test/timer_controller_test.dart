import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/data/session_repository.dart';
import 'package:my_pomodoro_time_management_system/domain/models.dart';
import 'package:my_pomodoro_time_management_system/features/timer/timer_controller.dart';
import 'package:my_pomodoro_time_management_system/services/notification_service.dart';

class FakeNotifier implements CompletionNotifier {
  FakeNotifier({this.throwOnCompletion = false});

  final bool throwOnCompletion;
  int completionCount = 0;

  @override
  Future<void> initialize() async {}

  @override
  Future<void> showCompletion(
    TimerPhase phase, {
    required bool playSound,
  }) async {
    completionCount++;
    if (throwOnCompletion) throw StateError('Notification backend failed.');
  }
}

void main() {
  late AppDatabase database;
  late SessionRepository sessions;
  late SettingsRepository settings;
  late FakeNotifier notifier;
  late DateTime now;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    sessions = SessionRepository(database);
    settings = SettingsRepository(database);
    notifier = FakeNotifier();
    now = DateTime.utc(2026, 8, 20, 9);
  });

  tearDown(() => database.close());

  TimerController createController({CompletionNotifier? completionNotifier}) =>
      TimerController(
        userId: 'user-1',
        database: database,
        sessions: sessions,
        settings: settings,
        notifier: completionNotifier ?? notifier,
        now: () => now,
      );

  test(
    'stopping early records actual focus time as a partial session',
    () async {
      final controller = createController();
      await controller.initialize();
      await controller.startFocus('Write release notes');

      now = now.add(const Duration(minutes: 7));
      await controller.stop();

      final saved = await database.allSessions('user-1');
      expect(saved, hasLength(1));
      expect(saved.single.activity, 'Write release notes');
      expect(saved.single.actualSeconds, 7 * 60);
      expect(saved.single.outcome, SessionOutcome.stopped);
      expect(controller.snapshot.state, TimerRunState.idle);
      controller.dispose();
    },
  );

  test('paused timers do not count wall-clock time while paused', () async {
    final controller = createController();
    await controller.initialize();
    await controller.startFocus('Review designs');
    now = now.add(const Duration(minutes: 3));

    await controller.pause();
    final remainingWhenPaused = controller.remainingSeconds;
    now = now.add(const Duration(hours: 2));
    expect(controller.remainingSeconds, remainingWhenPaused);

    await controller.resume();
    expect(controller.remainingSeconds, remainingWhenPaused);
    controller.dispose();
  });

  test('partial seconds neither tick early nor inflate stopped time', () async {
    final controller = createController();
    await controller.initialize();
    await controller.startFocus('Measure precisely');

    now = now.add(const Duration(milliseconds: 500));
    expect(controller.remainingSeconds, 25 * 60);
    await controller.stop();

    final saved = await database.allSessions('user-1');
    expect(saved.single.actualSeconds, 0);
    controller.dispose();
  });

  test('rejects focus descriptions above the persisted limit', () async {
    final controller = createController();
    await controller.initialize();

    await expectLater(
      controller.startFocus(List.filled(161, 'x').join()),
      throwsArgumentError,
    );
    expect(await database.activeTimer('user-1'), isNull);
    controller.dispose();
  });

  test('an elapsed persisted focus is recovered and completed once', () async {
    await database.saveTimer(
      TimerSnapshot(
        userId: 'user-1',
        state: TimerRunState.running,
        phase: TimerPhase.focus,
        activity: 'Deep work',
        cycleId: 'cycle-1',
        completedFocusesInCycle: 0,
        plannedSeconds: 25 * 60,
        accumulatedSeconds: 0,
        startedAt: now.subtract(const Duration(minutes: 25)),
        deadline: now.subtract(const Duration(seconds: 1)),
        updatedAt: now,
      ),
    );

    final controller = createController();
    await controller.initialize();

    expect(controller.snapshot.state, TimerRunState.awaitingNext);
    expect(controller.suggestedPhase, TimerPhase.shortBreak);
    expect(notifier.completionCount, 0);
    final saved = await database.allSessions('user-1');
    expect(saved, hasLength(1));
    expect(saved.single.outcome, SessionOutcome.completed);
    expect(saved.single.actualSeconds, 25 * 60);
    controller.dispose();
  });

  test('fourth recovered focus suggests a long break', () async {
    await database.saveTimer(
      TimerSnapshot(
        userId: 'user-1',
        state: TimerRunState.running,
        phase: TimerPhase.focus,
        activity: 'Final focus',
        cycleId: 'cycle-1',
        completedFocusesInCycle: 3,
        plannedSeconds: 25 * 60,
        accumulatedSeconds: 0,
        startedAt: now.subtract(const Duration(minutes: 25)),
        deadline: now.subtract(const Duration(seconds: 1)),
        updatedAt: now,
      ),
    );

    final controller = createController();
    await controller.initialize();

    expect(controller.snapshot.completedFocusesInCycle, 4);
    expect(controller.suggestedPhase, TimerPhase.longBreak);
    controller.dispose();
  });

  test('account-deletion suspension blocks later timer writes', () async {
    final controller = createController();
    await controller.initialize();
    await controller.startFocus('Sensitive work');

    await controller.suspendForAccountDeletion();
    await database.deleteUserData('user-1');

    await expectLater(controller.stop(), throwsStateError);
    expect(await database.activeTimer('user-1'), isNull);
    expect(await database.allSessions('user-1'), isEmpty);
    controller.dispose();
  });

  test('notification failure does not undo a completed timer', () async {
    await database.saveTimer(
      TimerSnapshot(
        userId: 'user-1',
        state: TimerRunState.running,
        phase: TimerPhase.focus,
        activity: 'Finish safely',
        cycleId: 'cycle-notification',
        completedFocusesInCycle: 0,
        plannedSeconds: 1,
        accumulatedSeconds: 0,
        startedAt: now,
        deadline: now.add(const Duration(seconds: 1)),
        updatedAt: now,
      ),
    );
    final failingNotifier = FakeNotifier(throwOnCompletion: true);
    final controller = createController(completionNotifier: failingNotifier);
    await controller.initialize();
    now = now.add(const Duration(seconds: 2));

    await Future<void>.delayed(const Duration(milliseconds: 1100));

    expect(controller.snapshot.state, TimerRunState.awaitingNext);
    expect(failingNotifier.completionCount, 1);
    expect(await database.allSessions('user-1'), hasLength(1));
    controller.dispose();
  });
}
