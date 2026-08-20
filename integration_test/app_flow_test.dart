import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/core/firebase_config.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/data/session_repository.dart';
import 'package:my_pomodoro_time_management_system/domain/models.dart';
import 'package:my_pomodoro_time_management_system/services/auth_service.dart';

void main() {
  const email = String.fromEnvironment('TEST_EMAIL');
  const password = String.fromEnvironment('TEST_PASSWORD');

  test('Firebase authenticates while work records remain local', () async {
    expect(email, isNotEmpty, reason: 'Pass TEST_EMAIL with --dart-define.');
    expect(
      password,
      isNotEmpty,
      reason: 'Pass TEST_PASSWORD with --dart-define.',
    );

    const config = FirebaseConfig.macos;
    final database = AppDatabase(NativeDatabase.memory());
    final auth = await AuthService.create(
      database: database,
      apiKey: config.apiKey,
    );
    await auth.signIn(email, password);
    final userId = auth.currentUser!.uid;
    final sessions = SessionRepository(database);
    final now = DateTime.now().toUtc();
    await sessions.save(
      WorkSession(
        id: 'local-${now.microsecondsSinceEpoch}',
        userId: userId,
        cycleId: 'local-only-cycle',
        phase: TimerPhase.focus,
        activity: 'Local-only integration test',
        plannedSeconds: 60,
        actualSeconds: 2,
        startedAt: now.subtract(const Duration(seconds: 2)),
        endedAt: now,
        outcome: SessionOutcome.stopped,
        updatedAt: now,
      ),
    );

    expect(await sessions.all(userId), hasLength(1));
    expect(await auth.idToken(), isNotEmpty);
    await auth.signOut();
    expect(await database.storedAuth(), isNull);
    expect(await sessions.all(userId), hasLength(1));
    await database.close();
  }, timeout: const Timeout(Duration(minutes: 2)));
}
