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

  Future<void> initialize() async {
    if (_initialized || (!Platform.isMacOS && !Platform.isWindows)) return;
    await windowManager.ensureInitialized();
    windowManager.addListener(this);
    await windowManager.setPreventClose(true);
    trayManager.addListener(this);
    await trayManager.setIcon(
      Platform.isMacOS
          ? 'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png'
          : 'windows/runner/resources/app_icon.ico',
      isTemplate: Platform.isMacOS,
    );
    await trayManager.setToolTip('Focus Flow');
    await refreshMenu();
    _initialized = true;
  }

  Future<void> refreshMenu() async {
    if ((!Platform.isMacOS && !Platform.isWindows)) return;
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
  void onTrayIconMouseDown() => unawaited(_showWindow());

  @override
  void onTrayMenuItemClick(MenuItem menuItem) {
    switch (menuItem.key) {
      case 'show':
        unawaited(_showWindow());
      case 'toggle-tracking':
        unawaited(_toggleTracking());
      case 'quit':
        unawaited(_quit());
    }
  }

  @override
  void onWindowClose() => unawaited(windowManager.hide());

  Future<void> _showWindow() async {
    await windowManager.show();
    await windowManager.focus();
  }

  Future<void> _toggleTracking() async {
    await _onToggleTracking();
    await refreshMenu();
  }

  Future<void> _quit() async {
    await windowManager.setPreventClose(false);
    await windowManager.close();
  }

  Future<void> dispose() async {
    if (!_initialized) return;
    windowManager.removeListener(this);
    trayManager.removeListener(this);
    await trayManager.destroy();
    _initialized = false;
  }
}
