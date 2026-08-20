import 'package:flutter/material.dart';

import '../../domain/models.dart';
import '../timer/timer_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.controller});

  final TimerController controller;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final TextEditingController _focus;
  late final TextEditingController _shortBreak;
  late final TextEditingController _longBreak;
  late final TextEditingController _interval;
  late bool _sound;
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final settings = widget.controller.settings;
    _focus = TextEditingController(text: '${settings.focusMinutes}');
    _shortBreak = TextEditingController(text: '${settings.shortBreakMinutes}');
    _longBreak = TextEditingController(text: '${settings.longBreakMinutes}');
    _interval = TextEditingController(text: '${settings.longBreakInterval}');
    _sound = settings.soundEnabled;
  }

  @override
  void dispose() {
    _focus.dispose();
    _shortBreak.dispose();
    _longBreak.dispose();
    _interval.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    await widget.controller.updateSettings(
      PomodoroSettings(
        focusMinutes: int.parse(_focus.text),
        shortBreakMinutes: int.parse(_shortBreak.text),
        longBreakMinutes: int.parse(_longBreak.text),
        longBreakInterval: int.parse(_interval.text),
        soundEnabled: _sound,
      ),
    );
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Settings saved.')));
  }

  void _reset() {
    setState(() {
      _focus.text = '25';
      _shortBreak.text = '5';
      _longBreak.text = '15';
      _interval.text = '4';
      _sound = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(40),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Changes apply to the next phase, never a timer already in progress.',
                ),
                const SizedBox(height: 28),
                Card(
                  color: Theme.of(context).colorScheme.surfaceContainerLow,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Pomodoro cycle',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: _minutesField(_focus, 'Focus minutes'),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _minutesField(_shortBreak, 'Short break'),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: _minutesField(_longBreak, 'Long break'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _interval,
                          decoration: const InputDecoration(
                            labelText: 'Focus sessions before a long break',
                          ),
                          validator: (value) =>
                              _wholeNumber(value, minimum: 2, maximum: 12),
                        ),
                        const SizedBox(height: 12),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Play completion sound'),
                          subtitle: const Text(
                            'System notifications are still shown when sound is off.',
                          ),
                          value: _sound,
                          onChanged: (value) => setState(() => _sound = value),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _saving ? null : _reset,
                      child: const Text('Restore classic defaults'),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: _saving ? null : _save,
                      child: const Text('Save settings'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _minutesField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) => _wholeNumber(value, minimum: 1, maximum: 180),
    );
  }

  String? _wholeNumber(
    String? value, {
    required int minimum,
    required int maximum,
  }) {
    final number = int.tryParse(value ?? '');
    if (number == null || number < minimum || number > maximum) {
      return 'Use $minimum–$maximum';
    }
    return null;
  }
}
