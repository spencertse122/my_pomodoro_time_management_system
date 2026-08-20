import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('routine production code has no Firestore write or sync service', () {
    expect(File('lib/data/sync_service.dart').existsSync(), isFalse);
    final productionSources = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'));
    final allSource = productionSources
        .map((file) => file.readAsStringSync())
        .join('\n');
    expect(allSource, isNot(contains('setDocument(')));
    expect(allSource, isNot(contains("'PATCH'")));
    expect(allSource, isNot(contains('syncUser(')));
  });

  test(
    'Firestore rules allow legacy purge but forbid new user-data writes',
    () {
      final rules = File('firestore.rules').readAsStringSync();
      expect(rules, contains('allow read, delete: if owns(userId);'));
      expect(rules, contains('allow create, update: if false;'));
      expect(rules, isNot(contains('allow create, update: if owns')));
    },
  );

  test('model binaries and partial release assets are ignored by Git', () {
    final ignore = File('.gitignore').readAsStringSync();
    expect(ignore, contains('/assets/models/*.gguf'));
    expect(ignore, contains('/assets/models/*.partial'));
    final committedModelCandidates = Directory(
      'assets/models',
    ).listSync().whereType<File>().where((file) => file.path.endsWith('.gguf'));
    expect(committedModelCandidates, isEmpty);
  });
}
