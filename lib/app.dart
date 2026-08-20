import 'package:flutter/material.dart';

import 'data/local/app_database.dart';
import 'data/session_repository.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/home_shell.dart';
import 'services/auth_service.dart';
import 'services/notification_service.dart';

class PomodoroApp extends StatelessWidget {
  const PomodoroApp({
    super.key,
    required this.database,
    required this.notifier,
    required this.authService,
    required this.sessionRepository,
    required this.settingsRepository,
    this.startupError,
  });

  final AppDatabase database;
  final CompletionNotifier notifier;
  final AuthService? authService;
  final SessionRepository? sessionRepository;
  final SettingsRepository? settingsRepository;
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
    final auth = authService;
    final sessions = sessionRepository;
    final settings = settingsRepository;
    if (startupError != null) return ConfigurationScreen(error: startupError);
    if (auth == null || sessions == null || settings == null) {
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
          constraints: const BoxConstraints(maxWidth: 620),
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
                      Icons.local_fire_department_outlined,
                      size: 46,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      error == null
                          ? 'Firebase configuration is unavailable'
                          : 'Firebase could not start',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      error ??
                          'Verify the Firebase project values in lib/core/firebase_config.dart, then restart the app.',
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
