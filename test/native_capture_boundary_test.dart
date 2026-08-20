import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Windows capture fails closed when self-exclusion is unavailable', () {
    final plugin = File(
      'windows/runner/activity_capture_plugin.cpp',
    ).readAsStringSync();
    final window = File('windows/runner/flutter_window.cpp').readAsStringSync();

    expect(window, contains('WDA_EXCLUDEFROMCAPTURE'));
    expect(window, contains('capture_exclusion_ready_'));
    expect(plugin, contains('privacy-exclusion-unavailable'));
    expect(plugin, contains('if (!*capture_exclusion_ready)'));
    expect(plugin, contains('EncodableValue("restricted")'));
    expect(plugin, contains('WTSSessionInfoEx'));
    expect(plugin, contains('WTS_SESSIONSTATE_UNLOCK'));
    expect(
      plugin,
      contains('CurrentSessionLockState().value_or(*session_locked)'),
    );
    expect(plugin, contains('CurrentSessionLockState().value_or(true)'));
  });

  test('Windows sends only the logical in-memory PNG stream', () {
    final plugin = File(
      'windows/runner/activity_capture_plugin.cpp',
    ).readAsStringSync();
    final cmake = File('windows/runner/CMakeLists.txt').readAsStringSync();

    expect(plugin, contains('CreateStreamOnHGlobal'));
    expect(plugin, contains('stream->Stat'));
    expect(plugin, contains('logical_size'));
    expect(cmake, contains('"ole32.lib"'));
    expect(cmake, contains('"windowscodecs.lib"'));
  });

  test('Windows launch-at-login state verifies the registered executable', () {
    final plugin = File(
      'windows/runner/activity_capture_plugin.cpp',
    ).readAsStringSync();

    expect(plugin, contains('const std::wstring command(value.data())'));
    expect(
      plugin,
      contains(r'const std::wstring command = L"\"" + executable + L"\"";'),
    );
    expect(plugin, contains('CurrentExecutablePath()'));
    expect(plugin, contains('CompareStringOrdinal'));
  });

  test('macOS excludes its own app and accepts only complete frames', () {
    final source = File(
      'macos/Runner/MainFlutterWindow.swift',
    ).readAsStringSync();

    expect(source, contains('excludingApplications: excludedApplications'));
    expect(source, contains('SCStreamFrameInfo.status'));
    expect(source, contains('status == .complete'));
    expect(source, contains('guard !screenIsLocked()'));
    expect(source, contains('ActivityCaptureError.sessionLocked'));
    expect(source, contains('code: "session-locked"'));
    expect(source, contains('case .requiresApproval:'));
    expect(source, contains('SMAppService.openSystemSettingsLoginItems()'));
    expect(source, isNot(contains('write(to:')));
  });
}
