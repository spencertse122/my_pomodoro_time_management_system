import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/services/activity_capture_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('focus_flow/activity_capture.test');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() {
    messenger.setMockMethodCallHandler(channel, null);
  });

  test('maps permission results and forwards permission requests', () async {
    final calls = <String>[];
    messenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call.method);
      return call.method == 'permissionStatus' ? 'notDetermined' : 'granted';
    });
    final service = ActivityCaptureService(channel: channel);

    expect(
      await service.permissionStatus(),
      ActivityCapturePermissionStatus.notDetermined,
    );
    expect(
      await service.requestPermission(),
      ActivityCapturePermissionStatus.granted,
    );
    expect(calls, ['permissionStatus', 'requestPermission']);
  });

  test('decodes foreground, idle, and lock state from a snapshot', () async {
    messenger.setMockMethodCallHandler(channel, (_) async {
      return <String, Object?>{
        'capturedAtMilliseconds': 1760000000000,
        'idleMilliseconds': 12345,
        'isIdle': true,
        'isLocked': false,
        'foregroundApplication': <String, Object?>{
          'name': 'Editor',
          'identifier': 'com.example.editor',
          'processId': 42,
          'windowTitle': 'private-local-file.dart',
        },
      };
    });

    final snapshot = await ActivityCaptureService(
      channel: channel,
    ).getActivitySnapshot();

    expect(snapshot.capturedAt.isUtc, isTrue);
    expect(snapshot.idleDuration, const Duration(milliseconds: 12345));
    expect(snapshot.isIdle, isTrue);
    expect(snapshot.isLocked, isFalse);
    expect(snapshot.foregroundApplication?.name, 'Editor');
    expect(snapshot.foregroundApplication?.identifier, 'com.example.editor');
    expect(snapshot.foregroundApplication?.processId, 42);
    expect(
      snapshot.foregroundApplication?.windowTitle,
      'private-local-file.dart',
    );
  });

  test('decodes each display as immutable typed PNG bytes', () async {
    messenger.setMockMethodCallHandler(channel, (_) async {
      return <Object?>[
        <String, Object?>{
          'id': 'display-1',
          'width': 2560,
          'height': 1440,
          'scaleFactor': 2.0,
          'pngBytes': Uint8List.fromList([0x89, 0x50, 0x4e, 0x47]),
        },
        <String, Object?>{
          'id': 'display-2',
          'width': 1920,
          'height': 1080,
          'scaleFactor': 1,
          'pngBytes': Uint8List.fromList([0x89, 0x50, 0x4e, 0x47, 0x0d]),
        },
      ];
    });

    final displays = await ActivityCaptureService(
      channel: channel,
    ).captureDisplays();

    expect(displays, hasLength(2));
    expect(displays.first.id, 'display-1');
    expect(displays.first.scaleFactor, 2.0);
    expect(
      displays.first.pngBytes,
      Uint8List.fromList([0x89, 0x50, 0x4e, 0x47]),
    );
    expect(() => displays.first.pngBytes[0] = 0, throwsUnsupportedError);
  });

  test(
    'launch-at-login calls are typed and preserve requested state',
    () async {
      var enabled = false;
      messenger.setMockMethodCallHandler(channel, (call) async {
        if (call.method == 'setLaunchAtLogin') {
          final arguments = call.arguments as Map<Object?, Object?>;
          enabled = arguments['enabled']! as bool;
        }
        return enabled;
      });
      final service = ActivityCaptureService(channel: channel);

      expect(await service.isLaunchAtLoginEnabled(), isFalse);
      expect(await service.setLaunchAtLogin(true), isTrue);
      expect(await service.isLaunchAtLoginEnabled(), isTrue);
    },
  );

  test(
    'rejects malformed native payloads before they reach persistence',
    () async {
      messenger.setMockMethodCallHandler(channel, (call) async {
        if (call.method == 'captureDisplays') {
          return <Object?>[
            <String, Object?>{
              'id': 'display-1',
              'width': 0,
              'height': 1080,
              'scaleFactor': 1.0,
              'pngBytes': Uint8List(0),
            },
          ];
        }
        return 'unexpected-new-status';
      });
      final service = ActivityCaptureService(channel: channel);

      await expectLater(service.permissionStatus(), throwsFormatException);
      await expectLater(service.captureDisplays(), throwsFormatException);
    },
  );
}
