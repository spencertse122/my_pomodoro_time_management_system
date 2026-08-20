import 'package:flutter/material.dart';

import 'app.dart';
import 'core/firebase_config.dart';
import 'data/local/app_database.dart';
import 'data/session_repository.dart';
import 'data/sync_service.dart';
import 'services/auth_service.dart';
import 'services/firestore_rest_client.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase.defaults();
  final notifier = DesktopCompletionNotifier();
  String? startupError;
  AuthService? authService;
  SessionRepository? sessionRepository;
  SettingsRepository? settingsRepository;

  try {
    await notifier.initialize();
  } on Object {
    // The timer and local history remain usable if notifications are blocked.
  }

  try {
    final config = FirebaseConfig.currentPlatform;
    authService = await AuthService.create(
      database: database,
      apiKey: config.apiKey,
    );
    final firestore = FirestoreRestClient(
      projectId: config.projectId,
      auth: authService,
    );
    final sync = SyncService(database, firestore);
    sessionRepository = SessionRepository(database, sync);
    settingsRepository = SettingsRepository(database, sync);
  } on Object catch (error) {
    startupError = error.toString();
  }

  runApp(
    PomodoroApp(
      database: database,
      notifier: notifier,
      authService: authService,
      sessionRepository: sessionRepository,
      settingsRepository: settingsRepository,
      startupError: startupError,
    ),
  );
}
