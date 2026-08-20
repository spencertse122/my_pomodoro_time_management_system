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
    defaultValue: const Constant(true),
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
          ..write('isDirty: $isDirty')
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
          other.isDirty == this.isDirty);
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
    } else if (isInserting) {
      context.missing(_refreshTokenMeta);
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
    required String refreshToken,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       email = Value(email),
       refreshToken = Value(refreshToken),
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SessionEntriesTable sessionEntries = $SessionEntriesTable(this);
  late final $TimerEntriesTable timerEntries = $TimerEntriesTable(this);
  late final $SettingsEntriesTable settingsEntries = $SettingsEntriesTable(
    this,
  );
  late final $AuthEntriesTable authEntries = $AuthEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sessionEntries,
    timerEntries,
    settingsEntries,
    authEntries,
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
      required String refreshToken,
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
                required String refreshToken,
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
}
