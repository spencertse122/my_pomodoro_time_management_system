enum TimerPhase { focus, shortBreak, longBreak }

enum SessionOutcome { completed, stopped }

enum TimerRunState { idle, running, paused, awaitingNext }

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

  WorkSession copyWith({
    String? activity,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? isDirty,
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
    );
  }
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
