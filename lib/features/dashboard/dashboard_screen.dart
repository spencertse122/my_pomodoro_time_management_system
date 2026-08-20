import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/session_repository.dart';
import '../../domain/models.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.userId,
    required this.sessions,
  });

  final String userId;
  final SessionRepository sessions;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _day = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your day',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 6),
                      Text('See where focused work and recovery time went.'),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Previous day',
                  onPressed: () => setState(
                    () => _day = _day.subtract(const Duration(days: 1)),
                  ),
                  icon: const Icon(Icons.chevron_left),
                ),
                TextButton(
                  onPressed: () => setState(() => _day = DateTime.now()),
                  child: Text(_dayLabel),
                ),
                IconButton(
                  tooltip: 'Next day',
                  onPressed: _isToday
                      ? null
                      : () => setState(
                          () => _day = _day.add(const Duration(days: 1)),
                        ),
                  icon: const Icon(Icons.chevron_right),
                ),
                IconButton(
                  tooltip: 'Sync now',
                  onPressed: () => widget.sessions.sync(widget.userId),
                  icon: const Icon(Icons.sync),
                ),
              ],
            ),
            const SizedBox(height: 28),
            Expanded(
              child: StreamBuilder<List<WorkSession>>(
                stream: widget.sessions.watchDay(widget.userId, _day),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final sessions = snapshot.data!;
                  if (sessions.isEmpty) return _empty(context);
                  return _content(context, sessions);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(BuildContext context, List<WorkSession> sessions) {
    final focusSeconds = sessions
        .where((session) => session.phase == TimerPhase.focus)
        .fold<int>(0, (sum, session) => sum + _secondsInDay(session));
    final breakSeconds = sessions
        .where((session) => session.phase.isBreak)
        .fold<int>(0, (sum, session) => sum + _secondsInDay(session));
    final completed = sessions
        .where(
          (session) =>
              session.phase == TimerPhase.focus &&
              session.outcome == SessionOutcome.completed,
        )
        .length;
    final partialSeconds = sessions
        .where(
          (session) =>
              session.phase == TimerPhase.focus &&
              session.outcome == SessionOutcome.stopped,
        )
        .fold<int>(0, (sum, session) => sum + _secondsInDay(session));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _stat(
                context,
                'Focus',
                _friendlyDuration(focusSeconds),
                Icons.bolt,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _stat(
                context,
                'Breaks',
                _friendlyDuration(breakSeconds),
                Icons.coffee_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _stat(
                context,
                'Pomodoros',
                '$completed',
                Icons.check_circle_outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _stat(
                context,
                'Partial focus',
                _friendlyDuration(partialSeconds),
                Icons.timelapse,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Card(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: ListView.separated(
              padding: const EdgeInsets.all(14),
              itemCount: sessions.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) =>
                  _sessionTile(context, sessions[index]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _stat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(value, style: Theme.of(context).textTheme.titleLarge),
                  Text(label, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sessionTile(BuildContext context, WorkSession session) {
    final localStart = session.startedAt.toLocal();
    final localEnd = session.endedAt.toLocal();
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          session.phase == TimerPhase.focus
              ? Icons.bolt
              : Icons.coffee_outlined,
        ),
      ),
      title: Text(
        session.phase == TimerPhase.focus
            ? session.activity
            : session.phase.label,
      ),
      subtitle: Text(
        '${DateFormat.jm().format(localStart)}–${DateFormat.jm().format(localEnd)} · '
        '${_friendlyDuration(_secondsInDay(session))}'
        '${session.outcome == SessionOutcome.stopped ? ' · partial' : ''}'
        '${session.phase.isBreak && session.activity.isNotEmpty ? ' · ${session.activity}' : ''}',
      ),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'edit') _edit(context, session);
          if (value == 'delete') _delete(context, session);
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'edit', child: Text('Edit label')),
          PopupMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
  }

  Widget _empty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_note_outlined,
            size: 58,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No tracked time for $_dayLabel',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 6),
          const Text('Completed and partial sessions will appear here.'),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context, WorkSession session) async {
    var editedActivity = session.activity;
    final value = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit activity label'),
        content: TextFormField(
          initialValue: session.activity,
          autofocus: true,
          maxLength: 160,
          onChanged: (value) => editedActivity = value,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, editedActivity.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (value != null && value.isNotEmpty) {
      await widget.sessions.editActivity(session, value);
    }
  }

  Future<void> _delete(BuildContext context, WorkSession session) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete this interval?'),
        content: const Text(
          'It will be removed locally and from Firebase during synchronization.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) await widget.sessions.delete(session);
  }

  int _secondsInDay(WorkSession session) {
    final dayStart = DateTime(_day.year, _day.month, _day.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final sessionStart = session.startedAt.toLocal();
    final sessionEnd = session.endedAt.toLocal();
    final overlapStart = sessionStart.isAfter(dayStart)
        ? sessionStart
        : dayStart;
    final overlapEnd = sessionEnd.isBefore(dayEnd) ? sessionEnd : dayEnd;
    if (!overlapEnd.isAfter(overlapStart)) return 0;
    final spanMs = sessionEnd.difference(sessionStart).inMilliseconds;
    if (spanMs <= 0) return session.actualSeconds;
    final overlapMs = overlapEnd.difference(overlapStart).inMilliseconds;
    return (session.actualSeconds * overlapMs / spanMs).round();
  }

  String _friendlyDuration(int seconds) {
    if (seconds < 60) return '${seconds}s';
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    if (hours == 0) return '${minutes}m';
    return minutes == 0 ? '${hours}h' : '${hours}h ${minutes}m';
  }

  bool get _isToday {
    final today = DateTime.now();
    return _day.year == today.year &&
        _day.month == today.month &&
        _day.day == today.day;
  }

  String get _dayLabel => _isToday ? 'Today' : DateFormat.yMMMMd().format(_day);
}
