import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/activity_repository.dart';
import '../../data/local/app_database.dart';
import '../../data/session_repository.dart';
import '../../services/activity_capture_service.dart';
import '../../services/auth_service.dart';
import '../../services/desktop_tray_service.dart';
import '../../services/diagnostics_service.dart';
import '../../services/encrypted_backup_service.dart';
import '../../services/legacy_cloud_migration_service.dart';
import '../../services/local_ai_service.dart';
import '../../services/notification_service.dart';
import '../../services/update_service.dart';
import '../dashboard/dashboard_screen.dart';
import '../onboarding/privacy_onboarding_screen.dart';
import '../settings/settings_screen.dart';
import '../timer/timer_controller.dart';
import '../timer/timer_screen.dart';
import '../tracking/activity_tracking_controller.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.user,
    required this.authService,
    required this.database,
    required this.sessions,
    required this.settings,
    required this.activities,
    required this.categories,
    required this.trackingSettings,
    required this.insights,
    required this.capture,
    required this.createLocalAi,
    required this.backup,
    required this.diagnostics,
    required this.migration,
    required this.updates,
    required this.notifier,
  });

  final AppUser user;
  final AuthService authService;
  final AppDatabase database;
  final SessionRepository sessions;
  final SettingsRepository settings;
  final ActivityRepository activities;
  final CategoryRepository categories;
  final TrackingSettingsRepository trackingSettings;
  final InsightRepository insights;
  final ActivityCaptureService capture;
  final LocalAiService Function() createLocalAi;
  final EncryptedBackupService backup;
  final DiagnosticsService diagnostics;
  final LegacyCloudMigrationService migration;
  final UpdateService updates;
  final CompletionNotifier notifier;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late final TimerController _timer;
  late final ActivityTrackingController _tracking;
  late final DesktopTrayService _tray;
  late final Future<void> _initialization;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = TimerController(
      userId: widget.user.uid,
      database: widget.database,
      sessions: widget.sessions,
      settings: widget.settings,
      notifier: widget.notifier,
    );
    _tracking = ActivityTrackingController(
      userId: widget.user.uid,
      activities: widget.activities,
      categories: widget.categories,
      settings: widget.trackingSettings,
      insights: widget.insights,
      sessions: widget.sessions,
      capture: widget.capture,
      localAi: widget.createLocalAi(),
      diagnosticsDatabase: widget.database,
      diagnostics: widget.diagnostics,
    )..addListener(_trackingChanged);
    _tray = DesktopTrayService(
      onToggleTracking: _tracking.togglePause,
      isTrackingPaused: () => !_tracking.isActivelyTracking,
    );
    _initialization = _initialize();
  }

  Future<void> _initialize() async {
    await Future.wait([_timer.initialize(), _tracking.initialize()]);
    await _tray.initialize();
  }

  void _trackingChanged() {
    if (!mounted) return;
    setState(() {});
    unawaited(_tray.refreshMenu());
  }

  @override
  void dispose() {
    _tracking.removeListener(_trackingChanged);
    _timer.dispose();
    _tracking.dispose();
    unawaited(_tray.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Text(
                  'Focus Flow could not open its private local services.\n\n'
                  '${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        final needsPrivacyConsent =
            !_tracking.settings.onboardingComplete ||
            _tracking.settings.privacyNoticeVersion <
                ActivityTrackingController.privacyNoticeVersion;
        if (needsPrivacyConsent) {
          return PrivacyOnboardingScreen(
            onEnableTracking: _tracking.completeOnboardingAndEnable,
            onContinueWithoutTracking:
                _tracking.completeOnboardingWithoutTracking,
          );
        }
        return _buildShell(context);
      },
    );
  }

  Widget _buildShell(BuildContext context) {
    final pages = [
      TimerScreen(controller: _timer),
      DashboardScreen(
        userId: widget.user.uid,
        sessions: widget.sessions,
        activities: widget.activities,
        categories: widget.categories,
        insights: widget.insights,
        onGenerateInsight: _tracking.generateDailyInsight,
        onExcludeApp: _tracking.excludeApp,
      ),
      SettingsScreen(
        controller: _timer,
        userId: widget.user.uid,
        tracking: _tracking,
        categories: widget.categories,
        backup: widget.backup,
        migration: widget.migration,
        updates: widget.updates,
        onDeleteAccount: _deleteAccount,
      ),
    ];
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: (value) => setState(() => _index = value),
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Column(
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 32,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 14),
                  Tooltip(
                    message: _trackingStatusLabel,
                    child: Icon(
                      _tracking.isActivelyTracking
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      size: 18,
                      color: _tracking.isActivelyTracking
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.outline,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: IconButton(
                    tooltip: 'Sign out',
                    onPressed: widget.authService.signOut,
                    icon: const Icon(Icons.logout),
                  ),
                ),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.hourglass_empty),
                selectedIcon: Icon(Icons.hourglass_top),
                label: Text('Timer'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.view_timeline_outlined),
                selectedIcon: Icon(Icons.view_timeline),
                label: Text('Day'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.tune_outlined),
                selectedIcon: Icon(Icons.tune),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: IndexedStack(index: _index, children: pages),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount() async {
    await _tracking.disableTracking();
    await widget.database.deleteUserData(widget.user.uid);
    await widget.authService.deleteAccount();
  }

  String get _trackingStatusLabel => switch (_tracking.status) {
    ActivityTrackingStatus.disabled => 'Activity tracking is off',
    ActivityTrackingStatus.paused => 'Activity tracking is paused',
    ActivityTrackingStatus.waiting => 'Activity tracking is on',
    ActivityTrackingStatus.capturing => 'Capturing connected displays',
    ActivityTrackingStatus.analyzing => 'Gemma is analyzing locally',
    ActivityTrackingStatus.idle => 'Paused while you are idle',
    ActivityTrackingStatus.locked => 'Paused while this computer is locked',
    ActivityTrackingStatus.permissionDenied => 'Screen access is unavailable',
    ActivityTrackingStatus.metadataOnly => 'Keeping metadata only',
    ActivityTrackingStatus.error => 'Local activity analysis needs attention',
  };
}
