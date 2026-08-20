import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../data/local/app_database.dart';
import '../../data/session_repository.dart';
import '../../domain/models.dart';
import '../../services/notification_service.dart';

typedef UtcNow = DateTime Function();

class TimerController extends ChangeNotifier {
  TimerController({
    required String userId,
    required AppDatabase database,
    required SessionRepository sessions,
    required SettingsRepository settings,
    required CompletionNotifier notifier,
    UtcNow? now,
    Uuid? uuid,
  }) : _userId = userId,
       _database = database,
       _sessions = sessions,
       _settingsRepository = settings,
       _notifier = notifier,
       _now = now ?? (() => DateTime.now().toUtc()),
       _uuid = uuid ?? const Uuid(),
       snapshot = TimerSnapshot.idle(userId);

  final String _userId;
  final AppDatabase _database;
  final SessionRepository _sessions;
  final SettingsRepository _settingsRepository;
  final CompletionNotifier _notifier;
  final UtcNow _now;
  final Uuid _uuid;
  Timer? _ticker;
  bool _completing = false;
  bool _accountDeletionSuspended = false;
  bool _disposed = false;
  Completer<void>? _activeCompletion;

  TimerSnapshot snapshot;
  PomodoroSettings settings = const PomodoroSettings();
  bool initialized = false;

  int get remainingSeconds {
    if (snapshot.state == TimerRunState.running && snapshot.deadline != null) {
      return _remainingAt(_now());
    }
    return (snapshot.plannedSeconds - snapshot.accumulatedSeconds).clamp(
      0,
      snapshot.plannedSeconds,
    );
  }

  double get progress {
    if (snapshot.plannedSeconds == 0) return 0;
    return 1 - (remainingSeconds / snapshot.plannedSeconds);
  }

  TimerPhase get suggestedPhase {
    if (snapshot.state != TimerRunState.awaitingNext) return TimerPhase.focus;
    if (snapshot.phase.isBreak) return TimerPhase.focus;
    return snapshot.completedFocusesInCycle >= settings.longBreakInterval
        ? TimerPhase.longBreak
        : TimerPhase.shortBreak;
  }

  Future<void> initialize() async {
    settings = await _settingsRepository.get(_userId);
    snapshot =
        await _database.activeTimer(_userId) ?? TimerSnapshot.idle(_userId);
    initialized = true;
    if (snapshot.state == TimerRunState.running) {
      if (remainingSeconds <= 0) {
        await _complete(playNotification: false);
      } else {
        _startTicker();
      }
    }
    notifyListeners();
  }

  Future<void> startFocus(String activity) async {
    _ensureWritable();
    final value = _validatedActivity(activity);
    await _begin(
      phase: TimerPhase.focus,
      activity: value,
      cycleId: _uuid.v4(),
      completedFocuses: 0,
    );
  }

  Future<void> startSuggested({String? focusActivity}) async {
    _ensureWritable();
    if (snapshot.state != TimerRunState.awaitingNext) return;
    final phase = suggestedPhase;
    var activity = snapshot.activity;
    var completed = snapshot.completedFocusesInCycle;
    if (phase == TimerPhase.focus) {
      activity = _validatedActivity(focusActivity ?? activity);
      if (snapshot.phase == TimerPhase.longBreak) completed = 0;
    }
    await _begin(
      phase: phase,
      activity: activity,
      cycleId: snapshot.cycleId,
      completedFocuses: completed,
    );
  }

  Future<void> _begin({
    required TimerPhase phase,
    required String activity,
    required String cycleId,
    required int completedFocuses,
  }) async {
    final now = _now();
    final seconds = settings.secondsFor(phase);
    snapshot = TimerSnapshot(
      userId: _userId,
      state: TimerRunState.running,
      phase: phase,
      activity: activity,
      cycleId: cycleId,
      completedFocusesInCycle: completedFocuses,
      plannedSeconds: seconds,
      accumulatedSeconds: 0,
      startedAt: now,
      deadline: now.add(Duration(seconds: seconds)),
      updatedAt: now,
    );
    await _database.saveTimer(snapshot);
    _startTicker();
    notifyListeners();
  }

  Future<void> pause() async {
    _ensureWritable();
    if (snapshot.state != TimerRunState.running) return;
    final elapsed = _elapsedAt(_now());
    snapshot = snapshot.copyWith(
      state: TimerRunState.paused,
      accumulatedSeconds: elapsed,
      clearDeadline: true,
    );
    _ticker?.cancel();
    await _database.saveTimer(snapshot);
    notifyListeners();
  }

  Future<void> resume() async {
    _ensureWritable();
    if (snapshot.state != TimerRunState.paused) return;
    final now = _now();
    snapshot = snapshot.copyWith(
      state: TimerRunState.running,
      deadline: now.add(Duration(seconds: remainingSeconds)),
    );
    await _database.saveTimer(snapshot);
    _startTicker();
    notifyListeners();
  }

  Future<void> stop() async {
    _ensureWritable();
    if (snapshot.state != TimerRunState.running &&
        snapshot.state != TimerRunState.paused) {
      return;
    }
    _ticker?.cancel();
    final now = _now();
    final actual = snapshot.state == TimerRunState.paused
        ? snapshot.accumulatedSeconds
        : _elapsedAt(now);
    await _saveSession(
      outcome: SessionOutcome.stopped,
      actualSeconds: actual,
      endedAt: now,
    );
    snapshot = TimerSnapshot.idle(_userId);
    await _database.saveTimer(snapshot);
    notifyListeners();
  }

  Future<void> resetCycle() async {
    _ensureWritable();
    _ticker?.cancel();
    snapshot = TimerSnapshot.idle(_userId);
    await _database.saveTimer(snapshot);
    notifyListeners();
  }

  Future<void> updateSettings(PomodoroSettings value) async {
    _ensureWritable();
    settings = value;
    await _settingsRepository.save(_userId, value);
    notifyListeners();
  }

  int _elapsedAt(DateTime now) {
    if (snapshot.deadline == null) return snapshot.accumulatedSeconds;
    final remaining = _remainingAt(now);
    return (snapshot.plannedSeconds - remaining).clamp(
      0,
      snapshot.plannedSeconds,
    );
  }

  int _remainingAt(DateTime now) {
    final milliseconds = snapshot.deadline!.difference(now).inMilliseconds;
    if (milliseconds <= 0) return 0;
    // A partially elapsed second still belongs to the user. Rounding down here
    // makes the display tick early and overstates short, stopped sessions.
    return ((milliseconds + 999) ~/ 1000).clamp(0, snapshot.plannedSeconds);
  }

  String _validatedActivity(String activity) {
    final value = activity.trim();
    if (value.isEmpty) {
      throw ArgumentError('Describe what you are focusing on.');
    }
    if (value.length > 160) {
      throw ArgumentError('Keep the focus description under 160 characters.');
    }
    return value;
  }

  void _startTicker() {
    _ticker?.cancel();
    if (_accountDeletionSuspended || _disposed) return;
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (remainingSeconds <= 0) {
        await _complete(playNotification: true);
      } else {
        notifyListeners();
      }
    });
  }

  Future<void> _complete({required bool playNotification}) async {
    if (_completing ||
        _accountDeletionSuspended ||
        _disposed ||
        snapshot.state != TimerRunState.running) {
      return;
    }
    _completing = true;
    final completion = Completer<void>();
    _activeCompletion = completion;
    _ticker?.cancel();
    try {
      final completedPhase = snapshot.phase;
      final end = snapshot.deadline ?? _now();
      await _saveSession(
        outcome: SessionOutcome.completed,
        actualSeconds: snapshot.plannedSeconds,
        endedAt: end,
      );
      var completedFocuses = snapshot.completedFocusesInCycle;
      if (snapshot.phase == TimerPhase.focus) completedFocuses++;
      if (snapshot.phase == TimerPhase.longBreak) completedFocuses = 0;
      snapshot = snapshot.copyWith(
        state: TimerRunState.awaitingNext,
        completedFocusesInCycle: completedFocuses,
        accumulatedSeconds: snapshot.plannedSeconds,
        clearDeadline: true,
      );
      await _database.saveTimer(snapshot);
      if (playNotification) {
        try {
          await _notifier.showCompletion(
            completedPhase,
            playSound: settings.soundEnabled,
          );
        } on Object {
          // Session completion is durable even when the desktop notification
          // backend is unavailable or loses permission at runtime.
        }
      }
    } finally {
      _completing = false;
      if (identical(_activeCompletion, completion)) {
        _activeCompletion = null;
      }
      if (!completion.isCompleted) completion.complete();
      if (!_disposed) notifyListeners();
    }
  }

  /// Prevents any timer callback from recreating rows after local account
  /// deletion and waits for a completion that already crossed the write gate.
  Future<void> suspendForAccountDeletion() async {
    _accountDeletionSuspended = true;
    _ticker?.cancel();
    await _activeCompletion?.future;
  }

  void _ensureWritable() {
    if (_accountDeletionSuspended || _disposed) {
      throw StateError('The timer is stopping for account deletion.');
    }
  }

  Future<void> _saveSession({
    required SessionOutcome outcome,
    required int actualSeconds,
    required DateTime endedAt,
  }) {
    return _sessions.save(
      WorkSession(
        id: _uuid.v4(),
        userId: _userId,
        cycleId: snapshot.cycleId,
        phase: snapshot.phase,
        activity: snapshot.activity,
        plannedSeconds: snapshot.plannedSeconds,
        actualSeconds: actualSeconds,
        startedAt: snapshot.startedAt ?? endedAt,
        endedAt: endedAt,
        outcome: outcome,
        updatedAt: _now(),
      ),
    );
  }

  @override
  void dispose() {
    _disposed = true;
    _accountDeletionSuspended = true;
    _ticker?.cancel();
    super.dispose();
  }
}
