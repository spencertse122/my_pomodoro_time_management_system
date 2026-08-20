import 'package:flutter/material.dart';

class PrivacyOnboardingScreen extends StatefulWidget {
  const PrivacyOnboardingScreen({
    super.key,
    required this.onEnableTracking,
    required this.onContinueWithoutTracking,
  });

  final Future<bool> Function() onEnableTracking;
  final Future<void> Function() onContinueWithoutTracking;

  @override
  State<PrivacyOnboardingScreen> createState() =>
      _PrivacyOnboardingScreenState();
}

class _PrivacyOnboardingScreenState extends State<PrivacyOnboardingScreen> {
  bool _busy = false;
  String? _error;

  Future<void> _enable() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final enabled = await widget.onEnableTracking();
      if (!enabled && mounted) {
        setState(() {
          _busy = false;
          _error =
              'Screen access was not granted. You can continue without activity '
              'tracking and enable it later in Settings.';
        });
      }
    } on Object {
      if (mounted) {
        setState(() {
          _busy = false;
          _error =
              'Activity tracking could not start. You can continue without it '
              'and try again from Settings.';
        });
      }
    }
  }

  Future<void> _skip() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await widget.onContinueWithoutTracking();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Card(
                color: colors.surfaceContainerLow,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: colors.primaryContainer,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Icon(
                          Icons.shield_outlined,
                          size: 36,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Your activity history stays on your computer',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Focus Flow can observe the foreground app and, at an '
                        'interval you choose, record its identifier and active '
                        'window title, then briefly capture connected displays '
                        'so Gemma can describe and categorize your activity.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 28),
                      const Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _PrivacyFact(
                            icon: Icons.computer,
                            title: 'Local AI only',
                            body:
                                'Gemma runs on this machine. Screenshots are passed '
                                'to memory and discarded after each analysis.',
                          ),
                          _PrivacyFact(
                            icon: Icons.lock_outline,
                            title: 'Encrypted history',
                            body:
                                'Activity, categories, timers, and insights live in '
                                'an encrypted local database.',
                          ),
                          _PrivacyFact(
                            icon: Icons.cloud_off_outlined,
                            title: 'No cloud activity data',
                            body:
                                'Firebase is used only to sign in. Your activity '
                                'history is not synchronized to Firebase.',
                          ),
                          _PrivacyFact(
                            icon: Icons.pause_circle_outline,
                            title: 'You stay in control',
                            body:
                                'Tracking pauses while idle or locked. Pause it, '
                                'exclude apps, or turn it off at any time.',
                          ),
                          _PrivacyFact(
                            icon: Icons.monitor_heart_outlined,
                            title: 'Coarse diagnostics only',
                            body:
                                'If a release endpoint is configured, bounded '
                                'success and failure counts are enabled by default. '
                                'Turn them off in Settings at any time.',
                          ),
                        ],
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 22),
                        MaterialBanner(
                          padding: const EdgeInsets.all(16),
                          content: Text(_error!),
                          leading: Icon(
                            Icons.info_outline,
                            color: colors.error,
                          ),
                          actions: const [SizedBox.shrink()],
                        ),
                      ],
                      const SizedBox(height: 30),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          TextButton(
                            onPressed: _busy ? null : _skip,
                            child: const Text('Continue without tracking'),
                          ),
                          FilledButton.icon(
                            onPressed: _busy ? null : _enable,
                            icon: _busy
                                ? const SizedBox.square(
                                    dimension: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.visibility_outlined),
                            label: const Text('Enable local activity tracking'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PrivacyFact extends StatelessWidget {
  const _PrivacyFact({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
