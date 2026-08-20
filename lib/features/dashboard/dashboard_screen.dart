import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/activity_repository.dart';
import '../../data/session_repository.dart';
import '../../domain/models.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    super.key,
    required this.userId,
    required this.sessions,
    this.activities,
    this.categories,
    this.insights,
    this.onGenerateInsight,
    this.onExcludeApp,
  });

  final String userId;
  final SessionRepository sessions;
  final ActivityRepository? activities;
  final CategoryRepository? categories;
  final InsightRepository? insights;
  final Future<void> Function(DateTime day)? onGenerateInsight;
  final Future<void> Function(String appId)? onExcludeApp;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime _day = DateTime.now();
  bool _generatingInsight = false;
  int _insightRevision = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 28, 32, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(context),
            const SizedBox(height: 22),
            Expanded(
              child: StreamBuilder<List<WorkSession>>(
                stream: widget.sessions.watchDay(widget.userId, _day),
                builder: (context, sessionSnapshot) {
                  if (!sessionSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final activityRepository = widget.activities;
                  if (activityRepository == null) {
                    return _content(
                      context,
                      sessionSnapshot.data!,
                      const [],
                      const [],
                    );
                  }
                  return StreamBuilder<List<ActivityBlock>>(
                    stream: activityRepository.watchDay(widget.userId, _day),
                    builder: (context, activitySnapshot) {
                      final categoryRepository = widget.categories;
                      if (!activitySnapshot.hasData ||
                          categoryRepository == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return StreamBuilder<List<ActivityCategory>>(
                        stream: categoryRepository.watch(widget.userId),
                        builder: (context, categorySnapshot) {
                          if (!categorySnapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return _content(
                            context,
                            sessionSnapshot.data!,
                            activitySnapshot.data!,
                            categorySnapshot.data!,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your day',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 4),
              const Text(
                'Observed activity is the source of category totals. Pomodoros '
                'appear as a separate intention lane.',
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Previous day',
          onPressed: () =>
              setState(() => _day = _day.subtract(const Duration(days: 1))),
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
              : () => setState(() => _day = _day.add(const Duration(days: 1))),
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }

  Widget _content(
    BuildContext context,
    List<WorkSession> sessions,
    List<ActivityBlock> blocks,
    List<ActivityCategory> categories,
  ) {
    final observedSeconds = blocks.fold<int>(
      0,
      (sum, block) => sum + block.durationSeconds,
    );
    final focusSeconds = sessions
        .where((session) => session.phase == TimerPhase.focus)
        .fold<int>(0, (sum, session) => sum + _secondsInDay(session));
    final classifiedSeconds = blocks
        .where((block) => block.categoryId != null)
        .fold<int>(0, (sum, block) => sum + block.durationSeconds);
    final completed = sessions
        .where(
          (session) =>
              session.phase == TimerPhase.focus &&
              session.outcome == SessionOutcome.completed,
        )
        .length;

    if (sessions.isEmpty && blocks.isEmpty) return _empty(context);
    return ListView(
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _stat(
              context,
              'Observed',
              _friendlyDuration(observedSeconds),
              Icons.visibility_outlined,
            ),
            _stat(
              context,
              'Pomodoro focus',
              _friendlyDuration(focusSeconds),
              Icons.bolt,
            ),
            _stat(
              context,
              'Categorized',
              observedSeconds == 0
                  ? '—'
                  : '${(classifiedSeconds * 100 / observedSeconds).round()}%',
              Icons.sell_outlined,
            ),
            _stat(
              context,
              'Pomodoros',
              '$completed',
              Icons.check_circle_outline,
            ),
          ],
        ),
        if (blocks.isNotEmpty) ...[
          const SizedBox(height: 18),
          _categorySummary(context, blocks, categories, observedSeconds),
        ],
        if (widget.insights != null) ...[
          const SizedBox(height: 18),
          _insightCard(context),
        ],
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final activity = _activityTimeline(context, blocks, categories);
            final pomodoro = _pomodoroTimeline(context, sessions);
            if (constraints.maxWidth >= 980 && blocks.isNotEmpty) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: activity),
                  const SizedBox(width: 16),
                  Expanded(flex: 5, child: pomodoro),
                ],
              );
            }
            return Column(
              children: [
                if (blocks.isNotEmpty) activity,
                if (blocks.isNotEmpty && sessions.isNotEmpty)
                  const SizedBox(height: 16),
                pomodoro,
              ],
            );
          },
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
    return SizedBox(
      width: 210,
      child: Card(
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
      ),
    );
  }

  Widget _categorySummary(
    BuildContext context,
    List<ActivityBlock> blocks,
    List<ActivityCategory> categories,
    int total,
  ) {
    final byId = {for (final category in categories) category.id: category};
    final totals = <String?, int>{};
    for (final block in blocks) {
      totals.update(
        block.categoryId,
        (value) => value + block.durationSeconds,
        ifAbsent: () => block.durationSeconds,
      );
    }
    final entries = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Observed categories',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            for (final entry in entries) ...[
              Builder(
                builder: (context) {
                  final category = byId[entry.key];
                  final color = Color(category?.colorValue ?? 0xff94a3b8);
                  final fraction = total == 0 ? 0.0 : entry.value / total;
                  return Row(
                    children: [
                      SizedBox(
                        width: 130,
                        child: Text(category?.name ?? 'Needs review'),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            minHeight: 9,
                            value: fraction,
                            color: color,
                            backgroundColor: color.withValues(alpha: 0.14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 72,
                        child: Text(
                          _friendlyDuration(entry.value),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  Widget _activityTimeline(
    BuildContext context,
    List<ActivityBlock> blocks,
    List<ActivityCategory> categories,
  ) {
    final byId = {for (final category in categories) category.id: category};
    return _timelineCard(
      context,
      title: 'Observed activity',
      subtitle: 'Screenshots are never kept',
      emptyMessage: 'No activity observations for this day.',
      children: [
        for (final block in blocks)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Color(
                byId[block.categoryId]?.colorValue ?? 0xff94a3b8,
              ).withValues(alpha: 0.15),
              child: Icon(
                Icons.desktop_windows_outlined,
                color: Color(byId[block.categoryId]?.colorValue ?? 0xff64748b),
              ),
            ),
            title: Text(block.activityLabel),
            subtitle: Text(
              '${block.appName} · ${byId[block.categoryId]?.name ?? 'Needs review'} · '
              '${block.confidence < 0.60 ? 'Low confidence—review · ' : ''}'
              '${_timeRange(block.startedAt, block.endedAt)} · '
              '${_friendlyDuration(block.durationSeconds)}',
            ),
            trailing: widget.activities == null
                ? null
                : PopupMenuButton<String>(
                    tooltip: 'Change category',
                    onSelected: (value) {
                      if (value == '_exclude') {
                        widget.onExcludeApp?.call(block.appId);
                      } else {
                        widget.activities!.setBlockCategory(block, value);
                      }
                    },
                    itemBuilder: (context) => [
                      for (final category in categories.where(
                        (value) => !value.isArchived,
                      ))
                        PopupMenuItem(
                          value: category.id,
                          child: Text(category.name),
                        ),
                      if (widget.onExcludeApp != null) ...[
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: '_exclude',
                          child: Text('Exclude this app'),
                        ),
                      ],
                    ],
                  ),
          ),
      ],
    );
  }

  Widget _pomodoroTimeline(BuildContext context, List<WorkSession> sessions) {
    return _timelineCard(
      context,
      title: 'Pomodoro intention',
      subtitle: 'Kept separate to avoid double-counting',
      emptyMessage: 'No Pomodoro sessions for this day.',
      children: [
        for (final session in sessions) _sessionTile(context, session),
      ],
    );
  }

  Widget _timelineCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String emptyMessage,
    required List<Widget> children,
  }) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 10),
            if (children.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(emptyMessage),
              )
            else
              ...children,
          ],
        ),
      ),
    );
  }

  Widget _sessionTile(BuildContext context, WorkSession session) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
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
        '${_timeRange(session.startedAt, session.endedAt)} · '
        '${_friendlyDuration(_secondsInDay(session))}'
        '${session.outcome == SessionOutcome.stopped ? ' · partial' : ''}',
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

  Widget _insightCard(BuildContext context) {
    final repository = widget.insights!;
    return FutureBuilder<DailyInsight?>(
      key: ValueKey('${_day.toIso8601String()}:$_insightRevision'),
      future: repository.get(widget.userId, _day),
      builder: (context, snapshot) {
        final insight = snapshot.data;
        return Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.auto_awesome_outlined),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Local daily insight',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        insight?.summary ??
                            'Generate a private summary from today’s local '
                                'activity and Pomodoro records.',
                      ),
                      if (insight != null) ...[
                        for (final pattern in insight.patterns.take(3))
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text('• $pattern'),
                          ),
                      ],
                    ],
                  ),
                ),
                if (widget.onGenerateInsight != null)
                  TextButton(
                    onPressed: _generatingInsight ? null : _generateInsight,
                    child: Text(insight == null ? 'Generate' : 'Refresh'),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _generateInsight() async {
    setState(() => _generatingInsight = true);
    try {
      await widget.onGenerateInsight!(_day);
      if (mounted) setState(() => _insightRevision++);
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Could not generate a local insight. Check the model status in Settings.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _generatingInsight = false);
    }
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
          const Text('Activity observations and Pomodoros will appear here.'),
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
          'It will be removed from this computer. No activity data is stored '
          'in Firebase.',
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

  String _timeRange(DateTime start, DateTime end) =>
      '${DateFormat.jm().format(start.toLocal())}–'
      '${DateFormat.jm().format(end.toLocal())}';

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
