import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/data/activity_repository.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/domain/models.dart';

void main() {
  late AppDatabase database;
  late ActivityRepository activities;
  late CategoryRepository categories;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    activities = ActivityRepository(database);
    categories = CategoryRepository(database);
  });

  tearDown(() => database.close());

  test(
    'default and custom category definitions stay local and editable',
    () async {
      await categories.ensureDefaults('user');
      expect(
        (await categories.get('user')).map((category) => category.name),
        containsAll([
          'Learning',
          'Work',
          'Miscellaneous',
          'Time Wasted',
          'Casual Browsing',
        ]),
      );

      await categories.create(
        userId: 'user',
        name: 'Creative work',
        description: 'Design and writing.',
        colorValue: 0xff123456,
      );
      final custom = (await categories.get(
        'user',
      )).singleWhere((category) => category.name == 'Creative work');
      await categories.save(custom.copyWith(name: 'Making'));

      expect(
        (await categories.get('user')).map((category) => category.name),
        contains('Making'),
      );
    },
  );

  test(
    'manual app rule classifies later samples without a screenshot',
    () async {
      await categories.ensureDefaults('user');
      final work = (await categories.get(
        'user',
      )).singleWhere((category) => category.name == 'Work');
      final now = DateTime(2026, 8, 20, 12).toUtc();
      final first = _sample('first', now);
      await activities.saveSample(first);
      await activities.setCategory(first, work.id, alwaysForApp: true);

      final ruled = await activities.saveSample(
        _sample('second', now.add(const Duration(minutes: 5))),
      );

      expect(ruled.categoryId, work.id);
      expect(ruled.categorySource, ActivityCategorySource.rule);
      expect(ruled.processingState, ActivityProcessingState.complete);
    },
  );
}

ActivitySample _sample(String id, DateTime end) => ActivitySample(
  id: id,
  userId: 'user',
  capturedAt: end,
  startedAt: end.subtract(const Duration(minutes: 5)),
  endedAt: end,
  appId: 'com.example.editor',
  appName: 'Editor',
  windowTitle: 'Private project',
  processingState: ActivityProcessingState.pending,
  updatedAt: end,
);
