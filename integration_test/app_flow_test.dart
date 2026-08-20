import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/core/firebase_config.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/data/session_repository.dart';
import 'package:my_pomodoro_time_management_system/data/sync_service.dart';
import 'package:my_pomodoro_time_management_system/domain/models.dart';
import 'package:my_pomodoro_time_management_system/services/auth_service.dart';
import 'package:my_pomodoro_time_management_system/services/firestore_rest_client.dart';

void main() {
  const email = String.fromEnvironment('TEST_EMAIL');
  const password = String.fromEnvironment('TEST_PASSWORD');

  test(
    'Firebase Auth and Firestore synchronize the complete session flow',
    () async {
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

      final restored = await AuthService.create(
        database: database,
        apiKey: config.apiKey,
      );
      expect(restored.currentUser?.uid, userId);

      final firestore = FirestoreRestClient(
        projectId: config.projectId,
        auth: auth,
      );
      final sync = SyncService(database, firestore);
      final sessions = SessionRepository(database);
      final settings = SettingsRepository(database);
      final now = DateTime.now().toUtc();
      final session = WorkSession(
        id: 'e2e-${now.microsecondsSinceEpoch}',
        userId: userId,
        cycleId: 'e2e-cycle',
        phase: TimerPhase.focus,
        activity: 'Integration test focus',
        plannedSeconds: 60,
        actualSeconds: 2,
        startedAt: now.subtract(const Duration(seconds: 2)),
        endedAt: now,
        outcome: SessionOutcome.stopped,
        updatedAt: now,
        isDirty: true,
      );

      await sessions.save(session);
      await settings.save(userId, const PomodoroSettings(focusMinutes: 1));
      await sync.syncUser(userId);

      var remote = await firestore.getDocument(
        'users/$userId/sessions/${session.id}',
      );
      expect(remote?.fields['activity'], 'Integration test focus');
      expect(remote?.fields['outcome'], 'stopped');
      expect(remote?.fields['actualSeconds'], 2);
      final remoteSettings = await firestore.getDocument(
        'users/$userId/settings/pomodoro',
      );
      expect(remoteSettings?.fields['focusMinutes'], 1);

      await sessions.editActivity(session, 'Edited integration focus');
      await sync.syncUser(userId);
      remote = await firestore.getDocument(
        'users/$userId/sessions/${session.id}',
      );
      expect(remote?.fields['activity'], 'Edited integration focus');

      final edited = await database.sessionById(session.id);
      await sessions.delete(edited!);
      await sync.syncUser(userId);
      remote = await firestore.getDocument(
        'users/$userId/sessions/${session.id}',
      );
      expect(remote?.fields['isDeleted'], isTrue);

      await auth.signOut();
      expect(await database.storedAuth(), isNull);
      await database.close();
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
