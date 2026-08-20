// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SessionEntriesTable extends SessionEntries
    with TableInfo<$SessionEntriesTable, SessionEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cycleIdMeta = const VerificationMeta(
    'cycleId',
  );
  @override
  late final GeneratedColumn<String> cycleId = GeneratedColumn<String>(
    'cycle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phaseMeta = const VerificationMeta('phase');
  @override
  late final GeneratedColumn<String> phase = GeneratedColumn<String>(
    'phase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityMeta = const VerificationMeta(
    'activity',
  );
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
    'activity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedSecondsMeta = const VerificationMeta(
    'plannedSeconds',
  );
  @override
  late final GeneratedColumn<int> plannedSeconds = GeneratedColumn<int>(
    'planned_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualSecondsMeta = const VerificationMeta(
    'actualSeconds',
  );
  @override
  late final GeneratedColumn<int> actualSeconds = GeneratedColumn<int>(
    'actual_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isDirtyMeta = const VerificationMeta(
    'isDirty',
  );
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
    'is_dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categorySourceMeta = const VerificationMeta(
    'categorySource',
  );
  @override
  late final GeneratedColumn<String> categorySource = GeneratedColumn<String>(
    'category_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryConfidenceMeta =
      const VerificationMeta('categoryConfidence');
  @override
  late final GeneratedColumn<double> categoryConfidence =
      GeneratedColumn<double>(
        'category_confidence',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _alignmentMeta = const VerificationMeta(
    'alignment',
  );
  @override
  late final GeneratedColumn<String> alignment = GeneratedColumn<String>(
    'alignment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unverified'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    cycleId,
    phase,
    activity,
    plannedSeconds,
    actualSeconds,
    startedAt,
    endedAt,
    outcome,
    updatedAt,
    isDeleted,
    isDirty,
    categoryId,
    categorySource,
    categoryConfidence,
    alignment,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('cycle_id')) {
      context.handle(
        _cycleIdMeta,
        cycleId.isAcceptableOrUnknown(data['cycle_id']!, _cycleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cycleIdMeta);
    }
    if (data.containsKey('phase')) {
      context.handle(
        _phaseMeta,
        phase.isAcceptableOrUnknown(data['phase']!, _phaseMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseMeta);
    }
    if (data.containsKey('activity')) {
      context.handle(
        _activityMeta,
        activity.isAcceptableOrUnknown(data['activity']!, _activityMeta),
      );
    } else if (isInserting) {
      context.missing(_activityMeta);
    }
    if (data.containsKey('planned_seconds')) {
      context.handle(
        _plannedSecondsMeta,
        plannedSeconds.isAcceptableOrUnknown(
          data['planned_seconds']!,
          _plannedSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedSecondsMeta);
    }
    if (data.containsKey('actual_seconds')) {
      context.handle(
        _actualSecondsMeta,
        actualSeconds.isAcceptableOrUnknown(
          data['actual_seconds']!,
          _actualSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualSecondsMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    } else if (isInserting) {
      context.missing(_outcomeMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    }
    if (data.containsKey('is_dirty')) {
      context.handle(
        _isDirtyMeta,
        isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('category_source')) {
      context.handle(
        _categorySourceMeta,
        categorySource.isAcceptableOrUnknown(
          data['category_source']!,
          _categorySourceMeta,
        ),
      );
    }
    if (data.containsKey('category_confidence')) {
      context.handle(
        _categoryConfidenceMeta,
        categoryConfidence.isAcceptableOrUnknown(
          data['category_confidence']!,
          _categoryConfidenceMeta,
        ),
      );
    }
    if (data.containsKey('alignment')) {
      context.handle(
        _alignmentMeta,
        alignment.isAcceptableOrUnknown(data['alignment']!, _alignmentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      cycleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cycle_id'],
      )!,
      phase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phase'],
      )!,
      activity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity'],
      )!,
      plannedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_seconds'],
      )!,
      actualSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}actual_seconds'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
      isDirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dirty'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      categorySource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_source'],
      ),
      categoryConfidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}category_confidence'],
      ),
      alignment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alignment'],
      )!,
    );
  }

  @override
  $SessionEntriesTable createAlias(String alias) {
    return $SessionEntriesTable(attachedDatabase, alias);
  }
}

class SessionEntry extends DataClass implements Insertable<SessionEntry> {
  final String id;
  final String userId;
  final String cycleId;
  final String phase;
  final String activity;
  final int plannedSeconds;
  final int actualSeconds;
  final DateTime startedAt;
  final DateTime endedAt;
  final String outcome;
  final DateTime updatedAt;
  final bool isDeleted;
  final bool isDirty;
  final String? categoryId;
  final String? categorySource;
  final double? categoryConfidence;
  final String alignment;
  const SessionEntry({
    required this.id,
    required this.userId,
    required this.cycleId,
    required this.phase,
    required this.activity,
    required this.plannedSeconds,
    required this.actualSeconds,
    required this.startedAt,
    required this.endedAt,
    required this.outcome,
    required this.updatedAt,
    required this.isDeleted,
    required this.isDirty,
    this.categoryId,
    this.categorySource,
    this.categoryConfidence,
    required this.alignment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['cycle_id'] = Variable<String>(cycleId);
    map['phase'] = Variable<String>(phase);
    map['activity'] = Variable<String>(activity);
    map['planned_seconds'] = Variable<int>(plannedSeconds);
    map['actual_seconds'] = Variable<int>(actualSeconds);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['outcome'] = Variable<String>(outcome);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || categorySource != null) {
      map['category_source'] = Variable<String>(categorySource);
    }
    if (!nullToAbsent || categoryConfidence != null) {
      map['category_confidence'] = Variable<double>(categoryConfidence);
    }
    map['alignment'] = Variable<String>(alignment);
    return map;
  }

  SessionEntriesCompanion toCompanion(bool nullToAbsent) {
    return SessionEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      cycleId: Value(cycleId),
      phase: Value(phase),
      activity: Value(activity),
      plannedSeconds: Value(plannedSeconds),
      actualSeconds: Value(actualSeconds),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      outcome: Value(outcome),
      updatedAt: Value(updatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      categorySource: categorySource == null && nullToAbsent
          ? const Value.absent()
          : Value(categorySource),
      categoryConfidence: categoryConfidence == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryConfidence),
      alignment: Value(alignment),
    );
  }

  factory SessionEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      cycleId: serializer.fromJson<String>(json['cycleId']),
      phase: serializer.fromJson<String>(json['phase']),
      activity: serializer.fromJson<String>(json['activity']),
      plannedSeconds: serializer.fromJson<int>(json['plannedSeconds']),
      actualSeconds: serializer.fromJson<int>(json['actualSeconds']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
      outcome: serializer.fromJson<String>(json['outcome']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      categorySource: serializer.fromJson<String?>(json['categorySource']),
      categoryConfidence: serializer.fromJson<double?>(
        json['categoryConfidence'],
      ),
      alignment: serializer.fromJson<String>(json['alignment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'cycleId': serializer.toJson<String>(cycleId),
      'phase': serializer.toJson<String>(phase),
      'activity': serializer.toJson<String>(activity),
      'plannedSeconds': serializer.toJson<int>(plannedSeconds),
      'actualSeconds': serializer.toJson<int>(actualSeconds),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
      'outcome': serializer.toJson<String>(outcome),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
      'categoryId': serializer.toJson<String?>(categoryId),
      'categorySource': serializer.toJson<String?>(categorySource),
      'categoryConfidence': serializer.toJson<double?>(categoryConfidence),
      'alignment': serializer.toJson<String>(alignment),
    };
  }

  SessionEntry copyWith({
    String? id,
    String? userId,
    String? cycleId,
    String? phase,
    String? activity,
    int? plannedSeconds,
    int? actualSeconds,
    DateTime? startedAt,
    DateTime? endedAt,
    String? outcome,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? isDirty,
    Value<String?> categoryId = const Value.absent(),
    Value<String?> categorySource = const Value.absent(),
    Value<double?> categoryConfidence = const Value.absent(),
    String? alignment,
  }) => SessionEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    cycleId: cycleId ?? this.cycleId,
    phase: phase ?? this.phase,
    activity: activity ?? this.activity,
    plannedSeconds: plannedSeconds ?? this.plannedSeconds,
    actualSeconds: actualSeconds ?? this.actualSeconds,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    outcome: outcome ?? this.outcome,
    updatedAt: updatedAt ?? this.updatedAt,
    isDeleted: isDeleted ?? this.isDeleted,
    isDirty: isDirty ?? this.isDirty,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    categorySource: categorySource.present
        ? categorySource.value
        : this.categorySource,
    categoryConfidence: categoryConfidence.present
        ? categoryConfidence.value
        : this.categoryConfidence,
    alignment: alignment ?? this.alignment,
  );
  SessionEntry copyWithCompanion(SessionEntriesCompanion data) {
    return SessionEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      cycleId: data.cycleId.present ? data.cycleId.value : this.cycleId,
      phase: data.phase.present ? data.phase.value : this.phase,
      activity: data.activity.present ? data.activity.value : this.activity,
      plannedSeconds: data.plannedSeconds.present
          ? data.plannedSeconds.value
          : this.plannedSeconds,
      actualSeconds: data.actualSeconds.present
          ? data.actualSeconds.value
          : this.actualSeconds,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      categorySource: data.categorySource.present
          ? data.categorySource.value
          : this.categorySource,
      categoryConfidence: data.categoryConfidence.present
          ? data.categoryConfidence.value
          : this.categoryConfidence,
      alignment: data.alignment.present ? data.alignment.value : this.alignment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('cycleId: $cycleId, ')
          ..write('phase: $phase, ')
          ..write('activity: $activity, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('actualSeconds: $actualSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('outcome: $outcome, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('categoryId: $categoryId, ')
          ..write('categorySource: $categorySource, ')
          ..write('categoryConfidence: $categoryConfidence, ')
          ..write('alignment: $alignment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    cycleId,
    phase,
    activity,
    plannedSeconds,
    actualSeconds,
    startedAt,
    endedAt,
    outcome,
    updatedAt,
    isDeleted,
    isDirty,
    categoryId,
    categorySource,
    categoryConfidence,
    alignment,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.cycleId == this.cycleId &&
          other.phase == this.phase &&
          other.activity == this.activity &&
          other.plannedSeconds == this.plannedSeconds &&
          other.actualSeconds == this.actualSeconds &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.outcome == this.outcome &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty &&
          other.categoryId == this.categoryId &&
          other.categorySource == this.categorySource &&
          other.categoryConfidence == this.categoryConfidence &&
          other.alignment == this.alignment);
}

class SessionEntriesCompanion extends UpdateCompanion<SessionEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> cycleId;
  final Value<String> phase;
  final Value<String> activity;
  final Value<int> plannedSeconds;
  final Value<int> actualSeconds;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<String> outcome;
  final Value<DateTime> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<String?> categoryId;
  final Value<String?> categorySource;
  final Value<double?> categoryConfidence;
  final Value<String> alignment;
  final Value<int> rowid;
  const SessionEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.cycleId = const Value.absent(),
    this.phase = const Value.absent(),
    this.activity = const Value.absent(),
    this.plannedSeconds = const Value.absent(),
    this.actualSeconds = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.outcome = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categorySource = const Value.absent(),
    this.categoryConfidence = const Value.absent(),
    this.alignment = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionEntriesCompanion.insert({
    required String id,
    required String userId,
    required String cycleId,
    required String phase,
    required String activity,
    required int plannedSeconds,
    required int actualSeconds,
    required DateTime startedAt,
    required DateTime endedAt,
    required String outcome,
    required DateTime updatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categorySource = const Value.absent(),
    this.categoryConfidence = const Value.absent(),
    this.alignment = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       cycleId = Value(cycleId),
       phase = Value(phase),
       activity = Value(activity),
       plannedSeconds = Value(plannedSeconds),
       actualSeconds = Value(actualSeconds),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       outcome = Value(outcome),
       updatedAt = Value(updatedAt);
  static Insertable<SessionEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? cycleId,
    Expression<String>? phase,
    Expression<String>? activity,
    Expression<int>? plannedSeconds,
    Expression<int>? actualSeconds,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? outcome,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<String>? categoryId,
    Expression<String>? categorySource,
    Expression<double>? categoryConfidence,
    Expression<String>? alignment,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (cycleId != null) 'cycle_id': cycleId,
      if (phase != null) 'phase': phase,
      if (activity != null) 'activity': activity,
      if (plannedSeconds != null) 'planned_seconds': plannedSeconds,
      if (actualSeconds != null) 'actual_seconds': actualSeconds,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (outcome != null) 'outcome': outcome,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (categoryId != null) 'category_id': categoryId,
      if (categorySource != null) 'category_source': categorySource,
      if (categoryConfidence != null) 'category_confidence': categoryConfidence,
      if (alignment != null) 'alignment': alignment,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? cycleId,
    Value<String>? phase,
    Value<String>? activity,
    Value<int>? plannedSeconds,
    Value<int>? actualSeconds,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<String>? outcome,
    Value<DateTime>? updatedAt,
    Value<bool>? isDeleted,
    Value<bool>? isDirty,
    Value<String?>? categoryId,
    Value<String?>? categorySource,
    Value<double?>? categoryConfidence,
    Value<String>? alignment,
    Value<int>? rowid,
  }) {
    return SessionEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      cycleId: cycleId ?? this.cycleId,
      phase: phase ?? this.phase,
      activity: activity ?? this.activity,
      plannedSeconds: plannedSeconds ?? this.plannedSeconds,
      actualSeconds: actualSeconds ?? this.actualSeconds,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      outcome: outcome ?? this.outcome,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      categoryId: categoryId ?? this.categoryId,
      categorySource: categorySource ?? this.categorySource,
      categoryConfidence: categoryConfidence ?? this.categoryConfidence,
      alignment: alignment ?? this.alignment,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (cycleId.present) {
      map['cycle_id'] = Variable<String>(cycleId.value);
    }
    if (phase.present) {
      map['phase'] = Variable<String>(phase.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (plannedSeconds.present) {
      map['planned_seconds'] = Variable<int>(plannedSeconds.value);
    }
    if (actualSeconds.present) {
      map['actual_seconds'] = Variable<int>(actualSeconds.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (categorySource.present) {
      map['category_source'] = Variable<String>(categorySource.value);
    }
    if (categoryConfidence.present) {
      map['category_confidence'] = Variable<double>(categoryConfidence.value);
    }
    if (alignment.present) {
      map['alignment'] = Variable<String>(alignment.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('cycleId: $cycleId, ')
          ..write('phase: $phase, ')
          ..write('activity: $activity, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('actualSeconds: $actualSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('outcome: $outcome, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('categoryId: $categoryId, ')
          ..write('categorySource: $categorySource, ')
          ..write('categoryConfidence: $categoryConfidence, ')
          ..write('alignment: $alignment, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimerEntriesTable extends TimerEntries
    with TableInfo<$TimerEntriesTable, TimerEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phaseMeta = const VerificationMeta('phase');
  @override
  late final GeneratedColumn<String> phase = GeneratedColumn<String>(
    'phase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityMeta = const VerificationMeta(
    'activity',
  );
  @override
  late final GeneratedColumn<String> activity = GeneratedColumn<String>(
    'activity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cycleIdMeta = const VerificationMeta(
    'cycleId',
  );
  @override
  late final GeneratedColumn<String> cycleId = GeneratedColumn<String>(
    'cycle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedFocusesInCycleMeta =
      const VerificationMeta('completedFocusesInCycle');
  @override
  late final GeneratedColumn<int> completedFocusesInCycle =
      GeneratedColumn<int>(
        'completed_focuses_in_cycle',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _plannedSecondsMeta = const VerificationMeta(
    'plannedSeconds',
  );
  @override
  late final GeneratedColumn<int> plannedSeconds = GeneratedColumn<int>(
    'planned_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accumulatedSecondsMeta =
      const VerificationMeta('accumulatedSeconds');
  @override
  late final GeneratedColumn<int> accumulatedSeconds = GeneratedColumn<int>(
    'accumulated_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    state,
    phase,
    activity,
    cycleId,
    completedFocusesInCycle,
    plannedSeconds,
    accumulatedSeconds,
    startedAt,
    deadline,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'timer_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimerEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('phase')) {
      context.handle(
        _phaseMeta,
        phase.isAcceptableOrUnknown(data['phase']!, _phaseMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseMeta);
    }
    if (data.containsKey('activity')) {
      context.handle(
        _activityMeta,
        activity.isAcceptableOrUnknown(data['activity']!, _activityMeta),
      );
    } else if (isInserting) {
      context.missing(_activityMeta);
    }
    if (data.containsKey('cycle_id')) {
      context.handle(
        _cycleIdMeta,
        cycleId.isAcceptableOrUnknown(data['cycle_id']!, _cycleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cycleIdMeta);
    }
    if (data.containsKey('completed_focuses_in_cycle')) {
      context.handle(
        _completedFocusesInCycleMeta,
        completedFocusesInCycle.isAcceptableOrUnknown(
          data['completed_focuses_in_cycle']!,
          _completedFocusesInCycleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedFocusesInCycleMeta);
    }
    if (data.containsKey('planned_seconds')) {
      context.handle(
        _plannedSecondsMeta,
        plannedSeconds.isAcceptableOrUnknown(
          data['planned_seconds']!,
          _plannedSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannedSecondsMeta);
    }
    if (data.containsKey('accumulated_seconds')) {
      context.handle(
        _accumulatedSecondsMeta,
        accumulatedSeconds.isAcceptableOrUnknown(
          data['accumulated_seconds']!,
          _accumulatedSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accumulatedSecondsMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  TimerEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimerEntry(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      phase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phase'],
      )!,
      activity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity'],
      )!,
      cycleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cycle_id'],
      )!,
      completedFocusesInCycle: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_focuses_in_cycle'],
      )!,
      plannedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}planned_seconds'],
      )!,
      accumulatedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accumulated_seconds'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TimerEntriesTable createAlias(String alias) {
    return $TimerEntriesTable(attachedDatabase, alias);
  }
}

class TimerEntry extends DataClass implements Insertable<TimerEntry> {
  final String userId;
  final String state;
  final String phase;
  final String activity;
  final String cycleId;
  final int completedFocusesInCycle;
  final int plannedSeconds;
  final int accumulatedSeconds;
  final DateTime? startedAt;
  final DateTime? deadline;
  final DateTime updatedAt;
  const TimerEntry({
    required this.userId,
    required this.state,
    required this.phase,
    required this.activity,
    required this.cycleId,
    required this.completedFocusesInCycle,
    required this.plannedSeconds,
    required this.accumulatedSeconds,
    this.startedAt,
    this.deadline,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['state'] = Variable<String>(state);
    map['phase'] = Variable<String>(phase);
    map['activity'] = Variable<String>(activity);
    map['cycle_id'] = Variable<String>(cycleId);
    map['completed_focuses_in_cycle'] = Variable<int>(completedFocusesInCycle);
    map['planned_seconds'] = Variable<int>(plannedSeconds);
    map['accumulated_seconds'] = Variable<int>(accumulatedSeconds);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TimerEntriesCompanion toCompanion(bool nullToAbsent) {
    return TimerEntriesCompanion(
      userId: Value(userId),
      state: Value(state),
      phase: Value(phase),
      activity: Value(activity),
      cycleId: Value(cycleId),
      completedFocusesInCycle: Value(completedFocusesInCycle),
      plannedSeconds: Value(plannedSeconds),
      accumulatedSeconds: Value(accumulatedSeconds),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      updatedAt: Value(updatedAt),
    );
  }

  factory TimerEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimerEntry(
      userId: serializer.fromJson<String>(json['userId']),
      state: serializer.fromJson<String>(json['state']),
      phase: serializer.fromJson<String>(json['phase']),
      activity: serializer.fromJson<String>(json['activity']),
      cycleId: serializer.fromJson<String>(json['cycleId']),
      completedFocusesInCycle: serializer.fromJson<int>(
        json['completedFocusesInCycle'],
      ),
      plannedSeconds: serializer.fromJson<int>(json['plannedSeconds']),
      accumulatedSeconds: serializer.fromJson<int>(json['accumulatedSeconds']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'state': serializer.toJson<String>(state),
      'phase': serializer.toJson<String>(phase),
      'activity': serializer.toJson<String>(activity),
      'cycleId': serializer.toJson<String>(cycleId),
      'completedFocusesInCycle': serializer.toJson<int>(
        completedFocusesInCycle,
      ),
      'plannedSeconds': serializer.toJson<int>(plannedSeconds),
      'accumulatedSeconds': serializer.toJson<int>(accumulatedSeconds),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TimerEntry copyWith({
    String? userId,
    String? state,
    String? phase,
    String? activity,
    String? cycleId,
    int? completedFocusesInCycle,
    int? plannedSeconds,
    int? accumulatedSeconds,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> deadline = const Value.absent(),
    DateTime? updatedAt,
  }) => TimerEntry(
    userId: userId ?? this.userId,
    state: state ?? this.state,
    phase: phase ?? this.phase,
    activity: activity ?? this.activity,
    cycleId: cycleId ?? this.cycleId,
    completedFocusesInCycle:
        completedFocusesInCycle ?? this.completedFocusesInCycle,
    plannedSeconds: plannedSeconds ?? this.plannedSeconds,
    accumulatedSeconds: accumulatedSeconds ?? this.accumulatedSeconds,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    deadline: deadline.present ? deadline.value : this.deadline,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TimerEntry copyWithCompanion(TimerEntriesCompanion data) {
    return TimerEntry(
      userId: data.userId.present ? data.userId.value : this.userId,
      state: data.state.present ? data.state.value : this.state,
      phase: data.phase.present ? data.phase.value : this.phase,
      activity: data.activity.present ? data.activity.value : this.activity,
      cycleId: data.cycleId.present ? data.cycleId.value : this.cycleId,
      completedFocusesInCycle: data.completedFocusesInCycle.present
          ? data.completedFocusesInCycle.value
          : this.completedFocusesInCycle,
      plannedSeconds: data.plannedSeconds.present
          ? data.plannedSeconds.value
          : this.plannedSeconds,
      accumulatedSeconds: data.accumulatedSeconds.present
          ? data.accumulatedSeconds.value
          : this.accumulatedSeconds,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimerEntry(')
          ..write('userId: $userId, ')
          ..write('state: $state, ')
          ..write('phase: $phase, ')
          ..write('activity: $activity, ')
          ..write('cycleId: $cycleId, ')
          ..write('completedFocusesInCycle: $completedFocusesInCycle, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('accumulatedSeconds: $accumulatedSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('deadline: $deadline, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    state,
    phase,
    activity,
    cycleId,
    completedFocusesInCycle,
    plannedSeconds,
    accumulatedSeconds,
    startedAt,
    deadline,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerEntry &&
          other.userId == this.userId &&
          other.state == this.state &&
          other.phase == this.phase &&
          other.activity == this.activity &&
          other.cycleId == this.cycleId &&
          other.completedFocusesInCycle == this.completedFocusesInCycle &&
          other.plannedSeconds == this.plannedSeconds &&
          other.accumulatedSeconds == this.accumulatedSeconds &&
          other.startedAt == this.startedAt &&
          other.deadline == this.deadline &&
          other.updatedAt == this.updatedAt);
}

class TimerEntriesCompanion extends UpdateCompanion<TimerEntry> {
  final Value<String> userId;
  final Value<String> state;
  final Value<String> phase;
  final Value<String> activity;
  final Value<String> cycleId;
  final Value<int> completedFocusesInCycle;
  final Value<int> plannedSeconds;
  final Value<int> accumulatedSeconds;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> deadline;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TimerEntriesCompanion({
    this.userId = const Value.absent(),
    this.state = const Value.absent(),
    this.phase = const Value.absent(),
    this.activity = const Value.absent(),
    this.cycleId = const Value.absent(),
    this.completedFocusesInCycle = const Value.absent(),
    this.plannedSeconds = const Value.absent(),
    this.accumulatedSeconds = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.deadline = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimerEntriesCompanion.insert({
    required String userId,
    required String state,
    required String phase,
    required String activity,
    required String cycleId,
    required int completedFocusesInCycle,
    required int plannedSeconds,
    required int accumulatedSeconds,
    this.startedAt = const Value.absent(),
    this.deadline = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       state = Value(state),
       phase = Value(phase),
       activity = Value(activity),
       cycleId = Value(cycleId),
       completedFocusesInCycle = Value(completedFocusesInCycle),
       plannedSeconds = Value(plannedSeconds),
       accumulatedSeconds = Value(accumulatedSeconds),
       updatedAt = Value(updatedAt);
  static Insertable<TimerEntry> custom({
    Expression<String>? userId,
    Expression<String>? state,
    Expression<String>? phase,
    Expression<String>? activity,
    Expression<String>? cycleId,
    Expression<int>? completedFocusesInCycle,
    Expression<int>? plannedSeconds,
    Expression<int>? accumulatedSeconds,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? deadline,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (state != null) 'state': state,
      if (phase != null) 'phase': phase,
      if (activity != null) 'activity': activity,
      if (cycleId != null) 'cycle_id': cycleId,
      if (completedFocusesInCycle != null)
        'completed_focuses_in_cycle': completedFocusesInCycle,
      if (plannedSeconds != null) 'planned_seconds': plannedSeconds,
      if (accumulatedSeconds != null) 'accumulated_seconds': accumulatedSeconds,
      if (startedAt != null) 'started_at': startedAt,
      if (deadline != null) 'deadline': deadline,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimerEntriesCompanion copyWith({
    Value<String>? userId,
    Value<String>? state,
    Value<String>? phase,
    Value<String>? activity,
    Value<String>? cycleId,
    Value<int>? completedFocusesInCycle,
    Value<int>? plannedSeconds,
    Value<int>? accumulatedSeconds,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? deadline,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TimerEntriesCompanion(
      userId: userId ?? this.userId,
      state: state ?? this.state,
      phase: phase ?? this.phase,
      activity: activity ?? this.activity,
      cycleId: cycleId ?? this.cycleId,
      completedFocusesInCycle:
          completedFocusesInCycle ?? this.completedFocusesInCycle,
      plannedSeconds: plannedSeconds ?? this.plannedSeconds,
      accumulatedSeconds: accumulatedSeconds ?? this.accumulatedSeconds,
      startedAt: startedAt ?? this.startedAt,
      deadline: deadline ?? this.deadline,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (phase.present) {
      map['phase'] = Variable<String>(phase.value);
    }
    if (activity.present) {
      map['activity'] = Variable<String>(activity.value);
    }
    if (cycleId.present) {
      map['cycle_id'] = Variable<String>(cycleId.value);
    }
    if (completedFocusesInCycle.present) {
      map['completed_focuses_in_cycle'] = Variable<int>(
        completedFocusesInCycle.value,
      );
    }
    if (plannedSeconds.present) {
      map['planned_seconds'] = Variable<int>(plannedSeconds.value);
    }
    if (accumulatedSeconds.present) {
      map['accumulated_seconds'] = Variable<int>(accumulatedSeconds.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimerEntriesCompanion(')
          ..write('userId: $userId, ')
          ..write('state: $state, ')
          ..write('phase: $phase, ')
          ..write('activity: $activity, ')
          ..write('cycleId: $cycleId, ')
          ..write('completedFocusesInCycle: $completedFocusesInCycle, ')
          ..write('plannedSeconds: $plannedSeconds, ')
          ..write('accumulatedSeconds: $accumulatedSeconds, ')
          ..write('startedAt: $startedAt, ')
          ..write('deadline: $deadline, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsEntriesTable extends SettingsEntries
    with TableInfo<$SettingsEntriesTable, SettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _focusMinutesMeta = const VerificationMeta(
    'focusMinutes',
  );
  @override
  late final GeneratedColumn<int> focusMinutes = GeneratedColumn<int>(
    'focus_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(25),
  );
  static const VerificationMeta _shortBreakMinutesMeta = const VerificationMeta(
    'shortBreakMinutes',
  );
  @override
  late final GeneratedColumn<int> shortBreakMinutes = GeneratedColumn<int>(
    'short_break_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _longBreakMinutesMeta = const VerificationMeta(
    'longBreakMinutes',
  );
  @override
  late final GeneratedColumn<int> longBreakMinutes = GeneratedColumn<int>(
    'long_break_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _longBreakIntervalMeta = const VerificationMeta(
    'longBreakInterval',
  );
  @override
  late final GeneratedColumn<int> longBreakInterval = GeneratedColumn<int>(
    'long_break_interval',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _soundEnabledMeta = const VerificationMeta(
    'soundEnabled',
  );
  @override
  late final GeneratedColumn<bool> soundEnabled = GeneratedColumn<bool>(
    'sound_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sound_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isDirtyMeta = const VerificationMeta(
    'isDirty',
  );
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
    'is_dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    focusMinutes,
    shortBreakMinutes,
    longBreakMinutes,
    longBreakInterval,
    soundEnabled,
    isDirty,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('focus_minutes')) {
      context.handle(
        _focusMinutesMeta,
        focusMinutes.isAcceptableOrUnknown(
          data['focus_minutes']!,
          _focusMinutesMeta,
        ),
      );
    }
    if (data.containsKey('short_break_minutes')) {
      context.handle(
        _shortBreakMinutesMeta,
        shortBreakMinutes.isAcceptableOrUnknown(
          data['short_break_minutes']!,
          _shortBreakMinutesMeta,
        ),
      );
    }
    if (data.containsKey('long_break_minutes')) {
      context.handle(
        _longBreakMinutesMeta,
        longBreakMinutes.isAcceptableOrUnknown(
          data['long_break_minutes']!,
          _longBreakMinutesMeta,
        ),
      );
    }
    if (data.containsKey('long_break_interval')) {
      context.handle(
        _longBreakIntervalMeta,
        longBreakInterval.isAcceptableOrUnknown(
          data['long_break_interval']!,
          _longBreakIntervalMeta,
        ),
      );
    }
    if (data.containsKey('sound_enabled')) {
      context.handle(
        _soundEnabledMeta,
        soundEnabled.isAcceptableOrUnknown(
          data['sound_enabled']!,
          _soundEnabledMeta,
        ),
      );
    }
    if (data.containsKey('is_dirty')) {
      context.handle(
        _isDirtyMeta,
        isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  SettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsEntry(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      focusMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}focus_minutes'],
      )!,
      shortBreakMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}short_break_minutes'],
      )!,
      longBreakMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}long_break_minutes'],
      )!,
      longBreakInterval: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}long_break_interval'],
      )!,
      soundEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sound_enabled'],
      )!,
      isDirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dirty'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SettingsEntriesTable createAlias(String alias) {
    return $SettingsEntriesTable(attachedDatabase, alias);
  }
}

class SettingsEntry extends DataClass implements Insertable<SettingsEntry> {
  final String userId;
  final int focusMinutes;
  final int shortBreakMinutes;
  final int longBreakMinutes;
  final int longBreakInterval;
  final bool soundEnabled;
  final bool isDirty;
  final DateTime updatedAt;
  const SettingsEntry({
    required this.userId,
    required this.focusMinutes,
    required this.shortBreakMinutes,
    required this.longBreakMinutes,
    required this.longBreakInterval,
    required this.soundEnabled,
    required this.isDirty,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['focus_minutes'] = Variable<int>(focusMinutes);
    map['short_break_minutes'] = Variable<int>(shortBreakMinutes);
    map['long_break_minutes'] = Variable<int>(longBreakMinutes);
    map['long_break_interval'] = Variable<int>(longBreakInterval);
    map['sound_enabled'] = Variable<bool>(soundEnabled);
    map['is_dirty'] = Variable<bool>(isDirty);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SettingsEntriesCompanion toCompanion(bool nullToAbsent) {
    return SettingsEntriesCompanion(
      userId: Value(userId),
      focusMinutes: Value(focusMinutes),
      shortBreakMinutes: Value(shortBreakMinutes),
      longBreakMinutes: Value(longBreakMinutes),
      longBreakInterval: Value(longBreakInterval),
      soundEnabled: Value(soundEnabled),
      isDirty: Value(isDirty),
      updatedAt: Value(updatedAt),
    );
  }

  factory SettingsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsEntry(
      userId: serializer.fromJson<String>(json['userId']),
      focusMinutes: serializer.fromJson<int>(json['focusMinutes']),
      shortBreakMinutes: serializer.fromJson<int>(json['shortBreakMinutes']),
      longBreakMinutes: serializer.fromJson<int>(json['longBreakMinutes']),
      longBreakInterval: serializer.fromJson<int>(json['longBreakInterval']),
      soundEnabled: serializer.fromJson<bool>(json['soundEnabled']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'focusMinutes': serializer.toJson<int>(focusMinutes),
      'shortBreakMinutes': serializer.toJson<int>(shortBreakMinutes),
      'longBreakMinutes': serializer.toJson<int>(longBreakMinutes),
      'longBreakInterval': serializer.toJson<int>(longBreakInterval),
      'soundEnabled': serializer.toJson<bool>(soundEnabled),
      'isDirty': serializer.toJson<bool>(isDirty),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SettingsEntry copyWith({
    String? userId,
    int? focusMinutes,
    int? shortBreakMinutes,
    int? longBreakMinutes,
    int? longBreakInterval,
    bool? soundEnabled,
    bool? isDirty,
    DateTime? updatedAt,
  }) => SettingsEntry(
    userId: userId ?? this.userId,
    focusMinutes: focusMinutes ?? this.focusMinutes,
    shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
    longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
    longBreakInterval: longBreakInterval ?? this.longBreakInterval,
    soundEnabled: soundEnabled ?? this.soundEnabled,
    isDirty: isDirty ?? this.isDirty,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SettingsEntry copyWithCompanion(SettingsEntriesCompanion data) {
    return SettingsEntry(
      userId: data.userId.present ? data.userId.value : this.userId,
      focusMinutes: data.focusMinutes.present
          ? data.focusMinutes.value
          : this.focusMinutes,
      shortBreakMinutes: data.shortBreakMinutes.present
          ? data.shortBreakMinutes.value
          : this.shortBreakMinutes,
      longBreakMinutes: data.longBreakMinutes.present
          ? data.longBreakMinutes.value
          : this.longBreakMinutes,
      longBreakInterval: data.longBreakInterval.present
          ? data.longBreakInterval.value
          : this.longBreakInterval,
      soundEnabled: data.soundEnabled.present
          ? data.soundEnabled.value
          : this.soundEnabled,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntry(')
          ..write('userId: $userId, ')
          ..write('focusMinutes: $focusMinutes, ')
          ..write('shortBreakMinutes: $shortBreakMinutes, ')
          ..write('longBreakMinutes: $longBreakMinutes, ')
          ..write('longBreakInterval: $longBreakInterval, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('isDirty: $isDirty, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    focusMinutes,
    shortBreakMinutes,
    longBreakMinutes,
    longBreakInterval,
    soundEnabled,
    isDirty,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsEntry &&
          other.userId == this.userId &&
          other.focusMinutes == this.focusMinutes &&
          other.shortBreakMinutes == this.shortBreakMinutes &&
          other.longBreakMinutes == this.longBreakMinutes &&
          other.longBreakInterval == this.longBreakInterval &&
          other.soundEnabled == this.soundEnabled &&
          other.isDirty == this.isDirty &&
          other.updatedAt == this.updatedAt);
}

class SettingsEntriesCompanion extends UpdateCompanion<SettingsEntry> {
  final Value<String> userId;
  final Value<int> focusMinutes;
  final Value<int> shortBreakMinutes;
  final Value<int> longBreakMinutes;
  final Value<int> longBreakInterval;
  final Value<bool> soundEnabled;
  final Value<bool> isDirty;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SettingsEntriesCompanion({
    this.userId = const Value.absent(),
    this.focusMinutes = const Value.absent(),
    this.shortBreakMinutes = const Value.absent(),
    this.longBreakMinutes = const Value.absent(),
    this.longBreakInterval = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsEntriesCompanion.insert({
    required String userId,
    this.focusMinutes = const Value.absent(),
    this.shortBreakMinutes = const Value.absent(),
    this.longBreakMinutes = const Value.absent(),
    this.longBreakInterval = const Value.absent(),
    this.soundEnabled = const Value.absent(),
    this.isDirty = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       updatedAt = Value(updatedAt);
  static Insertable<SettingsEntry> custom({
    Expression<String>? userId,
    Expression<int>? focusMinutes,
    Expression<int>? shortBreakMinutes,
    Expression<int>? longBreakMinutes,
    Expression<int>? longBreakInterval,
    Expression<bool>? soundEnabled,
    Expression<bool>? isDirty,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (focusMinutes != null) 'focus_minutes': focusMinutes,
      if (shortBreakMinutes != null) 'short_break_minutes': shortBreakMinutes,
      if (longBreakMinutes != null) 'long_break_minutes': longBreakMinutes,
      if (longBreakInterval != null) 'long_break_interval': longBreakInterval,
      if (soundEnabled != null) 'sound_enabled': soundEnabled,
      if (isDirty != null) 'is_dirty': isDirty,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsEntriesCompanion copyWith({
    Value<String>? userId,
    Value<int>? focusMinutes,
    Value<int>? shortBreakMinutes,
    Value<int>? longBreakMinutes,
    Value<int>? longBreakInterval,
    Value<bool>? soundEnabled,
    Value<bool>? isDirty,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SettingsEntriesCompanion(
      userId: userId ?? this.userId,
      focusMinutes: focusMinutes ?? this.focusMinutes,
      shortBreakMinutes: shortBreakMinutes ?? this.shortBreakMinutes,
      longBreakMinutes: longBreakMinutes ?? this.longBreakMinutes,
      longBreakInterval: longBreakInterval ?? this.longBreakInterval,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      isDirty: isDirty ?? this.isDirty,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (focusMinutes.present) {
      map['focus_minutes'] = Variable<int>(focusMinutes.value);
    }
    if (shortBreakMinutes.present) {
      map['short_break_minutes'] = Variable<int>(shortBreakMinutes.value);
    }
    if (longBreakMinutes.present) {
      map['long_break_minutes'] = Variable<int>(longBreakMinutes.value);
    }
    if (longBreakInterval.present) {
      map['long_break_interval'] = Variable<int>(longBreakInterval.value);
    }
    if (soundEnabled.present) {
      map['sound_enabled'] = Variable<bool>(soundEnabled.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntriesCompanion(')
          ..write('userId: $userId, ')
          ..write('focusMinutes: $focusMinutes, ')
          ..write('shortBreakMinutes: $shortBreakMinutes, ')
          ..write('longBreakMinutes: $longBreakMinutes, ')
          ..write('longBreakInterval: $longBreakInterval, ')
          ..write('soundEnabled: $soundEnabled, ')
          ..write('isDirty: $isDirty, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuthEntriesTable extends AuthEntries
    with TableInfo<$AuthEntriesTable, AuthEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuthEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refreshTokenMeta = const VerificationMeta(
    'refreshToken',
  );
  @override
  late final GeneratedColumn<String> refreshToken = GeneratedColumn<String>(
    'refresh_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    email,
    refreshToken,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'auth_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuthEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('refresh_token')) {
      context.handle(
        _refreshTokenMeta,
        refreshToken.isAcceptableOrUnknown(
          data['refresh_token']!,
          _refreshTokenMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  AuthEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuthEntry(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      refreshToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}refresh_token'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AuthEntriesTable createAlias(String alias) {
    return $AuthEntriesTable(attachedDatabase, alias);
  }
}

class AuthEntry extends DataClass implements Insertable<AuthEntry> {
  final String userId;
  final String email;
  final String refreshToken;
  final DateTime updatedAt;
  const AuthEntry({
    required this.userId,
    required this.email,
    required this.refreshToken,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['email'] = Variable<String>(email);
    map['refresh_token'] = Variable<String>(refreshToken);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AuthEntriesCompanion toCompanion(bool nullToAbsent) {
    return AuthEntriesCompanion(
      userId: Value(userId),
      email: Value(email),
      refreshToken: Value(refreshToken),
      updatedAt: Value(updatedAt),
    );
  }

  factory AuthEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuthEntry(
      userId: serializer.fromJson<String>(json['userId']),
      email: serializer.fromJson<String>(json['email']),
      refreshToken: serializer.fromJson<String>(json['refreshToken']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'email': serializer.toJson<String>(email),
      'refreshToken': serializer.toJson<String>(refreshToken),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AuthEntry copyWith({
    String? userId,
    String? email,
    String? refreshToken,
    DateTime? updatedAt,
  }) => AuthEntry(
    userId: userId ?? this.userId,
    email: email ?? this.email,
    refreshToken: refreshToken ?? this.refreshToken,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AuthEntry copyWithCompanion(AuthEntriesCompanion data) {
    return AuthEntry(
      userId: data.userId.present ? data.userId.value : this.userId,
      email: data.email.present ? data.email.value : this.email,
      refreshToken: data.refreshToken.present
          ? data.refreshToken.value
          : this.refreshToken,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuthEntry(')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, email, refreshToken, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuthEntry &&
          other.userId == this.userId &&
          other.email == this.email &&
          other.refreshToken == this.refreshToken &&
          other.updatedAt == this.updatedAt);
}

class AuthEntriesCompanion extends UpdateCompanion<AuthEntry> {
  final Value<String> userId;
  final Value<String> email;
  final Value<String> refreshToken;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AuthEntriesCompanion({
    this.userId = const Value.absent(),
    this.email = const Value.absent(),
    this.refreshToken = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuthEntriesCompanion.insert({
    required String userId,
    required String email,
    this.refreshToken = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       email = Value(email),
       updatedAt = Value(updatedAt);
  static Insertable<AuthEntry> custom({
    Expression<String>? userId,
    Expression<String>? email,
    Expression<String>? refreshToken,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (refreshToken != null) 'refresh_token': refreshToken,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuthEntriesCompanion copyWith({
    Value<String>? userId,
    Value<String>? email,
    Value<String>? refreshToken,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return AuthEntriesCompanion(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      refreshToken: refreshToken ?? this.refreshToken,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (refreshToken.present) {
      map['refresh_token'] = Variable<String>(refreshToken.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuthEntriesCompanion(')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('refreshToken: $refreshToken, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivitySampleEntriesTable extends ActivitySampleEntries
    with TableInfo<$ActivitySampleEntriesTable, ActivitySampleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitySampleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capturedAtMeta = const VerificationMeta(
    'capturedAt',
  );
  @override
  late final GeneratedColumn<DateTime> capturedAt = GeneratedColumn<DateTime>(
    'captured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appIdMeta = const VerificationMeta('appId');
  @override
  late final GeneratedColumn<String> appId = GeneratedColumn<String>(
    'app_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appNameMeta = const VerificationMeta(
    'appName',
  );
  @override
  late final GeneratedColumn<String> appName = GeneratedColumn<String>(
    'app_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _windowTitleMeta = const VerificationMeta(
    'windowTitle',
  );
  @override
  late final GeneratedColumn<String> windowTitle = GeneratedColumn<String>(
    'window_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityLabelMeta = const VerificationMeta(
    'activityLabel',
  );
  @override
  late final GeneratedColumn<String> activityLabel = GeneratedColumn<String>(
    'activity_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categorySourceMeta = const VerificationMeta(
    'categorySource',
  );
  @override
  late final GeneratedColumn<String> categorySource = GeneratedColumn<String>(
    'category_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _secondaryContextJsonMeta =
      const VerificationMeta('secondaryContextJson');
  @override
  late final GeneratedColumn<String> secondaryContextJson =
      GeneratedColumn<String>(
        'secondary_context_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _processingStateMeta = const VerificationMeta(
    'processingState',
  );
  @override
  late final GeneratedColumn<String> processingState = GeneratedColumn<String>(
    'processing_state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promptVersionMeta = const VerificationMeta(
    'promptVersion',
  );
  @override
  late final GeneratedColumn<String> promptVersion = GeneratedColumn<String>(
    'prompt_version',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _failureCodeMeta = const VerificationMeta(
    'failureCode',
  );
  @override
  late final GeneratedColumn<String> failureCode = GeneratedColumn<String>(
    'failure_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    capturedAt,
    startedAt,
    endedAt,
    appId,
    appName,
    windowTitle,
    activityLabel,
    categoryId,
    categorySource,
    confidence,
    secondaryContextJson,
    processingState,
    modelVersion,
    promptVersion,
    failureCode,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_sample_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivitySampleEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('captured_at')) {
      context.handle(
        _capturedAtMeta,
        capturedAt.isAcceptableOrUnknown(data['captured_at']!, _capturedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_capturedAtMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('app_id')) {
      context.handle(
        _appIdMeta,
        appId.isAcceptableOrUnknown(data['app_id']!, _appIdMeta),
      );
    } else if (isInserting) {
      context.missing(_appIdMeta);
    }
    if (data.containsKey('app_name')) {
      context.handle(
        _appNameMeta,
        appName.isAcceptableOrUnknown(data['app_name']!, _appNameMeta),
      );
    } else if (isInserting) {
      context.missing(_appNameMeta);
    }
    if (data.containsKey('window_title')) {
      context.handle(
        _windowTitleMeta,
        windowTitle.isAcceptableOrUnknown(
          data['window_title']!,
          _windowTitleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_windowTitleMeta);
    }
    if (data.containsKey('activity_label')) {
      context.handle(
        _activityLabelMeta,
        activityLabel.isAcceptableOrUnknown(
          data['activity_label']!,
          _activityLabelMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('category_source')) {
      context.handle(
        _categorySourceMeta,
        categorySource.isAcceptableOrUnknown(
          data['category_source']!,
          _categorySourceMeta,
        ),
      );
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    }
    if (data.containsKey('secondary_context_json')) {
      context.handle(
        _secondaryContextJsonMeta,
        secondaryContextJson.isAcceptableOrUnknown(
          data['secondary_context_json']!,
          _secondaryContextJsonMeta,
        ),
      );
    }
    if (data.containsKey('processing_state')) {
      context.handle(
        _processingStateMeta,
        processingState.isAcceptableOrUnknown(
          data['processing_state']!,
          _processingStateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_processingStateMeta);
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    }
    if (data.containsKey('prompt_version')) {
      context.handle(
        _promptVersionMeta,
        promptVersion.isAcceptableOrUnknown(
          data['prompt_version']!,
          _promptVersionMeta,
        ),
      );
    }
    if (data.containsKey('failure_code')) {
      context.handle(
        _failureCodeMeta,
        failureCode.isAcceptableOrUnknown(
          data['failure_code']!,
          _failureCodeMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivitySampleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivitySampleEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      capturedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}captured_at'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
      appId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_id'],
      )!,
      appName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_name'],
      )!,
      windowTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}window_title'],
      )!,
      activityLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_label'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      categorySource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_source'],
      ),
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      ),
      secondaryContextJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_context_json'],
      )!,
      processingState: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}processing_state'],
      )!,
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      ),
      promptVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_version'],
      ),
      failureCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}failure_code'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ActivitySampleEntriesTable createAlias(String alias) {
    return $ActivitySampleEntriesTable(attachedDatabase, alias);
  }
}

class ActivitySampleEntry extends DataClass
    implements Insertable<ActivitySampleEntry> {
  final String id;
  final String userId;
  final DateTime capturedAt;
  final DateTime startedAt;
  final DateTime endedAt;
  final String appId;
  final String appName;
  final String windowTitle;
  final String? activityLabel;
  final String? categoryId;
  final String? categorySource;
  final double? confidence;
  final String secondaryContextJson;
  final String processingState;
  final String? modelVersion;
  final String? promptVersion;
  final String? failureCode;
  final DateTime updatedAt;
  const ActivitySampleEntry({
    required this.id,
    required this.userId,
    required this.capturedAt,
    required this.startedAt,
    required this.endedAt,
    required this.appId,
    required this.appName,
    required this.windowTitle,
    this.activityLabel,
    this.categoryId,
    this.categorySource,
    this.confidence,
    required this.secondaryContextJson,
    required this.processingState,
    this.modelVersion,
    this.promptVersion,
    this.failureCode,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['captured_at'] = Variable<DateTime>(capturedAt);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['app_id'] = Variable<String>(appId);
    map['app_name'] = Variable<String>(appName);
    map['window_title'] = Variable<String>(windowTitle);
    if (!nullToAbsent || activityLabel != null) {
      map['activity_label'] = Variable<String>(activityLabel);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || categorySource != null) {
      map['category_source'] = Variable<String>(categorySource);
    }
    if (!nullToAbsent || confidence != null) {
      map['confidence'] = Variable<double>(confidence);
    }
    map['secondary_context_json'] = Variable<String>(secondaryContextJson);
    map['processing_state'] = Variable<String>(processingState);
    if (!nullToAbsent || modelVersion != null) {
      map['model_version'] = Variable<String>(modelVersion);
    }
    if (!nullToAbsent || promptVersion != null) {
      map['prompt_version'] = Variable<String>(promptVersion);
    }
    if (!nullToAbsent || failureCode != null) {
      map['failure_code'] = Variable<String>(failureCode);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ActivitySampleEntriesCompanion toCompanion(bool nullToAbsent) {
    return ActivitySampleEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      capturedAt: Value(capturedAt),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      appId: Value(appId),
      appName: Value(appName),
      windowTitle: Value(windowTitle),
      activityLabel: activityLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(activityLabel),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      categorySource: categorySource == null && nullToAbsent
          ? const Value.absent()
          : Value(categorySource),
      confidence: confidence == null && nullToAbsent
          ? const Value.absent()
          : Value(confidence),
      secondaryContextJson: Value(secondaryContextJson),
      processingState: Value(processingState),
      modelVersion: modelVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(modelVersion),
      promptVersion: promptVersion == null && nullToAbsent
          ? const Value.absent()
          : Value(promptVersion),
      failureCode: failureCode == null && nullToAbsent
          ? const Value.absent()
          : Value(failureCode),
      updatedAt: Value(updatedAt),
    );
  }

  factory ActivitySampleEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivitySampleEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      capturedAt: serializer.fromJson<DateTime>(json['capturedAt']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
      appId: serializer.fromJson<String>(json['appId']),
      appName: serializer.fromJson<String>(json['appName']),
      windowTitle: serializer.fromJson<String>(json['windowTitle']),
      activityLabel: serializer.fromJson<String?>(json['activityLabel']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      categorySource: serializer.fromJson<String?>(json['categorySource']),
      confidence: serializer.fromJson<double?>(json['confidence']),
      secondaryContextJson: serializer.fromJson<String>(
        json['secondaryContextJson'],
      ),
      processingState: serializer.fromJson<String>(json['processingState']),
      modelVersion: serializer.fromJson<String?>(json['modelVersion']),
      promptVersion: serializer.fromJson<String?>(json['promptVersion']),
      failureCode: serializer.fromJson<String?>(json['failureCode']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'capturedAt': serializer.toJson<DateTime>(capturedAt),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
      'appId': serializer.toJson<String>(appId),
      'appName': serializer.toJson<String>(appName),
      'windowTitle': serializer.toJson<String>(windowTitle),
      'activityLabel': serializer.toJson<String?>(activityLabel),
      'categoryId': serializer.toJson<String?>(categoryId),
      'categorySource': serializer.toJson<String?>(categorySource),
      'confidence': serializer.toJson<double?>(confidence),
      'secondaryContextJson': serializer.toJson<String>(secondaryContextJson),
      'processingState': serializer.toJson<String>(processingState),
      'modelVersion': serializer.toJson<String?>(modelVersion),
      'promptVersion': serializer.toJson<String?>(promptVersion),
      'failureCode': serializer.toJson<String?>(failureCode),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ActivitySampleEntry copyWith({
    String? id,
    String? userId,
    DateTime? capturedAt,
    DateTime? startedAt,
    DateTime? endedAt,
    String? appId,
    String? appName,
    String? windowTitle,
    Value<String?> activityLabel = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<String?> categorySource = const Value.absent(),
    Value<double?> confidence = const Value.absent(),
    String? secondaryContextJson,
    String? processingState,
    Value<String?> modelVersion = const Value.absent(),
    Value<String?> promptVersion = const Value.absent(),
    Value<String?> failureCode = const Value.absent(),
    DateTime? updatedAt,
  }) => ActivitySampleEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    capturedAt: capturedAt ?? this.capturedAt,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    appId: appId ?? this.appId,
    appName: appName ?? this.appName,
    windowTitle: windowTitle ?? this.windowTitle,
    activityLabel: activityLabel.present
        ? activityLabel.value
        : this.activityLabel,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    categorySource: categorySource.present
        ? categorySource.value
        : this.categorySource,
    confidence: confidence.present ? confidence.value : this.confidence,
    secondaryContextJson: secondaryContextJson ?? this.secondaryContextJson,
    processingState: processingState ?? this.processingState,
    modelVersion: modelVersion.present ? modelVersion.value : this.modelVersion,
    promptVersion: promptVersion.present
        ? promptVersion.value
        : this.promptVersion,
    failureCode: failureCode.present ? failureCode.value : this.failureCode,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ActivitySampleEntry copyWithCompanion(ActivitySampleEntriesCompanion data) {
    return ActivitySampleEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      capturedAt: data.capturedAt.present
          ? data.capturedAt.value
          : this.capturedAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      appId: data.appId.present ? data.appId.value : this.appId,
      appName: data.appName.present ? data.appName.value : this.appName,
      windowTitle: data.windowTitle.present
          ? data.windowTitle.value
          : this.windowTitle,
      activityLabel: data.activityLabel.present
          ? data.activityLabel.value
          : this.activityLabel,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      categorySource: data.categorySource.present
          ? data.categorySource.value
          : this.categorySource,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      secondaryContextJson: data.secondaryContextJson.present
          ? data.secondaryContextJson.value
          : this.secondaryContextJson,
      processingState: data.processingState.present
          ? data.processingState.value
          : this.processingState,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
      promptVersion: data.promptVersion.present
          ? data.promptVersion.value
          : this.promptVersion,
      failureCode: data.failureCode.present
          ? data.failureCode.value
          : this.failureCode,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivitySampleEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('appId: $appId, ')
          ..write('appName: $appName, ')
          ..write('windowTitle: $windowTitle, ')
          ..write('activityLabel: $activityLabel, ')
          ..write('categoryId: $categoryId, ')
          ..write('categorySource: $categorySource, ')
          ..write('confidence: $confidence, ')
          ..write('secondaryContextJson: $secondaryContextJson, ')
          ..write('processingState: $processingState, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('failureCode: $failureCode, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    capturedAt,
    startedAt,
    endedAt,
    appId,
    appName,
    windowTitle,
    activityLabel,
    categoryId,
    categorySource,
    confidence,
    secondaryContextJson,
    processingState,
    modelVersion,
    promptVersion,
    failureCode,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivitySampleEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.capturedAt == this.capturedAt &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.appId == this.appId &&
          other.appName == this.appName &&
          other.windowTitle == this.windowTitle &&
          other.activityLabel == this.activityLabel &&
          other.categoryId == this.categoryId &&
          other.categorySource == this.categorySource &&
          other.confidence == this.confidence &&
          other.secondaryContextJson == this.secondaryContextJson &&
          other.processingState == this.processingState &&
          other.modelVersion == this.modelVersion &&
          other.promptVersion == this.promptVersion &&
          other.failureCode == this.failureCode &&
          other.updatedAt == this.updatedAt);
}

class ActivitySampleEntriesCompanion
    extends UpdateCompanion<ActivitySampleEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> capturedAt;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<String> appId;
  final Value<String> appName;
  final Value<String> windowTitle;
  final Value<String?> activityLabel;
  final Value<String?> categoryId;
  final Value<String?> categorySource;
  final Value<double?> confidence;
  final Value<String> secondaryContextJson;
  final Value<String> processingState;
  final Value<String?> modelVersion;
  final Value<String?> promptVersion;
  final Value<String?> failureCode;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ActivitySampleEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.capturedAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.appId = const Value.absent(),
    this.appName = const Value.absent(),
    this.windowTitle = const Value.absent(),
    this.activityLabel = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categorySource = const Value.absent(),
    this.confidence = const Value.absent(),
    this.secondaryContextJson = const Value.absent(),
    this.processingState = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.promptVersion = const Value.absent(),
    this.failureCode = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivitySampleEntriesCompanion.insert({
    required String id,
    required String userId,
    required DateTime capturedAt,
    required DateTime startedAt,
    required DateTime endedAt,
    required String appId,
    required String appName,
    required String windowTitle,
    this.activityLabel = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categorySource = const Value.absent(),
    this.confidence = const Value.absent(),
    this.secondaryContextJson = const Value.absent(),
    required String processingState,
    this.modelVersion = const Value.absent(),
    this.promptVersion = const Value.absent(),
    this.failureCode = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       capturedAt = Value(capturedAt),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       appId = Value(appId),
       appName = Value(appName),
       windowTitle = Value(windowTitle),
       processingState = Value(processingState),
       updatedAt = Value(updatedAt);
  static Insertable<ActivitySampleEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? capturedAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? appId,
    Expression<String>? appName,
    Expression<String>? windowTitle,
    Expression<String>? activityLabel,
    Expression<String>? categoryId,
    Expression<String>? categorySource,
    Expression<double>? confidence,
    Expression<String>? secondaryContextJson,
    Expression<String>? processingState,
    Expression<String>? modelVersion,
    Expression<String>? promptVersion,
    Expression<String>? failureCode,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (capturedAt != null) 'captured_at': capturedAt,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (appId != null) 'app_id': appId,
      if (appName != null) 'app_name': appName,
      if (windowTitle != null) 'window_title': windowTitle,
      if (activityLabel != null) 'activity_label': activityLabel,
      if (categoryId != null) 'category_id': categoryId,
      if (categorySource != null) 'category_source': categorySource,
      if (confidence != null) 'confidence': confidence,
      if (secondaryContextJson != null)
        'secondary_context_json': secondaryContextJson,
      if (processingState != null) 'processing_state': processingState,
      if (modelVersion != null) 'model_version': modelVersion,
      if (promptVersion != null) 'prompt_version': promptVersion,
      if (failureCode != null) 'failure_code': failureCode,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivitySampleEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<DateTime>? capturedAt,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<String>? appId,
    Value<String>? appName,
    Value<String>? windowTitle,
    Value<String?>? activityLabel,
    Value<String?>? categoryId,
    Value<String?>? categorySource,
    Value<double?>? confidence,
    Value<String>? secondaryContextJson,
    Value<String>? processingState,
    Value<String?>? modelVersion,
    Value<String?>? promptVersion,
    Value<String?>? failureCode,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ActivitySampleEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      capturedAt: capturedAt ?? this.capturedAt,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      appId: appId ?? this.appId,
      appName: appName ?? this.appName,
      windowTitle: windowTitle ?? this.windowTitle,
      activityLabel: activityLabel ?? this.activityLabel,
      categoryId: categoryId ?? this.categoryId,
      categorySource: categorySource ?? this.categorySource,
      confidence: confidence ?? this.confidence,
      secondaryContextJson: secondaryContextJson ?? this.secondaryContextJson,
      processingState: processingState ?? this.processingState,
      modelVersion: modelVersion ?? this.modelVersion,
      promptVersion: promptVersion ?? this.promptVersion,
      failureCode: failureCode ?? this.failureCode,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (capturedAt.present) {
      map['captured_at'] = Variable<DateTime>(capturedAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (appId.present) {
      map['app_id'] = Variable<String>(appId.value);
    }
    if (appName.present) {
      map['app_name'] = Variable<String>(appName.value);
    }
    if (windowTitle.present) {
      map['window_title'] = Variable<String>(windowTitle.value);
    }
    if (activityLabel.present) {
      map['activity_label'] = Variable<String>(activityLabel.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (categorySource.present) {
      map['category_source'] = Variable<String>(categorySource.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (secondaryContextJson.present) {
      map['secondary_context_json'] = Variable<String>(
        secondaryContextJson.value,
      );
    }
    if (processingState.present) {
      map['processing_state'] = Variable<String>(processingState.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (promptVersion.present) {
      map['prompt_version'] = Variable<String>(promptVersion.value);
    }
    if (failureCode.present) {
      map['failure_code'] = Variable<String>(failureCode.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitySampleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('capturedAt: $capturedAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('appId: $appId, ')
          ..write('appName: $appName, ')
          ..write('windowTitle: $windowTitle, ')
          ..write('activityLabel: $activityLabel, ')
          ..write('categoryId: $categoryId, ')
          ..write('categorySource: $categorySource, ')
          ..write('confidence: $confidence, ')
          ..write('secondaryContextJson: $secondaryContextJson, ')
          ..write('processingState: $processingState, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('failureCode: $failureCode, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityBlockEntriesTable extends ActivityBlockEntries
    with TableInfo<$ActivityBlockEntriesTable, ActivityBlockEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityBlockEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appIdMeta = const VerificationMeta('appId');
  @override
  late final GeneratedColumn<String> appId = GeneratedColumn<String>(
    'app_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appNameMeta = const VerificationMeta(
    'appName',
  );
  @override
  late final GeneratedColumn<String> appName = GeneratedColumn<String>(
    'app_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityLabelMeta = const VerificationMeta(
    'activityLabel',
  );
  @override
  late final GeneratedColumn<String> activityLabel = GeneratedColumn<String>(
    'activity_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categorySourceMeta = const VerificationMeta(
    'categorySource',
  );
  @override
  late final GeneratedColumn<String> categorySource = GeneratedColumn<String>(
    'category_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sampleCountMeta = const VerificationMeta(
    'sampleCount',
  );
  @override
  late final GeneratedColumn<int> sampleCount = GeneratedColumn<int>(
    'sample_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _secondaryContextJsonMeta =
      const VerificationMeta('secondaryContextJson');
  @override
  late final GeneratedColumn<String> secondaryContextJson =
      GeneratedColumn<String>(
        'secondary_context_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    startedAt,
    endedAt,
    appId,
    appName,
    activityLabel,
    categoryId,
    categorySource,
    confidence,
    sampleCount,
    secondaryContextJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_block_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityBlockEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('app_id')) {
      context.handle(
        _appIdMeta,
        appId.isAcceptableOrUnknown(data['app_id']!, _appIdMeta),
      );
    } else if (isInserting) {
      context.missing(_appIdMeta);
    }
    if (data.containsKey('app_name')) {
      context.handle(
        _appNameMeta,
        appName.isAcceptableOrUnknown(data['app_name']!, _appNameMeta),
      );
    } else if (isInserting) {
      context.missing(_appNameMeta);
    }
    if (data.containsKey('activity_label')) {
      context.handle(
        _activityLabelMeta,
        activityLabel.isAcceptableOrUnknown(
          data['activity_label']!,
          _activityLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityLabelMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('category_source')) {
      context.handle(
        _categorySourceMeta,
        categorySource.isAcceptableOrUnknown(
          data['category_source']!,
          _categorySourceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categorySourceMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('sample_count')) {
      context.handle(
        _sampleCountMeta,
        sampleCount.isAcceptableOrUnknown(
          data['sample_count']!,
          _sampleCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sampleCountMeta);
    }
    if (data.containsKey('secondary_context_json')) {
      context.handle(
        _secondaryContextJsonMeta,
        secondaryContextJson.isAcceptableOrUnknown(
          data['secondary_context_json']!,
          _secondaryContextJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityBlockEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityBlockEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      )!,
      appId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_id'],
      )!,
      appName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_name'],
      )!,
      activityLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_label'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      categorySource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_source'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      sampleCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sample_count'],
      )!,
      secondaryContextJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_context_json'],
      )!,
    );
  }

  @override
  $ActivityBlockEntriesTable createAlias(String alias) {
    return $ActivityBlockEntriesTable(attachedDatabase, alias);
  }
}

class ActivityBlockEntry extends DataClass
    implements Insertable<ActivityBlockEntry> {
  final String id;
  final String userId;
  final DateTime startedAt;
  final DateTime endedAt;
  final String appId;
  final String appName;
  final String activityLabel;
  final String? categoryId;
  final String categorySource;
  final double confidence;
  final int sampleCount;
  final String secondaryContextJson;
  const ActivityBlockEntry({
    required this.id,
    required this.userId,
    required this.startedAt,
    required this.endedAt,
    required this.appId,
    required this.appName,
    required this.activityLabel,
    this.categoryId,
    required this.categorySource,
    required this.confidence,
    required this.sampleCount,
    required this.secondaryContextJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['app_id'] = Variable<String>(appId);
    map['app_name'] = Variable<String>(appName);
    map['activity_label'] = Variable<String>(activityLabel);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    map['category_source'] = Variable<String>(categorySource);
    map['confidence'] = Variable<double>(confidence);
    map['sample_count'] = Variable<int>(sampleCount);
    map['secondary_context_json'] = Variable<String>(secondaryContextJson);
    return map;
  }

  ActivityBlockEntriesCompanion toCompanion(bool nullToAbsent) {
    return ActivityBlockEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      appId: Value(appId),
      appName: Value(appName),
      activityLabel: Value(activityLabel),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      categorySource: Value(categorySource),
      confidence: Value(confidence),
      sampleCount: Value(sampleCount),
      secondaryContextJson: Value(secondaryContextJson),
    );
  }

  factory ActivityBlockEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityBlockEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
      appId: serializer.fromJson<String>(json['appId']),
      appName: serializer.fromJson<String>(json['appName']),
      activityLabel: serializer.fromJson<String>(json['activityLabel']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      categorySource: serializer.fromJson<String>(json['categorySource']),
      confidence: serializer.fromJson<double>(json['confidence']),
      sampleCount: serializer.fromJson<int>(json['sampleCount']),
      secondaryContextJson: serializer.fromJson<String>(
        json['secondaryContextJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
      'appId': serializer.toJson<String>(appId),
      'appName': serializer.toJson<String>(appName),
      'activityLabel': serializer.toJson<String>(activityLabel),
      'categoryId': serializer.toJson<String?>(categoryId),
      'categorySource': serializer.toJson<String>(categorySource),
      'confidence': serializer.toJson<double>(confidence),
      'sampleCount': serializer.toJson<int>(sampleCount),
      'secondaryContextJson': serializer.toJson<String>(secondaryContextJson),
    };
  }

  ActivityBlockEntry copyWith({
    String? id,
    String? userId,
    DateTime? startedAt,
    DateTime? endedAt,
    String? appId,
    String? appName,
    String? activityLabel,
    Value<String?> categoryId = const Value.absent(),
    String? categorySource,
    double? confidence,
    int? sampleCount,
    String? secondaryContextJson,
  }) => ActivityBlockEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt ?? this.endedAt,
    appId: appId ?? this.appId,
    appName: appName ?? this.appName,
    activityLabel: activityLabel ?? this.activityLabel,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    categorySource: categorySource ?? this.categorySource,
    confidence: confidence ?? this.confidence,
    sampleCount: sampleCount ?? this.sampleCount,
    secondaryContextJson: secondaryContextJson ?? this.secondaryContextJson,
  );
  ActivityBlockEntry copyWithCompanion(ActivityBlockEntriesCompanion data) {
    return ActivityBlockEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      appId: data.appId.present ? data.appId.value : this.appId,
      appName: data.appName.present ? data.appName.value : this.appName,
      activityLabel: data.activityLabel.present
          ? data.activityLabel.value
          : this.activityLabel,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      categorySource: data.categorySource.present
          ? data.categorySource.value
          : this.categorySource,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      sampleCount: data.sampleCount.present
          ? data.sampleCount.value
          : this.sampleCount,
      secondaryContextJson: data.secondaryContextJson.present
          ? data.secondaryContextJson.value
          : this.secondaryContextJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityBlockEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('appId: $appId, ')
          ..write('appName: $appName, ')
          ..write('activityLabel: $activityLabel, ')
          ..write('categoryId: $categoryId, ')
          ..write('categorySource: $categorySource, ')
          ..write('confidence: $confidence, ')
          ..write('sampleCount: $sampleCount, ')
          ..write('secondaryContextJson: $secondaryContextJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    startedAt,
    endedAt,
    appId,
    appName,
    activityLabel,
    categoryId,
    categorySource,
    confidence,
    sampleCount,
    secondaryContextJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityBlockEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.appId == this.appId &&
          other.appName == this.appName &&
          other.activityLabel == this.activityLabel &&
          other.categoryId == this.categoryId &&
          other.categorySource == this.categorySource &&
          other.confidence == this.confidence &&
          other.sampleCount == this.sampleCount &&
          other.secondaryContextJson == this.secondaryContextJson);
}

class ActivityBlockEntriesCompanion
    extends UpdateCompanion<ActivityBlockEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<String> appId;
  final Value<String> appName;
  final Value<String> activityLabel;
  final Value<String?> categoryId;
  final Value<String> categorySource;
  final Value<double> confidence;
  final Value<int> sampleCount;
  final Value<String> secondaryContextJson;
  final Value<int> rowid;
  const ActivityBlockEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.appId = const Value.absent(),
    this.appName = const Value.absent(),
    this.activityLabel = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.categorySource = const Value.absent(),
    this.confidence = const Value.absent(),
    this.sampleCount = const Value.absent(),
    this.secondaryContextJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityBlockEntriesCompanion.insert({
    required String id,
    required String userId,
    required DateTime startedAt,
    required DateTime endedAt,
    required String appId,
    required String appName,
    required String activityLabel,
    this.categoryId = const Value.absent(),
    required String categorySource,
    required double confidence,
    required int sampleCount,
    this.secondaryContextJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       startedAt = Value(startedAt),
       endedAt = Value(endedAt),
       appId = Value(appId),
       appName = Value(appName),
       activityLabel = Value(activityLabel),
       categorySource = Value(categorySource),
       confidence = Value(confidence),
       sampleCount = Value(sampleCount);
  static Insertable<ActivityBlockEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<String>? appId,
    Expression<String>? appName,
    Expression<String>? activityLabel,
    Expression<String>? categoryId,
    Expression<String>? categorySource,
    Expression<double>? confidence,
    Expression<int>? sampleCount,
    Expression<String>? secondaryContextJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (appId != null) 'app_id': appId,
      if (appName != null) 'app_name': appName,
      if (activityLabel != null) 'activity_label': activityLabel,
      if (categoryId != null) 'category_id': categoryId,
      if (categorySource != null) 'category_source': categorySource,
      if (confidence != null) 'confidence': confidence,
      if (sampleCount != null) 'sample_count': sampleCount,
      if (secondaryContextJson != null)
        'secondary_context_json': secondaryContextJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityBlockEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<DateTime>? startedAt,
    Value<DateTime>? endedAt,
    Value<String>? appId,
    Value<String>? appName,
    Value<String>? activityLabel,
    Value<String?>? categoryId,
    Value<String>? categorySource,
    Value<double>? confidence,
    Value<int>? sampleCount,
    Value<String>? secondaryContextJson,
    Value<int>? rowid,
  }) {
    return ActivityBlockEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      appId: appId ?? this.appId,
      appName: appName ?? this.appName,
      activityLabel: activityLabel ?? this.activityLabel,
      categoryId: categoryId ?? this.categoryId,
      categorySource: categorySource ?? this.categorySource,
      confidence: confidence ?? this.confidence,
      sampleCount: sampleCount ?? this.sampleCount,
      secondaryContextJson: secondaryContextJson ?? this.secondaryContextJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (appId.present) {
      map['app_id'] = Variable<String>(appId.value);
    }
    if (appName.present) {
      map['app_name'] = Variable<String>(appName.value);
    }
    if (activityLabel.present) {
      map['activity_label'] = Variable<String>(activityLabel.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (categorySource.present) {
      map['category_source'] = Variable<String>(categorySource.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (sampleCount.present) {
      map['sample_count'] = Variable<int>(sampleCount.value);
    }
    if (secondaryContextJson.present) {
      map['secondary_context_json'] = Variable<String>(
        secondaryContextJson.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityBlockEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('appId: $appId, ')
          ..write('appName: $appName, ')
          ..write('activityLabel: $activityLabel, ')
          ..write('categoryId: $categoryId, ')
          ..write('categorySource: $categorySource, ')
          ..write('confidence: $confidence, ')
          ..write('sampleCount: $sampleCount, ')
          ..write('secondaryContextJson: $secondaryContextJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoryEntriesTable extends CategoryEntries
    with TableInfo<$CategoryEntriesTable, CategoryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorValueMeta = const VerificationMeta(
    'colorValue',
  );
  @override
  late final GeneratedColumn<int> colorValue = GeneratedColumn<int>(
    'color_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isSystemMeta = const VerificationMeta(
    'isSystem',
  );
  @override
  late final GeneratedColumn<bool> isSystem = GeneratedColumn<bool>(
    'is_system',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_system" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    description,
    colorValue,
    sortOrder,
    isArchived,
    isSystem,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('color_value')) {
      context.handle(
        _colorValueMeta,
        colorValue.isAcceptableOrUnknown(data['color_value']!, _colorValueMeta),
      );
    } else if (isInserting) {
      context.missing(_colorValueMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('is_system')) {
      context.handle(
        _isSystemMeta,
        isSystem.isAcceptableOrUnknown(data['is_system']!, _isSystemMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      colorValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_value'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      isSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_system'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoryEntriesTable createAlias(String alias) {
    return $CategoryEntriesTable(attachedDatabase, alias);
  }
}

class CategoryEntry extends DataClass implements Insertable<CategoryEntry> {
  final String id;
  final String userId;
  final String name;
  final String description;
  final int colorValue;
  final int sortOrder;
  final bool isArchived;
  final bool isSystem;
  final DateTime updatedAt;
  const CategoryEntry({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.colorValue,
    required this.sortOrder,
    required this.isArchived,
    required this.isSystem,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['color_value'] = Variable<int>(colorValue);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_system'] = Variable<bool>(isSystem);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoryEntriesCompanion toCompanion(bool nullToAbsent) {
    return CategoryEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: Value(description),
      colorValue: Value(colorValue),
      sortOrder: Value(sortOrder),
      isArchived: Value(isArchived),
      isSystem: Value(isSystem),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      colorValue: serializer.fromJson<int>(json['colorValue']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isSystem: serializer.fromJson<bool>(json['isSystem']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'colorValue': serializer.toJson<int>(colorValue),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isSystem': serializer.toJson<bool>(isSystem),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryEntry copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    int? colorValue,
    int? sortOrder,
    bool? isArchived,
    bool? isSystem,
    DateTime? updatedAt,
  }) => CategoryEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description ?? this.description,
    colorValue: colorValue ?? this.colorValue,
    sortOrder: sortOrder ?? this.sortOrder,
    isArchived: isArchived ?? this.isArchived,
    isSystem: isSystem ?? this.isSystem,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoryEntry copyWithCompanion(CategoryEntriesCompanion data) {
    return CategoryEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      colorValue: data.colorValue.present
          ? data.colorValue.value
          : this.colorValue,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      isSystem: data.isSystem.present ? data.isSystem.value : this.isSystem,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('isSystem: $isSystem, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    description,
    colorValue,
    sortOrder,
    isArchived,
    isSystem,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.colorValue == this.colorValue &&
          other.sortOrder == this.sortOrder &&
          other.isArchived == this.isArchived &&
          other.isSystem == this.isSystem &&
          other.updatedAt == this.updatedAt);
}

class CategoryEntriesCompanion extends UpdateCompanion<CategoryEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> description;
  final Value<int> colorValue;
  final Value<int> sortOrder;
  final Value<bool> isArchived;
  final Value<bool> isSystem;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoryEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.colorValue = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isSystem = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryEntriesCompanion.insert({
    required String id,
    required String userId,
    required String name,
    required String description,
    required int colorValue,
    required int sortOrder,
    this.isArchived = const Value.absent(),
    this.isSystem = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name),
       description = Value(description),
       colorValue = Value(colorValue),
       sortOrder = Value(sortOrder),
       updatedAt = Value(updatedAt);
  static Insertable<CategoryEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? colorValue,
    Expression<int>? sortOrder,
    Expression<bool>? isArchived,
    Expression<bool>? isSystem,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (colorValue != null) 'color_value': colorValue,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isArchived != null) 'is_archived': isArchived,
      if (isSystem != null) 'is_system': isSystem,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String>? description,
    Value<int>? colorValue,
    Value<int>? sortOrder,
    Value<bool>? isArchived,
    Value<bool>? isSystem,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoryEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      colorValue: colorValue ?? this.colorValue,
      sortOrder: sortOrder ?? this.sortOrder,
      isArchived: isArchived ?? this.isArchived,
      isSystem: isSystem ?? this.isSystem,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (colorValue.present) {
      map['color_value'] = Variable<int>(colorValue.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isSystem.present) {
      map['is_system'] = Variable<bool>(isSystem.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('colorValue: $colorValue, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isArchived: $isArchived, ')
          ..write('isSystem: $isSystem, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoryRuleEntriesTable extends CategoryRuleEntries
    with TableInfo<$CategoryRuleEntriesTable, CategoryRuleEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryRuleEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appIdMeta = const VerificationMeta('appId');
  @override
  late final GeneratedColumn<String> appId = GeneratedColumn<String>(
    'app_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleContainsMeta = const VerificationMeta(
    'titleContains',
  );
  @override
  late final GeneratedColumn<String> titleContains = GeneratedColumn<String>(
    'title_contains',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    appId,
    titleContains,
    categoryId,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_rule_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryRuleEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('app_id')) {
      context.handle(
        _appIdMeta,
        appId.isAcceptableOrUnknown(data['app_id']!, _appIdMeta),
      );
    } else if (isInserting) {
      context.missing(_appIdMeta);
    }
    if (data.containsKey('title_contains')) {
      context.handle(
        _titleContainsMeta,
        titleContains.isAcceptableOrUnknown(
          data['title_contains']!,
          _titleContainsMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryRuleEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryRuleEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      appId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}app_id'],
      )!,
      titleContains: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_contains'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoryRuleEntriesTable createAlias(String alias) {
    return $CategoryRuleEntriesTable(attachedDatabase, alias);
  }
}

class CategoryRuleEntry extends DataClass
    implements Insertable<CategoryRuleEntry> {
  final String id;
  final String userId;
  final String appId;
  final String? titleContains;
  final String categoryId;
  final DateTime updatedAt;
  const CategoryRuleEntry({
    required this.id,
    required this.userId,
    required this.appId,
    this.titleContains,
    required this.categoryId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['app_id'] = Variable<String>(appId);
    if (!nullToAbsent || titleContains != null) {
      map['title_contains'] = Variable<String>(titleContains);
    }
    map['category_id'] = Variable<String>(categoryId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoryRuleEntriesCompanion toCompanion(bool nullToAbsent) {
    return CategoryRuleEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      appId: Value(appId),
      titleContains: titleContains == null && nullToAbsent
          ? const Value.absent()
          : Value(titleContains),
      categoryId: Value(categoryId),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryRuleEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryRuleEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      appId: serializer.fromJson<String>(json['appId']),
      titleContains: serializer.fromJson<String?>(json['titleContains']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'appId': serializer.toJson<String>(appId),
      'titleContains': serializer.toJson<String?>(titleContains),
      'categoryId': serializer.toJson<String>(categoryId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryRuleEntry copyWith({
    String? id,
    String? userId,
    String? appId,
    Value<String?> titleContains = const Value.absent(),
    String? categoryId,
    DateTime? updatedAt,
  }) => CategoryRuleEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    appId: appId ?? this.appId,
    titleContains: titleContains.present
        ? titleContains.value
        : this.titleContains,
    categoryId: categoryId ?? this.categoryId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoryRuleEntry copyWithCompanion(CategoryRuleEntriesCompanion data) {
    return CategoryRuleEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      appId: data.appId.present ? data.appId.value : this.appId,
      titleContains: data.titleContains.present
          ? data.titleContains.value
          : this.titleContains,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRuleEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('appId: $appId, ')
          ..write('titleContains: $titleContains, ')
          ..write('categoryId: $categoryId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, appId, titleContains, categoryId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryRuleEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.appId == this.appId &&
          other.titleContains == this.titleContains &&
          other.categoryId == this.categoryId &&
          other.updatedAt == this.updatedAt);
}

class CategoryRuleEntriesCompanion extends UpdateCompanion<CategoryRuleEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> appId;
  final Value<String?> titleContains;
  final Value<String> categoryId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoryRuleEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.appId = const Value.absent(),
    this.titleContains = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryRuleEntriesCompanion.insert({
    required String id,
    required String userId,
    required String appId,
    this.titleContains = const Value.absent(),
    required String categoryId,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       appId = Value(appId),
       categoryId = Value(categoryId),
       updatedAt = Value(updatedAt);
  static Insertable<CategoryRuleEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? appId,
    Expression<String>? titleContains,
    Expression<String>? categoryId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (appId != null) 'app_id': appId,
      if (titleContains != null) 'title_contains': titleContains,
      if (categoryId != null) 'category_id': categoryId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryRuleEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? appId,
    Value<String?>? titleContains,
    Value<String>? categoryId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoryRuleEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      appId: appId ?? this.appId,
      titleContains: titleContains ?? this.titleContains,
      categoryId: categoryId ?? this.categoryId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (appId.present) {
      map['app_id'] = Variable<String>(appId.value);
    }
    if (titleContains.present) {
      map['title_contains'] = Variable<String>(titleContains.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryRuleEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('appId: $appId, ')
          ..write('titleContains: $titleContains, ')
          ..write('categoryId: $categoryId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyInsightEntriesTable extends DailyInsightEntries
    with TableInfo<$DailyInsightEntriesTable, DailyInsightEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyInsightEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<String> localDate = GeneratedColumn<String>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _patternsJsonMeta = const VerificationMeta(
    'patternsJson',
  );
  @override
  late final GeneratedColumn<String> patternsJson = GeneratedColumn<String>(
    'patterns_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discrepanciesJsonMeta = const VerificationMeta(
    'discrepanciesJson',
  );
  @override
  late final GeneratedColumn<String> discrepanciesJson =
      GeneratedColumn<String>(
        'discrepancies_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _modelVersionMeta = const VerificationMeta(
    'modelVersion',
  );
  @override
  late final GeneratedColumn<String> modelVersion = GeneratedColumn<String>(
    'model_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _promptVersionMeta = const VerificationMeta(
    'promptVersion',
  );
  @override
  late final GeneratedColumn<String> promptVersion = GeneratedColumn<String>(
    'prompt_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceUpdatedAtMeta = const VerificationMeta(
    'sourceUpdatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> sourceUpdatedAt =
      GeneratedColumn<DateTime>(
        'source_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    localDate,
    summary,
    patternsJson,
    discrepanciesJson,
    modelVersion,
    promptVersion,
    sourceUpdatedAt,
    generatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_insight_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyInsightEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('patterns_json')) {
      context.handle(
        _patternsJsonMeta,
        patternsJson.isAcceptableOrUnknown(
          data['patterns_json']!,
          _patternsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_patternsJsonMeta);
    }
    if (data.containsKey('discrepancies_json')) {
      context.handle(
        _discrepanciesJsonMeta,
        discrepanciesJson.isAcceptableOrUnknown(
          data['discrepancies_json']!,
          _discrepanciesJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_discrepanciesJsonMeta);
    }
    if (data.containsKey('model_version')) {
      context.handle(
        _modelVersionMeta,
        modelVersion.isAcceptableOrUnknown(
          data['model_version']!,
          _modelVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_modelVersionMeta);
    }
    if (data.containsKey('prompt_version')) {
      context.handle(
        _promptVersionMeta,
        promptVersion.isAcceptableOrUnknown(
          data['prompt_version']!,
          _promptVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_promptVersionMeta);
    }
    if (data.containsKey('source_updated_at')) {
      context.handle(
        _sourceUpdatedAtMeta,
        sourceUpdatedAt.isAcceptableOrUnknown(
          data['source_updated_at']!,
          _sourceUpdatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceUpdatedAtMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, localDate};
  @override
  DailyInsightEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyInsightEntry(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_date'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      patternsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}patterns_json'],
      )!,
      discrepanciesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}discrepancies_json'],
      )!,
      modelVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_version'],
      )!,
      promptVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_version'],
      )!,
      sourceUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}source_updated_at'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
    );
  }

  @override
  $DailyInsightEntriesTable createAlias(String alias) {
    return $DailyInsightEntriesTable(attachedDatabase, alias);
  }
}

class DailyInsightEntry extends DataClass
    implements Insertable<DailyInsightEntry> {
  final String userId;
  final String localDate;
  final String summary;
  final String patternsJson;
  final String discrepanciesJson;
  final String modelVersion;
  final String promptVersion;
  final DateTime sourceUpdatedAt;
  final DateTime generatedAt;
  const DailyInsightEntry({
    required this.userId,
    required this.localDate,
    required this.summary,
    required this.patternsJson,
    required this.discrepanciesJson,
    required this.modelVersion,
    required this.promptVersion,
    required this.sourceUpdatedAt,
    required this.generatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['local_date'] = Variable<String>(localDate);
    map['summary'] = Variable<String>(summary);
    map['patterns_json'] = Variable<String>(patternsJson);
    map['discrepancies_json'] = Variable<String>(discrepanciesJson);
    map['model_version'] = Variable<String>(modelVersion);
    map['prompt_version'] = Variable<String>(promptVersion);
    map['source_updated_at'] = Variable<DateTime>(sourceUpdatedAt);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  DailyInsightEntriesCompanion toCompanion(bool nullToAbsent) {
    return DailyInsightEntriesCompanion(
      userId: Value(userId),
      localDate: Value(localDate),
      summary: Value(summary),
      patternsJson: Value(patternsJson),
      discrepanciesJson: Value(discrepanciesJson),
      modelVersion: Value(modelVersion),
      promptVersion: Value(promptVersion),
      sourceUpdatedAt: Value(sourceUpdatedAt),
      generatedAt: Value(generatedAt),
    );
  }

  factory DailyInsightEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyInsightEntry(
      userId: serializer.fromJson<String>(json['userId']),
      localDate: serializer.fromJson<String>(json['localDate']),
      summary: serializer.fromJson<String>(json['summary']),
      patternsJson: serializer.fromJson<String>(json['patternsJson']),
      discrepanciesJson: serializer.fromJson<String>(json['discrepanciesJson']),
      modelVersion: serializer.fromJson<String>(json['modelVersion']),
      promptVersion: serializer.fromJson<String>(json['promptVersion']),
      sourceUpdatedAt: serializer.fromJson<DateTime>(json['sourceUpdatedAt']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'localDate': serializer.toJson<String>(localDate),
      'summary': serializer.toJson<String>(summary),
      'patternsJson': serializer.toJson<String>(patternsJson),
      'discrepanciesJson': serializer.toJson<String>(discrepanciesJson),
      'modelVersion': serializer.toJson<String>(modelVersion),
      'promptVersion': serializer.toJson<String>(promptVersion),
      'sourceUpdatedAt': serializer.toJson<DateTime>(sourceUpdatedAt),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  DailyInsightEntry copyWith({
    String? userId,
    String? localDate,
    String? summary,
    String? patternsJson,
    String? discrepanciesJson,
    String? modelVersion,
    String? promptVersion,
    DateTime? sourceUpdatedAt,
    DateTime? generatedAt,
  }) => DailyInsightEntry(
    userId: userId ?? this.userId,
    localDate: localDate ?? this.localDate,
    summary: summary ?? this.summary,
    patternsJson: patternsJson ?? this.patternsJson,
    discrepanciesJson: discrepanciesJson ?? this.discrepanciesJson,
    modelVersion: modelVersion ?? this.modelVersion,
    promptVersion: promptVersion ?? this.promptVersion,
    sourceUpdatedAt: sourceUpdatedAt ?? this.sourceUpdatedAt,
    generatedAt: generatedAt ?? this.generatedAt,
  );
  DailyInsightEntry copyWithCompanion(DailyInsightEntriesCompanion data) {
    return DailyInsightEntry(
      userId: data.userId.present ? data.userId.value : this.userId,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      summary: data.summary.present ? data.summary.value : this.summary,
      patternsJson: data.patternsJson.present
          ? data.patternsJson.value
          : this.patternsJson,
      discrepanciesJson: data.discrepanciesJson.present
          ? data.discrepanciesJson.value
          : this.discrepanciesJson,
      modelVersion: data.modelVersion.present
          ? data.modelVersion.value
          : this.modelVersion,
      promptVersion: data.promptVersion.present
          ? data.promptVersion.value
          : this.promptVersion,
      sourceUpdatedAt: data.sourceUpdatedAt.present
          ? data.sourceUpdatedAt.value
          : this.sourceUpdatedAt,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyInsightEntry(')
          ..write('userId: $userId, ')
          ..write('localDate: $localDate, ')
          ..write('summary: $summary, ')
          ..write('patternsJson: $patternsJson, ')
          ..write('discrepanciesJson: $discrepanciesJson, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('sourceUpdatedAt: $sourceUpdatedAt, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    localDate,
    summary,
    patternsJson,
    discrepanciesJson,
    modelVersion,
    promptVersion,
    sourceUpdatedAt,
    generatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyInsightEntry &&
          other.userId == this.userId &&
          other.localDate == this.localDate &&
          other.summary == this.summary &&
          other.patternsJson == this.patternsJson &&
          other.discrepanciesJson == this.discrepanciesJson &&
          other.modelVersion == this.modelVersion &&
          other.promptVersion == this.promptVersion &&
          other.sourceUpdatedAt == this.sourceUpdatedAt &&
          other.generatedAt == this.generatedAt);
}

class DailyInsightEntriesCompanion extends UpdateCompanion<DailyInsightEntry> {
  final Value<String> userId;
  final Value<String> localDate;
  final Value<String> summary;
  final Value<String> patternsJson;
  final Value<String> discrepanciesJson;
  final Value<String> modelVersion;
  final Value<String> promptVersion;
  final Value<DateTime> sourceUpdatedAt;
  final Value<DateTime> generatedAt;
  final Value<int> rowid;
  const DailyInsightEntriesCompanion({
    this.userId = const Value.absent(),
    this.localDate = const Value.absent(),
    this.summary = const Value.absent(),
    this.patternsJson = const Value.absent(),
    this.discrepanciesJson = const Value.absent(),
    this.modelVersion = const Value.absent(),
    this.promptVersion = const Value.absent(),
    this.sourceUpdatedAt = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyInsightEntriesCompanion.insert({
    required String userId,
    required String localDate,
    required String summary,
    required String patternsJson,
    required String discrepanciesJson,
    required String modelVersion,
    required String promptVersion,
    required DateTime sourceUpdatedAt,
    required DateTime generatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       localDate = Value(localDate),
       summary = Value(summary),
       patternsJson = Value(patternsJson),
       discrepanciesJson = Value(discrepanciesJson),
       modelVersion = Value(modelVersion),
       promptVersion = Value(promptVersion),
       sourceUpdatedAt = Value(sourceUpdatedAt),
       generatedAt = Value(generatedAt);
  static Insertable<DailyInsightEntry> custom({
    Expression<String>? userId,
    Expression<String>? localDate,
    Expression<String>? summary,
    Expression<String>? patternsJson,
    Expression<String>? discrepanciesJson,
    Expression<String>? modelVersion,
    Expression<String>? promptVersion,
    Expression<DateTime>? sourceUpdatedAt,
    Expression<DateTime>? generatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (localDate != null) 'local_date': localDate,
      if (summary != null) 'summary': summary,
      if (patternsJson != null) 'patterns_json': patternsJson,
      if (discrepanciesJson != null) 'discrepancies_json': discrepanciesJson,
      if (modelVersion != null) 'model_version': modelVersion,
      if (promptVersion != null) 'prompt_version': promptVersion,
      if (sourceUpdatedAt != null) 'source_updated_at': sourceUpdatedAt,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyInsightEntriesCompanion copyWith({
    Value<String>? userId,
    Value<String>? localDate,
    Value<String>? summary,
    Value<String>? patternsJson,
    Value<String>? discrepanciesJson,
    Value<String>? modelVersion,
    Value<String>? promptVersion,
    Value<DateTime>? sourceUpdatedAt,
    Value<DateTime>? generatedAt,
    Value<int>? rowid,
  }) {
    return DailyInsightEntriesCompanion(
      userId: userId ?? this.userId,
      localDate: localDate ?? this.localDate,
      summary: summary ?? this.summary,
      patternsJson: patternsJson ?? this.patternsJson,
      discrepanciesJson: discrepanciesJson ?? this.discrepanciesJson,
      modelVersion: modelVersion ?? this.modelVersion,
      promptVersion: promptVersion ?? this.promptVersion,
      sourceUpdatedAt: sourceUpdatedAt ?? this.sourceUpdatedAt,
      generatedAt: generatedAt ?? this.generatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<String>(localDate.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (patternsJson.present) {
      map['patterns_json'] = Variable<String>(patternsJson.value);
    }
    if (discrepanciesJson.present) {
      map['discrepancies_json'] = Variable<String>(discrepanciesJson.value);
    }
    if (modelVersion.present) {
      map['model_version'] = Variable<String>(modelVersion.value);
    }
    if (promptVersion.present) {
      map['prompt_version'] = Variable<String>(promptVersion.value);
    }
    if (sourceUpdatedAt.present) {
      map['source_updated_at'] = Variable<DateTime>(sourceUpdatedAt.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyInsightEntriesCompanion(')
          ..write('userId: $userId, ')
          ..write('localDate: $localDate, ')
          ..write('summary: $summary, ')
          ..write('patternsJson: $patternsJson, ')
          ..write('discrepanciesJson: $discrepanciesJson, ')
          ..write('modelVersion: $modelVersion, ')
          ..write('promptVersion: $promptVersion, ')
          ..write('sourceUpdatedAt: $sourceUpdatedAt, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrackingSettingsEntriesTable extends TrackingSettingsEntries
    with TableInfo<$TrackingSettingsEntriesTable, TrackingSettingsEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackingSettingsEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _trackingEnabledMeta = const VerificationMeta(
    'trackingEnabled',
  );
  @override
  late final GeneratedColumn<bool> trackingEnabled = GeneratedColumn<bool>(
    'tracking_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tracking_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _captureIntervalMinutesMeta =
      const VerificationMeta('captureIntervalMinutes');
  @override
  late final GeneratedColumn<int> captureIntervalMinutes = GeneratedColumn<int>(
    'capture_interval_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _idleThresholdMinutesMeta =
      const VerificationMeta('idleThresholdMinutes');
  @override
  late final GeneratedColumn<int> idleThresholdMinutes = GeneratedColumn<int>(
    'idle_threshold_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _launchAtLoginMeta = const VerificationMeta(
    'launchAtLogin',
  );
  @override
  late final GeneratedColumn<bool> launchAtLogin = GeneratedColumn<bool>(
    'launch_at_login',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("launch_at_login" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _captureAllDisplaysMeta =
      const VerificationMeta('captureAllDisplays');
  @override
  late final GeneratedColumn<bool> captureAllDisplays = GeneratedColumn<bool>(
    'capture_all_displays',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("capture_all_displays" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _diagnosticsEnabledMeta =
      const VerificationMeta('diagnosticsEnabled');
  @override
  late final GeneratedColumn<bool> diagnosticsEnabled = GeneratedColumn<bool>(
    'diagnostics_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("diagnostics_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _excludedAppIdsJsonMeta =
      const VerificationMeta('excludedAppIdsJson');
  @override
  late final GeneratedColumn<String> excludedAppIdsJson =
      GeneratedColumn<String>(
        'excluded_app_ids_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _privacyNoticeVersionMeta =
      const VerificationMeta('privacyNoticeVersion');
  @override
  late final GeneratedColumn<int> privacyNoticeVersion = GeneratedColumn<int>(
    'privacy_notice_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pausedUntilMeta = const VerificationMeta(
    'pausedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> pausedUntil = GeneratedColumn<DateTime>(
    'paused_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    trackingEnabled,
    captureIntervalMinutes,
    idleThresholdMinutes,
    launchAtLogin,
    captureAllDisplays,
    diagnosticsEnabled,
    excludedAppIdsJson,
    onboardingComplete,
    privacyNoticeVersion,
    pausedUntil,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tracking_settings_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackingSettingsEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('tracking_enabled')) {
      context.handle(
        _trackingEnabledMeta,
        trackingEnabled.isAcceptableOrUnknown(
          data['tracking_enabled']!,
          _trackingEnabledMeta,
        ),
      );
    }
    if (data.containsKey('capture_interval_minutes')) {
      context.handle(
        _captureIntervalMinutesMeta,
        captureIntervalMinutes.isAcceptableOrUnknown(
          data['capture_interval_minutes']!,
          _captureIntervalMinutesMeta,
        ),
      );
    }
    if (data.containsKey('idle_threshold_minutes')) {
      context.handle(
        _idleThresholdMinutesMeta,
        idleThresholdMinutes.isAcceptableOrUnknown(
          data['idle_threshold_minutes']!,
          _idleThresholdMinutesMeta,
        ),
      );
    }
    if (data.containsKey('launch_at_login')) {
      context.handle(
        _launchAtLoginMeta,
        launchAtLogin.isAcceptableOrUnknown(
          data['launch_at_login']!,
          _launchAtLoginMeta,
        ),
      );
    }
    if (data.containsKey('capture_all_displays')) {
      context.handle(
        _captureAllDisplaysMeta,
        captureAllDisplays.isAcceptableOrUnknown(
          data['capture_all_displays']!,
          _captureAllDisplaysMeta,
        ),
      );
    }
    if (data.containsKey('diagnostics_enabled')) {
      context.handle(
        _diagnosticsEnabledMeta,
        diagnosticsEnabled.isAcceptableOrUnknown(
          data['diagnostics_enabled']!,
          _diagnosticsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('excluded_app_ids_json')) {
      context.handle(
        _excludedAppIdsJsonMeta,
        excludedAppIdsJson.isAcceptableOrUnknown(
          data['excluded_app_ids_json']!,
          _excludedAppIdsJsonMeta,
        ),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('privacy_notice_version')) {
      context.handle(
        _privacyNoticeVersionMeta,
        privacyNoticeVersion.isAcceptableOrUnknown(
          data['privacy_notice_version']!,
          _privacyNoticeVersionMeta,
        ),
      );
    }
    if (data.containsKey('paused_until')) {
      context.handle(
        _pausedUntilMeta,
        pausedUntil.isAcceptableOrUnknown(
          data['paused_until']!,
          _pausedUntilMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  TrackingSettingsEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackingSettingsEntry(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      trackingEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tracking_enabled'],
      )!,
      captureIntervalMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}capture_interval_minutes'],
      )!,
      idleThresholdMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}idle_threshold_minutes'],
      )!,
      launchAtLogin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}launch_at_login'],
      )!,
      captureAllDisplays: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}capture_all_displays'],
      )!,
      diagnosticsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}diagnostics_enabled'],
      )!,
      excludedAppIdsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}excluded_app_ids_json'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      privacyNoticeVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}privacy_notice_version'],
      )!,
      pausedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paused_until'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TrackingSettingsEntriesTable createAlias(String alias) {
    return $TrackingSettingsEntriesTable(attachedDatabase, alias);
  }
}

class TrackingSettingsEntry extends DataClass
    implements Insertable<TrackingSettingsEntry> {
  final String userId;
  final bool trackingEnabled;
  final int captureIntervalMinutes;
  final int idleThresholdMinutes;
  final bool launchAtLogin;
  final bool captureAllDisplays;
  final bool diagnosticsEnabled;
  final String excludedAppIdsJson;
  final bool onboardingComplete;
  final int privacyNoticeVersion;
  final DateTime? pausedUntil;
  final DateTime updatedAt;
  const TrackingSettingsEntry({
    required this.userId,
    required this.trackingEnabled,
    required this.captureIntervalMinutes,
    required this.idleThresholdMinutes,
    required this.launchAtLogin,
    required this.captureAllDisplays,
    required this.diagnosticsEnabled,
    required this.excludedAppIdsJson,
    required this.onboardingComplete,
    required this.privacyNoticeVersion,
    this.pausedUntil,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['tracking_enabled'] = Variable<bool>(trackingEnabled);
    map['capture_interval_minutes'] = Variable<int>(captureIntervalMinutes);
    map['idle_threshold_minutes'] = Variable<int>(idleThresholdMinutes);
    map['launch_at_login'] = Variable<bool>(launchAtLogin);
    map['capture_all_displays'] = Variable<bool>(captureAllDisplays);
    map['diagnostics_enabled'] = Variable<bool>(diagnosticsEnabled);
    map['excluded_app_ids_json'] = Variable<String>(excludedAppIdsJson);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['privacy_notice_version'] = Variable<int>(privacyNoticeVersion);
    if (!nullToAbsent || pausedUntil != null) {
      map['paused_until'] = Variable<DateTime>(pausedUntil);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TrackingSettingsEntriesCompanion toCompanion(bool nullToAbsent) {
    return TrackingSettingsEntriesCompanion(
      userId: Value(userId),
      trackingEnabled: Value(trackingEnabled),
      captureIntervalMinutes: Value(captureIntervalMinutes),
      idleThresholdMinutes: Value(idleThresholdMinutes),
      launchAtLogin: Value(launchAtLogin),
      captureAllDisplays: Value(captureAllDisplays),
      diagnosticsEnabled: Value(diagnosticsEnabled),
      excludedAppIdsJson: Value(excludedAppIdsJson),
      onboardingComplete: Value(onboardingComplete),
      privacyNoticeVersion: Value(privacyNoticeVersion),
      pausedUntil: pausedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(pausedUntil),
      updatedAt: Value(updatedAt),
    );
  }

  factory TrackingSettingsEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackingSettingsEntry(
      userId: serializer.fromJson<String>(json['userId']),
      trackingEnabled: serializer.fromJson<bool>(json['trackingEnabled']),
      captureIntervalMinutes: serializer.fromJson<int>(
        json['captureIntervalMinutes'],
      ),
      idleThresholdMinutes: serializer.fromJson<int>(
        json['idleThresholdMinutes'],
      ),
      launchAtLogin: serializer.fromJson<bool>(json['launchAtLogin']),
      captureAllDisplays: serializer.fromJson<bool>(json['captureAllDisplays']),
      diagnosticsEnabled: serializer.fromJson<bool>(json['diagnosticsEnabled']),
      excludedAppIdsJson: serializer.fromJson<String>(
        json['excludedAppIdsJson'],
      ),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      privacyNoticeVersion: serializer.fromJson<int>(
        json['privacyNoticeVersion'],
      ),
      pausedUntil: serializer.fromJson<DateTime?>(json['pausedUntil']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'trackingEnabled': serializer.toJson<bool>(trackingEnabled),
      'captureIntervalMinutes': serializer.toJson<int>(captureIntervalMinutes),
      'idleThresholdMinutes': serializer.toJson<int>(idleThresholdMinutes),
      'launchAtLogin': serializer.toJson<bool>(launchAtLogin),
      'captureAllDisplays': serializer.toJson<bool>(captureAllDisplays),
      'diagnosticsEnabled': serializer.toJson<bool>(diagnosticsEnabled),
      'excludedAppIdsJson': serializer.toJson<String>(excludedAppIdsJson),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'privacyNoticeVersion': serializer.toJson<int>(privacyNoticeVersion),
      'pausedUntil': serializer.toJson<DateTime?>(pausedUntil),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TrackingSettingsEntry copyWith({
    String? userId,
    bool? trackingEnabled,
    int? captureIntervalMinutes,
    int? idleThresholdMinutes,
    bool? launchAtLogin,
    bool? captureAllDisplays,
    bool? diagnosticsEnabled,
    String? excludedAppIdsJson,
    bool? onboardingComplete,
    int? privacyNoticeVersion,
    Value<DateTime?> pausedUntil = const Value.absent(),
    DateTime? updatedAt,
  }) => TrackingSettingsEntry(
    userId: userId ?? this.userId,
    trackingEnabled: trackingEnabled ?? this.trackingEnabled,
    captureIntervalMinutes:
        captureIntervalMinutes ?? this.captureIntervalMinutes,
    idleThresholdMinutes: idleThresholdMinutes ?? this.idleThresholdMinutes,
    launchAtLogin: launchAtLogin ?? this.launchAtLogin,
    captureAllDisplays: captureAllDisplays ?? this.captureAllDisplays,
    diagnosticsEnabled: diagnosticsEnabled ?? this.diagnosticsEnabled,
    excludedAppIdsJson: excludedAppIdsJson ?? this.excludedAppIdsJson,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    privacyNoticeVersion: privacyNoticeVersion ?? this.privacyNoticeVersion,
    pausedUntil: pausedUntil.present ? pausedUntil.value : this.pausedUntil,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TrackingSettingsEntry copyWithCompanion(
    TrackingSettingsEntriesCompanion data,
  ) {
    return TrackingSettingsEntry(
      userId: data.userId.present ? data.userId.value : this.userId,
      trackingEnabled: data.trackingEnabled.present
          ? data.trackingEnabled.value
          : this.trackingEnabled,
      captureIntervalMinutes: data.captureIntervalMinutes.present
          ? data.captureIntervalMinutes.value
          : this.captureIntervalMinutes,
      idleThresholdMinutes: data.idleThresholdMinutes.present
          ? data.idleThresholdMinutes.value
          : this.idleThresholdMinutes,
      launchAtLogin: data.launchAtLogin.present
          ? data.launchAtLogin.value
          : this.launchAtLogin,
      captureAllDisplays: data.captureAllDisplays.present
          ? data.captureAllDisplays.value
          : this.captureAllDisplays,
      diagnosticsEnabled: data.diagnosticsEnabled.present
          ? data.diagnosticsEnabled.value
          : this.diagnosticsEnabled,
      excludedAppIdsJson: data.excludedAppIdsJson.present
          ? data.excludedAppIdsJson.value
          : this.excludedAppIdsJson,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      privacyNoticeVersion: data.privacyNoticeVersion.present
          ? data.privacyNoticeVersion.value
          : this.privacyNoticeVersion,
      pausedUntil: data.pausedUntil.present
          ? data.pausedUntil.value
          : this.pausedUntil,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackingSettingsEntry(')
          ..write('userId: $userId, ')
          ..write('trackingEnabled: $trackingEnabled, ')
          ..write('captureIntervalMinutes: $captureIntervalMinutes, ')
          ..write('idleThresholdMinutes: $idleThresholdMinutes, ')
          ..write('launchAtLogin: $launchAtLogin, ')
          ..write('captureAllDisplays: $captureAllDisplays, ')
          ..write('diagnosticsEnabled: $diagnosticsEnabled, ')
          ..write('excludedAppIdsJson: $excludedAppIdsJson, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('privacyNoticeVersion: $privacyNoticeVersion, ')
          ..write('pausedUntil: $pausedUntil, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    trackingEnabled,
    captureIntervalMinutes,
    idleThresholdMinutes,
    launchAtLogin,
    captureAllDisplays,
    diagnosticsEnabled,
    excludedAppIdsJson,
    onboardingComplete,
    privacyNoticeVersion,
    pausedUntil,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackingSettingsEntry &&
          other.userId == this.userId &&
          other.trackingEnabled == this.trackingEnabled &&
          other.captureIntervalMinutes == this.captureIntervalMinutes &&
          other.idleThresholdMinutes == this.idleThresholdMinutes &&
          other.launchAtLogin == this.launchAtLogin &&
          other.captureAllDisplays == this.captureAllDisplays &&
          other.diagnosticsEnabled == this.diagnosticsEnabled &&
          other.excludedAppIdsJson == this.excludedAppIdsJson &&
          other.onboardingComplete == this.onboardingComplete &&
          other.privacyNoticeVersion == this.privacyNoticeVersion &&
          other.pausedUntil == this.pausedUntil &&
          other.updatedAt == this.updatedAt);
}

class TrackingSettingsEntriesCompanion
    extends UpdateCompanion<TrackingSettingsEntry> {
  final Value<String> userId;
  final Value<bool> trackingEnabled;
  final Value<int> captureIntervalMinutes;
  final Value<int> idleThresholdMinutes;
  final Value<bool> launchAtLogin;
  final Value<bool> captureAllDisplays;
  final Value<bool> diagnosticsEnabled;
  final Value<String> excludedAppIdsJson;
  final Value<bool> onboardingComplete;
  final Value<int> privacyNoticeVersion;
  final Value<DateTime?> pausedUntil;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TrackingSettingsEntriesCompanion({
    this.userId = const Value.absent(),
    this.trackingEnabled = const Value.absent(),
    this.captureIntervalMinutes = const Value.absent(),
    this.idleThresholdMinutes = const Value.absent(),
    this.launchAtLogin = const Value.absent(),
    this.captureAllDisplays = const Value.absent(),
    this.diagnosticsEnabled = const Value.absent(),
    this.excludedAppIdsJson = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.privacyNoticeVersion = const Value.absent(),
    this.pausedUntil = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrackingSettingsEntriesCompanion.insert({
    required String userId,
    this.trackingEnabled = const Value.absent(),
    this.captureIntervalMinutes = const Value.absent(),
    this.idleThresholdMinutes = const Value.absent(),
    this.launchAtLogin = const Value.absent(),
    this.captureAllDisplays = const Value.absent(),
    this.diagnosticsEnabled = const Value.absent(),
    this.excludedAppIdsJson = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.privacyNoticeVersion = const Value.absent(),
    this.pausedUntil = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       updatedAt = Value(updatedAt);
  static Insertable<TrackingSettingsEntry> custom({
    Expression<String>? userId,
    Expression<bool>? trackingEnabled,
    Expression<int>? captureIntervalMinutes,
    Expression<int>? idleThresholdMinutes,
    Expression<bool>? launchAtLogin,
    Expression<bool>? captureAllDisplays,
    Expression<bool>? diagnosticsEnabled,
    Expression<String>? excludedAppIdsJson,
    Expression<bool>? onboardingComplete,
    Expression<int>? privacyNoticeVersion,
    Expression<DateTime>? pausedUntil,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (trackingEnabled != null) 'tracking_enabled': trackingEnabled,
      if (captureIntervalMinutes != null)
        'capture_interval_minutes': captureIntervalMinutes,
      if (idleThresholdMinutes != null)
        'idle_threshold_minutes': idleThresholdMinutes,
      if (launchAtLogin != null) 'launch_at_login': launchAtLogin,
      if (captureAllDisplays != null)
        'capture_all_displays': captureAllDisplays,
      if (diagnosticsEnabled != null) 'diagnostics_enabled': diagnosticsEnabled,
      if (excludedAppIdsJson != null)
        'excluded_app_ids_json': excludedAppIdsJson,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (privacyNoticeVersion != null)
        'privacy_notice_version': privacyNoticeVersion,
      if (pausedUntil != null) 'paused_until': pausedUntil,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrackingSettingsEntriesCompanion copyWith({
    Value<String>? userId,
    Value<bool>? trackingEnabled,
    Value<int>? captureIntervalMinutes,
    Value<int>? idleThresholdMinutes,
    Value<bool>? launchAtLogin,
    Value<bool>? captureAllDisplays,
    Value<bool>? diagnosticsEnabled,
    Value<String>? excludedAppIdsJson,
    Value<bool>? onboardingComplete,
    Value<int>? privacyNoticeVersion,
    Value<DateTime?>? pausedUntil,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TrackingSettingsEntriesCompanion(
      userId: userId ?? this.userId,
      trackingEnabled: trackingEnabled ?? this.trackingEnabled,
      captureIntervalMinutes:
          captureIntervalMinutes ?? this.captureIntervalMinutes,
      idleThresholdMinutes: idleThresholdMinutes ?? this.idleThresholdMinutes,
      launchAtLogin: launchAtLogin ?? this.launchAtLogin,
      captureAllDisplays: captureAllDisplays ?? this.captureAllDisplays,
      diagnosticsEnabled: diagnosticsEnabled ?? this.diagnosticsEnabled,
      excludedAppIdsJson: excludedAppIdsJson ?? this.excludedAppIdsJson,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      privacyNoticeVersion: privacyNoticeVersion ?? this.privacyNoticeVersion,
      pausedUntil: pausedUntil ?? this.pausedUntil,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (trackingEnabled.present) {
      map['tracking_enabled'] = Variable<bool>(trackingEnabled.value);
    }
    if (captureIntervalMinutes.present) {
      map['capture_interval_minutes'] = Variable<int>(
        captureIntervalMinutes.value,
      );
    }
    if (idleThresholdMinutes.present) {
      map['idle_threshold_minutes'] = Variable<int>(idleThresholdMinutes.value);
    }
    if (launchAtLogin.present) {
      map['launch_at_login'] = Variable<bool>(launchAtLogin.value);
    }
    if (captureAllDisplays.present) {
      map['capture_all_displays'] = Variable<bool>(captureAllDisplays.value);
    }
    if (diagnosticsEnabled.present) {
      map['diagnostics_enabled'] = Variable<bool>(diagnosticsEnabled.value);
    }
    if (excludedAppIdsJson.present) {
      map['excluded_app_ids_json'] = Variable<String>(excludedAppIdsJson.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (privacyNoticeVersion.present) {
      map['privacy_notice_version'] = Variable<int>(privacyNoticeVersion.value);
    }
    if (pausedUntil.present) {
      map['paused_until'] = Variable<DateTime>(pausedUntil.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackingSettingsEntriesCompanion(')
          ..write('userId: $userId, ')
          ..write('trackingEnabled: $trackingEnabled, ')
          ..write('captureIntervalMinutes: $captureIntervalMinutes, ')
          ..write('idleThresholdMinutes: $idleThresholdMinutes, ')
          ..write('launchAtLogin: $launchAtLogin, ')
          ..write('captureAllDisplays: $captureAllDisplays, ')
          ..write('diagnosticsEnabled: $diagnosticsEnabled, ')
          ..write('excludedAppIdsJson: $excludedAppIdsJson, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('privacyNoticeVersion: $privacyNoticeVersion, ')
          ..write('pausedUntil: $pausedUntil, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MigrationStateEntriesTable extends MigrationStateEntries
    with TableInfo<$MigrationStateEntriesTable, MigrationStateEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MigrationStateEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedSessionCountMeta =
      const VerificationMeta('importedSessionCount');
  @override
  late final GeneratedColumn<int> importedSessionCount = GeneratedColumn<int>(
    'imported_session_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cloudVerifiedEmptyMeta =
      const VerificationMeta('cloudVerifiedEmpty');
  @override
  late final GeneratedColumn<bool> cloudVerifiedEmpty = GeneratedColumn<bool>(
    'cloud_verified_empty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("cloud_verified_empty" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    state,
    importedSessionCount,
    cloudVerifiedEmpty,
    lastError,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'migration_state_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<MigrationStateEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('imported_session_count')) {
      context.handle(
        _importedSessionCountMeta,
        importedSessionCount.isAcceptableOrUnknown(
          data['imported_session_count']!,
          _importedSessionCountMeta,
        ),
      );
    }
    if (data.containsKey('cloud_verified_empty')) {
      context.handle(
        _cloudVerifiedEmptyMeta,
        cloudVerifiedEmpty.isAcceptableOrUnknown(
          data['cloud_verified_empty']!,
          _cloudVerifiedEmptyMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  MigrationStateEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MigrationStateEntry(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      importedSessionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}imported_session_count'],
      )!,
      cloudVerifiedEmpty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}cloud_verified_empty'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MigrationStateEntriesTable createAlias(String alias) {
    return $MigrationStateEntriesTable(attachedDatabase, alias);
  }
}

class MigrationStateEntry extends DataClass
    implements Insertable<MigrationStateEntry> {
  final String userId;
  final String state;
  final int importedSessionCount;
  final bool cloudVerifiedEmpty;
  final String? lastError;
  final DateTime updatedAt;
  const MigrationStateEntry({
    required this.userId,
    required this.state,
    required this.importedSessionCount,
    required this.cloudVerifiedEmpty,
    this.lastError,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['state'] = Variable<String>(state);
    map['imported_session_count'] = Variable<int>(importedSessionCount);
    map['cloud_verified_empty'] = Variable<bool>(cloudVerifiedEmpty);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MigrationStateEntriesCompanion toCompanion(bool nullToAbsent) {
    return MigrationStateEntriesCompanion(
      userId: Value(userId),
      state: Value(state),
      importedSessionCount: Value(importedSessionCount),
      cloudVerifiedEmpty: Value(cloudVerifiedEmpty),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      updatedAt: Value(updatedAt),
    );
  }

  factory MigrationStateEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MigrationStateEntry(
      userId: serializer.fromJson<String>(json['userId']),
      state: serializer.fromJson<String>(json['state']),
      importedSessionCount: serializer.fromJson<int>(
        json['importedSessionCount'],
      ),
      cloudVerifiedEmpty: serializer.fromJson<bool>(json['cloudVerifiedEmpty']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'state': serializer.toJson<String>(state),
      'importedSessionCount': serializer.toJson<int>(importedSessionCount),
      'cloudVerifiedEmpty': serializer.toJson<bool>(cloudVerifiedEmpty),
      'lastError': serializer.toJson<String?>(lastError),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MigrationStateEntry copyWith({
    String? userId,
    String? state,
    int? importedSessionCount,
    bool? cloudVerifiedEmpty,
    Value<String?> lastError = const Value.absent(),
    DateTime? updatedAt,
  }) => MigrationStateEntry(
    userId: userId ?? this.userId,
    state: state ?? this.state,
    importedSessionCount: importedSessionCount ?? this.importedSessionCount,
    cloudVerifiedEmpty: cloudVerifiedEmpty ?? this.cloudVerifiedEmpty,
    lastError: lastError.present ? lastError.value : this.lastError,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MigrationStateEntry copyWithCompanion(MigrationStateEntriesCompanion data) {
    return MigrationStateEntry(
      userId: data.userId.present ? data.userId.value : this.userId,
      state: data.state.present ? data.state.value : this.state,
      importedSessionCount: data.importedSessionCount.present
          ? data.importedSessionCount.value
          : this.importedSessionCount,
      cloudVerifiedEmpty: data.cloudVerifiedEmpty.present
          ? data.cloudVerifiedEmpty.value
          : this.cloudVerifiedEmpty,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MigrationStateEntry(')
          ..write('userId: $userId, ')
          ..write('state: $state, ')
          ..write('importedSessionCount: $importedSessionCount, ')
          ..write('cloudVerifiedEmpty: $cloudVerifiedEmpty, ')
          ..write('lastError: $lastError, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    state,
    importedSessionCount,
    cloudVerifiedEmpty,
    lastError,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MigrationStateEntry &&
          other.userId == this.userId &&
          other.state == this.state &&
          other.importedSessionCount == this.importedSessionCount &&
          other.cloudVerifiedEmpty == this.cloudVerifiedEmpty &&
          other.lastError == this.lastError &&
          other.updatedAt == this.updatedAt);
}

class MigrationStateEntriesCompanion
    extends UpdateCompanion<MigrationStateEntry> {
  final Value<String> userId;
  final Value<String> state;
  final Value<int> importedSessionCount;
  final Value<bool> cloudVerifiedEmpty;
  final Value<String?> lastError;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MigrationStateEntriesCompanion({
    this.userId = const Value.absent(),
    this.state = const Value.absent(),
    this.importedSessionCount = const Value.absent(),
    this.cloudVerifiedEmpty = const Value.absent(),
    this.lastError = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MigrationStateEntriesCompanion.insert({
    required String userId,
    required String state,
    this.importedSessionCount = const Value.absent(),
    this.cloudVerifiedEmpty = const Value.absent(),
    this.lastError = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       state = Value(state),
       updatedAt = Value(updatedAt);
  static Insertable<MigrationStateEntry> custom({
    Expression<String>? userId,
    Expression<String>? state,
    Expression<int>? importedSessionCount,
    Expression<bool>? cloudVerifiedEmpty,
    Expression<String>? lastError,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (state != null) 'state': state,
      if (importedSessionCount != null)
        'imported_session_count': importedSessionCount,
      if (cloudVerifiedEmpty != null)
        'cloud_verified_empty': cloudVerifiedEmpty,
      if (lastError != null) 'last_error': lastError,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MigrationStateEntriesCompanion copyWith({
    Value<String>? userId,
    Value<String>? state,
    Value<int>? importedSessionCount,
    Value<bool>? cloudVerifiedEmpty,
    Value<String?>? lastError,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MigrationStateEntriesCompanion(
      userId: userId ?? this.userId,
      state: state ?? this.state,
      importedSessionCount: importedSessionCount ?? this.importedSessionCount,
      cloudVerifiedEmpty: cloudVerifiedEmpty ?? this.cloudVerifiedEmpty,
      lastError: lastError ?? this.lastError,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (importedSessionCount.present) {
      map['imported_session_count'] = Variable<int>(importedSessionCount.value);
    }
    if (cloudVerifiedEmpty.present) {
      map['cloud_verified_empty'] = Variable<bool>(cloudVerifiedEmpty.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MigrationStateEntriesCompanion(')
          ..write('userId: $userId, ')
          ..write('state: $state, ')
          ..write('importedSessionCount: $importedSessionCount, ')
          ..write('cloudVerifiedEmpty: $cloudVerifiedEmpty, ')
          ..write('lastError: $lastError, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiagnosticsCounterEntriesTable extends DiagnosticsCounterEntries
    with TableInfo<$DiagnosticsCounterEntriesTable, DiagnosticsCounterEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiagnosticsCounterEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayUtcMeta = const VerificationMeta('dayUtc');
  @override
  late final GeneratedColumn<String> dayUtc = GeneratedColumn<String>(
    'day_utc',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventMeta = const VerificationMeta('event');
  @override
  late final GeneratedColumn<String> event = GeneratedColumn<String>(
    'event',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _outcomeMeta = const VerificationMeta(
    'outcome',
  );
  @override
  late final GeneratedColumn<String> outcome = GeneratedColumn<String>(
    'outcome',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationBucketMeta = const VerificationMeta(
    'durationBucket',
  );
  @override
  late final GeneratedColumn<String> durationBucket = GeneratedColumn<String>(
    'duration_bucket',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    dayUtc,
    event,
    outcome,
    durationBucket,
    count,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diagnostics_counter_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiagnosticsCounterEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day_utc')) {
      context.handle(
        _dayUtcMeta,
        dayUtc.isAcceptableOrUnknown(data['day_utc']!, _dayUtcMeta),
      );
    } else if (isInserting) {
      context.missing(_dayUtcMeta);
    }
    if (data.containsKey('event')) {
      context.handle(
        _eventMeta,
        event.isAcceptableOrUnknown(data['event']!, _eventMeta),
      );
    } else if (isInserting) {
      context.missing(_eventMeta);
    }
    if (data.containsKey('outcome')) {
      context.handle(
        _outcomeMeta,
        outcome.isAcceptableOrUnknown(data['outcome']!, _outcomeMeta),
      );
    } else if (isInserting) {
      context.missing(_outcomeMeta);
    }
    if (data.containsKey('duration_bucket')) {
      context.handle(
        _durationBucketMeta,
        durationBucket.isAcceptableOrUnknown(
          data['duration_bucket']!,
          _durationBucketMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationBucketMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {
    dayUtc,
    event,
    outcome,
    durationBucket,
  };
  @override
  DiagnosticsCounterEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiagnosticsCounterEntry(
      dayUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_utc'],
      )!,
      event: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event'],
      )!,
      outcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}outcome'],
      )!,
      durationBucket: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration_bucket'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
    );
  }

  @override
  $DiagnosticsCounterEntriesTable createAlias(String alias) {
    return $DiagnosticsCounterEntriesTable(attachedDatabase, alias);
  }
}

class DiagnosticsCounterEntry extends DataClass
    implements Insertable<DiagnosticsCounterEntry> {
  final String dayUtc;
  final String event;
  final String outcome;
  final String durationBucket;
  final int count;
  const DiagnosticsCounterEntry({
    required this.dayUtc,
    required this.event,
    required this.outcome,
    required this.durationBucket,
    required this.count,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day_utc'] = Variable<String>(dayUtc);
    map['event'] = Variable<String>(event);
    map['outcome'] = Variable<String>(outcome);
    map['duration_bucket'] = Variable<String>(durationBucket);
    map['count'] = Variable<int>(count);
    return map;
  }

  DiagnosticsCounterEntriesCompanion toCompanion(bool nullToAbsent) {
    return DiagnosticsCounterEntriesCompanion(
      dayUtc: Value(dayUtc),
      event: Value(event),
      outcome: Value(outcome),
      durationBucket: Value(durationBucket),
      count: Value(count),
    );
  }

  factory DiagnosticsCounterEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiagnosticsCounterEntry(
      dayUtc: serializer.fromJson<String>(json['dayUtc']),
      event: serializer.fromJson<String>(json['event']),
      outcome: serializer.fromJson<String>(json['outcome']),
      durationBucket: serializer.fromJson<String>(json['durationBucket']),
      count: serializer.fromJson<int>(json['count']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dayUtc': serializer.toJson<String>(dayUtc),
      'event': serializer.toJson<String>(event),
      'outcome': serializer.toJson<String>(outcome),
      'durationBucket': serializer.toJson<String>(durationBucket),
      'count': serializer.toJson<int>(count),
    };
  }

  DiagnosticsCounterEntry copyWith({
    String? dayUtc,
    String? event,
    String? outcome,
    String? durationBucket,
    int? count,
  }) => DiagnosticsCounterEntry(
    dayUtc: dayUtc ?? this.dayUtc,
    event: event ?? this.event,
    outcome: outcome ?? this.outcome,
    durationBucket: durationBucket ?? this.durationBucket,
    count: count ?? this.count,
  );
  DiagnosticsCounterEntry copyWithCompanion(
    DiagnosticsCounterEntriesCompanion data,
  ) {
    return DiagnosticsCounterEntry(
      dayUtc: data.dayUtc.present ? data.dayUtc.value : this.dayUtc,
      event: data.event.present ? data.event.value : this.event,
      outcome: data.outcome.present ? data.outcome.value : this.outcome,
      durationBucket: data.durationBucket.present
          ? data.durationBucket.value
          : this.durationBucket,
      count: data.count.present ? data.count.value : this.count,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiagnosticsCounterEntry(')
          ..write('dayUtc: $dayUtc, ')
          ..write('event: $event, ')
          ..write('outcome: $outcome, ')
          ..write('durationBucket: $durationBucket, ')
          ..write('count: $count')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(dayUtc, event, outcome, durationBucket, count);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiagnosticsCounterEntry &&
          other.dayUtc == this.dayUtc &&
          other.event == this.event &&
          other.outcome == this.outcome &&
          other.durationBucket == this.durationBucket &&
          other.count == this.count);
}

class DiagnosticsCounterEntriesCompanion
    extends UpdateCompanion<DiagnosticsCounterEntry> {
  final Value<String> dayUtc;
  final Value<String> event;
  final Value<String> outcome;
  final Value<String> durationBucket;
  final Value<int> count;
  final Value<int> rowid;
  const DiagnosticsCounterEntriesCompanion({
    this.dayUtc = const Value.absent(),
    this.event = const Value.absent(),
    this.outcome = const Value.absent(),
    this.durationBucket = const Value.absent(),
    this.count = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiagnosticsCounterEntriesCompanion.insert({
    required String dayUtc,
    required String event,
    required String outcome,
    required String durationBucket,
    this.count = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : dayUtc = Value(dayUtc),
       event = Value(event),
       outcome = Value(outcome),
       durationBucket = Value(durationBucket);
  static Insertable<DiagnosticsCounterEntry> custom({
    Expression<String>? dayUtc,
    Expression<String>? event,
    Expression<String>? outcome,
    Expression<String>? durationBucket,
    Expression<int>? count,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dayUtc != null) 'day_utc': dayUtc,
      if (event != null) 'event': event,
      if (outcome != null) 'outcome': outcome,
      if (durationBucket != null) 'duration_bucket': durationBucket,
      if (count != null) 'count': count,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiagnosticsCounterEntriesCompanion copyWith({
    Value<String>? dayUtc,
    Value<String>? event,
    Value<String>? outcome,
    Value<String>? durationBucket,
    Value<int>? count,
    Value<int>? rowid,
  }) {
    return DiagnosticsCounterEntriesCompanion(
      dayUtc: dayUtc ?? this.dayUtc,
      event: event ?? this.event,
      outcome: outcome ?? this.outcome,
      durationBucket: durationBucket ?? this.durationBucket,
      count: count ?? this.count,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dayUtc.present) {
      map['day_utc'] = Variable<String>(dayUtc.value);
    }
    if (event.present) {
      map['event'] = Variable<String>(event.value);
    }
    if (outcome.present) {
      map['outcome'] = Variable<String>(outcome.value);
    }
    if (durationBucket.present) {
      map['duration_bucket'] = Variable<String>(durationBucket.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiagnosticsCounterEntriesCompanion(')
          ..write('dayUtc: $dayUtc, ')
          ..write('event: $event, ')
          ..write('outcome: $outcome, ')
          ..write('durationBucket: $durationBucket, ')
          ..write('count: $count, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionEntriesTable sessionEntries = $SessionEntriesTable(this);
  late final $TimerEntriesTable timerEntries = $TimerEntriesTable(this);
  late final $SettingsEntriesTable settingsEntries = $SettingsEntriesTable(
    this,
  );
  late final $AuthEntriesTable authEntries = $AuthEntriesTable(this);
  late final $ActivitySampleEntriesTable activitySampleEntries =
      $ActivitySampleEntriesTable(this);
  late final $ActivityBlockEntriesTable activityBlockEntries =
      $ActivityBlockEntriesTable(this);
  late final $CategoryEntriesTable categoryEntries = $CategoryEntriesTable(
    this,
  );
  late final $CategoryRuleEntriesTable categoryRuleEntries =
      $CategoryRuleEntriesTable(this);
  late final $DailyInsightEntriesTable dailyInsightEntries =
      $DailyInsightEntriesTable(this);
  late final $TrackingSettingsEntriesTable trackingSettingsEntries =
      $TrackingSettingsEntriesTable(this);
  late final $MigrationStateEntriesTable migrationStateEntries =
      $MigrationStateEntriesTable(this);
  late final $DiagnosticsCounterEntriesTable diagnosticsCounterEntries =
      $DiagnosticsCounterEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessionEntries,
    timerEntries,
    settingsEntries,
    authEntries,
    activitySampleEntries,
    activityBlockEntries,
    categoryEntries,
    categoryRuleEntries,
    dailyInsightEntries,
    trackingSettingsEntries,
    migrationStateEntries,
    diagnosticsCounterEntries,
  ];
}

typedef $$SessionEntriesTableCreateCompanionBuilder =
    SessionEntriesCompanion Function({
      required String id,
      required String userId,
      required String cycleId,
      required String phase,
      required String activity,
      required int plannedSeconds,
      required int actualSeconds,
      required DateTime startedAt,
      required DateTime endedAt,
      required String outcome,
      required DateTime updatedAt,
      Value<bool> isDeleted,
      Value<bool> isDirty,
      Value<String?> categoryId,
      Value<String?> categorySource,
      Value<double?> categoryConfidence,
      Value<String> alignment,
      Value<int> rowid,
    });
typedef $$SessionEntriesTableUpdateCompanionBuilder =
    SessionEntriesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> cycleId,
      Value<String> phase,
      Value<String> activity,
      Value<int> plannedSeconds,
      Value<int> actualSeconds,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
      Value<String> outcome,
      Value<DateTime> updatedAt,
      Value<bool> isDeleted,
      Value<bool> isDirty,
      Value<String?> categoryId,
      Value<String?> categorySource,
      Value<double?> categoryConfidence,
      Value<String> alignment,
      Value<int> rowid,
    });

class $$SessionEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SessionEntriesTable> {
  $$SessionEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cycleId => $composableBuilder(
    column: $table.cycleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get actualSeconds => $composableBuilder(
    column: $table.actualSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get categoryConfidence => $composableBuilder(
    column: $table.categoryConfidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alignment => $composableBuilder(
    column: $table.alignment,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionEntriesTable> {
  $$SessionEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cycleId => $composableBuilder(
    column: $table.cycleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get actualSeconds => $composableBuilder(
    column: $table.actualSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get categoryConfidence => $composableBuilder(
    column: $table.categoryConfidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alignment => $composableBuilder(
    column: $table.alignment,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionEntriesTable> {
  $$SessionEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get cycleId =>
      $composableBuilder(column: $table.cycleId, builder: (column) => column);

  GeneratedColumn<String> get phase =>
      $composableBuilder(column: $table.phase, builder: (column) => column);

  GeneratedColumn<String> get activity =>
      $composableBuilder(column: $table.activity, builder: (column) => column);

  GeneratedColumn<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get actualSeconds => $composableBuilder(
    column: $table.actualSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => column,
  );

  GeneratedColumn<double> get categoryConfidence => $composableBuilder(
    column: $table.categoryConfidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alignment =>
      $composableBuilder(column: $table.alignment, builder: (column) => column);
}

class $$SessionEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionEntriesTable,
          SessionEntry,
          $$SessionEntriesTableFilterComposer,
          $$SessionEntriesTableOrderingComposer,
          $$SessionEntriesTableAnnotationComposer,
          $$SessionEntriesTableCreateCompanionBuilder,
          $$SessionEntriesTableUpdateCompanionBuilder,
          (
            SessionEntry,
            BaseReferences<_$AppDatabase, $SessionEntriesTable, SessionEntry>,
          ),
          SessionEntry,
          PrefetchHooks Function()
        > {
  $$SessionEntriesTableTableManager(
    _$AppDatabase db,
    $SessionEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> cycleId = const Value.absent(),
                Value<String> phase = const Value.absent(),
                Value<String> activity = const Value.absent(),
                Value<int> plannedSeconds = const Value.absent(),
                Value<int> actualSeconds = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> categorySource = const Value.absent(),
                Value<double?> categoryConfidence = const Value.absent(),
                Value<String> alignment = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionEntriesCompanion(
                id: id,
                userId: userId,
                cycleId: cycleId,
                phase: phase,
                activity: activity,
                plannedSeconds: plannedSeconds,
                actualSeconds: actualSeconds,
                startedAt: startedAt,
                endedAt: endedAt,
                outcome: outcome,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                isDirty: isDirty,
                categoryId: categoryId,
                categorySource: categorySource,
                categoryConfidence: categoryConfidence,
                alignment: alignment,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String cycleId,
                required String phase,
                required String activity,
                required int plannedSeconds,
                required int actualSeconds,
                required DateTime startedAt,
                required DateTime endedAt,
                required String outcome,
                required DateTime updatedAt,
                Value<bool> isDeleted = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> categorySource = const Value.absent(),
                Value<double?> categoryConfidence = const Value.absent(),
                Value<String> alignment = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionEntriesCompanion.insert(
                id: id,
                userId: userId,
                cycleId: cycleId,
                phase: phase,
                activity: activity,
                plannedSeconds: plannedSeconds,
                actualSeconds: actualSeconds,
                startedAt: startedAt,
                endedAt: endedAt,
                outcome: outcome,
                updatedAt: updatedAt,
                isDeleted: isDeleted,
                isDirty: isDirty,
                categoryId: categoryId,
                categorySource: categorySource,
                categoryConfidence: categoryConfidence,
                alignment: alignment,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionEntriesTable,
      SessionEntry,
      $$SessionEntriesTableFilterComposer,
      $$SessionEntriesTableOrderingComposer,
      $$SessionEntriesTableAnnotationComposer,
      $$SessionEntriesTableCreateCompanionBuilder,
      $$SessionEntriesTableUpdateCompanionBuilder,
      (
        SessionEntry,
        BaseReferences<_$AppDatabase, $SessionEntriesTable, SessionEntry>,
      ),
      SessionEntry,
      PrefetchHooks Function()
    >;
typedef $$TimerEntriesTableCreateCompanionBuilder =
    TimerEntriesCompanion Function({
      required String userId,
      required String state,
      required String phase,
      required String activity,
      required String cycleId,
      required int completedFocusesInCycle,
      required int plannedSeconds,
      required int accumulatedSeconds,
      Value<DateTime?> startedAt,
      Value<DateTime?> deadline,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TimerEntriesTableUpdateCompanionBuilder =
    TimerEntriesCompanion Function({
      Value<String> userId,
      Value<String> state,
      Value<String> phase,
      Value<String> activity,
      Value<String> cycleId,
      Value<int> completedFocusesInCycle,
      Value<int> plannedSeconds,
      Value<int> accumulatedSeconds,
      Value<DateTime?> startedAt,
      Value<DateTime?> deadline,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$TimerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TimerEntriesTable> {
  $$TimerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cycleId => $composableBuilder(
    column: $table.cycleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedFocusesInCycle => $composableBuilder(
    column: $table.completedFocusesInCycle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accumulatedSeconds => $composableBuilder(
    column: $table.accumulatedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TimerEntriesTable> {
  $$TimerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activity => $composableBuilder(
    column: $table.activity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cycleId => $composableBuilder(
    column: $table.cycleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedFocusesInCycle => $composableBuilder(
    column: $table.completedFocusesInCycle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accumulatedSeconds => $composableBuilder(
    column: $table.accumulatedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimerEntriesTable> {
  $$TimerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get phase =>
      $composableBuilder(column: $table.phase, builder: (column) => column);

  GeneratedColumn<String> get activity =>
      $composableBuilder(column: $table.activity, builder: (column) => column);

  GeneratedColumn<String> get cycleId =>
      $composableBuilder(column: $table.cycleId, builder: (column) => column);

  GeneratedColumn<int> get completedFocusesInCycle => $composableBuilder(
    column: $table.completedFocusesInCycle,
    builder: (column) => column,
  );

  GeneratedColumn<int> get plannedSeconds => $composableBuilder(
    column: $table.plannedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get accumulatedSeconds => $composableBuilder(
    column: $table.accumulatedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TimerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimerEntriesTable,
          TimerEntry,
          $$TimerEntriesTableFilterComposer,
          $$TimerEntriesTableOrderingComposer,
          $$TimerEntriesTableAnnotationComposer,
          $$TimerEntriesTableCreateCompanionBuilder,
          $$TimerEntriesTableUpdateCompanionBuilder,
          (
            TimerEntry,
            BaseReferences<_$AppDatabase, $TimerEntriesTable, TimerEntry>,
          ),
          TimerEntry,
          PrefetchHooks Function()
        > {
  $$TimerEntriesTableTableManager(_$AppDatabase db, $TimerEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> phase = const Value.absent(),
                Value<String> activity = const Value.absent(),
                Value<String> cycleId = const Value.absent(),
                Value<int> completedFocusesInCycle = const Value.absent(),
                Value<int> plannedSeconds = const Value.absent(),
                Value<int> accumulatedSeconds = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TimerEntriesCompanion(
                userId: userId,
                state: state,
                phase: phase,
                activity: activity,
                cycleId: cycleId,
                completedFocusesInCycle: completedFocusesInCycle,
                plannedSeconds: plannedSeconds,
                accumulatedSeconds: accumulatedSeconds,
                startedAt: startedAt,
                deadline: deadline,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String state,
                required String phase,
                required String activity,
                required String cycleId,
                required int completedFocusesInCycle,
                required int plannedSeconds,
                required int accumulatedSeconds,
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TimerEntriesCompanion.insert(
                userId: userId,
                state: state,
                phase: phase,
                activity: activity,
                cycleId: cycleId,
                completedFocusesInCycle: completedFocusesInCycle,
                plannedSeconds: plannedSeconds,
                accumulatedSeconds: accumulatedSeconds,
                startedAt: startedAt,
                deadline: deadline,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimerEntriesTable,
      TimerEntry,
      $$TimerEntriesTableFilterComposer,
      $$TimerEntriesTableOrderingComposer,
      $$TimerEntriesTableAnnotationComposer,
      $$TimerEntriesTableCreateCompanionBuilder,
      $$TimerEntriesTableUpdateCompanionBuilder,
      (
        TimerEntry,
        BaseReferences<_$AppDatabase, $TimerEntriesTable, TimerEntry>,
      ),
      TimerEntry,
      PrefetchHooks Function()
    >;
typedef $$SettingsEntriesTableCreateCompanionBuilder =
    SettingsEntriesCompanion Function({
      required String userId,
      Value<int> focusMinutes,
      Value<int> shortBreakMinutes,
      Value<int> longBreakMinutes,
      Value<int> longBreakInterval,
      Value<bool> soundEnabled,
      Value<bool> isDirty,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SettingsEntriesTableUpdateCompanionBuilder =
    SettingsEntriesCompanion Function({
      Value<String> userId,
      Value<int> focusMinutes,
      Value<int> shortBreakMinutes,
      Value<int> longBreakMinutes,
      Value<int> longBreakInterval,
      Value<bool> soundEnabled,
      Value<bool> isDirty,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SettingsEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get focusMinutes => $composableBuilder(
    column: $table.focusMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get shortBreakMinutes => $composableBuilder(
    column: $table.shortBreakMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longBreakMinutes => $composableBuilder(
    column: $table.longBreakMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longBreakInterval => $composableBuilder(
    column: $table.longBreakInterval,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get focusMinutes => $composableBuilder(
    column: $table.focusMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get shortBreakMinutes => $composableBuilder(
    column: $table.shortBreakMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longBreakMinutes => $composableBuilder(
    column: $table.longBreakMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longBreakInterval => $composableBuilder(
    column: $table.longBreakInterval,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsEntriesTable> {
  $$SettingsEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get focusMinutes => $composableBuilder(
    column: $table.focusMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get shortBreakMinutes => $composableBuilder(
    column: $table.shortBreakMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longBreakMinutes => $composableBuilder(
    column: $table.longBreakMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get longBreakInterval => $composableBuilder(
    column: $table.longBreakInterval,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get soundEnabled => $composableBuilder(
    column: $table.soundEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SettingsEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsEntriesTable,
          SettingsEntry,
          $$SettingsEntriesTableFilterComposer,
          $$SettingsEntriesTableOrderingComposer,
          $$SettingsEntriesTableAnnotationComposer,
          $$SettingsEntriesTableCreateCompanionBuilder,
          $$SettingsEntriesTableUpdateCompanionBuilder,
          (
            SettingsEntry,
            BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>,
          ),
          SettingsEntry,
          PrefetchHooks Function()
        > {
  $$SettingsEntriesTableTableManager(
    _$AppDatabase db,
    $SettingsEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<int> focusMinutes = const Value.absent(),
                Value<int> shortBreakMinutes = const Value.absent(),
                Value<int> longBreakMinutes = const Value.absent(),
                Value<int> longBreakInterval = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsEntriesCompanion(
                userId: userId,
                focusMinutes: focusMinutes,
                shortBreakMinutes: shortBreakMinutes,
                longBreakMinutes: longBreakMinutes,
                longBreakInterval: longBreakInterval,
                soundEnabled: soundEnabled,
                isDirty: isDirty,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<int> focusMinutes = const Value.absent(),
                Value<int> shortBreakMinutes = const Value.absent(),
                Value<int> longBreakMinutes = const Value.absent(),
                Value<int> longBreakInterval = const Value.absent(),
                Value<bool> soundEnabled = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SettingsEntriesCompanion.insert(
                userId: userId,
                focusMinutes: focusMinutes,
                shortBreakMinutes: shortBreakMinutes,
                longBreakMinutes: longBreakMinutes,
                longBreakInterval: longBreakInterval,
                soundEnabled: soundEnabled,
                isDirty: isDirty,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsEntriesTable,
      SettingsEntry,
      $$SettingsEntriesTableFilterComposer,
      $$SettingsEntriesTableOrderingComposer,
      $$SettingsEntriesTableAnnotationComposer,
      $$SettingsEntriesTableCreateCompanionBuilder,
      $$SettingsEntriesTableUpdateCompanionBuilder,
      (
        SettingsEntry,
        BaseReferences<_$AppDatabase, $SettingsEntriesTable, SettingsEntry>,
      ),
      SettingsEntry,
      PrefetchHooks Function()
    >;
typedef $$AuthEntriesTableCreateCompanionBuilder =
    AuthEntriesCompanion Function({
      required String userId,
      required String email,
      Value<String> refreshToken,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$AuthEntriesTableUpdateCompanionBuilder =
    AuthEntriesCompanion Function({
      Value<String> userId,
      Value<String> email,
      Value<String> refreshToken,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$AuthEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AuthEntriesTable> {
  $$AuthEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuthEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AuthEntriesTable> {
  $$AuthEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuthEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuthEntriesTable> {
  $$AuthEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get refreshToken => $composableBuilder(
    column: $table.refreshToken,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AuthEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuthEntriesTable,
          AuthEntry,
          $$AuthEntriesTableFilterComposer,
          $$AuthEntriesTableOrderingComposer,
          $$AuthEntriesTableAnnotationComposer,
          $$AuthEntriesTableCreateCompanionBuilder,
          $$AuthEntriesTableUpdateCompanionBuilder,
          (
            AuthEntry,
            BaseReferences<_$AppDatabase, $AuthEntriesTable, AuthEntry>,
          ),
          AuthEntry,
          PrefetchHooks Function()
        > {
  $$AuthEntriesTableTableManager(_$AppDatabase db, $AuthEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuthEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuthEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuthEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> refreshToken = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuthEntriesCompanion(
                userId: userId,
                email: email,
                refreshToken: refreshToken,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String email,
                Value<String> refreshToken = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => AuthEntriesCompanion.insert(
                userId: userId,
                email: email,
                refreshToken: refreshToken,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuthEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuthEntriesTable,
      AuthEntry,
      $$AuthEntriesTableFilterComposer,
      $$AuthEntriesTableOrderingComposer,
      $$AuthEntriesTableAnnotationComposer,
      $$AuthEntriesTableCreateCompanionBuilder,
      $$AuthEntriesTableUpdateCompanionBuilder,
      (AuthEntry, BaseReferences<_$AppDatabase, $AuthEntriesTable, AuthEntry>),
      AuthEntry,
      PrefetchHooks Function()
    >;
typedef $$ActivitySampleEntriesTableCreateCompanionBuilder =
    ActivitySampleEntriesCompanion Function({
      required String id,
      required String userId,
      required DateTime capturedAt,
      required DateTime startedAt,
      required DateTime endedAt,
      required String appId,
      required String appName,
      required String windowTitle,
      Value<String?> activityLabel,
      Value<String?> categoryId,
      Value<String?> categorySource,
      Value<double?> confidence,
      Value<String> secondaryContextJson,
      required String processingState,
      Value<String?> modelVersion,
      Value<String?> promptVersion,
      Value<String?> failureCode,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ActivitySampleEntriesTableUpdateCompanionBuilder =
    ActivitySampleEntriesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<DateTime> capturedAt,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
      Value<String> appId,
      Value<String> appName,
      Value<String> windowTitle,
      Value<String?> activityLabel,
      Value<String?> categoryId,
      Value<String?> categorySource,
      Value<double?> confidence,
      Value<String> secondaryContextJson,
      Value<String> processingState,
      Value<String?> modelVersion,
      Value<String?> promptVersion,
      Value<String?> failureCode,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ActivitySampleEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitySampleEntriesTable> {
  $$ActivitySampleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appId => $composableBuilder(
    column: $table.appId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get windowTitle => $composableBuilder(
    column: $table.windowTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryContextJson => $composableBuilder(
    column: $table.secondaryContextJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get processingState => $composableBuilder(
    column: $table.processingState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivitySampleEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitySampleEntriesTable> {
  $$ActivitySampleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appId => $composableBuilder(
    column: $table.appId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get windowTitle => $composableBuilder(
    column: $table.windowTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryContextJson => $composableBuilder(
    column: $table.secondaryContextJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get processingState => $composableBuilder(
    column: $table.processingState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivitySampleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitySampleEntriesTable> {
  $$ActivitySampleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get capturedAt => $composableBuilder(
    column: $table.capturedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get appId =>
      $composableBuilder(column: $table.appId, builder: (column) => column);

  GeneratedColumn<String> get appName =>
      $composableBuilder(column: $table.appName, builder: (column) => column);

  GeneratedColumn<String> get windowTitle => $composableBuilder(
    column: $table.windowTitle,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryContextJson => $composableBuilder(
    column: $table.secondaryContextJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get processingState => $composableBuilder(
    column: $table.processingState,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get failureCode => $composableBuilder(
    column: $table.failureCode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ActivitySampleEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivitySampleEntriesTable,
          ActivitySampleEntry,
          $$ActivitySampleEntriesTableFilterComposer,
          $$ActivitySampleEntriesTableOrderingComposer,
          $$ActivitySampleEntriesTableAnnotationComposer,
          $$ActivitySampleEntriesTableCreateCompanionBuilder,
          $$ActivitySampleEntriesTableUpdateCompanionBuilder,
          (
            ActivitySampleEntry,
            BaseReferences<
              _$AppDatabase,
              $ActivitySampleEntriesTable,
              ActivitySampleEntry
            >,
          ),
          ActivitySampleEntry,
          PrefetchHooks Function()
        > {
  $$ActivitySampleEntriesTableTableManager(
    _$AppDatabase db,
    $ActivitySampleEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitySampleEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ActivitySampleEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ActivitySampleEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> capturedAt = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<String> appId = const Value.absent(),
                Value<String> appName = const Value.absent(),
                Value<String> windowTitle = const Value.absent(),
                Value<String?> activityLabel = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> categorySource = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<String> secondaryContextJson = const Value.absent(),
                Value<String> processingState = const Value.absent(),
                Value<String?> modelVersion = const Value.absent(),
                Value<String?> promptVersion = const Value.absent(),
                Value<String?> failureCode = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivitySampleEntriesCompanion(
                id: id,
                userId: userId,
                capturedAt: capturedAt,
                startedAt: startedAt,
                endedAt: endedAt,
                appId: appId,
                appName: appName,
                windowTitle: windowTitle,
                activityLabel: activityLabel,
                categoryId: categoryId,
                categorySource: categorySource,
                confidence: confidence,
                secondaryContextJson: secondaryContextJson,
                processingState: processingState,
                modelVersion: modelVersion,
                promptVersion: promptVersion,
                failureCode: failureCode,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required DateTime capturedAt,
                required DateTime startedAt,
                required DateTime endedAt,
                required String appId,
                required String appName,
                required String windowTitle,
                Value<String?> activityLabel = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> categorySource = const Value.absent(),
                Value<double?> confidence = const Value.absent(),
                Value<String> secondaryContextJson = const Value.absent(),
                required String processingState,
                Value<String?> modelVersion = const Value.absent(),
                Value<String?> promptVersion = const Value.absent(),
                Value<String?> failureCode = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ActivitySampleEntriesCompanion.insert(
                id: id,
                userId: userId,
                capturedAt: capturedAt,
                startedAt: startedAt,
                endedAt: endedAt,
                appId: appId,
                appName: appName,
                windowTitle: windowTitle,
                activityLabel: activityLabel,
                categoryId: categoryId,
                categorySource: categorySource,
                confidence: confidence,
                secondaryContextJson: secondaryContextJson,
                processingState: processingState,
                modelVersion: modelVersion,
                promptVersion: promptVersion,
                failureCode: failureCode,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivitySampleEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivitySampleEntriesTable,
      ActivitySampleEntry,
      $$ActivitySampleEntriesTableFilterComposer,
      $$ActivitySampleEntriesTableOrderingComposer,
      $$ActivitySampleEntriesTableAnnotationComposer,
      $$ActivitySampleEntriesTableCreateCompanionBuilder,
      $$ActivitySampleEntriesTableUpdateCompanionBuilder,
      (
        ActivitySampleEntry,
        BaseReferences<
          _$AppDatabase,
          $ActivitySampleEntriesTable,
          ActivitySampleEntry
        >,
      ),
      ActivitySampleEntry,
      PrefetchHooks Function()
    >;
typedef $$ActivityBlockEntriesTableCreateCompanionBuilder =
    ActivityBlockEntriesCompanion Function({
      required String id,
      required String userId,
      required DateTime startedAt,
      required DateTime endedAt,
      required String appId,
      required String appName,
      required String activityLabel,
      Value<String?> categoryId,
      required String categorySource,
      required double confidence,
      required int sampleCount,
      Value<String> secondaryContextJson,
      Value<int> rowid,
    });
typedef $$ActivityBlockEntriesTableUpdateCompanionBuilder =
    ActivityBlockEntriesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<DateTime> startedAt,
      Value<DateTime> endedAt,
      Value<String> appId,
      Value<String> appName,
      Value<String> activityLabel,
      Value<String?> categoryId,
      Value<String> categorySource,
      Value<double> confidence,
      Value<int> sampleCount,
      Value<String> secondaryContextJson,
      Value<int> rowid,
    });

class $$ActivityBlockEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityBlockEntriesTable> {
  $$ActivityBlockEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appId => $composableBuilder(
    column: $table.appId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryContextJson => $composableBuilder(
    column: $table.secondaryContextJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityBlockEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityBlockEntriesTable> {
  $$ActivityBlockEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appId => $composableBuilder(
    column: $table.appId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appName => $composableBuilder(
    column: $table.appName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryContextJson => $composableBuilder(
    column: $table.secondaryContextJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityBlockEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityBlockEntriesTable> {
  $$ActivityBlockEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get appId =>
      $composableBuilder(column: $table.appId, builder: (column) => column);

  GeneratedColumn<String> get appName =>
      $composableBuilder(column: $table.appName, builder: (column) => column);

  GeneratedColumn<String> get activityLabel => $composableBuilder(
    column: $table.activityLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categorySource => $composableBuilder(
    column: $table.categorySource,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryContextJson => $composableBuilder(
    column: $table.secondaryContextJson,
    builder: (column) => column,
  );
}

class $$ActivityBlockEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityBlockEntriesTable,
          ActivityBlockEntry,
          $$ActivityBlockEntriesTableFilterComposer,
          $$ActivityBlockEntriesTableOrderingComposer,
          $$ActivityBlockEntriesTableAnnotationComposer,
          $$ActivityBlockEntriesTableCreateCompanionBuilder,
          $$ActivityBlockEntriesTableUpdateCompanionBuilder,
          (
            ActivityBlockEntry,
            BaseReferences<
              _$AppDatabase,
              $ActivityBlockEntriesTable,
              ActivityBlockEntry
            >,
          ),
          ActivityBlockEntry,
          PrefetchHooks Function()
        > {
  $$ActivityBlockEntriesTableTableManager(
    _$AppDatabase db,
    $ActivityBlockEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityBlockEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityBlockEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ActivityBlockEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> endedAt = const Value.absent(),
                Value<String> appId = const Value.absent(),
                Value<String> appName = const Value.absent(),
                Value<String> activityLabel = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String> categorySource = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<int> sampleCount = const Value.absent(),
                Value<String> secondaryContextJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityBlockEntriesCompanion(
                id: id,
                userId: userId,
                startedAt: startedAt,
                endedAt: endedAt,
                appId: appId,
                appName: appName,
                activityLabel: activityLabel,
                categoryId: categoryId,
                categorySource: categorySource,
                confidence: confidence,
                sampleCount: sampleCount,
                secondaryContextJson: secondaryContextJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required DateTime startedAt,
                required DateTime endedAt,
                required String appId,
                required String appName,
                required String activityLabel,
                Value<String?> categoryId = const Value.absent(),
                required String categorySource,
                required double confidence,
                required int sampleCount,
                Value<String> secondaryContextJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityBlockEntriesCompanion.insert(
                id: id,
                userId: userId,
                startedAt: startedAt,
                endedAt: endedAt,
                appId: appId,
                appName: appName,
                activityLabel: activityLabel,
                categoryId: categoryId,
                categorySource: categorySource,
                confidence: confidence,
                sampleCount: sampleCount,
                secondaryContextJson: secondaryContextJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityBlockEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityBlockEntriesTable,
      ActivityBlockEntry,
      $$ActivityBlockEntriesTableFilterComposer,
      $$ActivityBlockEntriesTableOrderingComposer,
      $$ActivityBlockEntriesTableAnnotationComposer,
      $$ActivityBlockEntriesTableCreateCompanionBuilder,
      $$ActivityBlockEntriesTableUpdateCompanionBuilder,
      (
        ActivityBlockEntry,
        BaseReferences<
          _$AppDatabase,
          $ActivityBlockEntriesTable,
          ActivityBlockEntry
        >,
      ),
      ActivityBlockEntry,
      PrefetchHooks Function()
    >;
typedef $$CategoryEntriesTableCreateCompanionBuilder =
    CategoryEntriesCompanion Function({
      required String id,
      required String userId,
      required String name,
      required String description,
      required int colorValue,
      required int sortOrder,
      Value<bool> isArchived,
      Value<bool> isSystem,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CategoryEntriesTableUpdateCompanionBuilder =
    CategoryEntriesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> name,
      Value<String> description,
      Value<int> colorValue,
      Value<int> sortOrder,
      Value<bool> isArchived,
      Value<bool> isSystem,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CategoryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryEntriesTable> {
  $$CategoryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryEntriesTable> {
  $$CategoryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSystem => $composableBuilder(
    column: $table.isSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryEntriesTable> {
  $$CategoryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorValue => $composableBuilder(
    column: $table.colorValue,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSystem =>
      $composableBuilder(column: $table.isSystem, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryEntriesTable,
          CategoryEntry,
          $$CategoryEntriesTableFilterComposer,
          $$CategoryEntriesTableOrderingComposer,
          $$CategoryEntriesTableAnnotationComposer,
          $$CategoryEntriesTableCreateCompanionBuilder,
          $$CategoryEntriesTableUpdateCompanionBuilder,
          (
            CategoryEntry,
            BaseReferences<_$AppDatabase, $CategoryEntriesTable, CategoryEntry>,
          ),
          CategoryEntry,
          PrefetchHooks Function()
        > {
  $$CategoryEntriesTableTableManager(
    _$AppDatabase db,
    $CategoryEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> colorValue = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryEntriesCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                colorValue: colorValue,
                sortOrder: sortOrder,
                isArchived: isArchived,
                isSystem: isSystem,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String name,
                required String description,
                required int colorValue,
                required int sortOrder,
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isSystem = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoryEntriesCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                colorValue: colorValue,
                sortOrder: sortOrder,
                isArchived: isArchived,
                isSystem: isSystem,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryEntriesTable,
      CategoryEntry,
      $$CategoryEntriesTableFilterComposer,
      $$CategoryEntriesTableOrderingComposer,
      $$CategoryEntriesTableAnnotationComposer,
      $$CategoryEntriesTableCreateCompanionBuilder,
      $$CategoryEntriesTableUpdateCompanionBuilder,
      (
        CategoryEntry,
        BaseReferences<_$AppDatabase, $CategoryEntriesTable, CategoryEntry>,
      ),
      CategoryEntry,
      PrefetchHooks Function()
    >;
typedef $$CategoryRuleEntriesTableCreateCompanionBuilder =
    CategoryRuleEntriesCompanion Function({
      required String id,
      required String userId,
      required String appId,
      Value<String?> titleContains,
      required String categoryId,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CategoryRuleEntriesTableUpdateCompanionBuilder =
    CategoryRuleEntriesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> appId,
      Value<String?> titleContains,
      Value<String> categoryId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CategoryRuleEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryRuleEntriesTable> {
  $$CategoryRuleEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appId => $composableBuilder(
    column: $table.appId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleContains => $composableBuilder(
    column: $table.titleContains,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoryRuleEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryRuleEntriesTable> {
  $$CategoryRuleEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appId => $composableBuilder(
    column: $table.appId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleContains => $composableBuilder(
    column: $table.titleContains,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryRuleEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryRuleEntriesTable> {
  $$CategoryRuleEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get appId =>
      $composableBuilder(column: $table.appId, builder: (column) => column);

  GeneratedColumn<String> get titleContains => $composableBuilder(
    column: $table.titleContains,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoryRuleEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryRuleEntriesTable,
          CategoryRuleEntry,
          $$CategoryRuleEntriesTableFilterComposer,
          $$CategoryRuleEntriesTableOrderingComposer,
          $$CategoryRuleEntriesTableAnnotationComposer,
          $$CategoryRuleEntriesTableCreateCompanionBuilder,
          $$CategoryRuleEntriesTableUpdateCompanionBuilder,
          (
            CategoryRuleEntry,
            BaseReferences<
              _$AppDatabase,
              $CategoryRuleEntriesTable,
              CategoryRuleEntry
            >,
          ),
          CategoryRuleEntry,
          PrefetchHooks Function()
        > {
  $$CategoryRuleEntriesTableTableManager(
    _$AppDatabase db,
    $CategoryRuleEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryRuleEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryRuleEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CategoryRuleEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> appId = const Value.absent(),
                Value<String?> titleContains = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryRuleEntriesCompanion(
                id: id,
                userId: userId,
                appId: appId,
                titleContains: titleContains,
                categoryId: categoryId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String appId,
                Value<String?> titleContains = const Value.absent(),
                required String categoryId,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoryRuleEntriesCompanion.insert(
                id: id,
                userId: userId,
                appId: appId,
                titleContains: titleContains,
                categoryId: categoryId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoryRuleEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryRuleEntriesTable,
      CategoryRuleEntry,
      $$CategoryRuleEntriesTableFilterComposer,
      $$CategoryRuleEntriesTableOrderingComposer,
      $$CategoryRuleEntriesTableAnnotationComposer,
      $$CategoryRuleEntriesTableCreateCompanionBuilder,
      $$CategoryRuleEntriesTableUpdateCompanionBuilder,
      (
        CategoryRuleEntry,
        BaseReferences<
          _$AppDatabase,
          $CategoryRuleEntriesTable,
          CategoryRuleEntry
        >,
      ),
      CategoryRuleEntry,
      PrefetchHooks Function()
    >;
typedef $$DailyInsightEntriesTableCreateCompanionBuilder =
    DailyInsightEntriesCompanion Function({
      required String userId,
      required String localDate,
      required String summary,
      required String patternsJson,
      required String discrepanciesJson,
      required String modelVersion,
      required String promptVersion,
      required DateTime sourceUpdatedAt,
      required DateTime generatedAt,
      Value<int> rowid,
    });
typedef $$DailyInsightEntriesTableUpdateCompanionBuilder =
    DailyInsightEntriesCompanion Function({
      Value<String> userId,
      Value<String> localDate,
      Value<String> summary,
      Value<String> patternsJson,
      Value<String> discrepanciesJson,
      Value<String> modelVersion,
      Value<String> promptVersion,
      Value<DateTime> sourceUpdatedAt,
      Value<DateTime> generatedAt,
      Value<int> rowid,
    });

class $$DailyInsightEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyInsightEntriesTable> {
  $$DailyInsightEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get patternsJson => $composableBuilder(
    column: $table.patternsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get discrepanciesJson => $composableBuilder(
    column: $table.discrepanciesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sourceUpdatedAt => $composableBuilder(
    column: $table.sourceUpdatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyInsightEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyInsightEntriesTable> {
  $$DailyInsightEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get patternsJson => $composableBuilder(
    column: $table.patternsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get discrepanciesJson => $composableBuilder(
    column: $table.discrepanciesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sourceUpdatedAt => $composableBuilder(
    column: $table.sourceUpdatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyInsightEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyInsightEntriesTable> {
  $$DailyInsightEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get patternsJson => $composableBuilder(
    column: $table.patternsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get discrepanciesJson => $composableBuilder(
    column: $table.discrepanciesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelVersion => $composableBuilder(
    column: $table.modelVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get promptVersion => $composableBuilder(
    column: $table.promptVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sourceUpdatedAt => $composableBuilder(
    column: $table.sourceUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );
}

class $$DailyInsightEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyInsightEntriesTable,
          DailyInsightEntry,
          $$DailyInsightEntriesTableFilterComposer,
          $$DailyInsightEntriesTableOrderingComposer,
          $$DailyInsightEntriesTableAnnotationComposer,
          $$DailyInsightEntriesTableCreateCompanionBuilder,
          $$DailyInsightEntriesTableUpdateCompanionBuilder,
          (
            DailyInsightEntry,
            BaseReferences<
              _$AppDatabase,
              $DailyInsightEntriesTable,
              DailyInsightEntry
            >,
          ),
          DailyInsightEntry,
          PrefetchHooks Function()
        > {
  $$DailyInsightEntriesTableTableManager(
    _$AppDatabase db,
    $DailyInsightEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyInsightEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyInsightEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DailyInsightEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> localDate = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String> patternsJson = const Value.absent(),
                Value<String> discrepanciesJson = const Value.absent(),
                Value<String> modelVersion = const Value.absent(),
                Value<String> promptVersion = const Value.absent(),
                Value<DateTime> sourceUpdatedAt = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyInsightEntriesCompanion(
                userId: userId,
                localDate: localDate,
                summary: summary,
                patternsJson: patternsJson,
                discrepanciesJson: discrepanciesJson,
                modelVersion: modelVersion,
                promptVersion: promptVersion,
                sourceUpdatedAt: sourceUpdatedAt,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String localDate,
                required String summary,
                required String patternsJson,
                required String discrepanciesJson,
                required String modelVersion,
                required String promptVersion,
                required DateTime sourceUpdatedAt,
                required DateTime generatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyInsightEntriesCompanion.insert(
                userId: userId,
                localDate: localDate,
                summary: summary,
                patternsJson: patternsJson,
                discrepanciesJson: discrepanciesJson,
                modelVersion: modelVersion,
                promptVersion: promptVersion,
                sourceUpdatedAt: sourceUpdatedAt,
                generatedAt: generatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyInsightEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyInsightEntriesTable,
      DailyInsightEntry,
      $$DailyInsightEntriesTableFilterComposer,
      $$DailyInsightEntriesTableOrderingComposer,
      $$DailyInsightEntriesTableAnnotationComposer,
      $$DailyInsightEntriesTableCreateCompanionBuilder,
      $$DailyInsightEntriesTableUpdateCompanionBuilder,
      (
        DailyInsightEntry,
        BaseReferences<
          _$AppDatabase,
          $DailyInsightEntriesTable,
          DailyInsightEntry
        >,
      ),
      DailyInsightEntry,
      PrefetchHooks Function()
    >;
typedef $$TrackingSettingsEntriesTableCreateCompanionBuilder =
    TrackingSettingsEntriesCompanion Function({
      required String userId,
      Value<bool> trackingEnabled,
      Value<int> captureIntervalMinutes,
      Value<int> idleThresholdMinutes,
      Value<bool> launchAtLogin,
      Value<bool> captureAllDisplays,
      Value<bool> diagnosticsEnabled,
      Value<String> excludedAppIdsJson,
      Value<bool> onboardingComplete,
      Value<int> privacyNoticeVersion,
      Value<DateTime?> pausedUntil,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TrackingSettingsEntriesTableUpdateCompanionBuilder =
    TrackingSettingsEntriesCompanion Function({
      Value<String> userId,
      Value<bool> trackingEnabled,
      Value<int> captureIntervalMinutes,
      Value<int> idleThresholdMinutes,
      Value<bool> launchAtLogin,
      Value<bool> captureAllDisplays,
      Value<bool> diagnosticsEnabled,
      Value<String> excludedAppIdsJson,
      Value<bool> onboardingComplete,
      Value<int> privacyNoticeVersion,
      Value<DateTime?> pausedUntil,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$TrackingSettingsEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TrackingSettingsEntriesTable> {
  $$TrackingSettingsEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get trackingEnabled => $composableBuilder(
    column: $table.trackingEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get captureIntervalMinutes => $composableBuilder(
    column: $table.captureIntervalMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get idleThresholdMinutes => $composableBuilder(
    column: $table.idleThresholdMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get launchAtLogin => $composableBuilder(
    column: $table.launchAtLogin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get captureAllDisplays => $composableBuilder(
    column: $table.captureAllDisplays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get diagnosticsEnabled => $composableBuilder(
    column: $table.diagnosticsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get excludedAppIdsJson => $composableBuilder(
    column: $table.excludedAppIdsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get privacyNoticeVersion => $composableBuilder(
    column: $table.privacyNoticeVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get pausedUntil => $composableBuilder(
    column: $table.pausedUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TrackingSettingsEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackingSettingsEntriesTable> {
  $$TrackingSettingsEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get trackingEnabled => $composableBuilder(
    column: $table.trackingEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get captureIntervalMinutes => $composableBuilder(
    column: $table.captureIntervalMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get idleThresholdMinutes => $composableBuilder(
    column: $table.idleThresholdMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get launchAtLogin => $composableBuilder(
    column: $table.launchAtLogin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get captureAllDisplays => $composableBuilder(
    column: $table.captureAllDisplays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get diagnosticsEnabled => $composableBuilder(
    column: $table.diagnosticsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get excludedAppIdsJson => $composableBuilder(
    column: $table.excludedAppIdsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get privacyNoticeVersion => $composableBuilder(
    column: $table.privacyNoticeVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get pausedUntil => $composableBuilder(
    column: $table.pausedUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrackingSettingsEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackingSettingsEntriesTable> {
  $$TrackingSettingsEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<bool> get trackingEnabled => $composableBuilder(
    column: $table.trackingEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get captureIntervalMinutes => $composableBuilder(
    column: $table.captureIntervalMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get idleThresholdMinutes => $composableBuilder(
    column: $table.idleThresholdMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get launchAtLogin => $composableBuilder(
    column: $table.launchAtLogin,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get captureAllDisplays => $composableBuilder(
    column: $table.captureAllDisplays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get diagnosticsEnabled => $composableBuilder(
    column: $table.diagnosticsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get excludedAppIdsJson => $composableBuilder(
    column: $table.excludedAppIdsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<int> get privacyNoticeVersion => $composableBuilder(
    column: $table.privacyNoticeVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get pausedUntil => $composableBuilder(
    column: $table.pausedUntil,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TrackingSettingsEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackingSettingsEntriesTable,
          TrackingSettingsEntry,
          $$TrackingSettingsEntriesTableFilterComposer,
          $$TrackingSettingsEntriesTableOrderingComposer,
          $$TrackingSettingsEntriesTableAnnotationComposer,
          $$TrackingSettingsEntriesTableCreateCompanionBuilder,
          $$TrackingSettingsEntriesTableUpdateCompanionBuilder,
          (
            TrackingSettingsEntry,
            BaseReferences<
              _$AppDatabase,
              $TrackingSettingsEntriesTable,
              TrackingSettingsEntry
            >,
          ),
          TrackingSettingsEntry,
          PrefetchHooks Function()
        > {
  $$TrackingSettingsEntriesTableTableManager(
    _$AppDatabase db,
    $TrackingSettingsEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackingSettingsEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TrackingSettingsEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TrackingSettingsEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<bool> trackingEnabled = const Value.absent(),
                Value<int> captureIntervalMinutes = const Value.absent(),
                Value<int> idleThresholdMinutes = const Value.absent(),
                Value<bool> launchAtLogin = const Value.absent(),
                Value<bool> captureAllDisplays = const Value.absent(),
                Value<bool> diagnosticsEnabled = const Value.absent(),
                Value<String> excludedAppIdsJson = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<int> privacyNoticeVersion = const Value.absent(),
                Value<DateTime?> pausedUntil = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrackingSettingsEntriesCompanion(
                userId: userId,
                trackingEnabled: trackingEnabled,
                captureIntervalMinutes: captureIntervalMinutes,
                idleThresholdMinutes: idleThresholdMinutes,
                launchAtLogin: launchAtLogin,
                captureAllDisplays: captureAllDisplays,
                diagnosticsEnabled: diagnosticsEnabled,
                excludedAppIdsJson: excludedAppIdsJson,
                onboardingComplete: onboardingComplete,
                privacyNoticeVersion: privacyNoticeVersion,
                pausedUntil: pausedUntil,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<bool> trackingEnabled = const Value.absent(),
                Value<int> captureIntervalMinutes = const Value.absent(),
                Value<int> idleThresholdMinutes = const Value.absent(),
                Value<bool> launchAtLogin = const Value.absent(),
                Value<bool> captureAllDisplays = const Value.absent(),
                Value<bool> diagnosticsEnabled = const Value.absent(),
                Value<String> excludedAppIdsJson = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<int> privacyNoticeVersion = const Value.absent(),
                Value<DateTime?> pausedUntil = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TrackingSettingsEntriesCompanion.insert(
                userId: userId,
                trackingEnabled: trackingEnabled,
                captureIntervalMinutes: captureIntervalMinutes,
                idleThresholdMinutes: idleThresholdMinutes,
                launchAtLogin: launchAtLogin,
                captureAllDisplays: captureAllDisplays,
                diagnosticsEnabled: diagnosticsEnabled,
                excludedAppIdsJson: excludedAppIdsJson,
                onboardingComplete: onboardingComplete,
                privacyNoticeVersion: privacyNoticeVersion,
                pausedUntil: pausedUntil,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TrackingSettingsEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackingSettingsEntriesTable,
      TrackingSettingsEntry,
      $$TrackingSettingsEntriesTableFilterComposer,
      $$TrackingSettingsEntriesTableOrderingComposer,
      $$TrackingSettingsEntriesTableAnnotationComposer,
      $$TrackingSettingsEntriesTableCreateCompanionBuilder,
      $$TrackingSettingsEntriesTableUpdateCompanionBuilder,
      (
        TrackingSettingsEntry,
        BaseReferences<
          _$AppDatabase,
          $TrackingSettingsEntriesTable,
          TrackingSettingsEntry
        >,
      ),
      TrackingSettingsEntry,
      PrefetchHooks Function()
    >;
typedef $$MigrationStateEntriesTableCreateCompanionBuilder =
    MigrationStateEntriesCompanion Function({
      required String userId,
      required String state,
      Value<int> importedSessionCount,
      Value<bool> cloudVerifiedEmpty,
      Value<String?> lastError,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MigrationStateEntriesTableUpdateCompanionBuilder =
    MigrationStateEntriesCompanion Function({
      Value<String> userId,
      Value<String> state,
      Value<int> importedSessionCount,
      Value<bool> cloudVerifiedEmpty,
      Value<String?> lastError,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MigrationStateEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MigrationStateEntriesTable> {
  $$MigrationStateEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importedSessionCount => $composableBuilder(
    column: $table.importedSessionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get cloudVerifiedEmpty => $composableBuilder(
    column: $table.cloudVerifiedEmpty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MigrationStateEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MigrationStateEntriesTable> {
  $$MigrationStateEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importedSessionCount => $composableBuilder(
    column: $table.importedSessionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get cloudVerifiedEmpty => $composableBuilder(
    column: $table.cloudVerifiedEmpty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MigrationStateEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MigrationStateEntriesTable> {
  $$MigrationStateEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<int> get importedSessionCount => $composableBuilder(
    column: $table.importedSessionCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get cloudVerifiedEmpty => $composableBuilder(
    column: $table.cloudVerifiedEmpty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MigrationStateEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MigrationStateEntriesTable,
          MigrationStateEntry,
          $$MigrationStateEntriesTableFilterComposer,
          $$MigrationStateEntriesTableOrderingComposer,
          $$MigrationStateEntriesTableAnnotationComposer,
          $$MigrationStateEntriesTableCreateCompanionBuilder,
          $$MigrationStateEntriesTableUpdateCompanionBuilder,
          (
            MigrationStateEntry,
            BaseReferences<
              _$AppDatabase,
              $MigrationStateEntriesTable,
              MigrationStateEntry
            >,
          ),
          MigrationStateEntry,
          PrefetchHooks Function()
        > {
  $$MigrationStateEntriesTableTableManager(
    _$AppDatabase db,
    $MigrationStateEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MigrationStateEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MigrationStateEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MigrationStateEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<int> importedSessionCount = const Value.absent(),
                Value<bool> cloudVerifiedEmpty = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MigrationStateEntriesCompanion(
                userId: userId,
                state: state,
                importedSessionCount: importedSessionCount,
                cloudVerifiedEmpty: cloudVerifiedEmpty,
                lastError: lastError,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String state,
                Value<int> importedSessionCount = const Value.absent(),
                Value<bool> cloudVerifiedEmpty = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MigrationStateEntriesCompanion.insert(
                userId: userId,
                state: state,
                importedSessionCount: importedSessionCount,
                cloudVerifiedEmpty: cloudVerifiedEmpty,
                lastError: lastError,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MigrationStateEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MigrationStateEntriesTable,
      MigrationStateEntry,
      $$MigrationStateEntriesTableFilterComposer,
      $$MigrationStateEntriesTableOrderingComposer,
      $$MigrationStateEntriesTableAnnotationComposer,
      $$MigrationStateEntriesTableCreateCompanionBuilder,
      $$MigrationStateEntriesTableUpdateCompanionBuilder,
      (
        MigrationStateEntry,
        BaseReferences<
          _$AppDatabase,
          $MigrationStateEntriesTable,
          MigrationStateEntry
        >,
      ),
      MigrationStateEntry,
      PrefetchHooks Function()
    >;
typedef $$DiagnosticsCounterEntriesTableCreateCompanionBuilder =
    DiagnosticsCounterEntriesCompanion Function({
      required String dayUtc,
      required String event,
      required String outcome,
      required String durationBucket,
      Value<int> count,
      Value<int> rowid,
    });
typedef $$DiagnosticsCounterEntriesTableUpdateCompanionBuilder =
    DiagnosticsCounterEntriesCompanion Function({
      Value<String> dayUtc,
      Value<String> event,
      Value<String> outcome,
      Value<String> durationBucket,
      Value<int> count,
      Value<int> rowid,
    });

class $$DiagnosticsCounterEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DiagnosticsCounterEntriesTable> {
  $$DiagnosticsCounterEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dayUtc => $composableBuilder(
    column: $table.dayUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get durationBucket => $composableBuilder(
    column: $table.durationBucket,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DiagnosticsCounterEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DiagnosticsCounterEntriesTable> {
  $$DiagnosticsCounterEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dayUtc => $composableBuilder(
    column: $table.dayUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get event => $composableBuilder(
    column: $table.event,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outcome => $composableBuilder(
    column: $table.outcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get durationBucket => $composableBuilder(
    column: $table.durationBucket,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiagnosticsCounterEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiagnosticsCounterEntriesTable> {
  $$DiagnosticsCounterEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dayUtc =>
      $composableBuilder(column: $table.dayUtc, builder: (column) => column);

  GeneratedColumn<String> get event =>
      $composableBuilder(column: $table.event, builder: (column) => column);

  GeneratedColumn<String> get outcome =>
      $composableBuilder(column: $table.outcome, builder: (column) => column);

  GeneratedColumn<String> get durationBucket => $composableBuilder(
    column: $table.durationBucket,
    builder: (column) => column,
  );

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);
}

class $$DiagnosticsCounterEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiagnosticsCounterEntriesTable,
          DiagnosticsCounterEntry,
          $$DiagnosticsCounterEntriesTableFilterComposer,
          $$DiagnosticsCounterEntriesTableOrderingComposer,
          $$DiagnosticsCounterEntriesTableAnnotationComposer,
          $$DiagnosticsCounterEntriesTableCreateCompanionBuilder,
          $$DiagnosticsCounterEntriesTableUpdateCompanionBuilder,
          (
            DiagnosticsCounterEntry,
            BaseReferences<
              _$AppDatabase,
              $DiagnosticsCounterEntriesTable,
              DiagnosticsCounterEntry
            >,
          ),
          DiagnosticsCounterEntry,
          PrefetchHooks Function()
        > {
  $$DiagnosticsCounterEntriesTableTableManager(
    _$AppDatabase db,
    $DiagnosticsCounterEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiagnosticsCounterEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DiagnosticsCounterEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DiagnosticsCounterEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> dayUtc = const Value.absent(),
                Value<String> event = const Value.absent(),
                Value<String> outcome = const Value.absent(),
                Value<String> durationBucket = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiagnosticsCounterEntriesCompanion(
                dayUtc: dayUtc,
                event: event,
                outcome: outcome,
                durationBucket: durationBucket,
                count: count,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dayUtc,
                required String event,
                required String outcome,
                required String durationBucket,
                Value<int> count = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiagnosticsCounterEntriesCompanion.insert(
                dayUtc: dayUtc,
                event: event,
                outcome: outcome,
                durationBucket: durationBucket,
                count: count,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DiagnosticsCounterEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiagnosticsCounterEntriesTable,
      DiagnosticsCounterEntry,
      $$DiagnosticsCounterEntriesTableFilterComposer,
      $$DiagnosticsCounterEntriesTableOrderingComposer,
      $$DiagnosticsCounterEntriesTableAnnotationComposer,
      $$DiagnosticsCounterEntriesTableCreateCompanionBuilder,
      $$DiagnosticsCounterEntriesTableUpdateCompanionBuilder,
      (
        DiagnosticsCounterEntry,
        BaseReferences<
          _$AppDatabase,
          $DiagnosticsCounterEntriesTable,
          DiagnosticsCounterEntry
        >,
      ),
      DiagnosticsCounterEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SessionEntriesTableTableManager get sessionEntries =>
      $$SessionEntriesTableTableManager(_db, _db.sessionEntries);
  $$TimerEntriesTableTableManager get timerEntries =>
      $$TimerEntriesTableTableManager(_db, _db.timerEntries);
  $$SettingsEntriesTableTableManager get settingsEntries =>
      $$SettingsEntriesTableTableManager(_db, _db.settingsEntries);
  $$AuthEntriesTableTableManager get authEntries =>
      $$AuthEntriesTableTableManager(_db, _db.authEntries);
  $$ActivitySampleEntriesTableTableManager get activitySampleEntries =>
      $$ActivitySampleEntriesTableTableManager(_db, _db.activitySampleEntries);
  $$ActivityBlockEntriesTableTableManager get activityBlockEntries =>
      $$ActivityBlockEntriesTableTableManager(_db, _db.activityBlockEntries);
  $$CategoryEntriesTableTableManager get categoryEntries =>
      $$CategoryEntriesTableTableManager(_db, _db.categoryEntries);
  $$CategoryRuleEntriesTableTableManager get categoryRuleEntries =>
      $$CategoryRuleEntriesTableTableManager(_db, _db.categoryRuleEntries);
  $$DailyInsightEntriesTableTableManager get dailyInsightEntries =>
      $$DailyInsightEntriesTableTableManager(_db, _db.dailyInsightEntries);
  $$TrackingSettingsEntriesTableTableManager get trackingSettingsEntries =>
      $$TrackingSettingsEntriesTableTableManager(
        _db,
        _db.trackingSettingsEntries,
      );
  $$MigrationStateEntriesTableTableManager get migrationStateEntries =>
      $$MigrationStateEntriesTableTableManager(_db, _db.migrationStateEntries);
  $$DiagnosticsCounterEntriesTableTableManager get diagnosticsCounterEntries =>
      $$DiagnosticsCounterEntriesTableTableManager(
        _db,
        _db.diagnosticsCounterEntries,
      );
}
