import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../domain/models.dart';

abstract interface class CompletionNotifier {
  Future<void> initialize();
  Future<void> showCompletion(TimerPhase phase, {required bool playSound});
}

class DesktopCompletionNotifier implements CompletionNotifier {
  DesktopCompletionNotifier({
    FlutterLocalNotificationsPlugin? notifications,
    AudioPlayer? audioPlayer,
  }) : _notifications = notifications ?? FlutterLocalNotificationsPlugin(),
       _audioPlayer = audioPlayer ?? AudioPlayer();

  final FlutterLocalNotificationsPlugin _notifications;
  final AudioPlayer _audioPlayer;
  bool _initialized = false;

  @override
  Future<void> initialize() async {
    const darwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
    );
    const windows = WindowsInitializationSettings(
      appName: 'Focus Flow',
      appUserModelId: 'SpencerTse.FocusFlow.Desktop',
      guid: '7e241091-0a14-43e8-81d4-5e078cbb1e0f',
    );
    await _notifications.initialize(
      settings: const InitializationSettings(macOS: darwin, windows: windows),
    );
    _initialized = true;
  }

  @override
  Future<void> showCompletion(
    TimerPhase phase, {
    required bool playSound,
  }) async {
    if (!_initialized) return;
    final next = phase == TimerPhase.focus
        ? 'Time for a break.'
        : 'Ready to focus?';
    await _notifications.show(
      id: 1001,
      title: '${phase.label} complete',
      body: next,
      notificationDetails: const NotificationDetails(
        macOS: DarwinNotificationDetails(presentSound: false),
        windows: WindowsNotificationDetails(),
      ),
    );
    if (playSound) {
      try {
        await _audioPlayer.play(BytesSource(_completionTone()));
      } on Object {
        // The notification remains useful if an audio backend is unavailable.
      }
    }
  }

  Uint8List _completionTone() {
    const sampleRate = 16000;
    const durationMs = 280;
    final samples = sampleRate * durationMs ~/ 1000;
    final bytes = ByteData(44 + samples * 2);
    void ascii(int offset, String value) {
      for (var index = 0; index < value.length; index++) {
        bytes.setUint8(offset + index, value.codeUnitAt(index));
      }
    }

    ascii(0, 'RIFF');
    bytes.setUint32(4, 36 + samples * 2, Endian.little);
    ascii(8, 'WAVE');
    ascii(12, 'fmt ');
    bytes.setUint32(16, 16, Endian.little);
    bytes.setUint16(20, 1, Endian.little);
    bytes.setUint16(22, 1, Endian.little);
    bytes.setUint32(24, sampleRate, Endian.little);
    bytes.setUint32(28, sampleRate * 2, Endian.little);
    bytes.setUint16(32, 2, Endian.little);
    bytes.setUint16(34, 16, Endian.little);
    ascii(36, 'data');
    bytes.setUint32(40, samples * 2, Endian.little);
    for (var index = 0; index < samples; index++) {
      final cycle = (index * 880 ~/ sampleRate) % 2;
      final envelope = 1 - (index / samples);
      final amplitude = (cycle == 0 ? 9000 : -9000) * envelope;
      bytes.setInt16(44 + index * 2, amplitude.round(), Endian.little);
    }
    return bytes.buffer.asUint8List();
  }
}
