import 'dart:io';

const _files = <String, String>{
  'assets/models/gemma-3-4b-it-q4_k_m.gguf': 'GEMMA_MODEL_SHA256',
  'assets/models/mmproj-gemma-3-4b-it-f16.gguf': 'GEMMA_MMPROJ_SHA256',
};

Future<void> main() async {
  var failed = false;
  for (final entry in _files.entries) {
    final expected = Platform.environment[entry.value]?.trim().toLowerCase();
    if (expected == null || !RegExp(r'^[a-f0-9]{64}$').hasMatch(expected)) {
      stderr.writeln('${entry.value} must contain a 64-character SHA-256.');
      failed = true;
      continue;
    }
    final file = File(entry.key);
    if (!await file.exists()) {
      stderr.writeln('${entry.key} is missing.');
      failed = true;
      continue;
    }
    final actual = await _sha256(file);
    if (actual != expected) {
      stderr.writeln('${entry.key} failed SHA-256 verification.');
      failed = true;
    } else {
      stdout.writeln('Verified ${entry.key}.');
    }
  }
  if (failed) exitCode = 1;
}

Future<String> _sha256(File file) async {
  if (Platform.isWindows) {
    final result = await Process.run('certutil', [
      '-hashfile',
      file.path,
      'SHA256',
    ]);
    if (result.exitCode != 0) {
      throw StateError('certutil failed: ${result.stderr}');
    }
    final lines = (result.stdout as String)
        .split(RegExp(r'\r?\n'))
        .map((line) => line.trim().replaceAll(' ', '').toLowerCase());
    return lines.firstWhere((line) => RegExp(r'^[a-f0-9]{64}$').hasMatch(line));
  }
  final result = await Process.run('shasum', ['-a', '256', file.path]);
  if (result.exitCode != 0) {
    throw StateError('shasum failed: ${result.stderr}');
  }
  return (result.stdout as String)
      .trim()
      .split(RegExp(r'\s+'))
      .first
      .toLowerCase();
}
