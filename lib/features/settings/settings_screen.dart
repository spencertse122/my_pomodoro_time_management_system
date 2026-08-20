import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../data/activity_repository.dart';
import '../../domain/models.dart';
import '../../services/encrypted_backup_service.dart';
import '../../services/legacy_cloud_migration_service.dart';
import '../../services/update_service.dart';
import '../timer/timer_controller.dart';
import '../tracking/activity_tracking_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.controller,
    this.userId,
    this.tracking,
    this.categories,
    this.backup,
    this.migration,
    this.updates,
    this.onDeleteAccount,
  });

  final TimerController controller;
  final String? userId;
  final ActivityTrackingController? tracking;
  final CategoryRepository? categories;
  final EncryptedBackupService? backup;
  final LegacyCloudMigrationService? migration;
  final UpdateService? updates;
  final Future<void> Function()? onDeleteAccount;

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
  bool _dataBusy = false;

  @override
  void initState() {
    super.initState();
    final settings = widget.controller.settings;
    _focus = TextEditingController(text: '${settings.focusMinutes}');
    _shortBreak = TextEditingController(text: '${settings.shortBreakMinutes}');
    _longBreak = TextEditingController(text: '${settings.longBreakMinutes}');
    _interval = TextEditingController(text: '${settings.longBreakInterval}');
    _sound = settings.soundEnabled;
    widget.tracking?.addListener(_trackingChanged);
  }

  @override
  void dispose() {
    widget.tracking?.removeListener(_trackingChanged);
    _focus.dispose();
    _shortBreak.dispose();
    _longBreak.dispose();
    _interval.dispose();
    super.dispose();
  }

  void _trackingChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(36, 30, 36, 48),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Settings',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 6),
              const Text(
                'Activity data, categories, and AI output remain encrypted on this computer.',
              ),
              const SizedBox(height: 26),
              if (widget.tracking != null) ...[
                _trackingCard(context),
                const SizedBox(height: 18),
              ],
              if (widget.categories != null && widget.userId != null) ...[
                _categoriesCard(context),
                const SizedBox(height: 18),
              ],
              _pomodoroCard(context),
              if (widget.backup != null || widget.migration != null) ...[
                const SizedBox(height: 18),
                _privacyDataCard(context),
              ],
              if (widget.updates != null || widget.onDeleteAccount != null) ...[
                const SizedBox(height: 18),
                _accountCard(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _trackingCard(BuildContext context) {
    final controller = widget.tracking!;
    final settings = controller.settings;
    final permissionLabel = switch (controller.permission) {
      _ when controller.permission.name == 'granted' => 'Screen access granted',
      _ when controller.permission.name == 'denied' => 'Screen access denied',
      _ when controller.permission.name == 'restricted' =>
        'Screen capture blocked by this system',
      _ when controller.permission.name == 'unsupported' =>
        'Screen capture unsupported',
      _ => 'Screen access not requested',
    };
    final aiLabel = controller.aiAvailability?.isReady == true
        ? 'Gemma is ready'
        : 'Gemma model files are missing';
    return _section(
      context,
      title: 'Local activity tracking',
      subtitle: '$permissionLabel · $aiLabel',
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Track foreground activity'),
          subtitle: const Text(
            'Images are analyzed in memory by the local model and never saved.',
          ),
          value: settings.trackingEnabled,
          onChanged: _dataBusy ? null : _setTrackingEnabled,
        ),
        const Divider(),
        Text('Capture interval: ${settings.captureIntervalMinutes} minutes'),
        Slider(
          value: settings.captureIntervalMinutes.toDouble(),
          min: 1,
          max: 30,
          divisions: 29,
          label: '${settings.captureIntervalMinutes} min',
          onChanged: (value) => controller.updateTrackingSettings(
            settings.copyWith(captureIntervalMinutes: value.round()),
          ),
        ),
        Text('Pause after ${settings.idleThresholdMinutes} idle minutes'),
        Slider(
          value: settings.idleThresholdMinutes.toDouble().clamp(1, 30),
          min: 1,
          max: 30,
          divisions: 29,
          label: '${settings.idleThresholdMinutes} min',
          onChanged: (value) => controller.updateTrackingSettings(
            settings.copyWith(idleThresholdMinutes: value.round()),
          ),
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Launch at login'),
          subtitle: const Text('Tracking still follows the switch above.'),
          value: settings.launchAtLogin,
          onChanged: _dataBusy ? null : _setLaunchAtLogin,
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Aggregate health diagnostics'),
          subtitle: const Text(
            'Sends only bounded success/failure counts when an endpoint is configured.',
          ),
          value: settings.diagnosticsEnabled,
          onChanged: (value) => controller.updateTrackingSettings(
            settings.copyWith(diagnosticsEnabled: value),
          ),
        ),
        if (settings.excludedAppIds.isNotEmpty) ...[
          const Divider(),
          Text(
            'Excluded applications',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          for (final appId in settings.excludedAppIds)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(appId),
              trailing: IconButton(
                tooltip: 'Resume tracking this app',
                onPressed: () => controller.includeApp(appId),
                icon: const Icon(Icons.close),
              ),
            ),
        ],
        if (settings.trackingEnabled)
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              spacing: 8,
              children: [
                if (settings.isPaused)
                  TextButton.icon(
                    onPressed: controller.resume,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Resume'),
                  )
                else
                  TextButton.icon(
                    onPressed: () =>
                        controller.pauseFor(const Duration(hours: 1)),
                    icon: const Icon(Icons.pause),
                    label: const Text('Pause for 1 hour'),
                  ),
                TextButton.icon(
                  onPressed: controller.isBusy ? null : controller.captureNow,
                  icon: const Icon(Icons.camera_outlined),
                  label: const Text('Analyze now'),
                ),
              ],
            ),
          ),
        if (controller.lastError != null)
          Text(
            controller.lastError!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
      ],
    );
  }

  Widget _categoriesCard(BuildContext context) {
    final repository = widget.categories!;
    return StreamBuilder<List<ActivityCategory>>(
      stream: repository.watch(widget.userId!),
      builder: (context, snapshot) => _section(
        context,
        title: 'Activity categories',
        subtitle: 'Gemma can choose only from this list.',
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: () => _editCategory(null),
              icon: const Icon(Icons.add),
              label: const Text('Add category'),
            ),
          ),
          for (final category in snapshot.data ?? const <ActivityCategory>[])
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Color(category.colorValue),
                radius: 9,
              ),
              title: Text(category.name),
              subtitle: Text(
                '${category.description}${category.isArchived ? ' · archived' : ''}',
              ),
              trailing: IconButton(
                tooltip: 'Edit category',
                onPressed: () => _editCategory(category),
                icon: const Icon(Icons.edit_outlined),
              ),
            ),
        ],
      ),
    );
  }

  Widget _pomodoroCard(BuildContext context) {
    return _section(
      context,
      title: 'Pomodoro cycle',
      subtitle: 'Changes apply to the next phase.',
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: _minutesField(_focus, 'Focus minutes')),
                  const SizedBox(width: 12),
                  Expanded(child: _minutesField(_shortBreak, 'Short break')),
                  const SizedBox(width: 12),
                  Expanded(child: _minutesField(_longBreak, 'Long break')),
                ],
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _interval,
                decoration: const InputDecoration(
                  labelText: 'Focuses before a long break',
                ),
                validator: (value) =>
                    _wholeNumber(value, minimum: 2, maximum: 12),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Play completion sound'),
                value: _sound,
                onChanged: (value) => setState(() => _sound = value),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: _saving ? null : _savePomodoro,
                  child: const Text('Save Pomodoro settings'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _privacyDataCard(BuildContext context) {
    return _section(
      context,
      title: 'Private data and recovery',
      subtitle:
          'A backup contains every local Focus Flow profile on this computer. It is encrypted and the passphrase is never stored.',
      children: [
        if (widget.backup != null)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.lock_outline),
            title: const Text('Encrypted backup'),
            subtitle: const Text(
              'Export now, or stage a restore that applies after restart.',
            ),
            trailing: Wrap(
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: _dataBusy ? null : _importBackup,
                  child: const Text('Import'),
                ),
                FilledButton.tonal(
                  onPressed: _dataBusy ? null : _exportBackup,
                  child: const Text('Export'),
                ),
              ],
            ),
          ),
        if (widget.migration != null) ...[
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.cloud_download_outlined),
            title: const Text('Legacy Firebase cleanup'),
            subtitle: const Text(
              'Preview, import to this primary computer, permanently purge the cloud copy, and verify it is empty.',
            ),
            trailing: OutlinedButton(
              onPressed: _dataBusy ? null : _migrateLegacy,
              child: const Text('Review'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _accountCard(BuildContext context) {
    return _section(
      context,
      title: 'Account and application',
      subtitle: 'Firebase is used for identity only.',
      children: [
        if (widget.updates != null)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.system_update_alt),
            title: const Text('Check for updates'),
            subtitle: Text(
              widget.updates!.isConfigured
                  ? 'Uses the signed release feed configured for this build.'
                  : 'No production update feed is configured in this build.',
            ),
            trailing: OutlinedButton(
              onPressed: widget.updates!.isConfigured ? _checkUpdates : null,
              child: const Text('Check'),
            ),
          ),
        if (widget.onDeleteAccount != null) ...[
          const Divider(),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.delete_forever_outlined,
              color: Theme.of(context).colorScheme.error,
            ),
            title: const Text('Delete account and local data'),
            subtitle: const Text(
              'Purges legacy cloud records, cancels any staged restore, and permanently deletes the Firebase identity and this account’s encrypted local records.',
            ),
            trailing: TextButton(
              onPressed: _dataBusy ? null : _deleteAccount,
              child: const Text('Delete account'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _section(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Future<void> _savePomodoro() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await widget.controller.updateSettings(
        PomodoroSettings(
          focusMinutes: int.parse(_focus.text),
          shortBreakMinutes: int.parse(_shortBreak.text),
          longBreakMinutes: int.parse(_longBreak.text),
          longBreakInterval: int.parse(_interval.text),
          soundEnabled: _sound,
        ),
      );
      if (mounted) _message('Pomodoro settings saved.');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _setTrackingEnabled(bool value) async {
    setState(() => _dataBusy = true);
    try {
      if (value) {
        final enabled = await widget.tracking!.enableTracking();
        if (!enabled && mounted) {
          _message('Screen access is required for local AI tracking.');
        }
      } else {
        await widget.tracking!.disableTracking();
      }
    } on Object {
      if (mounted) {
        _message(
          'Activity tracking could not be changed. Check system permissions and try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _dataBusy = false);
    }
  }

  Future<void> _setLaunchAtLogin(bool value) async {
    setState(() => _dataBusy = true);
    try {
      await widget.tracking!.updateTrackingSettings(
        widget.tracking!.settings.copyWith(launchAtLogin: value),
      );
      if (mounted && widget.tracking!.settings.launchAtLogin != value) {
        _message('The operating system did not accept the login setting.');
      }
    } on Object {
      if (mounted) {
        _message('Launch at login could not be changed on this computer.');
      }
    } finally {
      if (mounted) setState(() => _dataBusy = false);
    }
  }

  Future<void> _editCategory(ActivityCategory? category) async {
    var name = category?.name ?? '';
    var description = category?.description ?? '';
    var colorValue = category?.colorValue ?? 0xff64748b;
    var archived = category?.isArchived ?? false;
    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(category == null ? 'Add category' : 'Edit category'),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: name,
                  maxLength: 60,
                  decoration: const InputDecoration(labelText: 'Name'),
                  onChanged: (value) => name = value,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: description,
                  maxLength: 240,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                  onChanged: (value) => description = value,
                ),
                const SizedBox(height: 12),
                const Text('Color'),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final color in const [
                      0xff3b82f6,
                      0xff10b981,
                      0xff8b5cf6,
                      0xffef4444,
                      0xfff59e0b,
                      0xff64748b,
                    ])
                      ChoiceChip(
                        label: const SizedBox.square(dimension: 14),
                        avatar: CircleAvatar(backgroundColor: Color(color)),
                        selected: colorValue == color,
                        onSelected: (_) =>
                            setDialogState(() => colorValue = color),
                      ),
                  ],
                ),
                if (category != null)
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: archived,
                    onChanged: (value) =>
                        setDialogState(() => archived = value ?? false),
                    title: const Text('Archive category'),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (name.trim().isEmpty || description.trim().isEmpty) return;
                Navigator.pop(context, true);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    if (saved != true) return;
    try {
      if (category == null) {
        await widget.categories!.create(
          userId: widget.userId!,
          name: name,
          description: description,
          colorValue: colorValue,
        );
      } else {
        await widget.categories!.save(
          category.copyWith(
            name: name,
            description: description,
            colorValue: colorValue,
            isArchived: archived,
          ),
        );
      }
    } on ArgumentError catch (error) {
      if (mounted) _message(error.message?.toString() ?? error.toString());
    }
  }

  Future<void> _exportBackup() async {
    final passphrase = await _askPassphrase(confirm: true);
    if (passphrase == null) return;
    const type = XTypeGroup(
      label: 'Focus Flow encrypted backup',
      extensions: ['focusflow'],
    );
    final destination = await getSaveLocation(
      acceptedTypeGroups: const [type],
      suggestedName:
          'focus-flow-${DateFormat('yyyy-MM-dd').format(DateTime.now())}.focusflow',
    );
    if (destination == null) return;
    await _runDataTask(() async {
      await widget.backup!.exportTo(
        destinationPath: destination.path,
        passphrase: passphrase,
      );
      if (mounted) _message('Encrypted backup created.');
    });
  }

  Future<void> _importBackup() async {
    const type = XTypeGroup(
      label: 'Focus Flow encrypted backup',
      extensions: ['focusflow'],
    );
    final source = await openFile(acceptedTypeGroups: const [type]);
    if (source == null) return;
    if (!mounted) return;
    final replace = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Replace all local profiles after restart?'),
        content: const Text(
          'Importing this device backup will replace every Focus Flow profile '
          'stored on this computer. The backup is verified before it is staged.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
    if (replace != true || !mounted) return;
    final passphrase = await _askPassphrase();
    if (passphrase == null) return;
    await _runDataTask(() async {
      await widget.backup!.stageImport(
        sourcePath: source.path,
        passphrase: passphrase,
        confirmedReplaceAllProfiles: true,
      );
      if (mounted) {
        _message(
          'Restore verified and staged. Restart Focus Flow to apply it.',
        );
      }
    });
  }

  Future<void> _migrateLegacy() async {
    await _runDataTask(() async {
      final preview = await widget.migration!.preview(widget.userId!);
      if (!mounted) return;
      var primary = false;
      var purge = false;
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setDialogState) => AlertDialog(
            title: const Text('Import and purge legacy cloud data'),
            content: SizedBox(
              width: 520,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    preview.hasCloudData
                        ? '${preview.sessionCount} session(s) and '
                              '${preview.hasPomodoroSettings ? 'one settings record' : 'no settings record'} were found.'
                        : 'No legacy session or settings records were found.',
                  ),
                  const SizedBox(height: 14),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: primary,
                    onChanged: (value) =>
                        setDialogState(() => primary = value ?? false),
                    title: const Text('This is my primary computer'),
                  ),
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: purge,
                    onChanged: (value) =>
                        setDialogState(() => purge = value ?? false),
                    title: const Text(
                      'Permanently delete the imported records from Firebase',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: primary && purge
                    ? () => Navigator.pop(context, true)
                    : null,
                child: const Text('Import, purge, and verify'),
              ),
            ],
          ),
        ),
      );
      if (confirmed != true) return;
      final state = await widget.migration!.importAndPurge(
        userId: widget.userId!,
        confirmedPrimaryDevice: primary,
        confirmedPermanentPurge: purge,
      );
      if (mounted) {
        _message(
          'Imported ${state.importedSessionCount} session(s); Firebase is verified empty.',
        );
      }
    });
  }

  Future<void> _checkUpdates() async {
    try {
      final update = await widget.updates!.check();
      if (!mounted) return;
      if (update == null) {
        _message('Focus Flow is up to date.');
        return;
      }
      await Clipboard.setData(
        ClipboardData(text: update.downloadUrl.toString()),
      );
      _message(
        'Version ${update.version} is available. Its signed download link was copied.',
      );
    } on Object {
      _message('Update check failed. Check your connection and try again.');
    }
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permanently delete your account?'),
        content: const Text(
          'This purges legacy Firebase data, deletes your Firebase identity and local history, and cancels any pending device-wide restore so it cannot bring the profile back. User-created backup files are not deleted. Export one first if needed.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete permanently'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _dataBusy = true);
    try {
      await widget.onDeleteAccount!();
    } on Object {
      if (mounted) {
        _message(
          'Account deletion could not be fully verified. No success was reported; check your connection and try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _dataBusy = false);
    }
  }

  Future<String?> _askPassphrase({bool confirm = false}) async {
    var first = '';
    var second = '';
    String? error;
    return showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(
            confirm ? 'Create backup passphrase' : 'Backup passphrase',
          ),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  autofocus: true,
                  decoration: const InputDecoration(labelText: 'Passphrase'),
                  onChanged: (value) => first = value,
                ),
                if (confirm) ...[
                  const SizedBox(height: 12),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm passphrase',
                    ),
                    onChanged: (value) => second = value,
                  ),
                ],
                if (error != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                if (first.length < 12) {
                  setDialogState(() => error = 'Use at least 12 characters.');
                } else if (confirm && first != second) {
                  setDialogState(() => error = 'Passphrases do not match.');
                } else {
                  Navigator.pop(context, first);
                }
              },
              child: Text(confirm ? 'Continue' : 'Unlock'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _runDataTask(Future<void> Function() task) async {
    setState(() => _dataBusy = true);
    try {
      await task();
    } on Object {
      if (mounted) {
        _message(
          'The encrypted data operation failed. Check the selected file and passphrase.',
        );
      }
    } finally {
      if (mounted) setState(() => _dataBusy = false);
    }
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
    return number == null || number < minimum || number > maximum
        ? 'Use $minimum–$maximum'
        : null;
  }

  void _message(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
