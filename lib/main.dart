import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/firebase_config.dart';
import 'data/activity_repository.dart';
import 'data/local/app_database.dart';
import 'data/local/encrypted_database.dart';
import 'data/session_repository.dart';
import 'services/activity_capture_service.dart';
import 'services/auth_service.dart';
import 'services/diagnostics_service.dart';
import 'services/encrypted_backup_service.dart';
import 'services/firestore_rest_client.dart';
import 'services/legacy_cloud_migration_service.dart';
import 'services/local_ai_service.dart';
import 'services/model_asset_locator.dart';
import 'services/notification_service.dart';
import 'services/secure_store.dart';
import 'services/update_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notifier = DesktopCompletionNotifier();
  String? startupError;
  AppDatabase? database;
  AuthService? authService;
  SessionRepository? sessionRepository;
  SettingsRepository? settingsRepository;
  ActivityRepository? activityRepository;
  CategoryRepository? categoryRepository;
  TrackingSettingsRepository? trackingSettingsRepository;
  InsightRepository? insightRepository;
  EncryptedBackupService? backupService;
  LegacyCloudMigrationService? migrationService;
  LocalAiService Function()? createLocalAi;

  try {
    await notifier.initialize();
  } on Object {
    // The timer and local history remain usable if notifications are blocked.
  }

  try {
    final secureStore = SecureStore();
    final databaseKey = await secureStore.databaseKey();
    final directory = await getApplicationSupportDirectory();
    final legacyDirectory = await getApplicationDocumentsDirectory();
    database = await EncryptedDatabase.open(
      databaseKey,
      applicationDirectory: directory,
      legacyApplicationDirectory: legacyDirectory,
    );
    final config = FirebaseConfig.currentPlatform;
    authService = await AuthService.create(
      database: database,
      apiKey: config.apiKey,
      secureStore: secureStore,
    );
    final firestore = FirestoreRestClient(
      projectId: config.projectId,
      auth: authService,
    );
    sessionRepository = SessionRepository(database);
    settingsRepository = SettingsRepository(database);
    activityRepository = ActivityRepository(database);
    categoryRepository = CategoryRepository(database);
    trackingSettingsRepository = TrackingSettingsRepository(database);
    insightRepository = InsightRepository(database);
    backupService = EncryptedBackupService(
      database: database,
      databaseKey: databaseKey,
      applicationDirectory: directory,
    );
    migrationService = LegacyCloudMigrationService(database, firestore);
    final modelPaths = await const ModelAssetLocator().locateOrExpected();
    createLocalAi = () => GemmaLocalAiService(
      modelPath: modelPaths.model,
      projectorPath: modelPaths.projector,
    );
  } on Object {
    startupError =
        'Focus Flow could not unlock its encrypted local storage. Confirm that '
        'OS credential storage is available, then restart the app.';
  }

  runApp(
    PomodoroApp(
      database: database,
      notifier: notifier,
      authService: authService,
      sessionRepository: sessionRepository,
      settingsRepository: settingsRepository,
      activityRepository: activityRepository,
      categoryRepository: categoryRepository,
      trackingSettingsRepository: trackingSettingsRepository,
      insightRepository: insightRepository,
      captureService: ActivityCaptureService(),
      createLocalAi: createLocalAi,
      backupService: backupService,
      diagnosticsService: DiagnosticsService(),
      migrationService: migrationService,
      updateService: UpdateService(),
      startupError: startupError,
    ),
  );
}
