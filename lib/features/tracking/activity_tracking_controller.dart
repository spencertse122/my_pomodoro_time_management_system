import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../../data/activity_repository.dart';
import '../../data/local/app_database.dart';
import '../../data/session_repository.dart';
import '../../domain/models.dart';
import '../../services/activity_capture_service.dart';
import '../../services/diagnostics_service.dart';
import '../../services/local_ai_service.dart';

enum ActivityTrackingStatus {
  disabled,
  paused,
  waiting,
  capturing,
  analyzing,
  idle,
  locked,
  permissionDenied,
  metadataOnly,
  error,
}

class ActivityTrackingController extends ChangeNotifier {
  ActivityTrackingController({
    required String userId,
    required ActivityRepository activities,
    required CategoryRepository categories,
    required TrackingSettingsRepository settings,
    required InsightRepository insights,
    required SessionRepository sessions,
    required ActivityCaptureService capture,
    required LocalAiService localAi,
    AppDatabase? diagnosticsDatabase,
    DiagnosticsService? diagnostics,
    Uuid? uuid,
  }) : _userId = userId,
       _activities = activities,
       _categories = categories,
       _settingsRepository = settings,
       _insights = insights,
       _sessions = sessions,
       _capture = capture,
       _localAi = localAi,
       _diagnosticsDatabase = diagnosticsDatabase,
       _diagnostics = diagnostics,
       _uuid = uuid ?? const Uuid();

  static const privacyNoticeVersion = 1;

  final String _userId;
  final ActivityRepository _activities;
  final CategoryRepository _categories;
  final TrackingSettingsRepository _settingsRepository;
  final InsightRepository _insights;
  final SessionRepository _sessions;
  final ActivityCaptureService _capture;
  final LocalAiService _localAi;
  final AppDatabase? _diagnosticsDatabase;
  final DiagnosticsService? _diagnostics;
  final Uuid _uuid;

  Timer? _timer;
  Completer<void>? _captureCompletion;
  Future<void>? _diagnosticsFlush;
  bool _isCapturing = false;
  bool _disposed = false;
  bool _accountDeletionSuspended = false;
  DateTime? _lastActiveCaptureAt;

  TrackingSettings settings = const TrackingSettings();
  ActivityCapturePermissionStatus permission =
      ActivityCapturePermissionStatus.notDetermined;
  LocalAiAvailability? aiAvailability;
  ActivityTrackingStatus status = ActivityTrackingStatus.disabled;
  DateTime? lastCompletedAt;
  String? lastError;
  int capturesSucceeded = 0;
  int capturesSkipped = 0;
  int inferenceFailures = 0;

  bool get initialized => aiAvailability != null;
  bool get isActivelyTracking =>
      settings.trackingEnabled &&
      _hasCurrentPrivacyConsent &&
      !settings.isPaused;
  bool get isBusy => _isCapturing;

  Future<void> initialize() async {
    await _categories.ensureDefaults(_userId);
    settings = await _settingsRepository.get(_userId);
    try {
      permission = await _capture.permissionStatus();
    } on Object {
      permission = ActivityCapturePermissionStatus.unsupported;
    }
    aiAvailability = await _localAi.availability();
    try {
      final launchAtLogin = await _capture.isLaunchAtLoginEnabled();
      if (launchAtLogin != settings.launchAtLogin) {
        settings = settings.copyWith(launchAtLogin: launchAtLogin);
        await _settingsRepository.save(_userId, settings);
      }
    } on Object {
      // A platform login-item lookup must not prevent local tracking startup.
    }
    _diagnosticsFlush = _flushDiagnostics();
    unawaited(_diagnosticsFlush);
    _reschedule(captureImmediately: settings.trackingEnabled);
    notifyListeners();
  }

  Future<bool> completeOnboardingAndEnable() async {
    _ensureWritable();
    final requested = await _capture.requestPermission();
    permission = requested;
    final enabled = requested == ActivityCapturePermissionStatus.granted;
    settings = settings.copyWith(
      onboardingComplete: true,
      privacyNoticeVersion: privacyNoticeVersion,
      trackingEnabled: enabled,
      clearPause: true,
    );
    await _settingsRepository.save(_userId, settings);
    _reschedule(captureImmediately: enabled);
    notifyListeners();
    return enabled;
  }

  Future<void> completeOnboardingWithoutTracking() async {
    _ensureWritable();
    settings = settings.copyWith(
      onboardingComplete: true,
      privacyNoticeVersion: privacyNoticeVersion,
      trackingEnabled: false,
      clearPause: true,
    );
    await _settingsRepository.save(_userId, settings);
    _reschedule();
    notifyListeners();
  }

  Future<bool> enableTracking() async {
    _ensureWritable();
    if (!_hasCurrentPrivacyConsent) {
      status = ActivityTrackingStatus.disabled;
      notifyListeners();
      return false;
    }
    var currentPermission = await _capture.permissionStatus();
    if (currentPermission != ActivityCapturePermissionStatus.granted) {
      currentPermission = await _capture.requestPermission();
    }
    permission = currentPermission;
    if (currentPermission != ActivityCapturePermissionStatus.granted) {
      status = ActivityTrackingStatus.permissionDenied;
      notifyListeners();
      return false;
    }
    settings = settings.copyWith(trackingEnabled: true, clearPause: true);
    await _settingsRepository.save(_userId, settings);
    _reschedule(captureImmediately: true);
    notifyListeners();
    return true;
  }

  Future<void> disableTracking() async {
    _ensureWritable();
    settings = settings.copyWith(trackingEnabled: false, clearPause: true);
    await _settingsRepository.save(_userId, settings);
    _lastActiveCaptureAt = null;
    _reschedule();
    notifyListeners();
    await _captureCompletion?.future;
  }

  Future<void> pauseFor(Duration duration) async {
    _ensureWritable();
    settings = settings.copyWith(
      pausedUntil: DateTime.now().toUtc().add(duration),
    );
    await _settingsRepository.save(_userId, settings);
    _lastActiveCaptureAt = null;
    _reschedule();
    notifyListeners();
  }

  Future<void> resume() async {
    _ensureWritable();
    settings = settings.copyWith(clearPause: true);
    await _settingsRepository.save(_userId, settings);
    _reschedule(captureImmediately: settings.trackingEnabled);
    notifyListeners();
  }

  Future<void> togglePause() async {
    if (!settings.trackingEnabled) {
      await enableTracking();
    } else if (settings.isPaused) {
      await resume();
    } else {
      await pauseFor(const Duration(hours: 1));
    }
  }

  Future<void> excludeApp(String appId) async {
    final value = appId.trim();
    if (value.isEmpty || settings.excludedAppIds.contains(value)) return;
    await updateTrackingSettings(
      settings.copyWith(excludedAppIds: [...settings.excludedAppIds, value]),
    );
  }

  Future<void> includeApp(String appId) => updateTrackingSettings(
    settings.copyWith(
      excludedAppIds: settings.excludedAppIds
          .where((value) => value != appId)
          .toList(),
    ),
  );

  Future<void> updateTrackingSettings(TrackingSettings value) async {
    _ensureWritable();
    final intervalChanged =
        value.captureIntervalMinutes != settings.captureIntervalMinutes;
    final scheduleChanged =
        intervalChanged ||
        value.trackingEnabled != settings.trackingEnabled ||
        value.pausedUntil != settings.pausedUntil;
    final loginChanged = value.launchAtLogin != settings.launchAtLogin;
    var saved = value.copyWith(
      captureIntervalMinutes: value.captureIntervalMinutes.clamp(1, 30),
      idleThresholdMinutes: value.idleThresholdMinutes.clamp(1, 60),
    );
    if (loginChanged) {
      final actual = await _capture.setLaunchAtLogin(value.launchAtLogin);
      saved = saved.copyWith(launchAtLogin: actual);
    }
    settings = saved;
    await _settingsRepository.save(_userId, settings);
    if (!settings.diagnosticsEnabled) {
      final database = _diagnosticsDatabase;
      if (database != null) {
        await database.deleteDiagnosticCounters(
          await database.diagnosticCounters(),
        );
      }
    }
    if (scheduleChanged) {
      _reschedule(captureImmediately: settings.trackingEnabled);
    }
    notifyListeners();
  }

  Future<void> captureNow() async {
    if (_disposed ||
        _accountDeletionSuspended ||
        !_hasCurrentPrivacyConsent ||
        !settings.trackingEnabled ||
        settings.isPaused) {
      status = settings.isPaused
          ? ActivityTrackingStatus.paused
          : ActivityTrackingStatus.disabled;
      if (!_disposed) notifyListeners();
      return;
    }
    if (_isCapturing) {
      capturesSkipped++;
      await _recordDiagnostic('skipped');
      notifyListeners();
      return;
    }
    _isCapturing = true;
    final completion = Completer<void>();
    _captureCompletion = completion;
    lastError = null;
    status = ActivityTrackingStatus.capturing;
    notifyListeners();
    ActivitySample? persistedSample;
    try {
      final snapshot = await _capture.getActivitySnapshot();
      if (snapshot.isLocked) {
        await _skip(ActivityTrackingStatus.locked);
        return;
      }
      if (snapshot.idleDuration >=
          Duration(minutes: settings.idleThresholdMinutes)) {
        await _skip(ActivityTrackingStatus.idle);
        return;
      }
      final app = snapshot.foregroundApplication;
      if (app == null) {
        await _skip(ActivityTrackingStatus.metadataOnly);
        return;
      }
      final boundedAppName = _bounded(app.name, 200);
      final appName = boundedAppName.isEmpty
          ? 'Unknown application'
          : boundedAppName;
      final appId = _bounded(
        (app.identifier?.trim().isNotEmpty ?? false)
            ? app.identifier!.trim()
            : 'process:${app.processId}:${appName.toLowerCase()}',
        240,
      );
      if (_isFocusFlow(appId, appName) ||
          settings.excludedAppIds.contains(appId)) {
        await _skip(ActivityTrackingStatus.waiting);
        return;
      }

      final end = snapshot.capturedAt.toUtc();
      final previous = _lastActiveCaptureAt;
      final start = previous != null && end.isAfter(previous) ? previous : end;
      _lastActiveCaptureAt = end;
      final sample = ActivitySample(
        id: _uuid.v4(),
        userId: _userId,
        capturedAt: end,
        startedAt: start,
        endedAt: end,
        appId: appId,
        appName: appName,
        windowTitle: _bounded(app.windowTitle ?? '', 500),
        processingState: ActivityProcessingState.pending,
        updatedAt: DateTime.now().toUtc(),
      );
      persistedSample = await _activities.saveSample(sample);
      if (persistedSample.categorySource == ActivityCategorySource.rule) {
        capturesSucceeded++;
        await _recordDiagnostic('success');
        status = ActivityTrackingStatus.waiting;
        lastCompletedAt = DateTime.now().toUtc();
        return;
      }

      if (permission != ActivityCapturePermissionStatus.granted) {
        await _activities.markMetadataOnly(persistedSample, 'permissionDenied');
        status = ActivityTrackingStatus.permissionDenied;
        await _recordDiagnostic('skipped');
        return;
      }

      var displays = await _capture.captureDisplays();
      final categories = await _categories.get(_userId);
      status = ActivityTrackingStatus.analyzing;
      notifyListeners();
      late final LocalAiResult<ActivityClassification> result;
      try {
        result = await _localAi.classifyActivity(
          snapshot: snapshot,
          displays: displays,
          categories: categories,
        );
      } finally {
        // Release the controller's last image references before any database
        // or diagnostics work continues.
        displays = const [];
      }
      final classification = result.value;
      if (classification != null) {
        await _activities.saveClassification(
          persistedSample,
          activityLabel: classification.activityLabel,
          categoryId: classification.categoryId,
          confidence: classification.confidence,
          secondaryContext: classification.secondaryContext,
          modelVersion: classification.modelVersion,
          promptVersion: classification.promptVersion,
        );
        capturesSucceeded++;
        await _recordDiagnostic('success');
        status = ActivityTrackingStatus.waiting;
      } else {
        final failure = result.failure!;
        if (failure.isMetadataOnly) {
          await _activities.markMetadataOnly(
            persistedSample,
            failure.storageCode,
          );
          status = ActivityTrackingStatus.metadataOnly;
          await _recordDiagnostic('skipped');
        } else {
          await _activities.markClassificationFailed(
            persistedSample,
            failure.storageCode,
          );
          inferenceFailures++;
          await _recordDiagnostic('inferenceFailure');
          status = ActivityTrackingStatus.error;
        }
        lastError = failure.message;
      }
      lastCompletedAt = DateTime.now().toUtc();
    } on Object catch (error) {
      capturesSkipped++;
      await _recordDiagnostic('captureFailure');
      status = ActivityTrackingStatus.error;
      lastError = _safeError(error);
      if (persistedSample != null) {
        await _activities.markMetadataOnly(
          persistedSample,
          error.toString().contains('permission-denied')
              ? 'permissionDenied'
              : 'captureFailed',
        );
      }
    } finally {
      _isCapturing = false;
      if (!completion.isCompleted) completion.complete();
      if (identical(_captureCompletion, completion)) {
        _captureCompletion = null;
      }
      if (!_disposed) {
        // A disable or pause can race an in-flight local inference. Preserve
        // the user's latest control state after that work drains.
        if (!settings.trackingEnabled || !_hasCurrentPrivacyConsent) {
          status = ActivityTrackingStatus.disabled;
        } else if (settings.isPaused) {
          status = ActivityTrackingStatus.paused;
        }
        notifyListeners();
      }
    }
  }

  Future<void> generateDailyInsight(DateTime day) async {
    _ensureWritable();
    final blocks = await _activities.watchDay(_userId, day).first;
    final pomodoros = await _sessions.watchDay(_userId, day).first;
    final categories = await _categories.get(_userId);
    if (blocks.isEmpty && pomodoros.isEmpty) {
      throw StateError('There is no local activity to summarize for this day.');
    }
    final timestamps = <DateTime>[
      for (final block in blocks) block.endedAt,
      for (final session in pomodoros) session.updatedAt,
    ]..sort();
    final result = await _localAi.generateDailyInsight(
      DailyInsightRequest(
        userId: _userId,
        localDate: day,
        sourceUpdatedAt: timestamps.last,
        blocks: blocks,
        pomodoroSessions: pomodoros,
        categories: categories,
      ),
    );
    final insight = result.value;
    if (insight == null) throw StateError(result.failure!.message);
    _ensureWritable();
    await _insights.save(insight);
  }

  /// Stops scheduled and in-flight capture writes before local account rows
  /// are removed, then rejects every later mutation from UI or tray callbacks.
  Future<void> suspendForAccountDeletion() async {
    if (_accountDeletionSuspended) {
      await _captureCompletion?.future;
      return;
    }
    _accountDeletionSuspended = true;
    _timer?.cancel();
    settings = settings.copyWith(trackingEnabled: false, clearPause: true);
    await _settingsRepository.save(_userId, settings);
    _lastActiveCaptureAt = null;
    status = ActivityTrackingStatus.disabled;
    notifyListeners();
    await _captureCompletion?.future;
    await _diagnosticsFlush;
  }

  void _ensureWritable() {
    if (_accountDeletionSuspended || _disposed) {
      throw StateError('Activity tracking is stopping for account deletion.');
    }
  }

  Future<void> _skip(ActivityTrackingStatus value) async {
    capturesSkipped++;
    await _recordDiagnostic('skipped');
    _lastActiveCaptureAt = null;
    status = value;
    lastCompletedAt = DateTime.now().toUtc();
  }

  void _reschedule({bool captureImmediately = false}) {
    _timer?.cancel();
    if (!settings.trackingEnabled || !_hasCurrentPrivacyConsent) {
      status = ActivityTrackingStatus.disabled;
      return;
    }
    if (settings.isPaused) {
      status = ActivityTrackingStatus.paused;
      final pause = settings.pausedUntil;
      if (pause != null) {
        _timer = Timer(pause.difference(DateTime.now().toUtc()), () {
          unawaited(resume());
        });
      }
      return;
    }
    status = ActivityTrackingStatus.waiting;
    final interval = Duration(minutes: settings.captureIntervalMinutes);
    _timer = Timer.periodic(interval, (_) => unawaited(captureNow()));
    if (captureImmediately) unawaited(captureNow());
  }

  String _safeError(Object error) {
    final text = error.toString();
    if (text.contains('permission-denied')) {
      permission = ActivityCapturePermissionStatus.denied;
      return 'Screen access is no longer available. Re-enable it in system settings.';
    }
    return 'Local activity analysis failed. No screenshot was retained.';
  }

  bool _isFocusFlow(String appId, String appName) {
    final id = appId.toLowerCase();
    final name = appName.toLowerCase();
    return id == 'com.spencertse.focusflow' ||
        id == 'focusflow.exe' ||
        id == 'my_pomodoro_time_management_system.exe' ||
        name == 'focus flow' ||
        name == 'focusflow.exe' ||
        name == 'my_pomodoro_time_management_system.exe';
  }

  String _bounded(String value, int maximumLength) {
    final trimmed = value.trim();
    return trimmed.length <= maximumLength
        ? trimmed
        : trimmed.substring(0, maximumLength);
  }

  Future<void> _recordDiagnostic(String outcome) async {
    try {
      final database = _diagnosticsDatabase;
      if (database == null || !_hasDiagnosticsConsent) return;
      await database.incrementDiagnostic(
        event: 'activityCapture',
        outcome: outcome,
        durationBucket: 'notCollected',
      );
    } on Object {
      // Aggregate diagnostics are optional and never affect local tracking.
    }
  }

  Future<void> _flushDiagnostics() async {
    try {
      final database = _diagnosticsDatabase;
      final diagnostics = _diagnostics;
      if (database == null || diagnostics == null) return;
      final counters = await database.diagnosticCounters();
      if (counters.isEmpty) return;
      if (!_hasDiagnosticsConsent) {
        await database.deleteDiagnosticCounters(counters);
        return;
      }
      final package = await PackageInfo.fromPlatform();
      int count(String outcome) => counters
          .where((counter) => counter.outcome == outcome)
          .fold(0, (sum, counter) => sum + counter.count);
      final sent = await diagnostics.sendDailyHealth(
        enabled: _hasDiagnosticsConsent,
        platform: Platform.operatingSystem,
        appVersion: package.version,
        capturesSucceeded: count('success'),
        capturesSkipped: count('skipped') + count('captureFailure'),
        inferenceFailures: count('inferenceFailure'),
      );
      if (sent) await database.deleteDiagnosticCounters(counters);
    } on Object {
      // Startup and teardown must not depend on optional diagnostics support.
    }
  }

  bool get _hasDiagnosticsConsent =>
      !_accountDeletionSuspended &&
      settings.diagnosticsEnabled &&
      _hasCurrentPrivacyConsent;

  bool get _hasCurrentPrivacyConsent =>
      settings.onboardingComplete &&
      settings.privacyNoticeVersion >= privacyNoticeVersion;

  @override
  void dispose() {
    _disposed = true;
    _accountDeletionSuspended = true;
    _timer?.cancel();
    unawaited(_localAi.dispose());
    super.dispose();
  }
}
