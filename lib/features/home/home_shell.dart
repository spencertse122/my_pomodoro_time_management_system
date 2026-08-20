import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../data/local/app_database.dart';
import '../../data/session_repository.dart';
import '../../services/auth_service.dart';
import '../../services/notification_service.dart';
import '../dashboard/dashboard_screen.dart';
import '../settings/settings_screen.dart';
import '../timer/timer_controller.dart';
import '../timer/timer_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({
    super.key,
    required this.user,
    required this.authService,
    required this.database,
    required this.sessions,
    required this.settings,
    required this.notifier,
  });

  final AppUser user;
  final AuthService authService;
  final AppDatabase database;
  final SessionRepository sessions;
  final SettingsRepository settings;
  final CompletionNotifier notifier;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  late final TimerController _timer;
  late final Future<void> _initialization;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
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
    _initialization = _initialize();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      if (results.any((result) => result != ConnectivityResult.none)) {
        unawaited(widget.sessions.sync(widget.user.uid));
      }
    });
  }

  Future<void> _initialize() async {
    await _timer.initialize();
    unawaited(widget.sessions.sync(widget.user.uid));
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _timer.dispose();
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
              child: Text('Could not open your local data: ${snapshot.error}'),
            ),
          );
        }
        return _buildShell(context);
      },
    );
  }

  Widget _buildShell(BuildContext context) {
    final pages = [
      TimerScreen(controller: _timer),
      DashboardScreen(userId: widget.user.uid, sessions: widget.sessions),
      SettingsScreen(controller: _timer),
    ];
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: (value) => setState(() => _index = value),
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Icon(
                Icons.timer_outlined,
                size: 34,
                color: Theme.of(context).colorScheme.primary,
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
}
