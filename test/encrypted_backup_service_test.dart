import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/data/local/encrypted_database.dart';
import 'package:my_pomodoro_time_management_system/data/session_repository.dart';
import 'package:my_pomodoro_time_management_system/domain/models.dart';
import 'package:my_pomodoro_time_management_system/services/encrypted_backup_service.dart';
import 'package:sqlite3/sqlite3.dart';

void main() {
  test(
    'exports a portable encrypted database and stages an atomic restore',
    () async {
      final sourceDirectory = await Directory.systemTemp.createTemp(
        'focus-flow-source-',
      );
      final restoreDirectory = await Directory.systemTemp.createTemp(
        'focus-flow-restore-',
      );
      addTearDown(() => sourceDirectory.delete(recursive: true));
      addTearDown(() => restoreDirectory.delete(recursive: true));
      const sourceKey = 'source-machine-key-000000000000000000000000';
      const restoreKey = 'restore-machine-key-00000000000000000000000';
      const passphrase = 'correct horse battery staple';

      final sourceDatabase = await EncryptedDatabase.open(
        sourceKey,
        applicationDirectory: sourceDirectory,
      );
      final now = DateTime.now().toUtc();
      await SessionRepository(sourceDatabase).save(
        WorkSession(
          id: 'portable-session',
          userId: 'user',
          cycleId: 'cycle',
          phase: TimerPhase.focus,
          activity: 'Private work',
          plannedSeconds: 1500,
          actualSeconds: 900,
          startedAt: now.subtract(const Duration(minutes: 15)),
          endedAt: now,
          outcome: SessionOutcome.stopped,
          updatedAt: now,
        ),
      );
      final backup = File('${sourceDirectory.path}/portable.focusflow');
      await EncryptedBackupService(
        database: sourceDatabase,
        databaseKey: sourceKey,
        applicationDirectory: sourceDirectory,
      ).exportTo(destinationPath: backup.path, passphrase: passphrase);
      expect(await backup.length(), greaterThan(0));
      await sourceDatabase.close();

      final withoutPassphrase = sqlite3.open(backup.path);
      try {
        expect(
          () => withoutPassphrase.select('SELECT * FROM session_entries'),
          throwsA(anything),
        );
      } finally {
        withoutPassphrase.close();
      }

      final restoreDatabase = await EncryptedDatabase.open(
        restoreKey,
        applicationDirectory: restoreDirectory,
      );
      final restoreService = EncryptedBackupService(
        database: restoreDatabase,
        databaseKey: restoreKey,
        applicationDirectory: restoreDirectory,
      );
      await expectLater(
        restoreService.stageImport(
          sourcePath: backup.path,
          passphrase: 'this passphrase is incorrect',
        ),
        throwsA(anything),
      );
      final incompatible = await backup.copy(
        '${sourceDirectory.path}/future.focusflow',
      );
      final futureDatabase = sqlite3.open(incompatible.path);
      try {
        futureDatabase.select("PRAGMA cipher = 'sqlcipher';");
        futureDatabase.select("PRAGMA key = '$passphrase';");
        futureDatabase.execute('PRAGMA user_version = 999;');
      } finally {
        futureDatabase.close();
      }
      await expectLater(
        restoreService.stageImport(
          sourcePath: incompatible.path,
          passphrase: passphrase,
        ),
        throwsA(anything),
      );
      await restoreService.stageImport(
        sourcePath: backup.path,
        passphrase: passphrase,
      );
      await restoreDatabase.close();

      final reopened = await EncryptedDatabase.open(
        restoreKey,
        applicationDirectory: restoreDirectory,
      );
      addTearDown(reopened.close);
      final restored = await reopened.sessionById('portable-session');
      expect(restored?.activity, 'Private work');
      expect(
        File(
          '${restoreDirectory.path}/${EncryptedDatabase.pendingRestoreFileName}',
        ).existsSync(),
        isFalse,
      );
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  test(
    'atomically converts the v1 plaintext file and removes its sidecars',
    () async {
      final legacyDirectory = await Directory.systemTemp.createTemp(
        'focus-flow-legacy-',
      );
      final supportDirectory = await Directory.systemTemp.createTemp(
        'focus-flow-support-',
      );
      addTearDown(() => legacyDirectory.delete(recursive: true));
      addTearDown(() => supportDirectory.delete(recursive: true));
      final legacyFile = File(
        '${legacyDirectory.path}/${EncryptedDatabase.legacyDatabaseFileName}',
      );
      final plaintext = AppDatabase(NativeDatabase(legacyFile));
      final now = DateTime.now().toUtc();
      await SessionRepository(plaintext).save(
        WorkSession(
          id: 'legacy-local',
          userId: 'user',
          cycleId: 'cycle',
          phase: TimerPhase.focus,
          activity: 'Existing local work',
          plannedSeconds: 1500,
          actualSeconds: 1500,
          startedAt: now.subtract(const Duration(minutes: 25)),
          endedAt: now,
          outcome: SessionOutcome.completed,
          updatedAt: now,
        ),
      );
      await plaintext.close();

      final encrypted = await EncryptedDatabase.open(
        'migration-key-0000000000000000000000000000',
        applicationDirectory: supportDirectory,
        legacyApplicationDirectory: legacyDirectory,
      );
      addTearDown(encrypted.close);

      expect(await encrypted.sessionById('legacy-local'), isNotNull);
      expect(legacyFile.existsSync(), isFalse);
      expect(File('${legacyFile.path}-wal').existsSync(), isFalse);
      final encryptedFile = File(
        '${supportDirectory.path}/${EncryptedDatabase.databaseFileName}',
      );
      final raw = sqlite3.open(encryptedFile.path);
      try {
        expect(
          () => raw.select('SELECT * FROM session_entries'),
          throwsA(anything),
        );
      } finally {
        raw.close();
      }
    },
  );
}
