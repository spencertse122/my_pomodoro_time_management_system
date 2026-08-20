import 'package:flutter/material.dart';

import 'data/activity_repository.dart';
import 'data/local/app_database.dart';
import 'data/session_repository.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/home_shell.dart';
import 'services/activity_capture_service.dart';
import 'services/auth_service.dart';
import 'services/diagnostics_service.dart';
import 'services/encrypted_backup_service.dart';
import 'services/legacy_cloud_migration_service.dart';
import 'services/local_ai_service.dart';
import 'services/notification_service.dart';
import 'services/update_service.dart';

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({
    super.key,
    required this.database,
    required this.notifier,
    required this.authService,
    required this.sessionRepository,
    required this.settingsRepository,
    required this.activityRepository,
    required this.categoryRepository,
    required this.trackingSettingsRepository,
    required this.insightRepository,
    required this.captureService,
    required this.createLocalAi,
    required this.backupService,
    required this.diagnosticsService,
    required this.migrationService,
    required this.updateService,
    this.startupError,
  });

  final AppDatabase? database;
  final CompletionNotifier notifier;
  final AuthService? authService;
  final SessionRepository? sessionRepository;
  final SettingsRepository? settingsRepository;
  final ActivityRepository? activityRepository;
  final CategoryRepository? categoryRepository;
  final TrackingSettingsRepository? trackingSettingsRepository;
  final InsightRepository? insightRepository;
  final ActivityCaptureService captureService;
  final LocalAiService Function()? createLocalAi;
  final EncryptedBackupService? backupService;
  final DiagnosticsService diagnosticsService;
  final LegacyCloudMigrationService? migrationService;
  final UpdateService updateService;
  final String? startupError;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xff416d63),
      surface: const Color(0xfff7f7f2),
    );
    return MaterialApp(
      title: 'Focus Flow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAlias,
        ),
      ),
      home: _root(),
    );
  }

  Widget _root() {
    final database = this.database;
    final auth = authService;
    final sessions = sessionRepository;
    final settings = settingsRepository;
    final activities = activityRepository;
    final categories = categoryRepository;
    final trackingSettings = trackingSettingsRepository;
    final insights = insightRepository;
    final localAi = createLocalAi;
    final backup = backupService;
    final migration = migrationService;
    if (startupError != null) return ConfigurationScreen(error: startupError);
    if (database == null ||
        auth == null ||
        sessions == null ||
        settings == null ||
        activities == null ||
        categories == null ||
        trackingSettings == null ||
        insights == null ||
        localAi == null ||
        backup == null ||
        migration == null) {
      return const ConfigurationScreen();
    }
    return StreamBuilder<AppUser?>(
      stream: auth.userChanges,
      initialData: auth.currentUser,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return AuthScreen(authService: auth);
        return HomeShell(
          key: ValueKey(user.uid),
          user: user,
          authService: auth,
          database: database,
          sessions: sessions,
          settings: settings,
          activities: activities,
          categories: categories,
          trackingSettings: trackingSettings,
          insights: insights,
          capture: captureService,
          createLocalAi: localAi,
          backup: backup,
          diagnostics: diagnosticsService,
          migration: migration,
          updates: updateService,
          notifier: notifier,
        );
      },
    );
  }
}

class ConfigurationScreen extends StatelessWidget {
  const ConfigurationScreen({super.key, this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 660),
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 46,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      error == null
                          ? 'Private storage configuration is unavailable'
                          : 'Focus Flow could not start securely',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      error ??
                          'Focus Flow requires OS-protected credential storage, '
                              'the encrypted SQLite runtime, and valid Firebase '
                              'Authentication configuration. It will not fall back '
                              'to plaintext activity storage.',
                    ),
                    if (error != null) ...[
                      const SizedBox(height: 16),
                      SelectableText(
                        error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
