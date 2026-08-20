import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

import '../data/local/app_database.dart';
import '../data/local/encrypted_database.dart';

class EncryptedBackupService {
  EncryptedBackupService({
    required AppDatabase database,
    required String databaseKey,
    required Directory applicationDirectory,
  }) : _database = database,
       _databaseKey = databaseKey,
       _applicationDirectory = applicationDirectory;

  final AppDatabase _database;
  final String _databaseKey;
  final Directory _applicationDirectory;

  static const _minimumSupportedSchema = 1;
  static const _maximumSupportedSchema = 4;

  Future<void> exportTo({
    required String destinationPath,
    required String passphrase,
  }) async {
    _validatePassphrase(passphrase);
    final sourcePath = p.join(
      _applicationDirectory.path,
      EncryptedDatabase.databaseFileName,
    );
    if (p.equals(p.absolute(sourcePath), p.absolute(destinationPath))) {
      throw ArgumentError('Choose a different file for the backup.');
    }
    await _database.customStatement('PRAGMA wal_checkpoint(TRUNCATE);');
    final destination = File(destinationPath);
    await destination.parent.create(recursive: true);
    final temporary = File('$destinationPath.partial');
    await _deleteDatabaseAndSidecars(temporary.path);
    await _copyWithNewKey(
      sourcePath: sourcePath,
      sourceKey: _databaseKey,
      destinationPath: temporary.path,
      destinationKey: passphrase,
    );
    await _deleteDatabaseAndSidecars(destination.path);
    await temporary.rename(destination.path);
  }

  /// Validates a portable backup, re-encrypts it with this machine's protected
  /// key, and stages it for an atomic restore on the next app launch.
  Future<void> stageImport({
    required String sourcePath,
    required String passphrase,
    required bool confirmedReplaceAllProfiles,
  }) async {
    if (!confirmedReplaceAllProfiles) {
      throw ArgumentError(
        'Confirm that the restore will replace every local profile.',
      );
    }
    _validatePassphrase(passphrase);
    final staged = File(
      p.join(
        _applicationDirectory.path,
        EncryptedDatabase.pendingRestoreFileName,
      ),
    );
    if (p.equals(p.absolute(sourcePath), p.absolute(staged.path))) {
      throw ArgumentError('The selected backup path is invalid.');
    }
    await _applicationDirectory.create(recursive: true);
    final temporary = File('${staged.path}.partial');
    await _deleteDatabaseAndSidecars(temporary.path);
    await _copyWithNewKey(
      sourcePath: sourcePath,
      sourceKey: passphrase,
      destinationPath: temporary.path,
      destinationKey: _databaseKey,
    );
    await _deleteDatabaseAndSidecars(staged.path);
    await temporary.rename(staged.path);
  }

  /// Cancels a not-yet-applied restore, including an interrupted staging file.
  ///
  /// Account deletion calls this so an older device-wide backup cannot bring
  /// the just-deleted profile back on the next launch.
  Future<void> cancelStagedImport() async {
    final stagedPath = p.join(
      _applicationDirectory.path,
      EncryptedDatabase.pendingRestoreFileName,
    );
    await _deleteDatabaseAndSidecars(stagedPath);
    await _deleteDatabaseAndSidecars('$stagedPath.partial');
  }

  Future<void> _copyWithNewKey({
    required String sourcePath,
    required String sourceKey,
    required String destinationPath,
    required String destinationKey,
  }) async {
    if (!await File(sourcePath).exists()) {
      throw const FileSystemException(
        'The encrypted database file is missing.',
      );
    }
    final source = sqlite3.open(sourcePath);
    Database? destination;
    var sourceClosed = false;
    try {
      _applyKey(source, sourceKey);
      _verify(source);
      _verifyPortableSchema(source);
      destination = sqlite3.open(destinationPath);
      _applyKey(destination, destinationKey);
      await source.backup(destination, nPage: 128).drain<void>();
      _verify(destination);
      _verifyPortableSchema(destination);
    } on Object catch (error, stackTrace) {
      // Windows will not delete an open SQLite file. Close both handles first,
      // then best-effort scrub the partial without masking the real failure.
      try {
        destination?.close();
      } on Object {
        // Preserve the validation/copy failure below.
      }
      destination = null;
      try {
        source.close();
      } on Object {
        // Preserve the validation/copy failure below.
      }
      sourceClosed = true;
      try {
        await _deleteDatabaseAndSidecars(destinationPath);
      } on Object {
        // Preserve the validation/copy failure that caused cleanup.
      }
      Error.throwWithStackTrace(error, stackTrace);
    } finally {
      destination?.close();
      if (!sourceClosed) source.close();
    }
  }

  void _applyKey(Database database, String key) {
    final cipher = database.select("PRAGMA cipher = 'sqlcipher';");
    if (cipher.isEmpty || cipher.first.values.first != 'sqlcipher') {
      throw StateError('The encrypted SQLite runtime is unavailable.');
    }
    final keyed = database.select("PRAGMA key = '${_escape(key)}';");
    if (keyed.isEmpty || keyed.first.values.first != 'ok') {
      throw StateError('The backup passphrase is incorrect.');
    }
  }

  void _verify(Database database) {
    database.select('SELECT count(*) FROM sqlite_master;');
    final integrity = database.select('PRAGMA integrity_check;');
    if (integrity.isEmpty || integrity.first.values.first != 'ok') {
      throw StateError('Encrypted backup integrity verification failed.');
    }
  }

  void _verifyPortableSchema(Database database) {
    final versionRows = database.select('PRAGMA user_version;');
    final version = versionRows.isEmpty
        ? 0
        : versionRows.first.values.first as int;
    if (version < _minimumSupportedSchema ||
        version > _maximumSupportedSchema) {
      throw StateError(
        'The backup schema is not compatible with this release.',
      );
    }
    final expected = _expectedSchema(version);
    final tables = database
        .select(
          "SELECT name FROM sqlite_master WHERE type = 'table' "
          "AND name NOT LIKE 'sqlite_%';",
        )
        .map((row) => row['name'] as String)
        .toSet();
    if (tables.length != expected.length ||
        !tables.containsAll(expected.keys)) {
      throw StateError('The selected file is not a Focus Flow backup.');
    }
    for (final entry in expected.entries) {
      final columns = database
          .select('PRAGMA table_info("${_escapeIdentifier(entry.key)}");')
          .map((row) => row['name'] as String)
          .toSet();
      if (columns.length != entry.value.length ||
          !columns.containsAll(entry.value)) {
        throw StateError(
          'The backup schema for ${entry.key} is incomplete or unexpected.',
        );
      }
    }
  }

  Map<String, Set<String>> _expectedSchema(int version) {
    final schema = <String, Set<String>>{
      'session_entries': {
        'id',
        'user_id',
        'cycle_id',
        'phase',
        'activity',
        'planned_seconds',
        'actual_seconds',
        'started_at',
        'ended_at',
        'outcome',
        'updated_at',
        'is_deleted',
        'is_dirty',
      },
      'timer_entries': {
        'user_id',
        'state',
        'phase',
        'activity',
        'cycle_id',
        'completed_focuses_in_cycle',
        'planned_seconds',
        'accumulated_seconds',
        'started_at',
        'deadline',
        'updated_at',
      },
      'settings_entries': {
        'user_id',
        'focus_minutes',
        'short_break_minutes',
        'long_break_minutes',
        'long_break_interval',
        'sound_enabled',
        'is_dirty',
        'updated_at',
      },
    };
    if (version >= 2) {
      schema['auth_entries'] = {
        'user_id',
        'email',
        'refresh_token',
        'updated_at',
      };
    }
    if (version >= 3) {
      schema['session_entries']!.addAll({
        'category_id',
        'category_source',
        'category_confidence',
        'alignment',
      });
      schema.addAll({
        'activity_sample_entries': {
          'id',
          'user_id',
          'captured_at',
          'started_at',
          'ended_at',
          'app_id',
          'app_name',
          'window_title',
          'activity_label',
          'category_id',
          'category_source',
          'confidence',
          'secondary_context_json',
          'processing_state',
          'model_version',
          'prompt_version',
          'failure_code',
          'updated_at',
        },
        'activity_block_entries': {
          'id',
          'user_id',
          'started_at',
          'ended_at',
          'app_id',
          'app_name',
          'activity_label',
          'category_id',
          'category_source',
          'confidence',
          'sample_count',
          'secondary_context_json',
        },
        'category_entries': {
          'id',
          'user_id',
          'name',
          'description',
          'color_value',
          'sort_order',
          'is_archived',
          'is_system',
          'updated_at',
        },
        'category_rule_entries': {
          'id',
          'user_id',
          'app_id',
          'title_contains',
          'category_id',
          'updated_at',
        },
        'daily_insight_entries': {
          'user_id',
          'local_date',
          'summary',
          'patterns_json',
          'discrepancies_json',
          'model_version',
          'prompt_version',
          'source_updated_at',
          'generated_at',
        },
        'tracking_settings_entries': {
          'user_id',
          'tracking_enabled',
          'capture_interval_minutes',
          'idle_threshold_minutes',
          'launch_at_login',
          'capture_all_displays',
          'diagnostics_enabled',
          'excluded_app_ids_json',
          'paused_until',
          'updated_at',
        },
        'migration_state_entries': {
          'user_id',
          'state',
          'imported_session_count',
          'cloud_verified_empty',
          'last_error',
          'updated_at',
        },
        'diagnostics_counter_entries': {
          'day_utc',
          'event',
          'outcome',
          'duration_bucket',
          'count',
        },
      });
    }
    if (version >= 4) {
      schema['tracking_settings_entries']!.addAll({
        'onboarding_complete',
        'privacy_notice_version',
      });
    }
    return schema;
  }

  void _validatePassphrase(String passphrase) {
    if (passphrase.length < 12) {
      throw ArgumentError(
        'Use a backup passphrase with at least 12 characters.',
      );
    }
  }

  String _escape(String value) => value.replaceAll("'", "''");

  String _escapeIdentifier(String value) => value.replaceAll('"', '""');

  Future<void> _deleteDatabaseAndSidecars(String path) async {
    for (final candidate in [path, '$path-wal', '$path-shm', '$path-journal']) {
      final file = File(candidate);
      if (await file.exists()) await file.delete();
    }
  }
}
