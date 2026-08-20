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

  TimerSnapshot snapshot;
  PomodoroSettings settings = const PomodoroSettings();
  bool initialized = false;

  int get remainingSeconds {
    if (snapshot.state == TimerRunState.running && snapshot.deadline != null) {
      return snapshot.deadline!
          .difference(_now())
          .inSeconds
          .clamp(0, snapshot.plannedSeconds);
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
    final value = activity.trim();
    if (value.isEmpty) {
      throw ArgumentError('Describe what you are focusing on.');
    }
    await _begin(
      phase: TimerPhase.focus,
      activity: value,
      cycleId: _uuid.v4(),
      completedFocuses: 0,
    );
  }

  Future<void> startSuggested({String? focusActivity}) async {
    if (snapshot.state != TimerRunState.awaitingNext) return;
    final phase = suggestedPhase;
    var activity = snapshot.activity;
    var completed = snapshot.completedFocusesInCycle;
    if (phase == TimerPhase.focus) {
      activity = (focusActivity ?? activity).trim();
      if (activity.isEmpty) {
        throw ArgumentError('Describe what you are focusing on.');
      }
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
    _ticker?.cancel();
    snapshot = TimerSnapshot.idle(_userId);
    await _database.saveTimer(snapshot);
    notifyListeners();
  }

  Future<void> updateSettings(PomodoroSettings value) async {
    settings = value;
    await _settingsRepository.save(_userId, value);
    notifyListeners();
  }

  int _elapsedAt(DateTime now) {
    if (snapshot.deadline == null) return snapshot.accumulatedSeconds;
    final remaining = snapshot.deadline!
        .difference(now)
        .inSeconds
        .clamp(0, snapshot.plannedSeconds);
    return (snapshot.plannedSeconds - remaining).clamp(
      0,
      snapshot.plannedSeconds,
    );
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (remainingSeconds <= 0) {
        await _complete(playNotification: true);
      } else {
        notifyListeners();
      }
    });
  }

  Future<void> _complete({required bool playNotification}) async {
    if (_completing || snapshot.state != TimerRunState.running) return;
    _completing = true;
    _ticker?.cancel();
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
      await _notifier.showCompletion(
        completedPhase,
        playSound: settings.soundEnabled,
      );
    }
    _completing = false;
    notifyListeners();
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
    _ticker?.cancel();
    super.dispose();
  }
}
