import 'package:flutter/material.dart';

import '../../domain/models.dart';
import 'timer_controller.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key, required this.controller});

  final TimerController controller;

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final _activity = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    _activity.text = widget.controller.snapshot.activity;
  }

  @override
  void dispose() {
    _activity.dispose();
    super.dispose();
  }

  Future<void> _startFocus() async {
    try {
      await widget.controller.startFocus(_activity.text);
      setState(() => _error = null);
    } on ArgumentError catch (error) {
      setState(() => _error = error.message.toString());
    }
  }

  Future<void> _startNext() async {
    try {
      await widget.controller.startSuggested(focusActivity: _activity.text);
      setState(() => _error = null);
    } on ArgumentError catch (error) {
      setState(() => _error = error.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) => _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final controller = widget.controller;
    final snapshot = controller.snapshot;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Focus timer',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Name the work, give it your attention, and keep an honest record.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: switch (snapshot.state) {
                      TimerRunState.idle => _idle(context),
                      TimerRunState.running ||
                      TimerRunState.paused => _active(context),
                      TimerRunState.awaitingNext => _awaiting(context),
                    },
                  ),
                ),
                const SizedBox(height: 24),
                _cycleProgress(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _idle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'What are you working on?',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 18),
        TextField(
          controller: _activity,
          autofocus: true,
          maxLength: 160,
          decoration: InputDecoration(
            hintText: 'For example: Draft the project proposal',
            errorText: _error,
          ),
          onSubmitted: (_) => _startFocus(),
        ),
        const SizedBox(height: 14),
        FilledButton.icon(
          onPressed: _startFocus,
          icon: const Icon(Icons.play_arrow),
          label: Text(
            'Start ${widget.controller.settings.focusMinutes}-minute focus',
          ),
        ),
      ],
    );
  }

  Widget _active(BuildContext context) {
    final controller = widget.controller;
    final snapshot = controller.snapshot;
    final paused = snapshot.state == TimerRunState.paused;
    return Column(
      children: [
        Text(
          snapshot.phase.label.toUpperCase(),
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 10),
        Text(
          snapshot.phase == TimerPhase.focus
              ? snapshot.activity
              : 'Step away · ${snapshot.activity}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 34),
        SizedBox(
          width: 230,
          height: 230,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.expand(
                child: CircularProgressIndicator(
                  value: controller.progress.clamp(0, 1),
                  strokeWidth: 12,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest,
                  strokeCap: StrokeCap.round,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _duration(controller.remainingSeconds),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  if (paused) const Text('PAUSED'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 34),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonalIcon(
              onPressed: paused ? controller.resume : controller.pause,
              icon: Icon(paused ? Icons.play_arrow : Icons.pause),
              label: Text(paused ? 'Resume' : 'Pause'),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => _confirmStop(context),
              icon: const Icon(Icons.stop),
              label: const Text('Stop and save'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _awaiting(BuildContext context) {
    final controller = widget.controller;
    final next = controller.suggestedPhase;
    if (next == TimerPhase.focus && _activity.text.isEmpty) {
      _activity.text = controller.snapshot.activity;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 62,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 18),
        Text(
          '${controller.snapshot.phase.label} complete',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          '${controller.snapshot.plannedSeconds ~/ 60} minutes saved locally.',
          textAlign: TextAlign.center,
        ),
        if (next == TimerPhase.focus) ...[
          const SizedBox(height: 24),
          TextField(
            controller: _activity,
            maxLength: 160,
            decoration: InputDecoration(
              labelText: 'Next focus activity',
              errorText: _error,
            ),
          ),
        ] else
          const SizedBox(height: 24),
        FilledButton.icon(
          onPressed: _startNext,
          icon: const Icon(Icons.play_arrow),
          label: Text('Start ${next.label.toLowerCase()}'),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: controller.resetCycle,
          child: const Text('End cycle'),
        ),
      ],
    );
  }

  Widget _cycleProgress(BuildContext context) {
    final completed = widget.controller.snapshot.completedFocusesInCycle;
    final total = widget.controller.settings.longBreakInterval;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Long break progress  ',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        for (var index = 0; index < total; index++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Icon(
              index < completed ? Icons.circle : Icons.circle_outlined,
              size: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }

  Future<void> _confirmStop(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Stop this timer?'),
        content: const Text(
          'The focused or break time so far will be saved as a partial interval.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep going'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Stop and save'),
          ),
        ],
      ),
    );
    if (confirmed == true) await widget.controller.stop();
  }

  String _duration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainder = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainder.toString().padLeft(2, '0')}';
  }
}
