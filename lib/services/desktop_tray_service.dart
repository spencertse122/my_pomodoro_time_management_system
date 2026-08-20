import 'dart:async';
import 'dart:io';

import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class DesktopTrayService with TrayListener, WindowListener {
  DesktopTrayService({
    required Future<void> Function() onToggleTracking,
    required bool Function() isTrackingPaused,
  }) : _onToggleTracking = onToggleTracking,
       _isTrackingPaused = isTrackingPaused;

  final Future<void> Function() _onToggleTracking;
  final bool Function() _isTrackingPaused;
  bool _initialized = false;
  bool _windowListenerAdded = false;
  bool _trayListenerAdded = false;
  bool _preventCloseEnabled = false;
  bool _quitting = false;

  Future<void> initialize() async {
    if (_initialized || (!Platform.isMacOS && !Platform.isWindows)) return;
    try {
      await windowManager.ensureInitialized();
      windowManager.addListener(this);
      _windowListenerAdded = true;
      await windowManager.setPreventClose(true);
      _preventCloseEnabled = true;
      trayManager.addListener(this);
      _trayListenerAdded = true;
      await trayManager.setIcon(
        Platform.isMacOS
            ? 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png'
            : 'windows/runner/resources/app_icon.ico',
        isTemplate: Platform.isMacOS,
      );
      await trayManager.setToolTip('Focus Flow');
      await _setContextMenu();
      _initialized = true;
    } on Object {
      // A missing tray implementation must never leave an invisible window
      // that cannot be closed. Roll back prevent-close and all listeners before
      // allowing the main application to continue without tray integration.
      await _resetPlatformState();
      rethrow;
    }
  }

  Future<void> refreshMenu() async {
    if (!_initialized) return;
    await _setContextMenu();
  }

  Future<void> _setContextMenu() async {
    final paused = _isTrackingPaused();
    await trayManager.setContextMenu(
      Menu(
        items: [
          MenuItem(key: 'show', label: 'Show Focus Flow'),
          MenuItem(
            key: 'toggle-tracking',
            label: paused
                ? 'Resume activity tracking'
                : 'Pause activity tracking',
          ),
          MenuItem.separator(),
          MenuItem(key: 'quit', label: 'Quit Focus Flow'),
        ],
      ),
    );
  }

  @override
  void onTrayIconMouseDown() => unawaited(_bestEffort(_showWindow));

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case 'show':
        unawaited(_bestEffort(_showWindow));
      case 'toggle-tracking':
        unawaited(_bestEffort(_toggleTracking));
      case 'quit':
        unawaited(_bestEffort(_quit));
    }
  }

  @override
  void onWindowClose() {
    if (_quitting || !_initialized || !_preventCloseEnabled) return;
    unawaited(_bestEffort(windowManager.hide));
  }

  Future<void> _showWindow() async {
    await windowManager.show();
    await windowManager.focus();
  }

  Future<void> _toggleTracking() async {
    await _onToggleTracking();
    await refreshMenu();
  }

  Future<void> _quit() async {
    _quitting = true;
    try {
      await windowManager.setPreventClose(false);
      _preventCloseEnabled = false;
      await windowManager.close();
    } on Object {
      _quitting = false;
      try {
        await windowManager.setPreventClose(true);
        _preventCloseEnabled = true;
      } on Object {
        // The host window may have closed while reporting an error.
      }
      rethrow;
    }
  }

  Future<void> dispose() async {
    await _resetPlatformState();
  }

  Future<void> _resetPlatformState() async {
    _initialized = false;
    _quitting = false;
    if (_trayListenerAdded) {
      trayManager.removeListener(this);
      _trayListenerAdded = false;
    }
    try {
      await trayManager.destroy();
    } on Object {
      // Best effort during failed initialization and application teardown.
    }
    if (_preventCloseEnabled) {
      try {
        await windowManager.setPreventClose(false);
      } on Object {
        // The host window may already be gone during teardown.
      }
      _preventCloseEnabled = false;
    }
    if (_windowListenerAdded) {
      windowManager.removeListener(this);
      _windowListenerAdded = false;
    }
  }

  Future<void> _bestEffort(Future<void> Function() operation) async {
    try {
      await operation();
    } on Object {
      // Tray actions are optional conveniences and must not surface uncaught
      // asynchronous errors into the application's root zone.
    }
  }
}
