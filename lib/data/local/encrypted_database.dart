import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

import 'app_database.dart';

/// Opens Focus Flow's local database with SQLCipher-compatible encryption.
///
/// The [key] must come from OS-protected storage. It is deliberately required:
/// there is no production fallback that opens the v2 database as plaintext.
class EncryptedDatabase {
  const EncryptedDatabase._();

  static const databaseFileName = 'focus_flow_v2.sqlite';
  static const legacyDatabaseFileName = 'focus_flow.sqlite';
  static const pendingRestoreFileName = 'focus_flow_v2.restore';
  static const _cipherName = 'sqlcipher';

  static Future<AppDatabase> open(
    String key, {
    Directory? applicationDirectory,
    Directory? legacyApplicationDirectory,
  }) async {
    if (key.length < 32) {
      throw ArgumentError.value(
        key.length,
        'key',
        'The database key must contain at least 32 characters.',
      );
    }

    final directory =
        applicationDirectory ?? await getApplicationDocumentsDirectory();
    await directory.create(recursive: true);
    final legacyDirectory = legacyApplicationDirectory ?? directory;
    final legacy = File(p.join(legacyDirectory.path, legacyDatabaseFileName));
    final encrypted = File(p.join(directory.path, databaseFileName));
    final pendingRestore = File(p.join(directory.path, pendingRestoreFileName));

    if (await pendingRestore.exists()) {
      await _applyPendingRestore(pendingRestore, encrypted, key);
    }

    if (!await encrypted.exists() && await legacy.exists()) {
      await _encryptLegacyDatabase(legacy, encrypted, key);
    }

    final executor = NativeDatabase.createInBackground(
      encrypted,
      setup: (database) {
        _applyKey(database, key);
        database.execute('PRAGMA foreign_keys = ON;');
        database.execute('PRAGMA secure_delete = ON;');
        database.execute('PRAGMA memory_security = ON;');
        _verifyReadable(database);
      },
    );
    final database = AppDatabase(executor);
    try {
      // Force the background connection to open so key/cipher errors are
      // reported before an AppDatabase is handed to the application.
      await database.customSelect('SELECT count(*) FROM sqlite_master').get();
    } on Object {
      await database.close();
      rethrow;
    }

    // A crash between the atomic rename and plaintext cleanup is harmless.
    // Once the encrypted database has been reopened and verified, finish the
    // cleanup on the next launch.
    if (await legacy.exists()) await _deleteDatabaseAndSidecars(legacy);
    return database;
  }

  static Future<void> _applyPendingRestore(
    File pendingRestore,
    File encrypted,
    String key,
  ) async {
    final verification = sqlite3.open(pendingRestore.path);
    try {
      _applyKey(verification, key);
      _verifyReadable(verification);
    } finally {
      verification.close();
    }

    final rollback = File('${encrypted.path}.before-restore');
    await _deleteDatabaseAndSidecars(rollback);
    await _deleteDatabaseSidecars(encrypted);
    if (await encrypted.exists()) await encrypted.rename(rollback.path);
    try {
      await pendingRestore.rename(encrypted.path);
      final restored = sqlite3.open(encrypted.path);
      try {
        _applyKey(restored, key);
        _verifyReadable(restored);
      } finally {
        restored.close();
      }
      await _deleteDatabaseAndSidecars(rollback);
    } on Object {
      if (await encrypted.exists()) await _deleteDatabaseAndSidecars(encrypted);
      if (await rollback.exists()) await rollback.rename(encrypted.path);
      rethrow;
    }
  }

  static Future<void> _encryptLegacyDatabase(
    File legacy,
    File encrypted,
    String key,
  ) async {
    final temporary = File('${encrypted.path}.partial');
    await _deleteDatabaseAndSidecars(temporary);

    final source = sqlite3.open(legacy.path);
    late final Map<String, int> sourceCounts;
    try {
      _verifyReadable(source);
      source.execute('PRAGMA wal_checkpoint(TRUNCATE);');
      source.execute('PRAGMA journal_mode = DELETE;');
      sourceCounts = _tableCounts(source);
      source.execute("VACUUM INTO '${_escapeSql(temporary.path)}';");
    } finally {
      source.close();
    }

    final target = sqlite3.open(temporary.path);
    try {
      _selectCipher(target);
      final result = target.select("PRAGMA rekey = '${_escapeSql(key)}';");
      if (!_pragmaSucceeded(result)) {
        throw StateError(
          'The sqlite3mc encryption runtime rejected the database key.',
        );
      }
    } finally {
      target.close();
    }

    // Reopen with the key. This proves the file is encrypted with the expected
    // scheme rather than merely trusting PRAGMA rekey's return value.
    final verification = sqlite3.open(temporary.path);
    try {
      _applyKey(verification, key);
      _verifyReadable(verification);
      final targetCounts = _tableCounts(verification);
      if (!_sameCounts(sourceCounts, targetCounts)) {
        throw StateError(
          'Encrypted database verification found an incomplete data copy.',
        );
      }
    } finally {
      verification.close();
    }

    await temporary.rename(encrypted.path);
    await _deleteDatabaseAndSidecars(legacy);
  }

  static void _applyKey(Database database, String key) {
    _selectCipher(database);
    final result = database.select("PRAGMA key = '${_escapeSql(key)}';");
    if (!_pragmaSucceeded(result)) {
      throw StateError(
        'The sqlite3mc encryption runtime is unavailable. Focus Flow will not '
        'open a plaintext activity database.',
      );
    }
  }

  static void _selectCipher(Database database) {
    final result = database.select("PRAGMA cipher = '$_cipherName';");
    if (result.isEmpty || result.first.values.first != _cipherName) {
      throw StateError(
        'The SQLCipher-compatible sqlite3mc cipher is unavailable.',
      );
    }
  }

  static void _verifyReadable(Database database) {
    database.select('SELECT count(*) FROM sqlite_master;');
    final integrity = database.select('PRAGMA integrity_check;');
    if (integrity.isEmpty || integrity.first.values.first != 'ok') {
      throw StateError('Database integrity verification failed.');
    }
  }

  static Map<String, int> _tableCounts(Database database) {
    final tables = database.select(
      "SELECT name FROM sqlite_master WHERE type = 'table' "
      "AND name NOT LIKE 'sqlite_%' ORDER BY name",
    );
    return {
      for (final row in tables)
        row['name'] as String:
            (database
                    .select(
                      'SELECT count(*) AS row_count FROM "${_escapeIdentifier(row['name'] as String)}"',
                    )
                    .first['row_count']
                as int),
    };
  }

  static bool _sameCounts(Map<String, int> first, Map<String, int> second) {
    if (first.length != second.length) return false;
    for (final entry in first.entries) {
      if (second[entry.key] != entry.value) return false;
    }
    return true;
  }

  static bool _pragmaSucceeded(ResultSet result) =>
      result.isNotEmpty && result.first.values.first == 'ok';

  static Future<void> _deleteDatabaseAndSidecars(File database) async {
    for (final path in [
      database.path,
      '${database.path}-wal',
      '${database.path}-shm',
      '${database.path}-journal',
    ]) {
      final file = File(path);
      if (await file.exists()) await file.delete();
    }
  }

  static Future<void> _deleteDatabaseSidecars(File database) async {
    for (final suffix in const ['-wal', '-shm', '-journal']) {
      final file = File('${database.path}$suffix');
      if (await file.exists()) await file.delete();
    }
  }

  static String _escapeSql(String value) => value.replaceAll("'", "''");

  static String _escapeIdentifier(String value) => value.replaceAll('"', '""');
}
