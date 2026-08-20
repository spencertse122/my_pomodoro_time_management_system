import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/data/activity_repository.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/data/session_repository.dart';
import 'package:my_pomodoro_time_management_system/domain/models.dart';
import 'package:my_pomodoro_time_management_system/features/tracking/activity_tracking_controller.dart';
import 'package:my_pomodoro_time_management_system/services/activity_capture_service.dart';
import 'package:my_pomodoro_time_management_system/services/local_ai_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('focus_flow/activity_tracking_controller.test');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  test(
    'classifies all-display bytes locally and persists no image column',
    () async {
      final now = DateTime.now().toUtc();
      messenger.setMockMethodCallHandler(channel, (call) async {
        return switch (call.method) {
          'permissionStatus' => 'granted',
          'getActivitySnapshot' => <String, Object?>{
            'capturedAtMilliseconds': now.millisecondsSinceEpoch,
            'idleMilliseconds': 0,
            'isIdle': false,
            'isLocked': false,
            'foregroundApplication': <String, Object?>{
              'name': 'Editor',
              'identifier': 'com.example.editor',
              'processId': 42,
              'windowTitle': 'Focus Flow implementation',
            },
          },
          'captureDisplays' => <Object?>[
            <String, Object?>{
              'id': 'one',
              'width': 100,
              'height': 100,
              'scaleFactor': 1.0,
              'pngBytes': Uint8List.fromList([0x89, 0x50, 0x4e, 0x47]),
            },
            <String, Object?>{
              'id': 'two',
              'width': 200,
              'height': 100,
              'scaleFactor': 2.0,
              'pngBytes': Uint8List.fromList([0x89, 0x50, 0x4e, 0x47]),
            },
          ],
          _ => throw MissingPluginException(call.method),
        };
      });

      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final categories = CategoryRepository(database);
      final fakeAi = FakeLocalAiService(
        onClassify: (snapshot, displays, allowed) {
          expect(displays, hasLength(2));
          final work = allowed.singleWhere(
            (category) => category.name == 'Work',
          );
          return LocalAiResult.success(
            ActivityClassification(
              activityLabel: 'Building Focus Flow',
              categoryId: work.id,
              confidence: 0.42,
              needsReview: true,
              secondaryContext: const ['Documentation on second display'],
              modelVersion: 'test-model',
              promptVersion: 'test-prompt',
            ),
          );
        },
      );
      final activities = ActivityRepository(database);
      final controller = ActivityTrackingController(
        userId: 'user',
        activities: activities,
        categories: categories,
        settings: TrackingSettingsRepository(database),
        insights: InsightRepository(database),
        sessions: SessionRepository(database),
        capture: ActivityCaptureService(channel: channel),
        localAi: fakeAi,
      );
      addTearDown(controller.dispose);
      await controller.initialize();
      controller.settings = controller.settings.copyWith(trackingEnabled: true);

      await controller.captureNow();

      final samples = await activities
          .watchSamples('user', now.toLocal())
          .first;
      expect(samples, hasLength(1));
      expect(samples.single.activityLabel, 'Building Focus Flow');
      expect(samples.single.categoryId, isNotNull);
      expect(samples.single.confidence, 0.42);
      expect(samples.single.processingState, ActivityProcessingState.complete);
      final columns = await database
          .customSelect("PRAGMA table_info('activity_sample_entries')")
          .get();
      final names = columns.map((row) => row.data['name'].toString()).join(' ');
      expect(names, isNot(contains('screenshot')));
      expect(names, isNot(contains('image')));
      expect(names, isNot(contains('png')));
    },
  );

  test(
    'locked or idle sessions are skipped before screenshot capture',
    () async {
      var screenshotCalls = 0;
      final now = DateTime.now().toUtc();
      messenger.setMockMethodCallHandler(channel, (call) async {
        return switch (call.method) {
          'permissionStatus' => 'granted',
          'getActivitySnapshot' => <String, Object?>{
            'capturedAtMilliseconds': now.millisecondsSinceEpoch,
            'idleMilliseconds': const Duration(minutes: 10).inMilliseconds,
            'isIdle': true,
            'isLocked': false,
            'foregroundApplication': null,
          },
          'captureDisplays' => <Object?>[screenshotCalls++],
          _ => throw MissingPluginException(call.method),
        };
      });
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final activities = ActivityRepository(database);
      final controller = ActivityTrackingController(
        userId: 'idle-user',
        activities: activities,
        categories: CategoryRepository(database),
        settings: TrackingSettingsRepository(database),
        insights: InsightRepository(database),
        sessions: SessionRepository(database),
        capture: ActivityCaptureService(channel: channel),
        localAi: FakeLocalAiService(),
      );
      addTearDown(controller.dispose);
      await controller.initialize();
      controller.settings = controller.settings.copyWith(trackingEnabled: true);

      await controller.captureNow();

      expect(controller.status, ActivityTrackingStatus.idle);
      expect(screenshotCalls, 0);
      expect(
        await activities.watchSamples('idle-user', now.toLocal()).first,
        isEmpty,
      );
    },
  );

  test(
    'disabling waits for in-flight image analysis to release bytes',
    () async {
      final now = DateTime.now().toUtc();
      messenger.setMockMethodCallHandler(channel, (call) async {
        return switch (call.method) {
          'permissionStatus' => 'granted',
          'getActivitySnapshot' => <String, Object?>{
            'capturedAtMilliseconds': now.millisecondsSinceEpoch,
            'idleMilliseconds': 0,
            'isIdle': false,
            'isLocked': false,
            'foregroundApplication': <String, Object?>{
              'name': 'Editor',
              'identifier': 'com.example.editor',
              'processId': 42,
            },
          },
          'captureDisplays' => <Object?>[
            <String, Object?>{
              'id': 'one',
              'width': 100,
              'height': 100,
              'scaleFactor': 1.0,
              'pngBytes': Uint8List.fromList([0x89, 0x50, 0x4e, 0x47]),
            },
          ],
          _ => throw MissingPluginException(call.method),
        };
      });
      final inferenceStarted = Completer<void>();
      final releaseInference = Completer<void>();
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final controller = ActivityTrackingController(
        userId: 'user',
        activities: ActivityRepository(database),
        categories: CategoryRepository(database),
        settings: TrackingSettingsRepository(database),
        insights: InsightRepository(database),
        sessions: SessionRepository(database),
        capture: ActivityCaptureService(channel: channel),
        localAi: FakeLocalAiService(
          onClassify: (snapshot, displays, categories) async {
            inferenceStarted.complete();
            await releaseInference.future;
            return LocalAiResult.success(
              ActivityClassification(
                activityLabel: 'Editing',
                categoryId: categories.first.id,
                confidence: 1,
                needsReview: false,
                secondaryContext: const [],
                modelVersion: 'test-model',
                promptVersion: 'test-prompt',
              ),
            );
          },
        ),
      );
      addTearDown(controller.dispose);
      await controller.initialize();
      controller.settings = controller.settings.copyWith(trackingEnabled: true);

      final capture = controller.captureNow();
      await inferenceStarted.future;
      var disabled = false;
      final disabling = controller.disableTracking().then(
        (_) => disabled = true,
      );
      await Future<void>.delayed(Duration.zero);
      expect(disabled, isFalse);

      releaseInference.complete();
      await Future.wait([capture, disabling]);
      expect(disabled, isTrue);
      expect(controller.settings.trackingEnabled, isFalse);
    },
  );
}
