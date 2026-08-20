import 'dart:async';

import 'package:uuid/uuid.dart';

import '../domain/models.dart';
import 'local/app_database.dart';

class ActivityRepository {
  ActivityRepository(this._database, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final AppDatabase _database;
  final Uuid _uuid;

  Stream<List<ActivityBlock>> watchDay(String userId, DateTime localDay) {
    final (start, end) = _dayBounds(localDay);
    return _database.watchActivityBlocks(userId, start, end);
  }

  Stream<List<ActivitySample>> watchSamples(String userId, DateTime localDay) {
    final (start, end) = _dayBounds(localDay);
    return _database.watchActivitySamples(userId, start, end);
  }

  Future<ActivitySample> saveSample(ActivitySample sample) async {
    final ruled = await _applyRule(sample);
    await _database.upsertActivitySample(ruled);
    await rebuildDay(sample.userId, sample.startedAt.toLocal());
    return ruled;
  }

  Future<void> saveClassification(
    ActivitySample sample, {
    required String activityLabel,
    required String? categoryId,
    required double confidence,
    required List<String> secondaryContext,
    required String modelVersion,
    required String promptVersion,
  }) async {
    await _database.upsertActivitySample(
      sample.copyWith(
        activityLabel: activityLabel.trim().isEmpty
            ? sample.appName
            : activityLabel.trim(),
        categoryId: categoryId,
        categorySource: ActivityCategorySource.ai,
        confidence: confidence.clamp(0, 1).toDouble(),
        secondaryContext: secondaryContext.take(4).toList(),
        processingState: ActivityProcessingState.complete,
        modelVersion: modelVersion,
        promptVersion: promptVersion,
        clearFailure: true,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    await rebuildDay(sample.userId, sample.startedAt.toLocal());
  }

  Future<void> markMetadataOnly(
    ActivitySample sample,
    String failureCode,
  ) async {
    await _database.upsertActivitySample(
      sample.copyWith(
        activityLabel: sample.appName,
        categorySource: ActivityCategorySource.fallback,
        confidence: 0,
        processingState: ActivityProcessingState.metadataOnly,
        failureCode: failureCode,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    await rebuildDay(sample.userId, sample.startedAt.toLocal());
  }

  Future<void> markClassificationFailed(
    ActivitySample sample,
    String failureCode,
  ) async {
    await _database.upsertActivitySample(
      sample.copyWith(
        activityLabel: sample.appName,
        categorySource: ActivityCategorySource.fallback,
        confidence: 0,
        processingState: ActivityProcessingState.failed,
        failureCode: failureCode,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    await rebuildDay(sample.userId, sample.startedAt.toLocal());
  }

  Future<void> setCategory(
    ActivitySample sample,
    String categoryId, {
    bool alwaysForApp = false,
  }) async {
    await _database.upsertActivitySample(
      sample.copyWith(
        categoryId: categoryId,
        categorySource: ActivityCategorySource.manual,
        confidence: 1,
        processingState: ActivityProcessingState.complete,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
    if (alwaysForApp) {
      await _database.upsertCategoryRule(
        CategoryRule(
          id: _uuid.v5(Namespace.url.value, '${sample.userId}:${sample.appId}'),
          userId: sample.userId,
          appId: sample.appId,
          categoryId: categoryId,
          updatedAt: DateTime.now().toUtc(),
        ),
      );
    }
    await rebuildDay(sample.userId, sample.startedAt.toLocal());
  }

  Future<void> setBlockCategory(
    ActivityBlock block,
    String categoryId, {
    bool alwaysForApp = false,
  }) async {
    final (start, end) = _dayBounds(block.startedAt.toLocal());
    final samples = await _database.activitySamples(block.userId, start, end);
    final matching = samples.where(
      (sample) =>
          sample.appId == block.appId &&
          !sample.endedAt.isBefore(block.startedAt) &&
          !sample.startedAt.isAfter(block.endedAt),
    );
    for (final sample in matching) {
      await _database.upsertActivitySample(
        sample.copyWith(
          categoryId: categoryId,
          categorySource: ActivityCategorySource.manual,
          confidence: 1,
          processingState: ActivityProcessingState.complete,
          updatedAt: DateTime.now().toUtc(),
        ),
      );
    }
    if (alwaysForApp) {
      await _database.upsertCategoryRule(
        CategoryRule(
          id: _uuid.v5(Namespace.url.value, '${block.userId}:${block.appId}'),
          userId: block.userId,
          appId: block.appId,
          categoryId: categoryId,
          updatedAt: DateTime.now().toUtc(),
        ),
      );
    }
    await rebuildDay(block.userId, block.startedAt.toLocal());
  }

  Future<void> rebuildDay(String userId, DateTime localDay) async {
    final (start, end) = _dayBounds(localDay);
    final samples = await _database.activitySamples(userId, start, end);
    final blocks = _aggregate(samples);
    await _database.replaceActivityBlocks(userId, start, end, blocks);
  }

  Future<ActivitySample> _applyRule(ActivitySample sample) async {
    if (sample.categorySource == ActivityCategorySource.manual) return sample;
    final rules = await _database.categoryRules(sample.userId);
    for (final rule in rules) {
      if (rule.matches(sample.appId, sample.windowTitle)) {
        return sample.copyWith(
          categoryId: rule.categoryId,
          categorySource: ActivityCategorySource.rule,
          confidence: 1,
          processingState: ActivityProcessingState.complete,
          updatedAt: DateTime.now().toUtc(),
        );
      }
    }
    return sample;
  }

  List<ActivityBlock> _aggregate(List<ActivitySample> samples) {
    if (samples.isEmpty) return const [];
    final sorted = [...samples]
      ..sort((a, b) => a.startedAt.compareTo(b.startedAt));
    final blocks = <ActivityBlock>[];
    var group = <ActivitySample>[sorted.first];

    void flush() {
      final first = group.first;
      final last = group.last;
      final labels = group
          .map((sample) => sample.activityLabel?.trim())
          .whereType<String>()
          .where((label) => label.isNotEmpty)
          .toList();
      final confidence =
          group
              .map((sample) => sample.confidence ?? 0)
              .fold<double>(0, (sum, value) => sum + value) /
          group.length;
      final context = <String>{
        for (final sample in group) ...sample.secondaryContext,
      }.take(4).toList();
      blocks.add(
        ActivityBlock(
          id: _uuid.v5(
            Namespace.url.value,
            '${first.userId}:${first.startedAt.toIso8601String()}:${first.appId}',
          ),
          userId: first.userId,
          startedAt: first.startedAt,
          endedAt: last.endedAt.isAfter(first.endedAt)
              ? last.endedAt
              : first.endedAt,
          appId: first.appId,
          appName: first.appName,
          activityLabel: labels.isEmpty ? first.appName : labels.last,
          categoryId: first.categoryId,
          source: first.categorySource ?? ActivityCategorySource.fallback,
          confidence: confidence,
          sampleCount: group.length,
          secondaryContext: context,
        ),
      );
    }

    for (final sample in sorted.skip(1)) {
      final previous = group.last;
      final gap = sample.startedAt.difference(previous.endedAt);
      final sameClassification =
          sample.appId == previous.appId &&
          sample.categoryId == previous.categoryId;
      if (sameClassification && gap <= const Duration(seconds: 30)) {
        group.add(sample);
      } else {
        flush();
        group = [sample];
      }
    }
    flush();
    return blocks;
  }

  (DateTime, DateTime) _dayBounds(DateTime localDay) {
    final start = DateTime(localDay.year, localDay.month, localDay.day);
    return (start.toUtc(), start.add(const Duration(days: 1)).toUtc());
  }
}

class CategoryRepository {
  CategoryRepository(this._database, {Uuid? uuid})
    : _uuid = uuid ?? const Uuid();

  final AppDatabase _database;
  final Uuid _uuid;

  Stream<List<ActivityCategory>> watch(String userId) =>
      _database.watchCategories(userId);

  Future<List<ActivityCategory>> get(String userId) =>
      _database.categories(userId);

  Future<void> ensureDefaults(String userId) async {
    if ((await get(userId)).isNotEmpty) return;
    const defaults = [
      (
        'learning',
        'Learning',
        'Courses, reading, research, and deliberate practice.',
        0xff3b82f6,
      ),
      ('work', 'Work', 'Focused professional or project work.', 0xff10b981),
      (
        'miscellaneous',
        'Miscellaneous',
        'Useful activity that does not fit another category.',
        0xff8b5cf6,
      ),
      (
        'time-wasted',
        'Time Wasted',
        'Activity the user considers an unhelpful distraction.',
        0xffef4444,
      ),
      (
        'casual-browsing',
        'Casual Browsing',
        'Low-intensity browsing and entertainment.',
        0xfff59e0b,
      ),
    ];
    for (var index = 0; index < defaults.length; index++) {
      final value = defaults[index];
      await _database.upsertCategory(
        ActivityCategory(
          id: 'default-${value.$1}-$userId',
          userId: userId,
          name: value.$2,
          description: value.$3,
          colorValue: value.$4,
          sortOrder: index,
          isSystem: true,
        ),
      );
    }
  }

  Future<void> save(ActivityCategory category) async {
    final name = category.name.trim();
    final description = category.description.trim();
    if (name.isEmpty || description.isEmpty) {
      throw ArgumentError('Category name and description are required.');
    }
    if (name.length > 60 || description.length > 240) {
      throw ArgumentError(
        'Category names must be at most 60 characters and descriptions at most 240.',
      );
    }
    final existing = await get(category.userId);
    final duplicate = existing.any(
      (value) =>
          value.id != category.id &&
          value.name.toLowerCase() == name.toLowerCase(),
    );
    if (duplicate) throw ArgumentError('Category names must be unique.');
    if (category.isArchived &&
        existing.where((value) => !value.isArchived).length <= 1) {
      throw ArgumentError('Keep at least one active category.');
    }
    await _database.upsertCategory(
      category.copyWith(name: name, description: description),
    );
  }

  Future<void> create({
    required String userId,
    required String name,
    required String description,
    required int colorValue,
  }) async {
    final existing = await get(userId);
    await save(
      ActivityCategory(
        id: _uuid.v4(),
        userId: userId,
        name: name,
        description: description,
        colorValue: colorValue,
        sortOrder: existing.length,
      ),
    );
  }
}

class TrackingSettingsRepository {
  TrackingSettingsRepository(this._database);

  final AppDatabase _database;

  Stream<TrackingSettings> watch(String userId) =>
      _database.watchTrackingSettings(userId);

  Future<TrackingSettings> get(String userId) =>
      _database.trackingSettings(userId);

  Future<void> save(String userId, TrackingSettings settings) =>
      _database.saveTrackingSettings(userId, settings);
}

class InsightRepository {
  InsightRepository(this._database);

  final AppDatabase _database;

  Future<DailyInsight?> get(String userId, DateTime day) =>
      _database.dailyInsight(userId, day);

  Future<void> save(DailyInsight insight) =>
      _database.saveDailyInsight(insight);
}
