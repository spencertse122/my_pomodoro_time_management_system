import 'package:flutter/services.dart';

/// The operating-system authorization state for activity and screen capture.
enum ActivityCapturePermissionStatus {
  notDetermined,
  denied,
  granted,
  restricted,
  unsupported;

  static ActivityCapturePermissionStatus fromPlatform(String value) {
    return switch (value) {
      'notDetermined' => ActivityCapturePermissionStatus.notDetermined,
      'denied' => ActivityCapturePermissionStatus.denied,
      'granted' => ActivityCapturePermissionStatus.granted,
      'restricted' => ActivityCapturePermissionStatus.restricted,
      'unsupported' => ActivityCapturePermissionStatus.unsupported,
      _ => throw FormatException(
        'Unknown activity capture permission status: $value',
      ),
    };
  }
}

/// Metadata for the application that owns the foreground window.
final class ForegroundApplication {
  const ForegroundApplication({
    required this.name,
    required this.processId,
    this.identifier,
    this.windowTitle,
  });

  final String name;
  final int processId;
  final String? identifier;
  final String? windowTitle;

  factory ForegroundApplication.fromPlatform(Map<Object?, Object?> value) {
    final name = value['name'];
    final processId = value['processId'];
    if (name is! String || processId is! int) {
      throw const FormatException('Invalid foreground application payload.');
    }
    return ForegroundApplication(
      name: name,
      processId: processId,
      identifier: _optionalString(value['identifier']),
      windowTitle: _optionalString(value['windowTitle']),
    );
  }
}

/// A point-in-time view of foreground activity and input/session state.
final class ActivitySnapshot {
  const ActivitySnapshot({
    required this.capturedAt,
    required this.idleDuration,
    required this.isIdle,
    required this.isLocked,
    this.foregroundApplication,
  });

  final DateTime capturedAt;
  final Duration idleDuration;
  final bool isIdle;
  final bool isLocked;
  final ForegroundApplication? foregroundApplication;

  factory ActivitySnapshot.fromPlatform(Map<Object?, Object?> value) {
    final capturedAtMilliseconds = value['capturedAtMilliseconds'];
    final idleMilliseconds = value['idleMilliseconds'];
    final isIdle = value['isIdle'];
    final isLocked = value['isLocked'];
    if (capturedAtMilliseconds is! int ||
        idleMilliseconds is! int ||
        idleMilliseconds < 0 ||
        isIdle is! bool ||
        isLocked is! bool) {
      throw const FormatException('Invalid activity snapshot payload.');
    }

    final applicationValue = value['foregroundApplication'];
    return ActivitySnapshot(
      capturedAt: DateTime.fromMillisecondsSinceEpoch(
        capturedAtMilliseconds,
        isUtc: true,
      ),
      idleDuration: Duration(milliseconds: idleMilliseconds),
      isIdle: isIdle,
      isLocked: isLocked,
      foregroundApplication: applicationValue == null
          ? null
          : ForegroundApplication.fromPlatform(
              _platformMap(applicationValue, 'foreground application'),
            ),
    );
  }
}

/// An encoded screenshot for one physical display.
///
/// [pngBytes] is never backed by a path or native temporary file. Callers must
/// keep it in memory and discard it immediately after local inference.
final class CapturedDisplay {
  CapturedDisplay({
    required this.id,
    required this.width,
    required this.height,
    required this.scaleFactor,
    required Uint8List pngBytes,
  }) : pngBytes = Uint8List.fromList(pngBytes).asUnmodifiableView();

  final String id;
  final int width;
  final int height;
  final double scaleFactor;
  final Uint8List pngBytes;

  factory CapturedDisplay.fromPlatform(Map<Object?, Object?> value) {
    final id = value['id'];
    final width = value['width'];
    final height = value['height'];
    final scaleFactor = value['scaleFactor'];
    final bytes = value['pngBytes'];
    if (id is! String ||
        width is! int ||
        width <= 0 ||
        height is! int ||
        height <= 0 ||
        scaleFactor is! num ||
        scaleFactor <= 0 ||
        bytes is! Uint8List ||
        bytes.isEmpty) {
      throw const FormatException('Invalid captured display payload.');
    }
    return CapturedDisplay(
      id: id,
      width: width,
      height: height,
      scaleFactor: scaleFactor.toDouble(),
      pngBytes: bytes,
    );
  }
}

/// Typed Dart facade for the desktop `focus_flow/activity_capture` channel.
final class ActivityCaptureService {
  ActivityCaptureService({MethodChannel? channel})
    : _channel = channel ?? const MethodChannel(_channelName);

  static const String _channelName = 'focus_flow/activity_capture';
  final MethodChannel _channel;

  Future<ActivityCapturePermissionStatus> permissionStatus() async {
    final value = await _channel.invokeMethod<String>('permissionStatus');
    if (value == null) {
      throw const FormatException(
        'Missing activity capture permission status.',
      );
    }
    return ActivityCapturePermissionStatus.fromPlatform(value);
  }

  Future<ActivityCapturePermissionStatus> requestPermission() async {
    final value = await _channel.invokeMethod<String>('requestPermission');
    if (value == null) {
      throw const FormatException(
        'Missing activity capture permission status.',
      );
    }
    return ActivityCapturePermissionStatus.fromPlatform(value);
  }

  Future<ActivitySnapshot> getActivitySnapshot() async {
    final value = await _channel.invokeMethod<Object?>('getActivitySnapshot');
    return ActivitySnapshot.fromPlatform(
      _platformMap(value, 'activity snapshot'),
    );
  }

  Future<List<CapturedDisplay>> captureDisplays() async {
    final value = await _channel.invokeMethod<Object?>('captureDisplays');
    if (value is! List<Object?>) {
      throw const FormatException('Invalid captured displays payload.');
    }
    return List<CapturedDisplay>.unmodifiable(
      value.map(
        (display) => CapturedDisplay.fromPlatform(
          _platformMap(display, 'captured display'),
        ),
      ),
    );
  }

  /// Enables or disables launch at user login and returns the resulting state.
  Future<bool> setLaunchAtLogin(bool enabled) async {
    final value = await _channel.invokeMethod<bool>('setLaunchAtLogin', {
      'enabled': enabled,
    });
    if (value == null) {
      throw const FormatException('Missing launch-at-login result.');
    }
    return value;
  }

  Future<bool> isLaunchAtLoginEnabled() async {
    final value = await _channel.invokeMethod<bool>('isLaunchAtLoginEnabled');
    if (value == null) {
      throw const FormatException('Missing launch-at-login state.');
    }
    return value;
  }
}

Map<Object?, Object?> _platformMap(Object? value, String description) {
  if (value is! Map<Object?, Object?>) {
    throw FormatException('Invalid $description payload.');
  }
  return value;
}

String? _optionalString(Object? value) {
  if (value == null) return null;
  if (value is! String) {
    throw const FormatException('Invalid optional string value.');
  }
  return value.isEmpty ? null : value;
}
