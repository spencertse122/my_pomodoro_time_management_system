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
    if (await temporary.exists()) await temporary.delete();
    await _copyWithNewKey(
      sourcePath: sourcePath,
      sourceKey: _databaseKey,
      destinationPath: temporary.path,
      destinationKey: passphrase,
    );
    if (await destination.exists()) await destination.delete();
    await temporary.rename(destination.path);
  }

  /// Validates a portable backup, re-encrypts it with this machine's protected
  /// key, and stages it for an atomic restore on the next app launch.
  Future<void> stageImport({
    required String sourcePath,
    required String passphrase,
  }) async {
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
    if (await temporary.exists()) await temporary.delete();
    await _copyWithNewKey(
      sourcePath: sourcePath,
      sourceKey: passphrase,
      destinationPath: temporary.path,
      destinationKey: _databaseKey,
    );
    if (await staged.exists()) await staged.delete();
    await temporary.rename(staged.path);
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
    try {
      _applyKey(source, sourceKey);
      _verify(source);
      _verifyPortableSchema(source);
      destination = sqlite3.open(destinationPath);
      _applyKey(destination, destinationKey);
      await source.backup(destination, nPage: 128).drain<void>();
      _verify(destination);
      _verifyPortableSchema(destination);
    } on Object {
      final partial = File(destinationPath);
      if (await partial.exists()) await partial.delete();
      rethrow;
    } finally {
      destination?.close();
      source.close();
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
    final tables = database
        .select("SELECT name FROM sqlite_master WHERE type = 'table';")
        .map((row) => row['name'])
        .toSet();
    if (!tables.containsAll(const {
      'session_entries',
      'timer_entries',
      'settings_entries',
    })) {
      throw StateError('The selected file is not a Focus Flow backup.');
    }
  }

  void _validatePassphrase(String passphrase) {
    if (passphrase.length < 12) {
      throw ArgumentError(
        'Use a backup passphrase with at least 12 characters.',
      );
    }
  }

  String _escape(String value) => value.replaceAll("'", "''");
}
