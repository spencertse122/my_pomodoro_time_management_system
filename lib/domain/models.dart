enum TimerPhase { focus, shortBreak, longBreak }

enum SessionOutcome { completed, stopped }

enum TimerRunState { idle, running, paused, awaitingNext }

enum ActivityCategorySource { ai, manual, rule, fallback }

enum ActivityProcessingState { pending, complete, failed, metadataOnly }

enum SessionAlignment { aligned, mixed, unverified }

extension TimerPhaseLabel on TimerPhase {
  String get label => switch (this) {
    TimerPhase.focus => 'Focus',
    TimerPhase.shortBreak => 'Short break',
    TimerPhase.longBreak => 'Long break',
  };

  bool get isBreak => this != TimerPhase.focus;
}

class WorkSession {
  const WorkSession({
    required this.id,
    required this.userId,
    required this.cycleId,
    required this.phase,
    required this.activity,
    required this.plannedSeconds,
    required this.actualSeconds,
    required this.startedAt,
    required this.endedAt,
    required this.outcome,
    required this.updatedAt,
    this.isDeleted = false,
    this.isDirty = true,
    this.categoryId,
    this.categorySource,
    this.categoryConfidence,
    this.alignment = SessionAlignment.unverified,
  });

  final String id;
  final String userId;
  final String cycleId;
  final TimerPhase phase;
  final String activity;
  final int plannedSeconds;
  final int actualSeconds;
  final DateTime startedAt;
  final DateTime endedAt;
  final SessionOutcome outcome;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool isDirty;
  final String? categoryId;
  final ActivityCategorySource? categorySource;
  final double? categoryConfidence;
  final SessionAlignment alignment;

  WorkSession copyWith({
    String? activity,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? isDirty,
    String? categoryId,
    ActivityCategorySource? categorySource,
    double? categoryConfidence,
    SessionAlignment? alignment,
    bool clearCategory = false,
  }) {
    return WorkSession(
      id: id,
      userId: userId,
      cycleId: cycleId,
      phase: phase,
      activity: activity ?? this.activity,
      plannedSeconds: plannedSeconds,
      actualSeconds: actualSeconds,
      startedAt: startedAt,
      endedAt: endedAt,
      outcome: outcome,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      categoryId: clearCategory ? null : (categoryId ?? this.categoryId),
      categorySource: clearCategory
          ? null
          : (categorySource ?? this.categorySource),
      categoryConfidence: clearCategory
          ? null
          : (categoryConfidence ?? this.categoryConfidence),
      alignment: alignment ?? this.alignment,
    );
  }
}

class ActivityCategory {
  const ActivityCategory({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.colorValue,
    required this.sortOrder,
    this.isArchived = false,
    this.isSystem = false,
  });

  final String id;
  final String userId;
  final String name;
  final String description;
  final int colorValue;
  final int sortOrder;
  final bool isArchived;
  final bool isSystem;

  ActivityCategory copyWith({
    String? name,
    String? description,
    int? colorValue,
    int? sortOrder,
    bool? isArchived,
  }) => ActivityCategory(
    id: id,
    userId: userId,
    name: name ?? this.name,
    description: description ?? this.description,
    colorValue: colorValue ?? this.colorValue,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
    isSystem: isSystem,
  );
}

class ActivitySample {
  const ActivitySample({
    required this.id,
    required this.userId,
    required this.capturedAt,
    required this.startedAt,
    required this.endedAt,
    required this.appId,
    required this.appName,
    required this.windowTitle,
    required this.processingState,
    required this.updatedAt,
    this.activityLabel,
    this.categoryId,
    this.categorySource,
    this.confidence,
    this.secondaryContext = const [],
    this.modelVersion,
    this.promptVersion,
    this.failureCode,
  });

  final String id;
  final String userId;
  final DateTime capturedAt;
  final DateTime startedAt;
  final DateTime endedAt;
  final String appId;
  final String appName;
  final String windowTitle;
  final String? activityLabel;
  final String? categoryId;
  final ActivityCategorySource? categorySource;
  final double? confidence;
  final List<String> secondaryContext;
  final ActivityProcessingState processingState;
  final String? modelVersion;
  final String? promptVersion;
  final String? failureCode;
  final DateTime updatedAt;

  int get durationSeconds =>
      endedAt.difference(startedAt).inSeconds.clamp(0, 86400);

  ActivitySample copyWith({
    DateTime? startedAt,
    DateTime? endedAt,
    String? activityLabel,
    String? categoryId,
    ActivityCategorySource? categorySource,
    double? confidence,
    List<String>? secondaryContext,
    ActivityProcessingState? processingState,
    String? modelVersion,
    String? promptVersion,
    String? failureCode,
    DateTime? updatedAt,
    bool clearFailure = false,
  }) => ActivitySample(
    id: id,
    userId: userId,
    capturedAt: capturedAt,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    appId: appId,
    appName: appName,
    windowTitle: windowTitle,
    activityLabel: activityLabel ?? this.activityLabel,
    categoryId: categoryId ?? this.categoryId,
    categorySource: categorySource ?? this.categorySource,
    confidence: confidence ?? this.confidence,
    secondaryContext: secondaryContext ?? this.secondaryContext,
    processingState: processingState ?? this.processingState,
    modelVersion: modelVersion ?? this.modelVersion,
    promptVersion: promptVersion ?? this.promptVersion,
    failureCode: clearFailure ? null : (failureCode ?? this.failureCode),
    updatedAt: updatedAt ?? this.updatedAt,
  );
}

class ActivityBlock {
  const ActivityBlock({
    required this.id,
    required this.userId,
    required this.startedAt,
    required this.endedAt,
    required this.appId,
    required this.appName,
    required this.activityLabel,
    required this.categoryId,
    required this.source,
    required this.confidence,
    required this.sampleCount,
    this.secondaryContext = const [],
  });

  final String id;
  final String userId;
  final DateTime startedAt;
  final DateTime endedAt;
  final String appId;
  final String appName;
  final String activityLabel;
  final String? categoryId;
  final ActivityCategorySource source;
  final double confidence;
  final int sampleCount;
  final List<String> secondaryContext;

  int get durationSeconds =>
      endedAt.difference(startedAt).inSeconds.clamp(0, 86400);
}

class CategoryRule {
  const CategoryRule({
    required this.id,
    required this.userId,
    required this.appId,
    required this.categoryId,
    required this.updatedAt,
    this.titleContains,
  });

  final String id;
  final String userId;
  final String appId;
  final String? titleContains;
  final String categoryId;
  final DateTime updatedAt;

  bool matches(String candidateAppId, String candidateTitle) {
    if (appId != candidateAppId) return false;
    final title = titleContains;
    return title == null ||
        candidateTitle.toLowerCase().contains(title.toLowerCase());
  }
}

class DailyInsight {
  const DailyInsight({
    required this.userId,
    required this.localDate,
    required this.summary,
    required this.patterns,
    required this.discrepancies,
    required this.modelVersion,
    required this.promptVersion,
    required this.sourceUpdatedAt,
    required this.generatedAt,
  });

  final String userId;
  final DateTime localDate;
  final String summary;
  final List<String> patterns;
  final List<String> discrepancies;
  final String modelVersion;
  final String promptVersion;
  final DateTime sourceUpdatedAt;
  final DateTime generatedAt;
}

class TrackingSettings {
  const TrackingSettings({
    this.trackingEnabled = false,
    this.captureIntervalMinutes = 5,
    this.idleThresholdMinutes = 5,
    this.launchAtLogin = false,
    this.captureAllDisplays = true,
    this.diagnosticsEnabled = true,
    this.excludedAppIds = const [],
    this.pausedUntil,
    this.onboardingComplete = false,
    this.privacyNoticeVersion = 0,
  });

  final bool trackingEnabled;
  final int captureIntervalMinutes;
  final int idleThresholdMinutes;
  final bool launchAtLogin;
  final bool captureAllDisplays;
  final bool diagnosticsEnabled;
  final List<String> excludedAppIds;
  final DateTime? pausedUntil;
  final bool onboardingComplete;
  final int privacyNoticeVersion;

  bool get isPaused => pausedUntil?.isAfter(DateTime.now().toUtc()) ?? false;

  TrackingSettings copyWith({
    bool? trackingEnabled,
    int? captureIntervalMinutes,
    int? idleThresholdMinutes,
    bool? launchAtLogin,
    bool? captureAllDisplays,
    bool? diagnosticsEnabled,
    List<String>? excludedAppIds,
    DateTime? pausedUntil,
    bool clearPause = false,
    bool? onboardingComplete,
    int? privacyNoticeVersion,
  }) => TrackingSettings(
    trackingEnabled: trackingEnabled ?? this.trackingEnabled,
    captureIntervalMinutes:
        captureIntervalMinutes ?? this.captureIntervalMinutes,
    idleThresholdMinutes: idleThresholdMinutes ?? this.idleThresholdMinutes,
    launchAtLogin: launchAtLogin ?? this.launchAtLogin,
    captureAllDisplays: captureAllDisplays ?? this.captureAllDisplays,
    diagnosticsEnabled: diagnosticsEnabled ?? this.diagnosticsEnabled,
    excludedAppIds: excludedAppIds ?? this.excludedAppIds,
    pausedUntil: clearPause ? null : (pausedUntil ?? this.pausedUntil),
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    privacyNoticeVersion: privacyNoticeVersion ?? this.privacyNoticeVersion,
  );
}

class PomodoroSettings {
  const PomodoroSettings({
    this.focusMinutes = 25,
    this.shortBreakMinutes = 5,
    this.longBreakMinutes = 15,
    this.longBreakInterval = 4,
    this.soundEnabled = true,
    this.isDirty = false,
  });

  final int focusMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  final int longBreakInterval;
  final bool soundEnabled;
  final bool isDirty;

  int secondsFor(TimerPhase phase) => switch (phase) {
    TimerPhase.focus => focusMinutes * 60,
    TimerPhase.shortBreak => shortBreakMinutes * 60,
    TimerPhase.longBreak => longBreakMinutes * 60,
  };

  PomodoroSettings copyWith({
    int? focusMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
    int? longBreakInterval,
    bool? soundEnabled,
    bool? isDirty,
  }) {
    return PomodoroSettings(
      focusMinutes: focusMinutes ?? this.focusMinutes,
      shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
      longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
      longBreakInterval: longBreakInterval ?? this.longBreakInterval,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      isDirty: isDirty ?? this.isDirty,
    );
  }
}

class TimerSnapshot {
  const TimerSnapshot({
    required this.userId,
    required this.state,
    required this.phase,
    required this.activity,
    required this.cycleId,
    required this.completedFocusesInCycle,
    required this.plannedSeconds,
    required this.accumulatedSeconds,
    required this.updatedAt,
    this.startedAt,
    this.deadline,
  });

  factory TimerSnapshot.idle(String userId) => TimerSnapshot(
    userId: userId,
    state: TimerRunState.idle,
    phase: TimerPhase.focus,
    activity: '',
    cycleId: '',
    completedFocusesInCycle: 0,
    plannedSeconds: 0,
    accumulatedSeconds: 0,
    updatedAt: DateTime.now().toUtc(),
  );

  final String userId;
  final TimerRunState state;
  final TimerPhase phase;
  final String activity;
  final String cycleId;
  final int completedFocusesInCycle;
  final int plannedSeconds;
  final int accumulatedSeconds;
  final DateTime? startedAt;
  final DateTime? deadline;
  final DateTime updatedAt;

  TimerSnapshot copyWith({
    TimerRunState? state,
    TimerPhase? phase,
    String? activity,
    String? cycleId,
    int? completedFocusesInCycle,
    int? plannedSeconds,
    int? accumulatedSeconds,
    DateTime? startedAt,
    DateTime? deadline,
    bool clearDeadline = false,
  }) {
    return TimerSnapshot(
      userId: userId,
      state: state ?? this.state,
      phase: phase ?? this.phase,
      activity: activity ?? this.activity,
      cycleId: cycleId ?? this.cycleId,
      completedFocusesInCycle:
          completedFocusesInCycle ?? this.completedFocusesInCycle,
      plannedSeconds: plannedSeconds ?? this.plannedSeconds,
      accumulatedSeconds: accumulatedSeconds ?? this.accumulatedSeconds,
      startedAt: startedAt ?? this.startedAt,
      deadline: clearDeadline ? null : (deadline ?? this.deadline),
      updatedAt: DateTime.now().toUtc(),
    );
  }
}
