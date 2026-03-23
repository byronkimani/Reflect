// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RecurrenceRulesTable extends RecurrenceRules
    with TableInfo<$RecurrenceRulesTable, RecurrenceRuleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecurrenceRulesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalValMeta = const VerificationMeta(
    'intervalVal',
  );
  @override
  late final GeneratedColumn<int> intervalVal = GeneratedColumn<int>(
    'interval_val',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _daysOfWeekMeta = const VerificationMeta(
    'daysOfWeek',
  );
  @override
  late final GeneratedColumn<String> daysOfWeek = GeneratedColumn<String>(
    'days_of_week',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dayOfMonthMeta = const VerificationMeta(
    'dayOfMonth',
  );
  @override
  late final GeneratedColumn<int> dayOfMonth = GeneratedColumn<int>(
    'day_of_month',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endTypeMeta = const VerificationMeta(
    'endType',
  );
  @override
  late final GeneratedColumn<String> endType = GeneratedColumn<String>(
    'end_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('NEVER'),
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<int> endDate = GeneratedColumn<int>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endCountMeta = const VerificationMeta(
    'endCount',
  );
  @override
  late final GeneratedColumn<int> endCount = GeneratedColumn<int>(
    'end_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurrenceCountMeta = const VerificationMeta(
    'occurrenceCount',
  );
  @override
  late final GeneratedColumn<int> occurrenceCount = GeneratedColumn<int>(
    'occurrence_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    frequency,
    intervalVal,
    daysOfWeek,
    dayOfMonth,
    endType,
    endDate,
    endCount,
    occurrenceCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recurrence_rules';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecurrenceRuleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('interval_val')) {
      context.handle(
        _intervalValMeta,
        intervalVal.isAcceptableOrUnknown(
          data['interval_val']!,
          _intervalValMeta,
        ),
      );
    }
    if (data.containsKey('days_of_week')) {
      context.handle(
        _daysOfWeekMeta,
        daysOfWeek.isAcceptableOrUnknown(
          data['days_of_week']!,
          _daysOfWeekMeta,
        ),
      );
    }
    if (data.containsKey('day_of_month')) {
      context.handle(
        _dayOfMonthMeta,
        dayOfMonth.isAcceptableOrUnknown(
          data['day_of_month']!,
          _dayOfMonthMeta,
        ),
      );
    }
    if (data.containsKey('end_type')) {
      context.handle(
        _endTypeMeta,
        endType.isAcceptableOrUnknown(data['end_type']!, _endTypeMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('end_count')) {
      context.handle(
        _endCountMeta,
        endCount.isAcceptableOrUnknown(data['end_count']!, _endCountMeta),
      );
    }
    if (data.containsKey('occurrence_count')) {
      context.handle(
        _occurrenceCountMeta,
        occurrenceCount.isAcceptableOrUnknown(
          data['occurrence_count']!,
          _occurrenceCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecurrenceRuleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecurrenceRuleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      intervalVal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_val'],
      )!,
      daysOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}days_of_week'],
      ),
      dayOfMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_of_month'],
      ),
      endType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_type'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_date'],
      ),
      endCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_count'],
      ),
      occurrenceCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}occurrence_count'],
      )!,
    );
  }

  @override
  $RecurrenceRulesTable createAlias(String alias) {
    return $RecurrenceRulesTable(attachedDatabase, alias);
  }
}

class RecurrenceRuleData extends DataClass
    implements Insertable<RecurrenceRuleData> {
  final String id;
  final String frequency;
  final int intervalVal;
  final String? daysOfWeek;
  final int? dayOfMonth;
  final String endType;
  final int? endDate;
  final int? endCount;
  final int occurrenceCount;
  const RecurrenceRuleData({
    required this.id,
    required this.frequency,
    required this.intervalVal,
    this.daysOfWeek,
    this.dayOfMonth,
    required this.endType,
    this.endDate,
    this.endCount,
    required this.occurrenceCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['frequency'] = Variable<String>(frequency);
    map['interval_val'] = Variable<int>(intervalVal);
    if (!nullToAbsent || daysOfWeek != null) {
      map['days_of_week'] = Variable<String>(daysOfWeek);
    }
    if (!nullToAbsent || dayOfMonth != null) {
      map['day_of_month'] = Variable<int>(dayOfMonth);
    }
    map['end_type'] = Variable<String>(endType);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<int>(endDate);
    }
    if (!nullToAbsent || endCount != null) {
      map['end_count'] = Variable<int>(endCount);
    }
    map['occurrence_count'] = Variable<int>(occurrenceCount);
    return map;
  }

  RecurrenceRulesCompanion toCompanion(bool nullToAbsent) {
    return RecurrenceRulesCompanion(
      id: Value(id),
      frequency: Value(frequency),
      intervalVal: Value(intervalVal),
      daysOfWeek: daysOfWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(daysOfWeek),
      dayOfMonth: dayOfMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(dayOfMonth),
      endType: Value(endType),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      endCount: endCount == null && nullToAbsent
          ? const Value.absent()
          : Value(endCount),
      occurrenceCount: Value(occurrenceCount),
    );
  }

  factory RecurrenceRuleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecurrenceRuleData(
      id: serializer.fromJson<String>(json['id']),
      frequency: serializer.fromJson<String>(json['frequency']),
      intervalVal: serializer.fromJson<int>(json['intervalVal']),
      daysOfWeek: serializer.fromJson<String?>(json['daysOfWeek']),
      dayOfMonth: serializer.fromJson<int?>(json['dayOfMonth']),
      endType: serializer.fromJson<String>(json['endType']),
      endDate: serializer.fromJson<int?>(json['endDate']),
      endCount: serializer.fromJson<int?>(json['endCount']),
      occurrenceCount: serializer.fromJson<int>(json['occurrenceCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'frequency': serializer.toJson<String>(frequency),
      'intervalVal': serializer.toJson<int>(intervalVal),
      'daysOfWeek': serializer.toJson<String?>(daysOfWeek),
      'dayOfMonth': serializer.toJson<int?>(dayOfMonth),
      'endType': serializer.toJson<String>(endType),
      'endDate': serializer.toJson<int?>(endDate),
      'endCount': serializer.toJson<int?>(endCount),
      'occurrenceCount': serializer.toJson<int>(occurrenceCount),
    };
  }

  RecurrenceRuleData copyWith({
    String? id,
    String? frequency,
    int? intervalVal,
    Value<String?> daysOfWeek = const Value.absent(),
    Value<int?> dayOfMonth = const Value.absent(),
    String? endType,
    Value<int?> endDate = const Value.absent(),
    Value<int?> endCount = const Value.absent(),
    int? occurrenceCount,
  }) => RecurrenceRuleData(
    id: id ?? this.id,
    frequency: frequency ?? this.frequency,
    intervalVal: intervalVal ?? this.intervalVal,
    daysOfWeek: daysOfWeek.present ? daysOfWeek.value : this.daysOfWeek,
    dayOfMonth: dayOfMonth.present ? dayOfMonth.value : this.dayOfMonth,
    endType: endType ?? this.endType,
    endDate: endDate.present ? endDate.value : this.endDate,
    endCount: endCount.present ? endCount.value : this.endCount,
    occurrenceCount: occurrenceCount ?? this.occurrenceCount,
  );
  RecurrenceRuleData copyWithCompanion(RecurrenceRulesCompanion data) {
    return RecurrenceRuleData(
      id: data.id.present ? data.id.value : this.id,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      intervalVal: data.intervalVal.present
          ? data.intervalVal.value
          : this.intervalVal,
      daysOfWeek: data.daysOfWeek.present
          ? data.daysOfWeek.value
          : this.daysOfWeek,
      dayOfMonth: data.dayOfMonth.present
          ? data.dayOfMonth.value
          : this.dayOfMonth,
      endType: data.endType.present ? data.endType.value : this.endType,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      endCount: data.endCount.present ? data.endCount.value : this.endCount,
      occurrenceCount: data.occurrenceCount.present
          ? data.occurrenceCount.value
          : this.occurrenceCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecurrenceRuleData(')
          ..write('id: $id, ')
          ..write('frequency: $frequency, ')
          ..write('intervalVal: $intervalVal, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('endType: $endType, ')
          ..write('endDate: $endDate, ')
          ..write('endCount: $endCount, ')
          ..write('occurrenceCount: $occurrenceCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    frequency,
    intervalVal,
    daysOfWeek,
    dayOfMonth,
    endType,
    endDate,
    endCount,
    occurrenceCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecurrenceRuleData &&
          other.id == this.id &&
          other.frequency == this.frequency &&
          other.intervalVal == this.intervalVal &&
          other.daysOfWeek == this.daysOfWeek &&
          other.dayOfMonth == this.dayOfMonth &&
          other.endType == this.endType &&
          other.endDate == this.endDate &&
          other.endCount == this.endCount &&
          other.occurrenceCount == this.occurrenceCount);
}

class RecurrenceRulesCompanion extends UpdateCompanion<RecurrenceRuleData> {
  final Value<String> id;
  final Value<String> frequency;
  final Value<int> intervalVal;
  final Value<String?> daysOfWeek;
  final Value<int?> dayOfMonth;
  final Value<String> endType;
  final Value<int?> endDate;
  final Value<int?> endCount;
  final Value<int> occurrenceCount;
  final Value<int> rowid;
  const RecurrenceRulesCompanion({
    this.id = const Value.absent(),
    this.frequency = const Value.absent(),
    this.intervalVal = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    this.endType = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endCount = const Value.absent(),
    this.occurrenceCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecurrenceRulesCompanion.insert({
    this.id = const Value.absent(),
    required String frequency,
    this.intervalVal = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.dayOfMonth = const Value.absent(),
    this.endType = const Value.absent(),
    this.endDate = const Value.absent(),
    this.endCount = const Value.absent(),
    this.occurrenceCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : frequency = Value(frequency);
  static Insertable<RecurrenceRuleData> custom({
    Expression<String>? id,
    Expression<String>? frequency,
    Expression<int>? intervalVal,
    Expression<String>? daysOfWeek,
    Expression<int>? dayOfMonth,
    Expression<String>? endType,
    Expression<int>? endDate,
    Expression<int>? endCount,
    Expression<int>? occurrenceCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (frequency != null) 'frequency': frequency,
      if (intervalVal != null) 'interval_val': intervalVal,
      if (daysOfWeek != null) 'days_of_week': daysOfWeek,
      if (dayOfMonth != null) 'day_of_month': dayOfMonth,
      if (endType != null) 'end_type': endType,
      if (endDate != null) 'end_date': endDate,
      if (endCount != null) 'end_count': endCount,
      if (occurrenceCount != null) 'occurrence_count': occurrenceCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecurrenceRulesCompanion copyWith({
    Value<String>? id,
    Value<String>? frequency,
    Value<int>? intervalVal,
    Value<String?>? daysOfWeek,
    Value<int?>? dayOfMonth,
    Value<String>? endType,
    Value<int?>? endDate,
    Value<int?>? endCount,
    Value<int>? occurrenceCount,
    Value<int>? rowid,
  }) {
    return RecurrenceRulesCompanion(
      id: id ?? this.id,
      frequency: frequency ?? this.frequency,
      intervalVal: intervalVal ?? this.intervalVal,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
      endType: endType ?? this.endType,
      endDate: endDate ?? this.endDate,
      endCount: endCount ?? this.endCount,
      occurrenceCount: occurrenceCount ?? this.occurrenceCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (intervalVal.present) {
      map['interval_val'] = Variable<int>(intervalVal.value);
    }
    if (daysOfWeek.present) {
      map['days_of_week'] = Variable<String>(daysOfWeek.value);
    }
    if (dayOfMonth.present) {
      map['day_of_month'] = Variable<int>(dayOfMonth.value);
    }
    if (endType.present) {
      map['end_type'] = Variable<String>(endType.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<int>(endDate.value);
    }
    if (endCount.present) {
      map['end_count'] = Variable<int>(endCount.value);
    }
    if (occurrenceCount.present) {
      map['occurrence_count'] = Variable<int>(occurrenceCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecurrenceRulesCompanion(')
          ..write('id: $id, ')
          ..write('frequency: $frequency, ')
          ..write('intervalVal: $intervalVal, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('dayOfMonth: $dayOfMonth, ')
          ..write('endType: $endType, ')
          ..write('endDate: $endDate, ')
          ..write('endCount: $endCount, ')
          ..write('occurrenceCount: $occurrenceCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<int> dueDate = GeneratedColumn<int>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateLocalDayStartMeta =
      const VerificationMeta('dueDateLocalDayStart');
  @override
  late final GeneratedColumn<int> dueDateLocalDayStart = GeneratedColumn<int>(
    'due_date_local_day_start',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateUtcMsMeta = const VerificationMeta(
    'dueDateUtcMs',
  );
  @override
  late final GeneratedColumn<int> dueDateUtcMs = GeneratedColumn<int>(
    'due_date_utc_ms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueTimeMeta = const VerificationMeta(
    'dueTime',
  );
  @override
  late final GeneratedColumn<int> dueTime = GeneratedColumn<int>(
    'due_time',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _isOverdueMeta = const VerificationMeta(
    'isOverdue',
  );
  @override
  late final GeneratedColumn<int> isOverdue = GeneratedColumn<int>(
    'is_overdue',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _overdueDayMeta = const VerificationMeta(
    'overdueDay',
  );
  @override
  late final GeneratedColumn<int> overdueDay = GeneratedColumn<int>(
    'overdue_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recurrenceRuleIdMeta = const VerificationMeta(
    'recurrenceRuleId',
  );
  @override
  late final GeneratedColumn<String> recurrenceRuleId = GeneratedColumn<String>(
    'recurrence_rule_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES recurrence_rules(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _recurrenceParentIdMeta =
      const VerificationMeta('recurrenceParentId');
  @override
  late final GeneratedColumn<String> recurrenceParentId =
      GeneratedColumn<String>(
        'recurrence_parent_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        $customConstraints: 'REFERENCES tasks(id) ON DELETE CASCADE',
      );
  static const VerificationMeta _hasEnabledReminderMeta =
      const VerificationMeta('hasEnabledReminder');
  @override
  late final GeneratedColumn<int> hasEnabledReminder = GeneratedColumn<int>(
    'has_enabled_reminder',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gcalEventIdMeta = const VerificationMeta(
    'gcalEventId',
  );
  @override
  late final GeneratedColumn<String> gcalEventId = GeneratedColumn<String>(
    'gcal_event_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncToGcalMeta = const VerificationMeta(
    'syncToGcal',
  );
  @override
  late final GeneratedColumn<int> syncToGcal = GeneratedColumn<int>(
    'sync_to_gcal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    $customConstraints: 'REFERENCES goals(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    priority,
    dueDate,
    dueDateLocalDayStart,
    dueDateUtcMs,
    dueTime,
    notes,
    status,
    isOverdue,
    overdueDay,
    recurrenceRuleId,
    recurrenceParentId,
    hasEnabledReminder,
    gcalEventId,
    syncToGcal,
    goalId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('due_date_local_day_start')) {
      context.handle(
        _dueDateLocalDayStartMeta,
        dueDateLocalDayStart.isAcceptableOrUnknown(
          data['due_date_local_day_start']!,
          _dueDateLocalDayStartMeta,
        ),
      );
    }
    if (data.containsKey('due_date_utc_ms')) {
      context.handle(
        _dueDateUtcMsMeta,
        dueDateUtcMs.isAcceptableOrUnknown(
          data['due_date_utc_ms']!,
          _dueDateUtcMsMeta,
        ),
      );
    }
    if (data.containsKey('due_time')) {
      context.handle(
        _dueTimeMeta,
        dueTime.isAcceptableOrUnknown(data['due_time']!, _dueTimeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('is_overdue')) {
      context.handle(
        _isOverdueMeta,
        isOverdue.isAcceptableOrUnknown(data['is_overdue']!, _isOverdueMeta),
      );
    }
    if (data.containsKey('overdue_day')) {
      context.handle(
        _overdueDayMeta,
        overdueDay.isAcceptableOrUnknown(data['overdue_day']!, _overdueDayMeta),
      );
    }
    if (data.containsKey('recurrence_rule_id')) {
      context.handle(
        _recurrenceRuleIdMeta,
        recurrenceRuleId.isAcceptableOrUnknown(
          data['recurrence_rule_id']!,
          _recurrenceRuleIdMeta,
        ),
      );
    }
    if (data.containsKey('recurrence_parent_id')) {
      context.handle(
        _recurrenceParentIdMeta,
        recurrenceParentId.isAcceptableOrUnknown(
          data['recurrence_parent_id']!,
          _recurrenceParentIdMeta,
        ),
      );
    }
    if (data.containsKey('has_enabled_reminder')) {
      context.handle(
        _hasEnabledReminderMeta,
        hasEnabledReminder.isAcceptableOrUnknown(
          data['has_enabled_reminder']!,
          _hasEnabledReminderMeta,
        ),
      );
    }
    if (data.containsKey('gcal_event_id')) {
      context.handle(
        _gcalEventIdMeta,
        gcalEventId.isAcceptableOrUnknown(
          data['gcal_event_id']!,
          _gcalEventIdMeta,
        ),
      );
    }
    if (data.containsKey('sync_to_gcal')) {
      context.handle(
        _syncToGcalMeta,
        syncToGcal.isAcceptableOrUnknown(
          data['sync_to_gcal']!,
          _syncToGcalMeta,
        ),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
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
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_date'],
      ),
      dueDateLocalDayStart: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_date_local_day_start'],
      ),
      dueDateUtcMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_date_utc_ms'],
      ),
      dueTime: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}due_time'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      isOverdue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_overdue'],
      )!,
      overdueDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}overdue_day'],
      )!,
      recurrenceRuleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_rule_id'],
      ),
      recurrenceParentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurrence_parent_id'],
      ),
      hasEnabledReminder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}has_enabled_reminder'],
      )!,
      gcalEventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gcal_event_id'],
      ),
      syncToGcal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sync_to_gcal'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class TaskData extends DataClass implements Insertable<TaskData> {
  final String id;
  final String title;
  final String priority;
  final int? dueDate;

  /// Start of the due calendar day in the user's local timezone (epoch ms). Used for analytics and day bucketing.
  final int? dueDateLocalDayStart;

  /// Canonical due instant as epoch ms (same convention as [DateTime.millisecondsSinceEpoch]). Reserved for sync / server use.
  final int? dueDateUtcMs;
  final int? dueTime;
  final String? notes;
  final String status;
  final int isOverdue;
  final int overdueDay;
  final String? recurrenceRuleId;
  final String? recurrenceParentId;
  final int hasEnabledReminder;
  final String? gcalEventId;
  final int syncToGcal;
  final String? goalId;
  final int createdAt;
  final int updatedAt;
  const TaskData({
    required this.id,
    required this.title,
    required this.priority,
    this.dueDate,
    this.dueDateLocalDayStart,
    this.dueDateUtcMs,
    this.dueTime,
    this.notes,
    required this.status,
    required this.isOverdue,
    required this.overdueDay,
    this.recurrenceRuleId,
    this.recurrenceParentId,
    required this.hasEnabledReminder,
    this.gcalEventId,
    required this.syncToGcal,
    this.goalId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<int>(dueDate);
    }
    if (!nullToAbsent || dueDateLocalDayStart != null) {
      map['due_date_local_day_start'] = Variable<int>(dueDateLocalDayStart);
    }
    if (!nullToAbsent || dueDateUtcMs != null) {
      map['due_date_utc_ms'] = Variable<int>(dueDateUtcMs);
    }
    if (!nullToAbsent || dueTime != null) {
      map['due_time'] = Variable<int>(dueTime);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['is_overdue'] = Variable<int>(isOverdue);
    map['overdue_day'] = Variable<int>(overdueDay);
    if (!nullToAbsent || recurrenceRuleId != null) {
      map['recurrence_rule_id'] = Variable<String>(recurrenceRuleId);
    }
    if (!nullToAbsent || recurrenceParentId != null) {
      map['recurrence_parent_id'] = Variable<String>(recurrenceParentId);
    }
    map['has_enabled_reminder'] = Variable<int>(hasEnabledReminder);
    if (!nullToAbsent || gcalEventId != null) {
      map['gcal_event_id'] = Variable<String>(gcalEventId);
    }
    map['sync_to_gcal'] = Variable<int>(syncToGcal);
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      priority: Value(priority),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      dueDateLocalDayStart: dueDateLocalDayStart == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDateLocalDayStart),
      dueDateUtcMs: dueDateUtcMs == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDateUtcMs),
      dueTime: dueTime == null && nullToAbsent
          ? const Value.absent()
          : Value(dueTime),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      isOverdue: Value(isOverdue),
      overdueDay: Value(overdueDay),
      recurrenceRuleId: recurrenceRuleId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceRuleId),
      recurrenceParentId: recurrenceParentId == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceParentId),
      hasEnabledReminder: Value(hasEnabledReminder),
      gcalEventId: gcalEventId == null && nullToAbsent
          ? const Value.absent()
          : Value(gcalEventId),
      syncToGcal: Value(syncToGcal),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TaskData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      priority: serializer.fromJson<String>(json['priority']),
      dueDate: serializer.fromJson<int?>(json['dueDate']),
      dueDateLocalDayStart: serializer.fromJson<int?>(
        json['dueDateLocalDayStart'],
      ),
      dueDateUtcMs: serializer.fromJson<int?>(json['dueDateUtcMs']),
      dueTime: serializer.fromJson<int?>(json['dueTime']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      isOverdue: serializer.fromJson<int>(json['isOverdue']),
      overdueDay: serializer.fromJson<int>(json['overdueDay']),
      recurrenceRuleId: serializer.fromJson<String?>(json['recurrenceRuleId']),
      recurrenceParentId: serializer.fromJson<String?>(
        json['recurrenceParentId'],
      ),
      hasEnabledReminder: serializer.fromJson<int>(json['hasEnabledReminder']),
      gcalEventId: serializer.fromJson<String?>(json['gcalEventId']),
      syncToGcal: serializer.fromJson<int>(json['syncToGcal']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'priority': serializer.toJson<String>(priority),
      'dueDate': serializer.toJson<int?>(dueDate),
      'dueDateLocalDayStart': serializer.toJson<int?>(dueDateLocalDayStart),
      'dueDateUtcMs': serializer.toJson<int?>(dueDateUtcMs),
      'dueTime': serializer.toJson<int?>(dueTime),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'isOverdue': serializer.toJson<int>(isOverdue),
      'overdueDay': serializer.toJson<int>(overdueDay),
      'recurrenceRuleId': serializer.toJson<String?>(recurrenceRuleId),
      'recurrenceParentId': serializer.toJson<String?>(recurrenceParentId),
      'hasEnabledReminder': serializer.toJson<int>(hasEnabledReminder),
      'gcalEventId': serializer.toJson<String?>(gcalEventId),
      'syncToGcal': serializer.toJson<int>(syncToGcal),
      'goalId': serializer.toJson<String?>(goalId),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  TaskData copyWith({
    String? id,
    String? title,
    String? priority,
    Value<int?> dueDate = const Value.absent(),
    Value<int?> dueDateLocalDayStart = const Value.absent(),
    Value<int?> dueDateUtcMs = const Value.absent(),
    Value<int?> dueTime = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? status,
    int? isOverdue,
    int? overdueDay,
    Value<String?> recurrenceRuleId = const Value.absent(),
    Value<String?> recurrenceParentId = const Value.absent(),
    int? hasEnabledReminder,
    Value<String?> gcalEventId = const Value.absent(),
    int? syncToGcal,
    Value<String?> goalId = const Value.absent(),
    int? createdAt,
    int? updatedAt,
  }) => TaskData(
    id: id ?? this.id,
    title: title ?? this.title,
    priority: priority ?? this.priority,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    dueDateLocalDayStart: dueDateLocalDayStart.present
        ? dueDateLocalDayStart.value
        : this.dueDateLocalDayStart,
    dueDateUtcMs: dueDateUtcMs.present ? dueDateUtcMs.value : this.dueDateUtcMs,
    dueTime: dueTime.present ? dueTime.value : this.dueTime,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    isOverdue: isOverdue ?? this.isOverdue,
    overdueDay: overdueDay ?? this.overdueDay,
    recurrenceRuleId: recurrenceRuleId.present
        ? recurrenceRuleId.value
        : this.recurrenceRuleId,
    recurrenceParentId: recurrenceParentId.present
        ? recurrenceParentId.value
        : this.recurrenceParentId,
    hasEnabledReminder: hasEnabledReminder ?? this.hasEnabledReminder,
    gcalEventId: gcalEventId.present ? gcalEventId.value : this.gcalEventId,
    syncToGcal: syncToGcal ?? this.syncToGcal,
    goalId: goalId.present ? goalId.value : this.goalId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TaskData copyWithCompanion(TasksCompanion data) {
    return TaskData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      priority: data.priority.present ? data.priority.value : this.priority,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      dueDateLocalDayStart: data.dueDateLocalDayStart.present
          ? data.dueDateLocalDayStart.value
          : this.dueDateLocalDayStart,
      dueDateUtcMs: data.dueDateUtcMs.present
          ? data.dueDateUtcMs.value
          : this.dueDateUtcMs,
      dueTime: data.dueTime.present ? data.dueTime.value : this.dueTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      isOverdue: data.isOverdue.present ? data.isOverdue.value : this.isOverdue,
      overdueDay: data.overdueDay.present
          ? data.overdueDay.value
          : this.overdueDay,
      recurrenceRuleId: data.recurrenceRuleId.present
          ? data.recurrenceRuleId.value
          : this.recurrenceRuleId,
      recurrenceParentId: data.recurrenceParentId.present
          ? data.recurrenceParentId.value
          : this.recurrenceParentId,
      hasEnabledReminder: data.hasEnabledReminder.present
          ? data.hasEnabledReminder.value
          : this.hasEnabledReminder,
      gcalEventId: data.gcalEventId.present
          ? data.gcalEventId.value
          : this.gcalEventId,
      syncToGcal: data.syncToGcal.present
          ? data.syncToGcal.value
          : this.syncToGcal,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('priority: $priority, ')
          ..write('dueDate: $dueDate, ')
          ..write('dueDateLocalDayStart: $dueDateLocalDayStart, ')
          ..write('dueDateUtcMs: $dueDateUtcMs, ')
          ..write('dueTime: $dueTime, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('isOverdue: $isOverdue, ')
          ..write('overdueDay: $overdueDay, ')
          ..write('recurrenceRuleId: $recurrenceRuleId, ')
          ..write('recurrenceParentId: $recurrenceParentId, ')
          ..write('hasEnabledReminder: $hasEnabledReminder, ')
          ..write('gcalEventId: $gcalEventId, ')
          ..write('syncToGcal: $syncToGcal, ')
          ..write('goalId: $goalId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    priority,
    dueDate,
    dueDateLocalDayStart,
    dueDateUtcMs,
    dueTime,
    notes,
    status,
    isOverdue,
    overdueDay,
    recurrenceRuleId,
    recurrenceParentId,
    hasEnabledReminder,
    gcalEventId,
    syncToGcal,
    goalId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.title == this.title &&
          other.priority == this.priority &&
          other.dueDate == this.dueDate &&
          other.dueDateLocalDayStart == this.dueDateLocalDayStart &&
          other.dueDateUtcMs == this.dueDateUtcMs &&
          other.dueTime == this.dueTime &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.isOverdue == this.isOverdue &&
          other.overdueDay == this.overdueDay &&
          other.recurrenceRuleId == this.recurrenceRuleId &&
          other.recurrenceParentId == this.recurrenceParentId &&
          other.hasEnabledReminder == this.hasEnabledReminder &&
          other.gcalEventId == this.gcalEventId &&
          other.syncToGcal == this.syncToGcal &&
          other.goalId == this.goalId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TasksCompanion extends UpdateCompanion<TaskData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> priority;
  final Value<int?> dueDate;
  final Value<int?> dueDateLocalDayStart;
  final Value<int?> dueDateUtcMs;
  final Value<int?> dueTime;
  final Value<String?> notes;
  final Value<String> status;
  final Value<int> isOverdue;
  final Value<int> overdueDay;
  final Value<String?> recurrenceRuleId;
  final Value<String?> recurrenceParentId;
  final Value<int> hasEnabledReminder;
  final Value<String?> gcalEventId;
  final Value<int> syncToGcal;
  final Value<String?> goalId;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.priority = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.dueDateLocalDayStart = const Value.absent(),
    this.dueDateUtcMs = const Value.absent(),
    this.dueTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.isOverdue = const Value.absent(),
    this.overdueDay = const Value.absent(),
    this.recurrenceRuleId = const Value.absent(),
    this.recurrenceParentId = const Value.absent(),
    this.hasEnabledReminder = const Value.absent(),
    this.gcalEventId = const Value.absent(),
    this.syncToGcal = const Value.absent(),
    this.goalId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String priority,
    this.dueDate = const Value.absent(),
    this.dueDateLocalDayStart = const Value.absent(),
    this.dueDateUtcMs = const Value.absent(),
    this.dueTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.isOverdue = const Value.absent(),
    this.overdueDay = const Value.absent(),
    this.recurrenceRuleId = const Value.absent(),
    this.recurrenceParentId = const Value.absent(),
    this.hasEnabledReminder = const Value.absent(),
    this.gcalEventId = const Value.absent(),
    this.syncToGcal = const Value.absent(),
    this.goalId = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       priority = Value(priority),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TaskData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? priority,
    Expression<int>? dueDate,
    Expression<int>? dueDateLocalDayStart,
    Expression<int>? dueDateUtcMs,
    Expression<int>? dueTime,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<int>? isOverdue,
    Expression<int>? overdueDay,
    Expression<String>? recurrenceRuleId,
    Expression<String>? recurrenceParentId,
    Expression<int>? hasEnabledReminder,
    Expression<String>? gcalEventId,
    Expression<int>? syncToGcal,
    Expression<String>? goalId,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (priority != null) 'priority': priority,
      if (dueDate != null) 'due_date': dueDate,
      if (dueDateLocalDayStart != null)
        'due_date_local_day_start': dueDateLocalDayStart,
      if (dueDateUtcMs != null) 'due_date_utc_ms': dueDateUtcMs,
      if (dueTime != null) 'due_time': dueTime,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (isOverdue != null) 'is_overdue': isOverdue,
      if (overdueDay != null) 'overdue_day': overdueDay,
      if (recurrenceRuleId != null) 'recurrence_rule_id': recurrenceRuleId,
      if (recurrenceParentId != null)
        'recurrence_parent_id': recurrenceParentId,
      if (hasEnabledReminder != null)
        'has_enabled_reminder': hasEnabledReminder,
      if (gcalEventId != null) 'gcal_event_id': gcalEventId,
      if (syncToGcal != null) 'sync_to_gcal': syncToGcal,
      if (goalId != null) 'goal_id': goalId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? priority,
    Value<int?>? dueDate,
    Value<int?>? dueDateLocalDayStart,
    Value<int?>? dueDateUtcMs,
    Value<int?>? dueTime,
    Value<String?>? notes,
    Value<String>? status,
    Value<int>? isOverdue,
    Value<int>? overdueDay,
    Value<String?>? recurrenceRuleId,
    Value<String?>? recurrenceParentId,
    Value<int>? hasEnabledReminder,
    Value<String?>? gcalEventId,
    Value<int>? syncToGcal,
    Value<String?>? goalId,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      dueDateLocalDayStart: dueDateLocalDayStart ?? this.dueDateLocalDayStart,
      dueDateUtcMs: dueDateUtcMs ?? this.dueDateUtcMs,
      dueTime: dueTime ?? this.dueTime,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      isOverdue: isOverdue ?? this.isOverdue,
      overdueDay: overdueDay ?? this.overdueDay,
      recurrenceRuleId: recurrenceRuleId ?? this.recurrenceRuleId,
      recurrenceParentId: recurrenceParentId ?? this.recurrenceParentId,
      hasEnabledReminder: hasEnabledReminder ?? this.hasEnabledReminder,
      gcalEventId: gcalEventId ?? this.gcalEventId,
      syncToGcal: syncToGcal ?? this.syncToGcal,
      goalId: goalId ?? this.goalId,
      createdAt: createdAt ?? this.createdAt,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<int>(dueDate.value);
    }
    if (dueDateLocalDayStart.present) {
      map['due_date_local_day_start'] = Variable<int>(
        dueDateLocalDayStart.value,
      );
    }
    if (dueDateUtcMs.present) {
      map['due_date_utc_ms'] = Variable<int>(dueDateUtcMs.value);
    }
    if (dueTime.present) {
      map['due_time'] = Variable<int>(dueTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isOverdue.present) {
      map['is_overdue'] = Variable<int>(isOverdue.value);
    }
    if (overdueDay.present) {
      map['overdue_day'] = Variable<int>(overdueDay.value);
    }
    if (recurrenceRuleId.present) {
      map['recurrence_rule_id'] = Variable<String>(recurrenceRuleId.value);
    }
    if (recurrenceParentId.present) {
      map['recurrence_parent_id'] = Variable<String>(recurrenceParentId.value);
    }
    if (hasEnabledReminder.present) {
      map['has_enabled_reminder'] = Variable<int>(hasEnabledReminder.value);
    }
    if (gcalEventId.present) {
      map['gcal_event_id'] = Variable<String>(gcalEventId.value);
    }
    if (syncToGcal.present) {
      map['sync_to_gcal'] = Variable<int>(syncToGcal.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('priority: $priority, ')
          ..write('dueDate: $dueDate, ')
          ..write('dueDateLocalDayStart: $dueDateLocalDayStart, ')
          ..write('dueDateUtcMs: $dueDateUtcMs, ')
          ..write('dueTime: $dueTime, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('isOverdue: $isOverdue, ')
          ..write('overdueDay: $overdueDay, ')
          ..write('recurrenceRuleId: $recurrenceRuleId, ')
          ..write('recurrenceParentId: $recurrenceParentId, ')
          ..write('hasEnabledReminder: $hasEnabledReminder, ')
          ..write('gcalEventId: $gcalEventId, ')
          ..write('syncToGcal: $syncToGcal, ')
          ..write('goalId: $goalId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubtasksTable extends Subtasks
    with TableInfo<$SubtasksTable, SubtaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubtasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tasks(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<int> isCompleted = GeneratedColumn<int>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    title,
    isCompleted,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subtasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubtaskData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubtaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubtaskData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_completed'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SubtasksTable createAlias(String alias) {
    return $SubtasksTable(attachedDatabase, alias);
  }
}

class SubtaskData extends DataClass implements Insertable<SubtaskData> {
  final String id;
  final String taskId;
  final String title;
  final int isCompleted;
  final int sortOrder;
  final int createdAt;
  const SubtaskData({
    required this.id,
    required this.taskId,
    required this.title,
    required this.isCompleted,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['title'] = Variable<String>(title);
    map['is_completed'] = Variable<int>(isCompleted);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  SubtasksCompanion toCompanion(bool nullToAbsent) {
    return SubtasksCompanion(
      id: Value(id),
      taskId: Value(taskId),
      title: Value(title),
      isCompleted: Value(isCompleted),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory SubtaskData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubtaskData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      title: serializer.fromJson<String>(json['title']),
      isCompleted: serializer.fromJson<int>(json['isCompleted']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'title': serializer.toJson<String>(title),
      'isCompleted': serializer.toJson<int>(isCompleted),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  SubtaskData copyWith({
    String? id,
    String? taskId,
    String? title,
    int? isCompleted,
    int? sortOrder,
    int? createdAt,
  }) => SubtaskData(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    title: title ?? this.title,
    isCompleted: isCompleted ?? this.isCompleted,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  SubtaskData copyWithCompanion(SubtasksCompanion data) {
    return SubtaskData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      title: data.title.present ? data.title.value : this.title,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubtaskData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, taskId, title, isCompleted, sortOrder, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubtaskData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.title == this.title &&
          other.isCompleted == this.isCompleted &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class SubtasksCompanion extends UpdateCompanion<SubtaskData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> title;
  final Value<int> isCompleted;
  final Value<int> sortOrder;
  final Value<int> createdAt;
  final Value<int> rowid;
  const SubtasksCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.title = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubtasksCompanion.insert({
    this.id = const Value.absent(),
    required String taskId,
    required String title,
    this.isCompleted = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : taskId = Value(taskId),
       title = Value(title),
       createdAt = Value(createdAt);
  static Insertable<SubtaskData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? title,
    Expression<int>? isCompleted,
    Expression<int>? sortOrder,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (title != null) 'title': title,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubtasksCompanion copyWith({
    Value<String>? id,
    Value<String>? taskId,
    Value<String>? title,
    Value<int>? isCompleted,
    Value<int>? sortOrder,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return SubtasksCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<int>(isCompleted.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubtasksCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, TagData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _colourMeta = const VerificationMeta('colour');
  @override
  late final GeneratedColumn<String> colour = GeneratedColumn<String>(
    'colour',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, colour, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TagData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('colour')) {
      context.handle(
        _colourMeta,
        colour.isAcceptableOrUnknown(data['colour']!, _colourMeta),
      );
    } else if (isInserting) {
      context.missing(_colourMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      colour: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}colour'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class TagData extends DataClass implements Insertable<TagData> {
  final String id;
  final String name;
  final String colour;
  final int createdAt;
  const TagData({
    required this.id,
    required this.name,
    required this.colour,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['colour'] = Variable<String>(colour);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      colour: Value(colour),
      createdAt: Value(createdAt),
    );
  }

  factory TagData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      colour: serializer.fromJson<String>(json['colour']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'colour': serializer.toJson<String>(colour),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  TagData copyWith({
    String? id,
    String? name,
    String? colour,
    int? createdAt,
  }) => TagData(
    id: id ?? this.id,
    name: name ?? this.name,
    colour: colour ?? this.colour,
    createdAt: createdAt ?? this.createdAt,
  );
  TagData copyWithCompanion(TagsCompanion data) {
    return TagData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      colour: data.colour.present ? data.colour.value : this.colour,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colour: $colour, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, colour, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagData &&
          other.id == this.id &&
          other.name == this.name &&
          other.colour == this.colour &&
          other.createdAt == this.createdAt);
}

class TagsCompanion extends UpdateCompanion<TagData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> colour;
  final Value<int> createdAt;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.colour = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String colour,
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       colour = Value(colour),
       createdAt = Value(createdAt);
  static Insertable<TagData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? colour,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (colour != null) 'colour': colour,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? colour,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      colour: colour ?? this.colour,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (colour.present) {
      map['colour'] = Variable<String>(colour.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('colour: $colour, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TaskTagsTable extends TaskTags
    with TableInfo<$TaskTagsTable, TaskTagData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tasks(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tags(id) ON DELETE CASCADE',
  );
  @override
  List<GeneratedColumn> get $columns => [taskId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskTagData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {taskId, tagId};
  @override
  TaskTagData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskTagData(
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $TaskTagsTable createAlias(String alias) {
    return $TaskTagsTable(attachedDatabase, alias);
  }
}

class TaskTagData extends DataClass implements Insertable<TaskTagData> {
  final String taskId;
  final String tagId;
  const TaskTagData({required this.taskId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['task_id'] = Variable<String>(taskId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  TaskTagsCompanion toCompanion(bool nullToAbsent) {
    return TaskTagsCompanion(taskId: Value(taskId), tagId: Value(tagId));
  }

  factory TaskTagData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskTagData(
      taskId: serializer.fromJson<String>(json['taskId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'taskId': serializer.toJson<String>(taskId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  TaskTagData copyWith({String? taskId, String? tagId}) =>
      TaskTagData(taskId: taskId ?? this.taskId, tagId: tagId ?? this.tagId);
  TaskTagData copyWithCompanion(TaskTagsCompanion data) {
    return TaskTagData(
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskTagData(')
          ..write('taskId: $taskId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(taskId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskTagData &&
          other.taskId == this.taskId &&
          other.tagId == this.tagId);
}

class TaskTagsCompanion extends UpdateCompanion<TaskTagData> {
  final Value<String> taskId;
  final Value<String> tagId;
  final Value<int> rowid;
  const TaskTagsCompanion({
    this.taskId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaskTagsCompanion.insert({
    required String taskId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : taskId = Value(taskId),
       tagId = Value(tagId);
  static Insertable<TaskTagData> custom({
    Expression<String>? taskId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (taskId != null) 'task_id': taskId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaskTagsCompanion copyWith({
    Value<String>? taskId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return TaskTagsCompanion(
      taskId: taskId ?? this.taskId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskTagsCompanion(')
          ..write('taskId: $taskId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DailyReviewsTable extends DailyReviews
    with TableInfo<$DailyReviewsTable, DailyReviewData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _reviewDateMeta = const VerificationMeta(
    'reviewDate',
  );
  @override
  late final GeneratedColumn<int> reviewDate = GeneratedColumn<int>(
    'review_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _dayRatingMeta = const VerificationMeta(
    'dayRating',
  );
  @override
  late final GeneratedColumn<int> dayRating = GeneratedColumn<int>(
    'day_rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wentWellMeta = const VerificationMeta(
    'wentWell',
  );
  @override
  late final GeneratedColumn<String> wentWell = GeneratedColumn<String>(
    'went_well',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _couldBeBetterMeta = const VerificationMeta(
    'couldBeBetter',
  );
  @override
  late final GeneratedColumn<String> couldBeBetter = GeneratedColumn<String>(
    'could_be_better',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gratitude1Meta = const VerificationMeta(
    'gratitude1',
  );
  @override
  late final GeneratedColumn<String> gratitude1 = GeneratedColumn<String>(
    'gratitude1',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gratitude2Meta = const VerificationMeta(
    'gratitude2',
  );
  @override
  late final GeneratedColumn<String> gratitude2 = GeneratedColumn<String>(
    'gratitude2',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gratitude3Meta = const VerificationMeta(
    'gratitude3',
  );
  @override
  late final GeneratedColumn<String> gratitude3 = GeneratedColumn<String>(
    'gratitude3',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskCompletionRateMeta =
      const VerificationMeta('taskCompletionRate');
  @override
  late final GeneratedColumn<double> taskCompletionRate =
      GeneratedColumn<double>(
        'task_completion_rate',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reviewDate,
    dayRating,
    wentWell,
    couldBeBetter,
    gratitude1,
    gratitude2,
    gratitude3,
    taskCompletionRate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyReviewData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('review_date')) {
      context.handle(
        _reviewDateMeta,
        reviewDate.isAcceptableOrUnknown(data['review_date']!, _reviewDateMeta),
      );
    } else if (isInserting) {
      context.missing(_reviewDateMeta);
    }
    if (data.containsKey('day_rating')) {
      context.handle(
        _dayRatingMeta,
        dayRating.isAcceptableOrUnknown(data['day_rating']!, _dayRatingMeta),
      );
    } else if (isInserting) {
      context.missing(_dayRatingMeta);
    }
    if (data.containsKey('went_well')) {
      context.handle(
        _wentWellMeta,
        wentWell.isAcceptableOrUnknown(data['went_well']!, _wentWellMeta),
      );
    }
    if (data.containsKey('could_be_better')) {
      context.handle(
        _couldBeBetterMeta,
        couldBeBetter.isAcceptableOrUnknown(
          data['could_be_better']!,
          _couldBeBetterMeta,
        ),
      );
    }
    if (data.containsKey('gratitude1')) {
      context.handle(
        _gratitude1Meta,
        gratitude1.isAcceptableOrUnknown(data['gratitude1']!, _gratitude1Meta),
      );
    } else if (isInserting) {
      context.missing(_gratitude1Meta);
    }
    if (data.containsKey('gratitude2')) {
      context.handle(
        _gratitude2Meta,
        gratitude2.isAcceptableOrUnknown(data['gratitude2']!, _gratitude2Meta),
      );
    } else if (isInserting) {
      context.missing(_gratitude2Meta);
    }
    if (data.containsKey('gratitude3')) {
      context.handle(
        _gratitude3Meta,
        gratitude3.isAcceptableOrUnknown(data['gratitude3']!, _gratitude3Meta),
      );
    } else if (isInserting) {
      context.missing(_gratitude3Meta);
    }
    if (data.containsKey('task_completion_rate')) {
      context.handle(
        _taskCompletionRateMeta,
        taskCompletionRate.isAcceptableOrUnknown(
          data['task_completion_rate']!,
          _taskCompletionRateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyReviewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyReviewData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      reviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_date'],
      )!,
      dayRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_rating'],
      )!,
      wentWell: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}went_well'],
      ),
      couldBeBetter: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}could_be_better'],
      ),
      gratitude1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gratitude1'],
      )!,
      gratitude2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gratitude2'],
      )!,
      gratitude3: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gratitude3'],
      )!,
      taskCompletionRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}task_completion_rate'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $DailyReviewsTable createAlias(String alias) {
    return $DailyReviewsTable(attachedDatabase, alias);
  }
}

class DailyReviewData extends DataClass implements Insertable<DailyReviewData> {
  final String id;
  final int reviewDate;
  final int dayRating;
  final String? wentWell;
  final String? couldBeBetter;
  final String gratitude1;
  final String gratitude2;
  final String gratitude3;
  final double taskCompletionRate;
  final int createdAt;
  const DailyReviewData({
    required this.id,
    required this.reviewDate,
    required this.dayRating,
    this.wentWell,
    this.couldBeBetter,
    required this.gratitude1,
    required this.gratitude2,
    required this.gratitude3,
    required this.taskCompletionRate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['review_date'] = Variable<int>(reviewDate);
    map['day_rating'] = Variable<int>(dayRating);
    if (!nullToAbsent || wentWell != null) {
      map['went_well'] = Variable<String>(wentWell);
    }
    if (!nullToAbsent || couldBeBetter != null) {
      map['could_be_better'] = Variable<String>(couldBeBetter);
    }
    map['gratitude1'] = Variable<String>(gratitude1);
    map['gratitude2'] = Variable<String>(gratitude2);
    map['gratitude3'] = Variable<String>(gratitude3);
    map['task_completion_rate'] = Variable<double>(taskCompletionRate);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  DailyReviewsCompanion toCompanion(bool nullToAbsent) {
    return DailyReviewsCompanion(
      id: Value(id),
      reviewDate: Value(reviewDate),
      dayRating: Value(dayRating),
      wentWell: wentWell == null && nullToAbsent
          ? const Value.absent()
          : Value(wentWell),
      couldBeBetter: couldBeBetter == null && nullToAbsent
          ? const Value.absent()
          : Value(couldBeBetter),
      gratitude1: Value(gratitude1),
      gratitude2: Value(gratitude2),
      gratitude3: Value(gratitude3),
      taskCompletionRate: Value(taskCompletionRate),
      createdAt: Value(createdAt),
    );
  }

  factory DailyReviewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyReviewData(
      id: serializer.fromJson<String>(json['id']),
      reviewDate: serializer.fromJson<int>(json['reviewDate']),
      dayRating: serializer.fromJson<int>(json['dayRating']),
      wentWell: serializer.fromJson<String?>(json['wentWell']),
      couldBeBetter: serializer.fromJson<String?>(json['couldBeBetter']),
      gratitude1: serializer.fromJson<String>(json['gratitude1']),
      gratitude2: serializer.fromJson<String>(json['gratitude2']),
      gratitude3: serializer.fromJson<String>(json['gratitude3']),
      taskCompletionRate: serializer.fromJson<double>(
        json['taskCompletionRate'],
      ),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'reviewDate': serializer.toJson<int>(reviewDate),
      'dayRating': serializer.toJson<int>(dayRating),
      'wentWell': serializer.toJson<String?>(wentWell),
      'couldBeBetter': serializer.toJson<String?>(couldBeBetter),
      'gratitude1': serializer.toJson<String>(gratitude1),
      'gratitude2': serializer.toJson<String>(gratitude2),
      'gratitude3': serializer.toJson<String>(gratitude3),
      'taskCompletionRate': serializer.toJson<double>(taskCompletionRate),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  DailyReviewData copyWith({
    String? id,
    int? reviewDate,
    int? dayRating,
    Value<String?> wentWell = const Value.absent(),
    Value<String?> couldBeBetter = const Value.absent(),
    String? gratitude1,
    String? gratitude2,
    String? gratitude3,
    double? taskCompletionRate,
    int? createdAt,
  }) => DailyReviewData(
    id: id ?? this.id,
    reviewDate: reviewDate ?? this.reviewDate,
    dayRating: dayRating ?? this.dayRating,
    wentWell: wentWell.present ? wentWell.value : this.wentWell,
    couldBeBetter: couldBeBetter.present
        ? couldBeBetter.value
        : this.couldBeBetter,
    gratitude1: gratitude1 ?? this.gratitude1,
    gratitude2: gratitude2 ?? this.gratitude2,
    gratitude3: gratitude3 ?? this.gratitude3,
    taskCompletionRate: taskCompletionRate ?? this.taskCompletionRate,
    createdAt: createdAt ?? this.createdAt,
  );
  DailyReviewData copyWithCompanion(DailyReviewsCompanion data) {
    return DailyReviewData(
      id: data.id.present ? data.id.value : this.id,
      reviewDate: data.reviewDate.present
          ? data.reviewDate.value
          : this.reviewDate,
      dayRating: data.dayRating.present ? data.dayRating.value : this.dayRating,
      wentWell: data.wentWell.present ? data.wentWell.value : this.wentWell,
      couldBeBetter: data.couldBeBetter.present
          ? data.couldBeBetter.value
          : this.couldBeBetter,
      gratitude1: data.gratitude1.present
          ? data.gratitude1.value
          : this.gratitude1,
      gratitude2: data.gratitude2.present
          ? data.gratitude2.value
          : this.gratitude2,
      gratitude3: data.gratitude3.present
          ? data.gratitude3.value
          : this.gratitude3,
      taskCompletionRate: data.taskCompletionRate.present
          ? data.taskCompletionRate.value
          : this.taskCompletionRate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyReviewData(')
          ..write('id: $id, ')
          ..write('reviewDate: $reviewDate, ')
          ..write('dayRating: $dayRating, ')
          ..write('wentWell: $wentWell, ')
          ..write('couldBeBetter: $couldBeBetter, ')
          ..write('gratitude1: $gratitude1, ')
          ..write('gratitude2: $gratitude2, ')
          ..write('gratitude3: $gratitude3, ')
          ..write('taskCompletionRate: $taskCompletionRate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    reviewDate,
    dayRating,
    wentWell,
    couldBeBetter,
    gratitude1,
    gratitude2,
    gratitude3,
    taskCompletionRate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyReviewData &&
          other.id == this.id &&
          other.reviewDate == this.reviewDate &&
          other.dayRating == this.dayRating &&
          other.wentWell == this.wentWell &&
          other.couldBeBetter == this.couldBeBetter &&
          other.gratitude1 == this.gratitude1 &&
          other.gratitude2 == this.gratitude2 &&
          other.gratitude3 == this.gratitude3 &&
          other.taskCompletionRate == this.taskCompletionRate &&
          other.createdAt == this.createdAt);
}

class DailyReviewsCompanion extends UpdateCompanion<DailyReviewData> {
  final Value<String> id;
  final Value<int> reviewDate;
  final Value<int> dayRating;
  final Value<String?> wentWell;
  final Value<String?> couldBeBetter;
  final Value<String> gratitude1;
  final Value<String> gratitude2;
  final Value<String> gratitude3;
  final Value<double> taskCompletionRate;
  final Value<int> createdAt;
  final Value<int> rowid;
  const DailyReviewsCompanion({
    this.id = const Value.absent(),
    this.reviewDate = const Value.absent(),
    this.dayRating = const Value.absent(),
    this.wentWell = const Value.absent(),
    this.couldBeBetter = const Value.absent(),
    this.gratitude1 = const Value.absent(),
    this.gratitude2 = const Value.absent(),
    this.gratitude3 = const Value.absent(),
    this.taskCompletionRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DailyReviewsCompanion.insert({
    this.id = const Value.absent(),
    required int reviewDate,
    required int dayRating,
    this.wentWell = const Value.absent(),
    this.couldBeBetter = const Value.absent(),
    required String gratitude1,
    required String gratitude2,
    required String gratitude3,
    this.taskCompletionRate = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : reviewDate = Value(reviewDate),
       dayRating = Value(dayRating),
       gratitude1 = Value(gratitude1),
       gratitude2 = Value(gratitude2),
       gratitude3 = Value(gratitude3),
       createdAt = Value(createdAt);
  static Insertable<DailyReviewData> custom({
    Expression<String>? id,
    Expression<int>? reviewDate,
    Expression<int>? dayRating,
    Expression<String>? wentWell,
    Expression<String>? couldBeBetter,
    Expression<String>? gratitude1,
    Expression<String>? gratitude2,
    Expression<String>? gratitude3,
    Expression<double>? taskCompletionRate,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reviewDate != null) 'review_date': reviewDate,
      if (dayRating != null) 'day_rating': dayRating,
      if (wentWell != null) 'went_well': wentWell,
      if (couldBeBetter != null) 'could_be_better': couldBeBetter,
      if (gratitude1 != null) 'gratitude1': gratitude1,
      if (gratitude2 != null) 'gratitude2': gratitude2,
      if (gratitude3 != null) 'gratitude3': gratitude3,
      if (taskCompletionRate != null)
        'task_completion_rate': taskCompletionRate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DailyReviewsCompanion copyWith({
    Value<String>? id,
    Value<int>? reviewDate,
    Value<int>? dayRating,
    Value<String?>? wentWell,
    Value<String?>? couldBeBetter,
    Value<String>? gratitude1,
    Value<String>? gratitude2,
    Value<String>? gratitude3,
    Value<double>? taskCompletionRate,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return DailyReviewsCompanion(
      id: id ?? this.id,
      reviewDate: reviewDate ?? this.reviewDate,
      dayRating: dayRating ?? this.dayRating,
      wentWell: wentWell ?? this.wentWell,
      couldBeBetter: couldBeBetter ?? this.couldBeBetter,
      gratitude1: gratitude1 ?? this.gratitude1,
      gratitude2: gratitude2 ?? this.gratitude2,
      gratitude3: gratitude3 ?? this.gratitude3,
      taskCompletionRate: taskCompletionRate ?? this.taskCompletionRate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (reviewDate.present) {
      map['review_date'] = Variable<int>(reviewDate.value);
    }
    if (dayRating.present) {
      map['day_rating'] = Variable<int>(dayRating.value);
    }
    if (wentWell.present) {
      map['went_well'] = Variable<String>(wentWell.value);
    }
    if (couldBeBetter.present) {
      map['could_be_better'] = Variable<String>(couldBeBetter.value);
    }
    if (gratitude1.present) {
      map['gratitude1'] = Variable<String>(gratitude1.value);
    }
    if (gratitude2.present) {
      map['gratitude2'] = Variable<String>(gratitude2.value);
    }
    if (gratitude3.present) {
      map['gratitude3'] = Variable<String>(gratitude3.value);
    }
    if (taskCompletionRate.present) {
      map['task_completion_rate'] = Variable<double>(taskCompletionRate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyReviewsCompanion(')
          ..write('id: $id, ')
          ..write('reviewDate: $reviewDate, ')
          ..write('dayRating: $dayRating, ')
          ..write('wentWell: $wentWell, ')
          ..write('couldBeBetter: $couldBeBetter, ')
          ..write('gratitude1: $gratitude1, ')
          ..write('gratitude2: $gratitude2, ')
          ..write('gratitude3: $gratitude3, ')
          ..write('taskCompletionRate: $taskCompletionRate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyPlansTable extends WeeklyPlans
    with TableInfo<$WeeklyPlansTable, WeeklyPlanData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _weekStartDateMeta = const VerificationMeta(
    'weekStartDate',
  );
  @override
  late final GeneratedColumn<int> weekStartDate = GeneratedColumn<int>(
    'week_start_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
    'theme',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intentionsMeta = const VerificationMeta(
    'intentions',
  );
  @override
  late final GeneratedColumn<String> intentions = GeneratedColumn<String>(
    'intentions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    weekStartDate,
    theme,
    intentions,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyPlanData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('week_start_date')) {
      context.handle(
        _weekStartDateMeta,
        weekStartDate.isAcceptableOrUnknown(
          data['week_start_date']!,
          _weekStartDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekStartDateMeta);
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    }
    if (data.containsKey('intentions')) {
      context.handle(
        _intentionsMeta,
        intentions.isAcceptableOrUnknown(data['intentions']!, _intentionsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyPlanData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyPlanData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      weekStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_start_date'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme'],
      ),
      intentions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intentions'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WeeklyPlansTable createAlias(String alias) {
    return $WeeklyPlansTable(attachedDatabase, alias);
  }
}

class WeeklyPlanData extends DataClass implements Insertable<WeeklyPlanData> {
  final String id;
  final int weekStartDate;
  final String? theme;
  final String? intentions;
  final int createdAt;
  const WeeklyPlanData({
    required this.id,
    required this.weekStartDate,
    this.theme,
    this.intentions,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['week_start_date'] = Variable<int>(weekStartDate);
    if (!nullToAbsent || theme != null) {
      map['theme'] = Variable<String>(theme);
    }
    if (!nullToAbsent || intentions != null) {
      map['intentions'] = Variable<String>(intentions);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  WeeklyPlansCompanion toCompanion(bool nullToAbsent) {
    return WeeklyPlansCompanion(
      id: Value(id),
      weekStartDate: Value(weekStartDate),
      theme: theme == null && nullToAbsent
          ? const Value.absent()
          : Value(theme),
      intentions: intentions == null && nullToAbsent
          ? const Value.absent()
          : Value(intentions),
      createdAt: Value(createdAt),
    );
  }

  factory WeeklyPlanData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyPlanData(
      id: serializer.fromJson<String>(json['id']),
      weekStartDate: serializer.fromJson<int>(json['weekStartDate']),
      theme: serializer.fromJson<String?>(json['theme']),
      intentions: serializer.fromJson<String?>(json['intentions']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'weekStartDate': serializer.toJson<int>(weekStartDate),
      'theme': serializer.toJson<String?>(theme),
      'intentions': serializer.toJson<String?>(intentions),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  WeeklyPlanData copyWith({
    String? id,
    int? weekStartDate,
    Value<String?> theme = const Value.absent(),
    Value<String?> intentions = const Value.absent(),
    int? createdAt,
  }) => WeeklyPlanData(
    id: id ?? this.id,
    weekStartDate: weekStartDate ?? this.weekStartDate,
    theme: theme.present ? theme.value : this.theme,
    intentions: intentions.present ? intentions.value : this.intentions,
    createdAt: createdAt ?? this.createdAt,
  );
  WeeklyPlanData copyWithCompanion(WeeklyPlansCompanion data) {
    return WeeklyPlanData(
      id: data.id.present ? data.id.value : this.id,
      weekStartDate: data.weekStartDate.present
          ? data.weekStartDate.value
          : this.weekStartDate,
      theme: data.theme.present ? data.theme.value : this.theme,
      intentions: data.intentions.present
          ? data.intentions.value
          : this.intentions,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyPlanData(')
          ..write('id: $id, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('theme: $theme, ')
          ..write('intentions: $intentions, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, weekStartDate, theme, intentions, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyPlanData &&
          other.id == this.id &&
          other.weekStartDate == this.weekStartDate &&
          other.theme == this.theme &&
          other.intentions == this.intentions &&
          other.createdAt == this.createdAt);
}

class WeeklyPlansCompanion extends UpdateCompanion<WeeklyPlanData> {
  final Value<String> id;
  final Value<int> weekStartDate;
  final Value<String?> theme;
  final Value<String?> intentions;
  final Value<int> createdAt;
  final Value<int> rowid;
  const WeeklyPlansCompanion({
    this.id = const Value.absent(),
    this.weekStartDate = const Value.absent(),
    this.theme = const Value.absent(),
    this.intentions = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyPlansCompanion.insert({
    this.id = const Value.absent(),
    required int weekStartDate,
    this.theme = const Value.absent(),
    this.intentions = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : weekStartDate = Value(weekStartDate),
       createdAt = Value(createdAt);
  static Insertable<WeeklyPlanData> custom({
    Expression<String>? id,
    Expression<int>? weekStartDate,
    Expression<String>? theme,
    Expression<String>? intentions,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekStartDate != null) 'week_start_date': weekStartDate,
      if (theme != null) 'theme': theme,
      if (intentions != null) 'intentions': intentions,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyPlansCompanion copyWith({
    Value<String>? id,
    Value<int>? weekStartDate,
    Value<String?>? theme,
    Value<String?>? intentions,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return WeeklyPlansCompanion(
      id: id ?? this.id,
      weekStartDate: weekStartDate ?? this.weekStartDate,
      theme: theme ?? this.theme,
      intentions: intentions ?? this.intentions,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (weekStartDate.present) {
      map['week_start_date'] = Variable<int>(weekStartDate.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (intentions.present) {
      map['intentions'] = Variable<String>(intentions.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyPlansCompanion(')
          ..write('id: $id, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('theme: $theme, ')
          ..write('intentions: $intentions, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyReviewsTable extends WeeklyReviews
    with TableInfo<$WeeklyReviewsTable, WeeklyReviewData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _weekStartDateMeta = const VerificationMeta(
    'weekStartDate',
  );
  @override
  late final GeneratedColumn<int> weekStartDate = GeneratedColumn<int>(
    'week_start_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES weekly_plans(week_start_date)',
  );
  static const VerificationMeta _themeAchievedMeta = const VerificationMeta(
    'themeAchieved',
  );
  @override
  late final GeneratedColumn<int> themeAchieved = GeneratedColumn<int>(
    'theme_achieved',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reflectionNotesMeta = const VerificationMeta(
    'reflectionNotes',
  );
  @override
  late final GeneratedColumn<String> reflectionNotes = GeneratedColumn<String>(
    'reflection_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weekRatingMeta = const VerificationMeta(
    'weekRating',
  );
  @override
  late final GeneratedColumn<int> weekRating = GeneratedColumn<int>(
    'week_rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalHitRateMeta = const VerificationMeta(
    'goalHitRate',
  );
  @override
  late final GeneratedColumn<double> goalHitRate = GeneratedColumn<double>(
    'goal_hit_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    weekStartDate,
    themeAchieved,
    reflectionNotes,
    weekRating,
    goalHitRate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyReviewData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('week_start_date')) {
      context.handle(
        _weekStartDateMeta,
        weekStartDate.isAcceptableOrUnknown(
          data['week_start_date']!,
          _weekStartDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekStartDateMeta);
    }
    if (data.containsKey('theme_achieved')) {
      context.handle(
        _themeAchievedMeta,
        themeAchieved.isAcceptableOrUnknown(
          data['theme_achieved']!,
          _themeAchievedMeta,
        ),
      );
    }
    if (data.containsKey('reflection_notes')) {
      context.handle(
        _reflectionNotesMeta,
        reflectionNotes.isAcceptableOrUnknown(
          data['reflection_notes']!,
          _reflectionNotesMeta,
        ),
      );
    }
    if (data.containsKey('week_rating')) {
      context.handle(
        _weekRatingMeta,
        weekRating.isAcceptableOrUnknown(data['week_rating']!, _weekRatingMeta),
      );
    } else if (isInserting) {
      context.missing(_weekRatingMeta);
    }
    if (data.containsKey('goal_hit_rate')) {
      context.handle(
        _goalHitRateMeta,
        goalHitRate.isAcceptableOrUnknown(
          data['goal_hit_rate']!,
          _goalHitRateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyReviewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyReviewData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      weekStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_start_date'],
      )!,
      themeAchieved: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}theme_achieved'],
      ),
      reflectionNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reflection_notes'],
      ),
      weekRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_rating'],
      )!,
      goalHitRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}goal_hit_rate'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $WeeklyReviewsTable createAlias(String alias) {
    return $WeeklyReviewsTable(attachedDatabase, alias);
  }
}

class WeeklyReviewData extends DataClass
    implements Insertable<WeeklyReviewData> {
  final String id;
  final int weekStartDate;
  final int? themeAchieved;
  final String? reflectionNotes;
  final int weekRating;
  final double goalHitRate;
  final int createdAt;
  const WeeklyReviewData({
    required this.id,
    required this.weekStartDate,
    this.themeAchieved,
    this.reflectionNotes,
    required this.weekRating,
    required this.goalHitRate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['week_start_date'] = Variable<int>(weekStartDate);
    if (!nullToAbsent || themeAchieved != null) {
      map['theme_achieved'] = Variable<int>(themeAchieved);
    }
    if (!nullToAbsent || reflectionNotes != null) {
      map['reflection_notes'] = Variable<String>(reflectionNotes);
    }
    map['week_rating'] = Variable<int>(weekRating);
    map['goal_hit_rate'] = Variable<double>(goalHitRate);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  WeeklyReviewsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyReviewsCompanion(
      id: Value(id),
      weekStartDate: Value(weekStartDate),
      themeAchieved: themeAchieved == null && nullToAbsent
          ? const Value.absent()
          : Value(themeAchieved),
      reflectionNotes: reflectionNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(reflectionNotes),
      weekRating: Value(weekRating),
      goalHitRate: Value(goalHitRate),
      createdAt: Value(createdAt),
    );
  }

  factory WeeklyReviewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyReviewData(
      id: serializer.fromJson<String>(json['id']),
      weekStartDate: serializer.fromJson<int>(json['weekStartDate']),
      themeAchieved: serializer.fromJson<int?>(json['themeAchieved']),
      reflectionNotes: serializer.fromJson<String?>(json['reflectionNotes']),
      weekRating: serializer.fromJson<int>(json['weekRating']),
      goalHitRate: serializer.fromJson<double>(json['goalHitRate']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'weekStartDate': serializer.toJson<int>(weekStartDate),
      'themeAchieved': serializer.toJson<int?>(themeAchieved),
      'reflectionNotes': serializer.toJson<String?>(reflectionNotes),
      'weekRating': serializer.toJson<int>(weekRating),
      'goalHitRate': serializer.toJson<double>(goalHitRate),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  WeeklyReviewData copyWith({
    String? id,
    int? weekStartDate,
    Value<int?> themeAchieved = const Value.absent(),
    Value<String?> reflectionNotes = const Value.absent(),
    int? weekRating,
    double? goalHitRate,
    int? createdAt,
  }) => WeeklyReviewData(
    id: id ?? this.id,
    weekStartDate: weekStartDate ?? this.weekStartDate,
    themeAchieved: themeAchieved.present
        ? themeAchieved.value
        : this.themeAchieved,
    reflectionNotes: reflectionNotes.present
        ? reflectionNotes.value
        : this.reflectionNotes,
    weekRating: weekRating ?? this.weekRating,
    goalHitRate: goalHitRate ?? this.goalHitRate,
    createdAt: createdAt ?? this.createdAt,
  );
  WeeklyReviewData copyWithCompanion(WeeklyReviewsCompanion data) {
    return WeeklyReviewData(
      id: data.id.present ? data.id.value : this.id,
      weekStartDate: data.weekStartDate.present
          ? data.weekStartDate.value
          : this.weekStartDate,
      themeAchieved: data.themeAchieved.present
          ? data.themeAchieved.value
          : this.themeAchieved,
      reflectionNotes: data.reflectionNotes.present
          ? data.reflectionNotes.value
          : this.reflectionNotes,
      weekRating: data.weekRating.present
          ? data.weekRating.value
          : this.weekRating,
      goalHitRate: data.goalHitRate.present
          ? data.goalHitRate.value
          : this.goalHitRate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewData(')
          ..write('id: $id, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('themeAchieved: $themeAchieved, ')
          ..write('reflectionNotes: $reflectionNotes, ')
          ..write('weekRating: $weekRating, ')
          ..write('goalHitRate: $goalHitRate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    weekStartDate,
    themeAchieved,
    reflectionNotes,
    weekRating,
    goalHitRate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyReviewData &&
          other.id == this.id &&
          other.weekStartDate == this.weekStartDate &&
          other.themeAchieved == this.themeAchieved &&
          other.reflectionNotes == this.reflectionNotes &&
          other.weekRating == this.weekRating &&
          other.goalHitRate == this.goalHitRate &&
          other.createdAt == this.createdAt);
}

class WeeklyReviewsCompanion extends UpdateCompanion<WeeklyReviewData> {
  final Value<String> id;
  final Value<int> weekStartDate;
  final Value<int?> themeAchieved;
  final Value<String?> reflectionNotes;
  final Value<int> weekRating;
  final Value<double> goalHitRate;
  final Value<int> createdAt;
  final Value<int> rowid;
  const WeeklyReviewsCompanion({
    this.id = const Value.absent(),
    this.weekStartDate = const Value.absent(),
    this.themeAchieved = const Value.absent(),
    this.reflectionNotes = const Value.absent(),
    this.weekRating = const Value.absent(),
    this.goalHitRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyReviewsCompanion.insert({
    this.id = const Value.absent(),
    required int weekStartDate,
    this.themeAchieved = const Value.absent(),
    this.reflectionNotes = const Value.absent(),
    required int weekRating,
    this.goalHitRate = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : weekStartDate = Value(weekStartDate),
       weekRating = Value(weekRating),
       createdAt = Value(createdAt);
  static Insertable<WeeklyReviewData> custom({
    Expression<String>? id,
    Expression<int>? weekStartDate,
    Expression<int>? themeAchieved,
    Expression<String>? reflectionNotes,
    Expression<int>? weekRating,
    Expression<double>? goalHitRate,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekStartDate != null) 'week_start_date': weekStartDate,
      if (themeAchieved != null) 'theme_achieved': themeAchieved,
      if (reflectionNotes != null) 'reflection_notes': reflectionNotes,
      if (weekRating != null) 'week_rating': weekRating,
      if (goalHitRate != null) 'goal_hit_rate': goalHitRate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyReviewsCompanion copyWith({
    Value<String>? id,
    Value<int>? weekStartDate,
    Value<int?>? themeAchieved,
    Value<String?>? reflectionNotes,
    Value<int>? weekRating,
    Value<double>? goalHitRate,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return WeeklyReviewsCompanion(
      id: id ?? this.id,
      weekStartDate: weekStartDate ?? this.weekStartDate,
      themeAchieved: themeAchieved ?? this.themeAchieved,
      reflectionNotes: reflectionNotes ?? this.reflectionNotes,
      weekRating: weekRating ?? this.weekRating,
      goalHitRate: goalHitRate ?? this.goalHitRate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (weekStartDate.present) {
      map['week_start_date'] = Variable<int>(weekStartDate.value);
    }
    if (themeAchieved.present) {
      map['theme_achieved'] = Variable<int>(themeAchieved.value);
    }
    if (reflectionNotes.present) {
      map['reflection_notes'] = Variable<String>(reflectionNotes.value);
    }
    if (weekRating.present) {
      map['week_rating'] = Variable<int>(weekRating.value);
    }
    if (goalHitRate.present) {
      map['goal_hit_rate'] = Variable<double>(goalHitRate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewsCompanion(')
          ..write('id: $id, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('themeAchieved: $themeAchieved, ')
          ..write('reflectionNotes: $reflectionNotes, ')
          ..write('weekRating: $weekRating, ')
          ..write('goalHitRate: $goalHitRate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyGoalsTable extends WeeklyGoals
    with TableInfo<$WeeklyGoalsTable, WeeklyGoalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _weekStartDateMeta = const VerificationMeta(
    'weekStartDate',
  );
  @override
  late final GeneratedColumn<int> weekStartDate = GeneratedColumn<int>(
    'week_start_date',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES weekly_plans(week_start_date)',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAchievedMeta = const VerificationMeta(
    'isAchieved',
  );
  @override
  late final GeneratedColumn<int> isAchieved = GeneratedColumn<int>(
    'is_achieved',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    weekStartDate,
    title,
    isAchieved,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyGoalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('week_start_date')) {
      context.handle(
        _weekStartDateMeta,
        weekStartDate.isAcceptableOrUnknown(
          data['week_start_date']!,
          _weekStartDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekStartDateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_achieved')) {
      context.handle(
        _isAchievedMeta,
        isAchieved.isAcceptableOrUnknown(data['is_achieved']!, _isAchievedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyGoalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyGoalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      weekStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}week_start_date'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      isAchieved: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_achieved'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $WeeklyGoalsTable createAlias(String alias) {
    return $WeeklyGoalsTable(attachedDatabase, alias);
  }
}

class WeeklyGoalData extends DataClass implements Insertable<WeeklyGoalData> {
  final String id;
  final int weekStartDate;
  final String title;
  final int isAchieved;
  final int sortOrder;
  const WeeklyGoalData({
    required this.id,
    required this.weekStartDate,
    required this.title,
    required this.isAchieved,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['week_start_date'] = Variable<int>(weekStartDate);
    map['title'] = Variable<String>(title);
    map['is_achieved'] = Variable<int>(isAchieved);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  WeeklyGoalsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyGoalsCompanion(
      id: Value(id),
      weekStartDate: Value(weekStartDate),
      title: Value(title),
      isAchieved: Value(isAchieved),
      sortOrder: Value(sortOrder),
    );
  }

  factory WeeklyGoalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyGoalData(
      id: serializer.fromJson<String>(json['id']),
      weekStartDate: serializer.fromJson<int>(json['weekStartDate']),
      title: serializer.fromJson<String>(json['title']),
      isAchieved: serializer.fromJson<int>(json['isAchieved']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'weekStartDate': serializer.toJson<int>(weekStartDate),
      'title': serializer.toJson<String>(title),
      'isAchieved': serializer.toJson<int>(isAchieved),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  WeeklyGoalData copyWith({
    String? id,
    int? weekStartDate,
    String? title,
    int? isAchieved,
    int? sortOrder,
  }) => WeeklyGoalData(
    id: id ?? this.id,
    weekStartDate: weekStartDate ?? this.weekStartDate,
    title: title ?? this.title,
    isAchieved: isAchieved ?? this.isAchieved,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  WeeklyGoalData copyWithCompanion(WeeklyGoalsCompanion data) {
    return WeeklyGoalData(
      id: data.id.present ? data.id.value : this.id,
      weekStartDate: data.weekStartDate.present
          ? data.weekStartDate.value
          : this.weekStartDate,
      title: data.title.present ? data.title.value : this.title,
      isAchieved: data.isAchieved.present
          ? data.isAchieved.value
          : this.isAchieved,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyGoalData(')
          ..write('id: $id, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('title: $title, ')
          ..write('isAchieved: $isAchieved, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, weekStartDate, title, isAchieved, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyGoalData &&
          other.id == this.id &&
          other.weekStartDate == this.weekStartDate &&
          other.title == this.title &&
          other.isAchieved == this.isAchieved &&
          other.sortOrder == this.sortOrder);
}

class WeeklyGoalsCompanion extends UpdateCompanion<WeeklyGoalData> {
  final Value<String> id;
  final Value<int> weekStartDate;
  final Value<String> title;
  final Value<int> isAchieved;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const WeeklyGoalsCompanion({
    this.id = const Value.absent(),
    this.weekStartDate = const Value.absent(),
    this.title = const Value.absent(),
    this.isAchieved = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyGoalsCompanion.insert({
    this.id = const Value.absent(),
    required int weekStartDate,
    required String title,
    this.isAchieved = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : weekStartDate = Value(weekStartDate),
       title = Value(title);
  static Insertable<WeeklyGoalData> custom({
    Expression<String>? id,
    Expression<int>? weekStartDate,
    Expression<String>? title,
    Expression<int>? isAchieved,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekStartDate != null) 'week_start_date': weekStartDate,
      if (title != null) 'title': title,
      if (isAchieved != null) 'is_achieved': isAchieved,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyGoalsCompanion copyWith({
    Value<String>? id,
    Value<int>? weekStartDate,
    Value<String>? title,
    Value<int>? isAchieved,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return WeeklyGoalsCompanion(
      id: id ?? this.id,
      weekStartDate: weekStartDate ?? this.weekStartDate,
      title: title ?? this.title,
      isAchieved: isAchieved ?? this.isAchieved,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (weekStartDate.present) {
      map['week_start_date'] = Variable<int>(weekStartDate.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isAchieved.present) {
      map['is_achieved'] = Variable<int>(isAchieved.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyGoalsCompanion(')
          ..write('id: $id, ')
          ..write('weekStartDate: $weekStartDate, ')
          ..write('title: $title, ')
          ..write('isAchieved: $isAchieved, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyPlansTable extends MonthlyPlans
    with TableInfo<$MonthlyPlansTable, MonthlyPlanData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _monthYearMeta = const VerificationMeta(
    'monthYear',
  );
  @override
  late final GeneratedColumn<String> monthYear = GeneratedColumn<String>(
    'month_year',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _intentionsMeta = const VerificationMeta(
    'intentions',
  );
  @override
  late final GeneratedColumn<String> intentions = GeneratedColumn<String>(
    'intentions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, monthYear, intentions, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyPlanData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month_year')) {
      context.handle(
        _monthYearMeta,
        monthYear.isAcceptableOrUnknown(data['month_year']!, _monthYearMeta),
      );
    } else if (isInserting) {
      context.missing(_monthYearMeta);
    }
    if (data.containsKey('intentions')) {
      context.handle(
        _intentionsMeta,
        intentions.isAcceptableOrUnknown(data['intentions']!, _intentionsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlyPlanData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyPlanData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      monthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_year'],
      )!,
      intentions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intentions'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MonthlyPlansTable createAlias(String alias) {
    return $MonthlyPlansTable(attachedDatabase, alias);
  }
}

class MonthlyPlanData extends DataClass implements Insertable<MonthlyPlanData> {
  final String id;
  final String monthYear;
  final String? intentions;
  final int createdAt;
  const MonthlyPlanData({
    required this.id,
    required this.monthYear,
    this.intentions,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['month_year'] = Variable<String>(monthYear);
    if (!nullToAbsent || intentions != null) {
      map['intentions'] = Variable<String>(intentions);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  MonthlyPlansCompanion toCompanion(bool nullToAbsent) {
    return MonthlyPlansCompanion(
      id: Value(id),
      monthYear: Value(monthYear),
      intentions: intentions == null && nullToAbsent
          ? const Value.absent()
          : Value(intentions),
      createdAt: Value(createdAt),
    );
  }

  factory MonthlyPlanData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyPlanData(
      id: serializer.fromJson<String>(json['id']),
      monthYear: serializer.fromJson<String>(json['monthYear']),
      intentions: serializer.fromJson<String?>(json['intentions']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'monthYear': serializer.toJson<String>(monthYear),
      'intentions': serializer.toJson<String?>(intentions),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  MonthlyPlanData copyWith({
    String? id,
    String? monthYear,
    Value<String?> intentions = const Value.absent(),
    int? createdAt,
  }) => MonthlyPlanData(
    id: id ?? this.id,
    monthYear: monthYear ?? this.monthYear,
    intentions: intentions.present ? intentions.value : this.intentions,
    createdAt: createdAt ?? this.createdAt,
  );
  MonthlyPlanData copyWithCompanion(MonthlyPlansCompanion data) {
    return MonthlyPlanData(
      id: data.id.present ? data.id.value : this.id,
      monthYear: data.monthYear.present ? data.monthYear.value : this.monthYear,
      intentions: data.intentions.present
          ? data.intentions.value
          : this.intentions,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyPlanData(')
          ..write('id: $id, ')
          ..write('monthYear: $monthYear, ')
          ..write('intentions: $intentions, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, monthYear, intentions, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyPlanData &&
          other.id == this.id &&
          other.monthYear == this.monthYear &&
          other.intentions == this.intentions &&
          other.createdAt == this.createdAt);
}

class MonthlyPlansCompanion extends UpdateCompanion<MonthlyPlanData> {
  final Value<String> id;
  final Value<String> monthYear;
  final Value<String?> intentions;
  final Value<int> createdAt;
  final Value<int> rowid;
  const MonthlyPlansCompanion({
    this.id = const Value.absent(),
    this.monthYear = const Value.absent(),
    this.intentions = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyPlansCompanion.insert({
    this.id = const Value.absent(),
    required String monthYear,
    this.intentions = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : monthYear = Value(monthYear),
       createdAt = Value(createdAt);
  static Insertable<MonthlyPlanData> custom({
    Expression<String>? id,
    Expression<String>? monthYear,
    Expression<String>? intentions,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthYear != null) 'month_year': monthYear,
      if (intentions != null) 'intentions': intentions,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyPlansCompanion copyWith({
    Value<String>? id,
    Value<String>? monthYear,
    Value<String?>? intentions,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return MonthlyPlansCompanion(
      id: id ?? this.id,
      monthYear: monthYear ?? this.monthYear,
      intentions: intentions ?? this.intentions,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (monthYear.present) {
      map['month_year'] = Variable<String>(monthYear.value);
    }
    if (intentions.present) {
      map['intentions'] = Variable<String>(intentions.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyPlansCompanion(')
          ..write('id: $id, ')
          ..write('monthYear: $monthYear, ')
          ..write('intentions: $intentions, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyReviewsTable extends MonthlyReviews
    with TableInfo<$MonthlyReviewsTable, MonthlyReviewData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _monthYearMeta = const VerificationMeta(
    'monthYear',
  );
  @override
  late final GeneratedColumn<String> monthYear = GeneratedColumn<String>(
    'month_year',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES monthly_plans(month_year)',
  );
  static const VerificationMeta _overallRatingMeta = const VerificationMeta(
    'overallRating',
  );
  @override
  late final GeneratedColumn<int> overallRating = GeneratedColumn<int>(
    'overall_rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _win1Meta = const VerificationMeta('win1');
  @override
  late final GeneratedColumn<String> win1 = GeneratedColumn<String>(
    'win1',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _win2Meta = const VerificationMeta('win2');
  @override
  late final GeneratedColumn<String> win2 = GeneratedColumn<String>(
    'win2',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _win3Meta = const VerificationMeta('win3');
  @override
  late final GeneratedColumn<String> win3 = GeneratedColumn<String>(
    'win3',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _challenge1Meta = const VerificationMeta(
    'challenge1',
  );
  @override
  late final GeneratedColumn<String> challenge1 = GeneratedColumn<String>(
    'challenge1',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _challenge2Meta = const VerificationMeta(
    'challenge2',
  );
  @override
  late final GeneratedColumn<String> challenge2 = GeneratedColumn<String>(
    'challenge2',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _challenge3Meta = const VerificationMeta(
    'challenge3',
  );
  @override
  late final GeneratedColumn<String> challenge3 = GeneratedColumn<String>(
    'challenge3',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gratitudeSummaryMeta = const VerificationMeta(
    'gratitudeSummary',
  );
  @override
  late final GeneratedColumn<String> gratitudeSummary = GeneratedColumn<String>(
    'gratitude_summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intentionsNextMonthMeta =
      const VerificationMeta('intentionsNextMonth');
  @override
  late final GeneratedColumn<String> intentionsNextMonth =
      GeneratedColumn<String>(
        'intentions_next_month',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _goalCompletionRateMeta =
      const VerificationMeta('goalCompletionRate');
  @override
  late final GeneratedColumn<double> goalCompletionRate =
      GeneratedColumn<double>(
        'goal_completion_rate',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0.0),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monthYear,
    overallRating,
    win1,
    win2,
    win3,
    challenge1,
    challenge2,
    challenge3,
    gratitudeSummary,
    intentionsNextMonth,
    goalCompletionRate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyReviewData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month_year')) {
      context.handle(
        _monthYearMeta,
        monthYear.isAcceptableOrUnknown(data['month_year']!, _monthYearMeta),
      );
    } else if (isInserting) {
      context.missing(_monthYearMeta);
    }
    if (data.containsKey('overall_rating')) {
      context.handle(
        _overallRatingMeta,
        overallRating.isAcceptableOrUnknown(
          data['overall_rating']!,
          _overallRatingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_overallRatingMeta);
    }
    if (data.containsKey('win1')) {
      context.handle(
        _win1Meta,
        win1.isAcceptableOrUnknown(data['win1']!, _win1Meta),
      );
    }
    if (data.containsKey('win2')) {
      context.handle(
        _win2Meta,
        win2.isAcceptableOrUnknown(data['win2']!, _win2Meta),
      );
    }
    if (data.containsKey('win3')) {
      context.handle(
        _win3Meta,
        win3.isAcceptableOrUnknown(data['win3']!, _win3Meta),
      );
    }
    if (data.containsKey('challenge1')) {
      context.handle(
        _challenge1Meta,
        challenge1.isAcceptableOrUnknown(data['challenge1']!, _challenge1Meta),
      );
    }
    if (data.containsKey('challenge2')) {
      context.handle(
        _challenge2Meta,
        challenge2.isAcceptableOrUnknown(data['challenge2']!, _challenge2Meta),
      );
    }
    if (data.containsKey('challenge3')) {
      context.handle(
        _challenge3Meta,
        challenge3.isAcceptableOrUnknown(data['challenge3']!, _challenge3Meta),
      );
    }
    if (data.containsKey('gratitude_summary')) {
      context.handle(
        _gratitudeSummaryMeta,
        gratitudeSummary.isAcceptableOrUnknown(
          data['gratitude_summary']!,
          _gratitudeSummaryMeta,
        ),
      );
    }
    if (data.containsKey('intentions_next_month')) {
      context.handle(
        _intentionsNextMonthMeta,
        intentionsNextMonth.isAcceptableOrUnknown(
          data['intentions_next_month']!,
          _intentionsNextMonthMeta,
        ),
      );
    }
    if (data.containsKey('goal_completion_rate')) {
      context.handle(
        _goalCompletionRateMeta,
        goalCompletionRate.isAcceptableOrUnknown(
          data['goal_completion_rate']!,
          _goalCompletionRateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlyReviewData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyReviewData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      monthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_year'],
      )!,
      overallRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}overall_rating'],
      )!,
      win1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}win1'],
      ),
      win2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}win2'],
      ),
      win3: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}win3'],
      ),
      challenge1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge1'],
      ),
      challenge2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge2'],
      ),
      challenge3: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}challenge3'],
      ),
      gratitudeSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gratitude_summary'],
      ),
      intentionsNextMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intentions_next_month'],
      ),
      goalCompletionRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}goal_completion_rate'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MonthlyReviewsTable createAlias(String alias) {
    return $MonthlyReviewsTable(attachedDatabase, alias);
  }
}

class MonthlyReviewData extends DataClass
    implements Insertable<MonthlyReviewData> {
  final String id;
  final String monthYear;
  final int overallRating;
  final String? win1;
  final String? win2;
  final String? win3;
  final String? challenge1;
  final String? challenge2;
  final String? challenge3;
  final String? gratitudeSummary;
  final String? intentionsNextMonth;
  final double goalCompletionRate;
  final int createdAt;
  const MonthlyReviewData({
    required this.id,
    required this.monthYear,
    required this.overallRating,
    this.win1,
    this.win2,
    this.win3,
    this.challenge1,
    this.challenge2,
    this.challenge3,
    this.gratitudeSummary,
    this.intentionsNextMonth,
    required this.goalCompletionRate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['month_year'] = Variable<String>(monthYear);
    map['overall_rating'] = Variable<int>(overallRating);
    if (!nullToAbsent || win1 != null) {
      map['win1'] = Variable<String>(win1);
    }
    if (!nullToAbsent || win2 != null) {
      map['win2'] = Variable<String>(win2);
    }
    if (!nullToAbsent || win3 != null) {
      map['win3'] = Variable<String>(win3);
    }
    if (!nullToAbsent || challenge1 != null) {
      map['challenge1'] = Variable<String>(challenge1);
    }
    if (!nullToAbsent || challenge2 != null) {
      map['challenge2'] = Variable<String>(challenge2);
    }
    if (!nullToAbsent || challenge3 != null) {
      map['challenge3'] = Variable<String>(challenge3);
    }
    if (!nullToAbsent || gratitudeSummary != null) {
      map['gratitude_summary'] = Variable<String>(gratitudeSummary);
    }
    if (!nullToAbsent || intentionsNextMonth != null) {
      map['intentions_next_month'] = Variable<String>(intentionsNextMonth);
    }
    map['goal_completion_rate'] = Variable<double>(goalCompletionRate);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  MonthlyReviewsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyReviewsCompanion(
      id: Value(id),
      monthYear: Value(monthYear),
      overallRating: Value(overallRating),
      win1: win1 == null && nullToAbsent ? const Value.absent() : Value(win1),
      win2: win2 == null && nullToAbsent ? const Value.absent() : Value(win2),
      win3: win3 == null && nullToAbsent ? const Value.absent() : Value(win3),
      challenge1: challenge1 == null && nullToAbsent
          ? const Value.absent()
          : Value(challenge1),
      challenge2: challenge2 == null && nullToAbsent
          ? const Value.absent()
          : Value(challenge2),
      challenge3: challenge3 == null && nullToAbsent
          ? const Value.absent()
          : Value(challenge3),
      gratitudeSummary: gratitudeSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(gratitudeSummary),
      intentionsNextMonth: intentionsNextMonth == null && nullToAbsent
          ? const Value.absent()
          : Value(intentionsNextMonth),
      goalCompletionRate: Value(goalCompletionRate),
      createdAt: Value(createdAt),
    );
  }

  factory MonthlyReviewData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyReviewData(
      id: serializer.fromJson<String>(json['id']),
      monthYear: serializer.fromJson<String>(json['monthYear']),
      overallRating: serializer.fromJson<int>(json['overallRating']),
      win1: serializer.fromJson<String?>(json['win1']),
      win2: serializer.fromJson<String?>(json['win2']),
      win3: serializer.fromJson<String?>(json['win3']),
      challenge1: serializer.fromJson<String?>(json['challenge1']),
      challenge2: serializer.fromJson<String?>(json['challenge2']),
      challenge3: serializer.fromJson<String?>(json['challenge3']),
      gratitudeSummary: serializer.fromJson<String?>(json['gratitudeSummary']),
      intentionsNextMonth: serializer.fromJson<String?>(
        json['intentionsNextMonth'],
      ),
      goalCompletionRate: serializer.fromJson<double>(
        json['goalCompletionRate'],
      ),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'monthYear': serializer.toJson<String>(monthYear),
      'overallRating': serializer.toJson<int>(overallRating),
      'win1': serializer.toJson<String?>(win1),
      'win2': serializer.toJson<String?>(win2),
      'win3': serializer.toJson<String?>(win3),
      'challenge1': serializer.toJson<String?>(challenge1),
      'challenge2': serializer.toJson<String?>(challenge2),
      'challenge3': serializer.toJson<String?>(challenge3),
      'gratitudeSummary': serializer.toJson<String?>(gratitudeSummary),
      'intentionsNextMonth': serializer.toJson<String?>(intentionsNextMonth),
      'goalCompletionRate': serializer.toJson<double>(goalCompletionRate),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  MonthlyReviewData copyWith({
    String? id,
    String? monthYear,
    int? overallRating,
    Value<String?> win1 = const Value.absent(),
    Value<String?> win2 = const Value.absent(),
    Value<String?> win3 = const Value.absent(),
    Value<String?> challenge1 = const Value.absent(),
    Value<String?> challenge2 = const Value.absent(),
    Value<String?> challenge3 = const Value.absent(),
    Value<String?> gratitudeSummary = const Value.absent(),
    Value<String?> intentionsNextMonth = const Value.absent(),
    double? goalCompletionRate,
    int? createdAt,
  }) => MonthlyReviewData(
    id: id ?? this.id,
    monthYear: monthYear ?? this.monthYear,
    overallRating: overallRating ?? this.overallRating,
    win1: win1.present ? win1.value : this.win1,
    win2: win2.present ? win2.value : this.win2,
    win3: win3.present ? win3.value : this.win3,
    challenge1: challenge1.present ? challenge1.value : this.challenge1,
    challenge2: challenge2.present ? challenge2.value : this.challenge2,
    challenge3: challenge3.present ? challenge3.value : this.challenge3,
    gratitudeSummary: gratitudeSummary.present
        ? gratitudeSummary.value
        : this.gratitudeSummary,
    intentionsNextMonth: intentionsNextMonth.present
        ? intentionsNextMonth.value
        : this.intentionsNextMonth,
    goalCompletionRate: goalCompletionRate ?? this.goalCompletionRate,
    createdAt: createdAt ?? this.createdAt,
  );
  MonthlyReviewData copyWithCompanion(MonthlyReviewsCompanion data) {
    return MonthlyReviewData(
      id: data.id.present ? data.id.value : this.id,
      monthYear: data.monthYear.present ? data.monthYear.value : this.monthYear,
      overallRating: data.overallRating.present
          ? data.overallRating.value
          : this.overallRating,
      win1: data.win1.present ? data.win1.value : this.win1,
      win2: data.win2.present ? data.win2.value : this.win2,
      win3: data.win3.present ? data.win3.value : this.win3,
      challenge1: data.challenge1.present
          ? data.challenge1.value
          : this.challenge1,
      challenge2: data.challenge2.present
          ? data.challenge2.value
          : this.challenge2,
      challenge3: data.challenge3.present
          ? data.challenge3.value
          : this.challenge3,
      gratitudeSummary: data.gratitudeSummary.present
          ? data.gratitudeSummary.value
          : this.gratitudeSummary,
      intentionsNextMonth: data.intentionsNextMonth.present
          ? data.intentionsNextMonth.value
          : this.intentionsNextMonth,
      goalCompletionRate: data.goalCompletionRate.present
          ? data.goalCompletionRate.value
          : this.goalCompletionRate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyReviewData(')
          ..write('id: $id, ')
          ..write('monthYear: $monthYear, ')
          ..write('overallRating: $overallRating, ')
          ..write('win1: $win1, ')
          ..write('win2: $win2, ')
          ..write('win3: $win3, ')
          ..write('challenge1: $challenge1, ')
          ..write('challenge2: $challenge2, ')
          ..write('challenge3: $challenge3, ')
          ..write('gratitudeSummary: $gratitudeSummary, ')
          ..write('intentionsNextMonth: $intentionsNextMonth, ')
          ..write('goalCompletionRate: $goalCompletionRate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    monthYear,
    overallRating,
    win1,
    win2,
    win3,
    challenge1,
    challenge2,
    challenge3,
    gratitudeSummary,
    intentionsNextMonth,
    goalCompletionRate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyReviewData &&
          other.id == this.id &&
          other.monthYear == this.monthYear &&
          other.overallRating == this.overallRating &&
          other.win1 == this.win1 &&
          other.win2 == this.win2 &&
          other.win3 == this.win3 &&
          other.challenge1 == this.challenge1 &&
          other.challenge2 == this.challenge2 &&
          other.challenge3 == this.challenge3 &&
          other.gratitudeSummary == this.gratitudeSummary &&
          other.intentionsNextMonth == this.intentionsNextMonth &&
          other.goalCompletionRate == this.goalCompletionRate &&
          other.createdAt == this.createdAt);
}

class MonthlyReviewsCompanion extends UpdateCompanion<MonthlyReviewData> {
  final Value<String> id;
  final Value<String> monthYear;
  final Value<int> overallRating;
  final Value<String?> win1;
  final Value<String?> win2;
  final Value<String?> win3;
  final Value<String?> challenge1;
  final Value<String?> challenge2;
  final Value<String?> challenge3;
  final Value<String?> gratitudeSummary;
  final Value<String?> intentionsNextMonth;
  final Value<double> goalCompletionRate;
  final Value<int> createdAt;
  final Value<int> rowid;
  const MonthlyReviewsCompanion({
    this.id = const Value.absent(),
    this.monthYear = const Value.absent(),
    this.overallRating = const Value.absent(),
    this.win1 = const Value.absent(),
    this.win2 = const Value.absent(),
    this.win3 = const Value.absent(),
    this.challenge1 = const Value.absent(),
    this.challenge2 = const Value.absent(),
    this.challenge3 = const Value.absent(),
    this.gratitudeSummary = const Value.absent(),
    this.intentionsNextMonth = const Value.absent(),
    this.goalCompletionRate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyReviewsCompanion.insert({
    this.id = const Value.absent(),
    required String monthYear,
    required int overallRating,
    this.win1 = const Value.absent(),
    this.win2 = const Value.absent(),
    this.win3 = const Value.absent(),
    this.challenge1 = const Value.absent(),
    this.challenge2 = const Value.absent(),
    this.challenge3 = const Value.absent(),
    this.gratitudeSummary = const Value.absent(),
    this.intentionsNextMonth = const Value.absent(),
    this.goalCompletionRate = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : monthYear = Value(monthYear),
       overallRating = Value(overallRating),
       createdAt = Value(createdAt);
  static Insertable<MonthlyReviewData> custom({
    Expression<String>? id,
    Expression<String>? monthYear,
    Expression<int>? overallRating,
    Expression<String>? win1,
    Expression<String>? win2,
    Expression<String>? win3,
    Expression<String>? challenge1,
    Expression<String>? challenge2,
    Expression<String>? challenge3,
    Expression<String>? gratitudeSummary,
    Expression<String>? intentionsNextMonth,
    Expression<double>? goalCompletionRate,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthYear != null) 'month_year': monthYear,
      if (overallRating != null) 'overall_rating': overallRating,
      if (win1 != null) 'win1': win1,
      if (win2 != null) 'win2': win2,
      if (win3 != null) 'win3': win3,
      if (challenge1 != null) 'challenge1': challenge1,
      if (challenge2 != null) 'challenge2': challenge2,
      if (challenge3 != null) 'challenge3': challenge3,
      if (gratitudeSummary != null) 'gratitude_summary': gratitudeSummary,
      if (intentionsNextMonth != null)
        'intentions_next_month': intentionsNextMonth,
      if (goalCompletionRate != null)
        'goal_completion_rate': goalCompletionRate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyReviewsCompanion copyWith({
    Value<String>? id,
    Value<String>? monthYear,
    Value<int>? overallRating,
    Value<String?>? win1,
    Value<String?>? win2,
    Value<String?>? win3,
    Value<String?>? challenge1,
    Value<String?>? challenge2,
    Value<String?>? challenge3,
    Value<String?>? gratitudeSummary,
    Value<String?>? intentionsNextMonth,
    Value<double>? goalCompletionRate,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return MonthlyReviewsCompanion(
      id: id ?? this.id,
      monthYear: monthYear ?? this.monthYear,
      overallRating: overallRating ?? this.overallRating,
      win1: win1 ?? this.win1,
      win2: win2 ?? this.win2,
      win3: win3 ?? this.win3,
      challenge1: challenge1 ?? this.challenge1,
      challenge2: challenge2 ?? this.challenge2,
      challenge3: challenge3 ?? this.challenge3,
      gratitudeSummary: gratitudeSummary ?? this.gratitudeSummary,
      intentionsNextMonth: intentionsNextMonth ?? this.intentionsNextMonth,
      goalCompletionRate: goalCompletionRate ?? this.goalCompletionRate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (monthYear.present) {
      map['month_year'] = Variable<String>(monthYear.value);
    }
    if (overallRating.present) {
      map['overall_rating'] = Variable<int>(overallRating.value);
    }
    if (win1.present) {
      map['win1'] = Variable<String>(win1.value);
    }
    if (win2.present) {
      map['win2'] = Variable<String>(win2.value);
    }
    if (win3.present) {
      map['win3'] = Variable<String>(win3.value);
    }
    if (challenge1.present) {
      map['challenge1'] = Variable<String>(challenge1.value);
    }
    if (challenge2.present) {
      map['challenge2'] = Variable<String>(challenge2.value);
    }
    if (challenge3.present) {
      map['challenge3'] = Variable<String>(challenge3.value);
    }
    if (gratitudeSummary.present) {
      map['gratitude_summary'] = Variable<String>(gratitudeSummary.value);
    }
    if (intentionsNextMonth.present) {
      map['intentions_next_month'] = Variable<String>(
        intentionsNextMonth.value,
      );
    }
    if (goalCompletionRate.present) {
      map['goal_completion_rate'] = Variable<double>(goalCompletionRate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyReviewsCompanion(')
          ..write('id: $id, ')
          ..write('monthYear: $monthYear, ')
          ..write('overallRating: $overallRating, ')
          ..write('win1: $win1, ')
          ..write('win2: $win2, ')
          ..write('win3: $win3, ')
          ..write('challenge1: $challenge1, ')
          ..write('challenge2: $challenge2, ')
          ..write('challenge3: $challenge3, ')
          ..write('gratitudeSummary: $gratitudeSummary, ')
          ..write('intentionsNextMonth: $intentionsNextMonth, ')
          ..write('goalCompletionRate: $goalCompletionRate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyGoalsTable extends MonthlyGoals
    with TableInfo<$MonthlyGoalsTable, MonthlyGoalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _monthYearMeta = const VerificationMeta(
    'monthYear',
  );
  @override
  late final GeneratedColumn<String> monthYear = GeneratedColumn<String>(
    'month_year',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES monthly_plans(month_year)',
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAchievedMeta = const VerificationMeta(
    'isAchieved',
  );
  @override
  late final GeneratedColumn<int> isAchieved = GeneratedColumn<int>(
    'is_achieved',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monthYear,
    title,
    isAchieved,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyGoalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('month_year')) {
      context.handle(
        _monthYearMeta,
        monthYear.isAcceptableOrUnknown(data['month_year']!, _monthYearMeta),
      );
    } else if (isInserting) {
      context.missing(_monthYearMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_achieved')) {
      context.handle(
        _isAchievedMeta,
        isAchieved.isAcceptableOrUnknown(data['is_achieved']!, _isAchievedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlyGoalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyGoalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      monthYear: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_year'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      isAchieved: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_achieved'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $MonthlyGoalsTable createAlias(String alias) {
    return $MonthlyGoalsTable(attachedDatabase, alias);
  }
}

class MonthlyGoalData extends DataClass implements Insertable<MonthlyGoalData> {
  final String id;
  final String monthYear;
  final String title;
  final int isAchieved;
  final int sortOrder;
  const MonthlyGoalData({
    required this.id,
    required this.monthYear,
    required this.title,
    required this.isAchieved,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['month_year'] = Variable<String>(monthYear);
    map['title'] = Variable<String>(title);
    map['is_achieved'] = Variable<int>(isAchieved);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  MonthlyGoalsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyGoalsCompanion(
      id: Value(id),
      monthYear: Value(monthYear),
      title: Value(title),
      isAchieved: Value(isAchieved),
      sortOrder: Value(sortOrder),
    );
  }

  factory MonthlyGoalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyGoalData(
      id: serializer.fromJson<String>(json['id']),
      monthYear: serializer.fromJson<String>(json['monthYear']),
      title: serializer.fromJson<String>(json['title']),
      isAchieved: serializer.fromJson<int>(json['isAchieved']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'monthYear': serializer.toJson<String>(monthYear),
      'title': serializer.toJson<String>(title),
      'isAchieved': serializer.toJson<int>(isAchieved),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  MonthlyGoalData copyWith({
    String? id,
    String? monthYear,
    String? title,
    int? isAchieved,
    int? sortOrder,
  }) => MonthlyGoalData(
    id: id ?? this.id,
    monthYear: monthYear ?? this.monthYear,
    title: title ?? this.title,
    isAchieved: isAchieved ?? this.isAchieved,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  MonthlyGoalData copyWithCompanion(MonthlyGoalsCompanion data) {
    return MonthlyGoalData(
      id: data.id.present ? data.id.value : this.id,
      monthYear: data.monthYear.present ? data.monthYear.value : this.monthYear,
      title: data.title.present ? data.title.value : this.title,
      isAchieved: data.isAchieved.present
          ? data.isAchieved.value
          : this.isAchieved,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyGoalData(')
          ..write('id: $id, ')
          ..write('monthYear: $monthYear, ')
          ..write('title: $title, ')
          ..write('isAchieved: $isAchieved, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, monthYear, title, isAchieved, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyGoalData &&
          other.id == this.id &&
          other.monthYear == this.monthYear &&
          other.title == this.title &&
          other.isAchieved == this.isAchieved &&
          other.sortOrder == this.sortOrder);
}

class MonthlyGoalsCompanion extends UpdateCompanion<MonthlyGoalData> {
  final Value<String> id;
  final Value<String> monthYear;
  final Value<String> title;
  final Value<int> isAchieved;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const MonthlyGoalsCompanion({
    this.id = const Value.absent(),
    this.monthYear = const Value.absent(),
    this.title = const Value.absent(),
    this.isAchieved = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyGoalsCompanion.insert({
    this.id = const Value.absent(),
    required String monthYear,
    required String title,
    this.isAchieved = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : monthYear = Value(monthYear),
       title = Value(title);
  static Insertable<MonthlyGoalData> custom({
    Expression<String>? id,
    Expression<String>? monthYear,
    Expression<String>? title,
    Expression<int>? isAchieved,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthYear != null) 'month_year': monthYear,
      if (title != null) 'title': title,
      if (isAchieved != null) 'is_achieved': isAchieved,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyGoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? monthYear,
    Value<String>? title,
    Value<int>? isAchieved,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return MonthlyGoalsCompanion(
      id: id ?? this.id,
      monthYear: monthYear ?? this.monthYear,
      title: title ?? this.title,
      isAchieved: isAchieved ?? this.isAchieved,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (monthYear.present) {
      map['month_year'] = Variable<String>(monthYear.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isAchieved.present) {
      map['is_achieved'] = Variable<int>(isAchieved.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyGoalsCompanion(')
          ..write('id: $id, ')
          ..write('monthYear: $monthYear, ')
          ..write('title: $title, ')
          ..write('isAchieved: $isAchieved, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalCategoriesTable extends GoalCategories
    with TableInfo<$GoalCategoriesTable, GoalCategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
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
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    sortOrder,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalCategoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
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
  GoalCategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalCategoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GoalCategoriesTable createAlias(String alias) {
    return $GoalCategoriesTable(attachedDatabase, alias);
  }
}

class GoalCategoryData extends DataClass
    implements Insertable<GoalCategoryData> {
  final String id;
  final String name;
  final int sortOrder;
  final int createdAt;
  final int updatedAt;
  const GoalCategoryData({
    required this.id,
    required this.name,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  GoalCategoriesCompanion toCompanion(bool nullToAbsent) {
    return GoalCategoriesCompanion(
      id: Value(id),
      name: Value(name),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GoalCategoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalCategoryData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  GoalCategoryData copyWith({
    String? id,
    String? name,
    int? sortOrder,
    int? createdAt,
    int? updatedAt,
  }) => GoalCategoryData(
    id: id ?? this.id,
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GoalCategoryData copyWithCompanion(GoalCategoriesCompanion data) {
    return GoalCategoryData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalCategoryData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, sortOrder, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalCategoryData &&
          other.id == this.id &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GoalCategoriesCompanion extends UpdateCompanion<GoalCategoryData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const GoalCategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.sortOrder = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GoalCategoryData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? sortOrder,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return GoalCategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, GoalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
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
    $customConstraints: 'REFERENCES goal_categories(id) ON DELETE SET NULL',
  );
  static const VerificationMeta _kpiDescriptionMeta = const VerificationMeta(
    'kpiDescription',
  );
  @override
  late final GeneratedColumn<String> kpiDescription = GeneratedColumn<String>(
    'kpi_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startValueMeta = const VerificationMeta(
    'startValue',
  );
  @override
  late final GeneratedColumn<String> startValue = GeneratedColumn<String>(
    'start_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<String> targetValue = GeneratedColumn<String>(
    'target_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _urgencyMeta = const VerificationMeta(
    'urgency',
  );
  @override
  late final GeneratedColumn<String> urgency = GeneratedColumn<String>(
    'urgency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _whyMeta = const VerificationMeta('why');
  @override
  late final GeneratedColumn<String> why = GeneratedColumn<String>(
    'why',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<int> startDate = GeneratedColumn<int>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<int> targetDate = GeneratedColumn<int>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkInFrequencyMeta = const VerificationMeta(
    'checkInFrequency',
  );
  @override
  late final GeneratedColumn<String> checkInFrequency = GeneratedColumn<String>(
    'check_in_frequency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeHorizonMeta = const VerificationMeta(
    'timeHorizon',
  );
  @override
  late final GeneratedColumn<String> timeHorizon = GeneratedColumn<String>(
    'time_horizon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    categoryId,
    kpiDescription,
    startValue,
    targetValue,
    priority,
    urgency,
    why,
    startDate,
    targetDate,
    checkInFrequency,
    timeHorizon,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('kpi_description')) {
      context.handle(
        _kpiDescriptionMeta,
        kpiDescription.isAcceptableOrUnknown(
          data['kpi_description']!,
          _kpiDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('start_value')) {
      context.handle(
        _startValueMeta,
        startValue.isAcceptableOrUnknown(data['start_value']!, _startValueMeta),
      );
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('urgency')) {
      context.handle(
        _urgencyMeta,
        urgency.isAcceptableOrUnknown(data['urgency']!, _urgencyMeta),
      );
    }
    if (data.containsKey('why')) {
      context.handle(
        _whyMeta,
        why.isAcceptableOrUnknown(data['why']!, _whyMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('check_in_frequency')) {
      context.handle(
        _checkInFrequencyMeta,
        checkInFrequency.isAcceptableOrUnknown(
          data['check_in_frequency']!,
          _checkInFrequencyMeta,
        ),
      );
    }
    if (data.containsKey('time_horizon')) {
      context.handle(
        _timeHorizonMeta,
        timeHorizon.isAcceptableOrUnknown(
          data['time_horizon']!,
          _timeHorizonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeHorizonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
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
  GoalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      kpiDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kpi_description'],
      ),
      startValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_value'],
      ),
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_value'],
      ),
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      ),
      urgency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}urgency'],
      ),
      why: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}why'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_date'],
      ),
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_date'],
      ),
      checkInFrequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_in_frequency'],
      ),
      timeHorizon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_horizon'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class GoalData extends DataClass implements Insertable<GoalData> {
  final String id;
  final String title;
  final String? description;
  final String? categoryId;
  final String? kpiDescription;
  final String? startValue;
  final String? targetValue;
  final String? priority;
  final String? urgency;
  final String? why;
  final int? startDate;
  final int? targetDate;
  final String? checkInFrequency;
  final String timeHorizon;
  final int createdAt;
  final int updatedAt;
  const GoalData({
    required this.id,
    required this.title,
    this.description,
    this.categoryId,
    this.kpiDescription,
    this.startValue,
    this.targetValue,
    this.priority,
    this.urgency,
    this.why,
    this.startDate,
    this.targetDate,
    this.checkInFrequency,
    required this.timeHorizon,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || kpiDescription != null) {
      map['kpi_description'] = Variable<String>(kpiDescription);
    }
    if (!nullToAbsent || startValue != null) {
      map['start_value'] = Variable<String>(startValue);
    }
    if (!nullToAbsent || targetValue != null) {
      map['target_value'] = Variable<String>(targetValue);
    }
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<String>(priority);
    }
    if (!nullToAbsent || urgency != null) {
      map['urgency'] = Variable<String>(urgency);
    }
    if (!nullToAbsent || why != null) {
      map['why'] = Variable<String>(why);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<int>(startDate);
    }
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<int>(targetDate);
    }
    if (!nullToAbsent || checkInFrequency != null) {
      map['check_in_frequency'] = Variable<String>(checkInFrequency);
    }
    map['time_horizon'] = Variable<String>(timeHorizon);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      kpiDescription: kpiDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(kpiDescription),
      startValue: startValue == null && nullToAbsent
          ? const Value.absent()
          : Value(startValue),
      targetValue: targetValue == null && nullToAbsent
          ? const Value.absent()
          : Value(targetValue),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      urgency: urgency == null && nullToAbsent
          ? const Value.absent()
          : Value(urgency),
      why: why == null && nullToAbsent ? const Value.absent() : Value(why),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      checkInFrequency: checkInFrequency == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInFrequency),
      timeHorizon: Value(timeHorizon),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GoalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      kpiDescription: serializer.fromJson<String?>(json['kpiDescription']),
      startValue: serializer.fromJson<String?>(json['startValue']),
      targetValue: serializer.fromJson<String?>(json['targetValue']),
      priority: serializer.fromJson<String?>(json['priority']),
      urgency: serializer.fromJson<String?>(json['urgency']),
      why: serializer.fromJson<String?>(json['why']),
      startDate: serializer.fromJson<int?>(json['startDate']),
      targetDate: serializer.fromJson<int?>(json['targetDate']),
      checkInFrequency: serializer.fromJson<String?>(json['checkInFrequency']),
      timeHorizon: serializer.fromJson<String>(json['timeHorizon']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'categoryId': serializer.toJson<String?>(categoryId),
      'kpiDescription': serializer.toJson<String?>(kpiDescription),
      'startValue': serializer.toJson<String?>(startValue),
      'targetValue': serializer.toJson<String?>(targetValue),
      'priority': serializer.toJson<String?>(priority),
      'urgency': serializer.toJson<String?>(urgency),
      'why': serializer.toJson<String?>(why),
      'startDate': serializer.toJson<int?>(startDate),
      'targetDate': serializer.toJson<int?>(targetDate),
      'checkInFrequency': serializer.toJson<String?>(checkInFrequency),
      'timeHorizon': serializer.toJson<String>(timeHorizon),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
    };
  }

  GoalData copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<String?> kpiDescription = const Value.absent(),
    Value<String?> startValue = const Value.absent(),
    Value<String?> targetValue = const Value.absent(),
    Value<String?> priority = const Value.absent(),
    Value<String?> urgency = const Value.absent(),
    Value<String?> why = const Value.absent(),
    Value<int?> startDate = const Value.absent(),
    Value<int?> targetDate = const Value.absent(),
    Value<String?> checkInFrequency = const Value.absent(),
    String? timeHorizon,
    int? createdAt,
    int? updatedAt,
  }) => GoalData(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    kpiDescription: kpiDescription.present
        ? kpiDescription.value
        : this.kpiDescription,
    startValue: startValue.present ? startValue.value : this.startValue,
    targetValue: targetValue.present ? targetValue.value : this.targetValue,
    priority: priority.present ? priority.value : this.priority,
    urgency: urgency.present ? urgency.value : this.urgency,
    why: why.present ? why.value : this.why,
    startDate: startDate.present ? startDate.value : this.startDate,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    checkInFrequency: checkInFrequency.present
        ? checkInFrequency.value
        : this.checkInFrequency,
    timeHorizon: timeHorizon ?? this.timeHorizon,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GoalData copyWithCompanion(GoalsCompanion data) {
    return GoalData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      kpiDescription: data.kpiDescription.present
          ? data.kpiDescription.value
          : this.kpiDescription,
      startValue: data.startValue.present
          ? data.startValue.value
          : this.startValue,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      priority: data.priority.present ? data.priority.value : this.priority,
      urgency: data.urgency.present ? data.urgency.value : this.urgency,
      why: data.why.present ? data.why.value : this.why,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      checkInFrequency: data.checkInFrequency.present
          ? data.checkInFrequency.value
          : this.checkInFrequency,
      timeHorizon: data.timeHorizon.present
          ? data.timeHorizon.value
          : this.timeHorizon,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('kpiDescription: $kpiDescription, ')
          ..write('startValue: $startValue, ')
          ..write('targetValue: $targetValue, ')
          ..write('priority: $priority, ')
          ..write('urgency: $urgency, ')
          ..write('why: $why, ')
          ..write('startDate: $startDate, ')
          ..write('targetDate: $targetDate, ')
          ..write('checkInFrequency: $checkInFrequency, ')
          ..write('timeHorizon: $timeHorizon, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    categoryId,
    kpiDescription,
    startValue,
    targetValue,
    priority,
    urgency,
    why,
    startDate,
    targetDate,
    checkInFrequency,
    timeHorizon,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.categoryId == this.categoryId &&
          other.kpiDescription == this.kpiDescription &&
          other.startValue == this.startValue &&
          other.targetValue == this.targetValue &&
          other.priority == this.priority &&
          other.urgency == this.urgency &&
          other.why == this.why &&
          other.startDate == this.startDate &&
          other.targetDate == this.targetDate &&
          other.checkInFrequency == this.checkInFrequency &&
          other.timeHorizon == this.timeHorizon &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GoalsCompanion extends UpdateCompanion<GoalData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String?> categoryId;
  final Value<String?> kpiDescription;
  final Value<String?> startValue;
  final Value<String?> targetValue;
  final Value<String?> priority;
  final Value<String?> urgency;
  final Value<String?> why;
  final Value<int?> startDate;
  final Value<int?> targetDate;
  final Value<String?> checkInFrequency;
  final Value<String> timeHorizon;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.kpiDescription = const Value.absent(),
    this.startValue = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.priority = const Value.absent(),
    this.urgency = const Value.absent(),
    this.why = const Value.absent(),
    this.startDate = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.checkInFrequency = const Value.absent(),
    this.timeHorizon = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.kpiDescription = const Value.absent(),
    this.startValue = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.priority = const Value.absent(),
    this.urgency = const Value.absent(),
    this.why = const Value.absent(),
    this.startDate = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.checkInFrequency = const Value.absent(),
    required String timeHorizon,
    required int createdAt,
    required int updatedAt,
    this.rowid = const Value.absent(),
  }) : title = Value(title),
       timeHorizon = Value(timeHorizon),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GoalData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? categoryId,
    Expression<String>? kpiDescription,
    Expression<String>? startValue,
    Expression<String>? targetValue,
    Expression<String>? priority,
    Expression<String>? urgency,
    Expression<String>? why,
    Expression<int>? startDate,
    Expression<int>? targetDate,
    Expression<String>? checkInFrequency,
    Expression<String>? timeHorizon,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (categoryId != null) 'category_id': categoryId,
      if (kpiDescription != null) 'kpi_description': kpiDescription,
      if (startValue != null) 'start_value': startValue,
      if (targetValue != null) 'target_value': targetValue,
      if (priority != null) 'priority': priority,
      if (urgency != null) 'urgency': urgency,
      if (why != null) 'why': why,
      if (startDate != null) 'start_date': startDate,
      if (targetDate != null) 'target_date': targetDate,
      if (checkInFrequency != null) 'check_in_frequency': checkInFrequency,
      if (timeHorizon != null) 'time_horizon': timeHorizon,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String?>? categoryId,
    Value<String?>? kpiDescription,
    Value<String?>? startValue,
    Value<String?>? targetValue,
    Value<String?>? priority,
    Value<String?>? urgency,
    Value<String?>? why,
    Value<int?>? startDate,
    Value<int?>? targetDate,
    Value<String?>? checkInFrequency,
    Value<String>? timeHorizon,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      kpiDescription: kpiDescription ?? this.kpiDescription,
      startValue: startValue ?? this.startValue,
      targetValue: targetValue ?? this.targetValue,
      priority: priority ?? this.priority,
      urgency: urgency ?? this.urgency,
      why: why ?? this.why,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      checkInFrequency: checkInFrequency ?? this.checkInFrequency,
      timeHorizon: timeHorizon ?? this.timeHorizon,
      createdAt: createdAt ?? this.createdAt,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (kpiDescription.present) {
      map['kpi_description'] = Variable<String>(kpiDescription.value);
    }
    if (startValue.present) {
      map['start_value'] = Variable<String>(startValue.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<String>(targetValue.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (urgency.present) {
      map['urgency'] = Variable<String>(urgency.value);
    }
    if (why.present) {
      map['why'] = Variable<String>(why.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<int>(startDate.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<int>(targetDate.value);
    }
    if (checkInFrequency.present) {
      map['check_in_frequency'] = Variable<String>(checkInFrequency.value);
    }
    if (timeHorizon.present) {
      map['time_horizon'] = Variable<String>(timeHorizon.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('categoryId: $categoryId, ')
          ..write('kpiDescription: $kpiDescription, ')
          ..write('startValue: $startValue, ')
          ..write('targetValue: $targetValue, ')
          ..write('priority: $priority, ')
          ..write('urgency: $urgency, ')
          ..write('why: $why, ')
          ..write('startDate: $startDate, ')
          ..write('targetDate: $targetDate, ')
          ..write('checkInFrequency: $checkInFrequency, ')
          ..write('timeHorizon: $timeHorizon, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GCalSyncQueueTable extends GCalSyncQueue
    with TableInfo<$GCalSyncQueueTable, GCalSyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GCalSyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => const Uuid().v4(),
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL REFERENCES tasks(id) ON DELETE CASCADE',
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    operation,
    payload,
    retryCount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'g_cal_sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<GCalSyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GCalSyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GCalSyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GCalSyncQueueTable createAlias(String alias) {
    return $GCalSyncQueueTable(attachedDatabase, alias);
  }
}

class GCalSyncQueueData extends DataClass
    implements Insertable<GCalSyncQueueData> {
  final String id;
  final String taskId;
  final String operation;
  final String payload;
  final int retryCount;
  final int createdAt;
  const GCalSyncQueueData({
    required this.id,
    required this.taskId,
    required this.operation,
    required this.payload,
    required this.retryCount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['task_id'] = Variable<String>(taskId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  GCalSyncQueueCompanion toCompanion(bool nullToAbsent) {
    return GCalSyncQueueCompanion(
      id: Value(id),
      taskId: Value(taskId),
      operation: Value(operation),
      payload: Value(payload),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
    );
  }

  factory GCalSyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GCalSyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'taskId': serializer.toJson<String>(taskId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  GCalSyncQueueData copyWith({
    String? id,
    String? taskId,
    String? operation,
    String? payload,
    int? retryCount,
    int? createdAt,
  }) => GCalSyncQueueData(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
  );
  GCalSyncQueueData copyWithCompanion(GCalSyncQueueCompanion data) {
    return GCalSyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GCalSyncQueueData(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, taskId, operation, payload, retryCount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GCalSyncQueueData &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt);
}

class GCalSyncQueueCompanion extends UpdateCompanion<GCalSyncQueueData> {
  final Value<String> id;
  final Value<String> taskId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<int> retryCount;
  final Value<int> createdAt;
  final Value<int> rowid;
  const GCalSyncQueueCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GCalSyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String taskId,
    required String operation,
    required String payload,
    this.retryCount = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  }) : taskId = Value(taskId),
       operation = Value(operation),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<GCalSyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? taskId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? retryCount,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GCalSyncQueueCompanion copyWith({
    Value<String>? id,
    Value<String>? taskId,
    Value<String>? operation,
    Value<String>? payload,
    Value<int>? retryCount,
    Value<int>? createdAt,
    Value<int>? rowid,
  }) {
    return GCalSyncQueueCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GCalSyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RecurrenceRulesTable recurrenceRules = $RecurrenceRulesTable(
    this,
  );
  late final $TasksTable tasks = $TasksTable(this);
  late final $SubtasksTable subtasks = $SubtasksTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $TaskTagsTable taskTags = $TaskTagsTable(this);
  late final $DailyReviewsTable dailyReviews = $DailyReviewsTable(this);
  late final $WeeklyPlansTable weeklyPlans = $WeeklyPlansTable(this);
  late final $WeeklyReviewsTable weeklyReviews = $WeeklyReviewsTable(this);
  late final $WeeklyGoalsTable weeklyGoals = $WeeklyGoalsTable(this);
  late final $MonthlyPlansTable monthlyPlans = $MonthlyPlansTable(this);
  late final $MonthlyReviewsTable monthlyReviews = $MonthlyReviewsTable(this);
  late final $MonthlyGoalsTable monthlyGoals = $MonthlyGoalsTable(this);
  late final $GoalCategoriesTable goalCategories = $GoalCategoriesTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $GCalSyncQueueTable gCalSyncQueue = $GCalSyncQueueTable(this);
  late final AnalyticsDao analyticsDao = AnalyticsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    recurrenceRules,
    tasks,
    subtasks,
    tags,
    taskTags,
    dailyReviews,
    weeklyPlans,
    weeklyReviews,
    weeklyGoals,
    monthlyPlans,
    monthlyReviews,
    monthlyGoals,
    goalCategories,
    goals,
    gCalSyncQueue,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recurrence_rules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('subtasks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tasks',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('task_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('task_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goal_categories',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('goals', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$RecurrenceRulesTableCreateCompanionBuilder =
    RecurrenceRulesCompanion Function({
      Value<String> id,
      required String frequency,
      Value<int> intervalVal,
      Value<String?> daysOfWeek,
      Value<int?> dayOfMonth,
      Value<String> endType,
      Value<int?> endDate,
      Value<int?> endCount,
      Value<int> occurrenceCount,
      Value<int> rowid,
    });
typedef $$RecurrenceRulesTableUpdateCompanionBuilder =
    RecurrenceRulesCompanion Function({
      Value<String> id,
      Value<String> frequency,
      Value<int> intervalVal,
      Value<String?> daysOfWeek,
      Value<int?> dayOfMonth,
      Value<String> endType,
      Value<int?> endDate,
      Value<int?> endCount,
      Value<int> occurrenceCount,
      Value<int> rowid,
    });

final class $$RecurrenceRulesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecurrenceRulesTable,
          RecurrenceRuleData
        > {
  $$RecurrenceRulesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$TasksTable, List<TaskData>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: $_aliasNameGenerator(
      db.recurrenceRules.id,
      db.tasks.recurrenceRuleId,
    ),
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager($_db, $_db.tasks).filter(
      (f) => f.recurrenceRuleId.id.sqlEquals($_itemColumn<String>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecurrenceRulesTableFilterComposer
    extends Composer<_$AppDatabase, $RecurrenceRulesTable> {
  $$RecurrenceRulesTableFilterComposer({
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

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalVal => $composableBuilder(
    column: $table.intervalVal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get daysOfWeek => $composableBuilder(
    column: $table.daysOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endType => $composableBuilder(
    column: $table.endType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endCount => $composableBuilder(
    column: $table.endCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get occurrenceCount => $composableBuilder(
    column: $table.occurrenceCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.recurrenceRuleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecurrenceRulesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecurrenceRulesTable> {
  $$RecurrenceRulesTableOrderingComposer({
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

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalVal => $composableBuilder(
    column: $table.intervalVal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get daysOfWeek => $composableBuilder(
    column: $table.daysOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endType => $composableBuilder(
    column: $table.endType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endCount => $composableBuilder(
    column: $table.endCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get occurrenceCount => $composableBuilder(
    column: $table.occurrenceCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecurrenceRulesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecurrenceRulesTable> {
  $$RecurrenceRulesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get intervalVal => $composableBuilder(
    column: $table.intervalVal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get daysOfWeek => $composableBuilder(
    column: $table.daysOfWeek,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayOfMonth => $composableBuilder(
    column: $table.dayOfMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get endType =>
      $composableBuilder(column: $table.endType, builder: (column) => column);

  GeneratedColumn<int> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get endCount =>
      $composableBuilder(column: $table.endCount, builder: (column) => column);

  GeneratedColumn<int> get occurrenceCount => $composableBuilder(
    column: $table.occurrenceCount,
    builder: (column) => column,
  );

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.recurrenceRuleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecurrenceRulesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecurrenceRulesTable,
          RecurrenceRuleData,
          $$RecurrenceRulesTableFilterComposer,
          $$RecurrenceRulesTableOrderingComposer,
          $$RecurrenceRulesTableAnnotationComposer,
          $$RecurrenceRulesTableCreateCompanionBuilder,
          $$RecurrenceRulesTableUpdateCompanionBuilder,
          (RecurrenceRuleData, $$RecurrenceRulesTableReferences),
          RecurrenceRuleData,
          PrefetchHooks Function({bool tasksRefs})
        > {
  $$RecurrenceRulesTableTableManager(
    _$AppDatabase db,
    $RecurrenceRulesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecurrenceRulesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecurrenceRulesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecurrenceRulesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int> intervalVal = const Value.absent(),
                Value<String?> daysOfWeek = const Value.absent(),
                Value<int?> dayOfMonth = const Value.absent(),
                Value<String> endType = const Value.absent(),
                Value<int?> endDate = const Value.absent(),
                Value<int?> endCount = const Value.absent(),
                Value<int> occurrenceCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurrenceRulesCompanion(
                id: id,
                frequency: frequency,
                intervalVal: intervalVal,
                daysOfWeek: daysOfWeek,
                dayOfMonth: dayOfMonth,
                endType: endType,
                endDate: endDate,
                endCount: endCount,
                occurrenceCount: occurrenceCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String frequency,
                Value<int> intervalVal = const Value.absent(),
                Value<String?> daysOfWeek = const Value.absent(),
                Value<int?> dayOfMonth = const Value.absent(),
                Value<String> endType = const Value.absent(),
                Value<int?> endDate = const Value.absent(),
                Value<int?> endCount = const Value.absent(),
                Value<int> occurrenceCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecurrenceRulesCompanion.insert(
                id: id,
                frequency: frequency,
                intervalVal: intervalVal,
                daysOfWeek: daysOfWeek,
                dayOfMonth: dayOfMonth,
                endType: endType,
                endDate: endDate,
                endCount: endCount,
                occurrenceCount: occurrenceCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecurrenceRulesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tasksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tasksRefs) db.tasks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tasksRefs)
                    await $_getPrefetchedData<
                      RecurrenceRuleData,
                      $RecurrenceRulesTable,
                      TaskData
                    >(
                      currentTable: table,
                      referencedTable: $$RecurrenceRulesTableReferences
                          ._tasksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RecurrenceRulesTableReferences(
                            db,
                            table,
                            p0,
                          ).tasksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.recurrenceRuleId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RecurrenceRulesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecurrenceRulesTable,
      RecurrenceRuleData,
      $$RecurrenceRulesTableFilterComposer,
      $$RecurrenceRulesTableOrderingComposer,
      $$RecurrenceRulesTableAnnotationComposer,
      $$RecurrenceRulesTableCreateCompanionBuilder,
      $$RecurrenceRulesTableUpdateCompanionBuilder,
      (RecurrenceRuleData, $$RecurrenceRulesTableReferences),
      RecurrenceRuleData,
      PrefetchHooks Function({bool tasksRefs})
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      required String title,
      required String priority,
      Value<int?> dueDate,
      Value<int?> dueDateLocalDayStart,
      Value<int?> dueDateUtcMs,
      Value<int?> dueTime,
      Value<String?> notes,
      Value<String> status,
      Value<int> isOverdue,
      Value<int> overdueDay,
      Value<String?> recurrenceRuleId,
      Value<String?> recurrenceParentId,
      Value<int> hasEnabledReminder,
      Value<String?> gcalEventId,
      Value<int> syncToGcal,
      Value<String?> goalId,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> priority,
      Value<int?> dueDate,
      Value<int?> dueDateLocalDayStart,
      Value<int?> dueDateUtcMs,
      Value<int?> dueTime,
      Value<String?> notes,
      Value<String> status,
      Value<int> isOverdue,
      Value<int> overdueDay,
      Value<String?> recurrenceRuleId,
      Value<String?> recurrenceParentId,
      Value<int> hasEnabledReminder,
      Value<String?> gcalEventId,
      Value<int> syncToGcal,
      Value<String?> goalId,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, TaskData> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecurrenceRulesTable _recurrenceRuleIdTable(_$AppDatabase db) =>
      db.recurrenceRules.createAlias(
        $_aliasNameGenerator(db.tasks.recurrenceRuleId, db.recurrenceRules.id),
      );

  $$RecurrenceRulesTableProcessedTableManager? get recurrenceRuleId {
    final $_column = $_itemColumn<String>('recurrence_rule_id');
    if ($_column == null) return null;
    final manager = $$RecurrenceRulesTableTableManager(
      $_db,
      $_db.recurrenceRules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recurrenceRuleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SubtasksTable, List<SubtaskData>>
  _subtasksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.subtasks,
    aliasName: $_aliasNameGenerator(db.tasks.id, db.subtasks.taskId),
  );

  $$SubtasksTableProcessedTableManager get subtasksRefs {
    final manager = $$SubtasksTableTableManager(
      $_db,
      $_db.subtasks,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_subtasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TaskTagsTable, List<TaskTagData>>
  _taskTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.taskTags,
    aliasName: $_aliasNameGenerator(db.tasks.id, db.taskTags.taskId),
  );

  $$TaskTagsTableProcessedTableManager get taskTagsRefs {
    final manager = $$TaskTagsTableTableManager(
      $_db,
      $_db.taskTags,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDateLocalDayStart => $composableBuilder(
    column: $table.dueDateLocalDayStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueDateUtcMs => $composableBuilder(
    column: $table.dueDateUtcMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dueTime => $composableBuilder(
    column: $table.dueTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isOverdue => $composableBuilder(
    column: $table.isOverdue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get overdueDay => $composableBuilder(
    column: $table.overdueDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurrenceParentId => $composableBuilder(
    column: $table.recurrenceParentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hasEnabledReminder => $composableBuilder(
    column: $table.hasEnabledReminder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gcalEventId => $composableBuilder(
    column: $table.gcalEventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get syncToGcal => $composableBuilder(
    column: $table.syncToGcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RecurrenceRulesTableFilterComposer get recurrenceRuleId {
    final $$RecurrenceRulesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recurrenceRuleId,
      referencedTable: $db.recurrenceRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurrenceRulesTableFilterComposer(
            $db: $db,
            $table: $db.recurrenceRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> subtasksRefs(
    Expression<bool> Function($$SubtasksTableFilterComposer f) f,
  ) {
    final $$SubtasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subtasks,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubtasksTableFilterComposer(
            $db: $db,
            $table: $db.subtasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> taskTagsRefs(
    Expression<bool> Function($$TaskTagsTableFilterComposer f) f,
  ) {
    final $$TaskTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskTags,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaskTagsTableFilterComposer(
            $db: $db,
            $table: $db.taskTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDateLocalDayStart => $composableBuilder(
    column: $table.dueDateLocalDayStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueDateUtcMs => $composableBuilder(
    column: $table.dueDateUtcMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dueTime => $composableBuilder(
    column: $table.dueTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isOverdue => $composableBuilder(
    column: $table.isOverdue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get overdueDay => $composableBuilder(
    column: $table.overdueDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurrenceParentId => $composableBuilder(
    column: $table.recurrenceParentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hasEnabledReminder => $composableBuilder(
    column: $table.hasEnabledReminder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gcalEventId => $composableBuilder(
    column: $table.gcalEventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncToGcal => $composableBuilder(
    column: $table.syncToGcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecurrenceRulesTableOrderingComposer get recurrenceRuleId {
    final $$RecurrenceRulesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recurrenceRuleId,
      referencedTable: $db.recurrenceRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurrenceRulesTableOrderingComposer(
            $db: $db,
            $table: $db.recurrenceRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<int> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<int> get dueDateLocalDayStart => $composableBuilder(
    column: $table.dueDateLocalDayStart,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueDateUtcMs => $composableBuilder(
    column: $table.dueDateUtcMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dueTime =>
      $composableBuilder(column: $table.dueTime, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get isOverdue =>
      $composableBuilder(column: $table.isOverdue, builder: (column) => column);

  GeneratedColumn<int> get overdueDay => $composableBuilder(
    column: $table.overdueDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recurrenceParentId => $composableBuilder(
    column: $table.recurrenceParentId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hasEnabledReminder => $composableBuilder(
    column: $table.hasEnabledReminder,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gcalEventId => $composableBuilder(
    column: $table.gcalEventId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get syncToGcal => $composableBuilder(
    column: $table.syncToGcal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$RecurrenceRulesTableAnnotationComposer get recurrenceRuleId {
    final $$RecurrenceRulesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recurrenceRuleId,
      referencedTable: $db.recurrenceRules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecurrenceRulesTableAnnotationComposer(
            $db: $db,
            $table: $db.recurrenceRules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> subtasksRefs<T extends Object>(
    Expression<T> Function($$SubtasksTableAnnotationComposer a) f,
  ) {
    final $$SubtasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subtasks,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubtasksTableAnnotationComposer(
            $db: $db,
            $table: $db.subtasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> taskTagsRefs<T extends Object>(
    Expression<T> Function($$TaskTagsTableAnnotationComposer a) f,
  ) {
    final $$TaskTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskTags,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaskTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.taskTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          TaskData,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (TaskData, $$TasksTableReferences),
          TaskData,
          PrefetchHooks Function({
            bool recurrenceRuleId,
            bool subtasksRefs,
            bool taskTagsRefs,
          })
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<int?> dueDate = const Value.absent(),
                Value<int?> dueDateLocalDayStart = const Value.absent(),
                Value<int?> dueDateUtcMs = const Value.absent(),
                Value<int?> dueTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> isOverdue = const Value.absent(),
                Value<int> overdueDay = const Value.absent(),
                Value<String?> recurrenceRuleId = const Value.absent(),
                Value<String?> recurrenceParentId = const Value.absent(),
                Value<int> hasEnabledReminder = const Value.absent(),
                Value<String?> gcalEventId = const Value.absent(),
                Value<int> syncToGcal = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                priority: priority,
                dueDate: dueDate,
                dueDateLocalDayStart: dueDateLocalDayStart,
                dueDateUtcMs: dueDateUtcMs,
                dueTime: dueTime,
                notes: notes,
                status: status,
                isOverdue: isOverdue,
                overdueDay: overdueDay,
                recurrenceRuleId: recurrenceRuleId,
                recurrenceParentId: recurrenceParentId,
                hasEnabledReminder: hasEnabledReminder,
                gcalEventId: gcalEventId,
                syncToGcal: syncToGcal,
                goalId: goalId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                required String priority,
                Value<int?> dueDate = const Value.absent(),
                Value<int?> dueDateLocalDayStart = const Value.absent(),
                Value<int?> dueDateUtcMs = const Value.absent(),
                Value<int?> dueTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> isOverdue = const Value.absent(),
                Value<int> overdueDay = const Value.absent(),
                Value<String?> recurrenceRuleId = const Value.absent(),
                Value<String?> recurrenceParentId = const Value.absent(),
                Value<int> hasEnabledReminder = const Value.absent(),
                Value<String?> gcalEventId = const Value.absent(),
                Value<int> syncToGcal = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                priority: priority,
                dueDate: dueDate,
                dueDateLocalDayStart: dueDateLocalDayStart,
                dueDateUtcMs: dueDateUtcMs,
                dueTime: dueTime,
                notes: notes,
                status: status,
                isOverdue: isOverdue,
                overdueDay: overdueDay,
                recurrenceRuleId: recurrenceRuleId,
                recurrenceParentId: recurrenceParentId,
                hasEnabledReminder: hasEnabledReminder,
                gcalEventId: gcalEventId,
                syncToGcal: syncToGcal,
                goalId: goalId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TasksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                recurrenceRuleId = false,
                subtasksRefs = false,
                taskTagsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (subtasksRefs) db.subtasks,
                    if (taskTagsRefs) db.taskTags,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (recurrenceRuleId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.recurrenceRuleId,
                                    referencedTable: $$TasksTableReferences
                                        ._recurrenceRuleIdTable(db),
                                    referencedColumn: $$TasksTableReferences
                                        ._recurrenceRuleIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (subtasksRefs)
                        await $_getPrefetchedData<
                          TaskData,
                          $TasksTable,
                          SubtaskData
                        >(
                          currentTable: table,
                          referencedTable: $$TasksTableReferences
                              ._subtasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TasksTableReferences(
                                db,
                                table,
                                p0,
                              ).subtasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (taskTagsRefs)
                        await $_getPrefetchedData<
                          TaskData,
                          $TasksTable,
                          TaskTagData
                        >(
                          currentTable: table,
                          referencedTable: $$TasksTableReferences
                              ._taskTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TasksTableReferences(
                                db,
                                table,
                                p0,
                              ).taskTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.taskId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      TaskData,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (TaskData, $$TasksTableReferences),
      TaskData,
      PrefetchHooks Function({
        bool recurrenceRuleId,
        bool subtasksRefs,
        bool taskTagsRefs,
      })
    >;
typedef $$SubtasksTableCreateCompanionBuilder =
    SubtasksCompanion Function({
      Value<String> id,
      required String taskId,
      required String title,
      Value<int> isCompleted,
      Value<int> sortOrder,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$SubtasksTableUpdateCompanionBuilder =
    SubtasksCompanion Function({
      Value<String> id,
      Value<String> taskId,
      Value<String> title,
      Value<int> isCompleted,
      Value<int> sortOrder,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$SubtasksTableReferences
    extends BaseReferences<_$AppDatabase, $SubtasksTable, SubtaskData> {
  $$SubtasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$AppDatabase db) => db.tasks.createAlias(
    $_aliasNameGenerator(db.subtasks.taskId, db.tasks.id),
  );

  $$TasksTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubtasksTableFilterComposer
    extends Composer<_$AppDatabase, $SubtasksTable> {
  $$SubtasksTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubtasksTableOrderingComposer
    extends Composer<_$AppDatabase, $SubtasksTable> {
  $$SubtasksTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubtasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubtasksTable> {
  $$SubtasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubtasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubtasksTable,
          SubtaskData,
          $$SubtasksTableFilterComposer,
          $$SubtasksTableOrderingComposer,
          $$SubtasksTableAnnotationComposer,
          $$SubtasksTableCreateCompanionBuilder,
          $$SubtasksTableUpdateCompanionBuilder,
          (SubtaskData, $$SubtasksTableReferences),
          SubtaskData,
          PrefetchHooks Function({bool taskId})
        > {
  $$SubtasksTableTableManager(_$AppDatabase db, $SubtasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubtasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubtasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubtasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> taskId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> isCompleted = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SubtasksCompanion(
                id: id,
                taskId: taskId,
                title: title,
                isCompleted: isCompleted,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String taskId,
                required String title,
                Value<int> isCompleted = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SubtasksCompanion.insert(
                id: id,
                taskId: taskId,
                title: title,
                isCompleted: isCompleted,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubtasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable: $$SubtasksTableReferences
                                    ._taskIdTable(db),
                                referencedColumn: $$SubtasksTableReferences
                                    ._taskIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SubtasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubtasksTable,
      SubtaskData,
      $$SubtasksTableFilterComposer,
      $$SubtasksTableOrderingComposer,
      $$SubtasksTableAnnotationComposer,
      $$SubtasksTableCreateCompanionBuilder,
      $$SubtasksTableUpdateCompanionBuilder,
      (SubtaskData, $$SubtasksTableReferences),
      SubtaskData,
      PrefetchHooks Function({bool taskId})
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      Value<String> id,
      required String name,
      required String colour,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> colour,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, TagData> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TaskTagsTable, List<TaskTagData>>
  _taskTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.taskTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.taskTags.tagId),
  );

  $$TaskTagsTableProcessedTableManager get taskTagsRefs {
    final manager = $$TaskTagsTableTableManager(
      $_db,
      $_db.taskTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colour => $composableBuilder(
    column: $table.colour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> taskTagsRefs(
    Expression<bool> Function($$TaskTagsTableFilterComposer f) f,
  ) {
    final $$TaskTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaskTagsTableFilterComposer(
            $db: $db,
            $table: $db.taskTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colour => $composableBuilder(
    column: $table.colour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get colour =>
      $composableBuilder(column: $table.colour, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> taskTagsRefs<T extends Object>(
    Expression<T> Function($$TaskTagsTableAnnotationComposer a) f,
  ) {
    final $$TaskTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaskTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.taskTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          TagData,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (TagData, $$TagsTableReferences),
          TagData,
          PrefetchHooks Function({bool taskTagsRefs})
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> colour = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                name: name,
                colour: colour,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                required String colour,
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                name: name,
                colour: colour,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TagsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({taskTagsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (taskTagsRefs) db.taskTags],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (taskTagsRefs)
                    await $_getPrefetchedData<TagData, $TagsTable, TaskTagData>(
                      currentTable: table,
                      referencedTable: $$TagsTableReferences._taskTagsRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$TagsTableReferences(db, table, p0).taskTagsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tagId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      TagData,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (TagData, $$TagsTableReferences),
      TagData,
      PrefetchHooks Function({bool taskTagsRefs})
    >;
typedef $$TaskTagsTableCreateCompanionBuilder =
    TaskTagsCompanion Function({
      required String taskId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$TaskTagsTableUpdateCompanionBuilder =
    TaskTagsCompanion Function({
      Value<String> taskId,
      Value<String> tagId,
      Value<int> rowid,
    });

final class $$TaskTagsTableReferences
    extends BaseReferences<_$AppDatabase, $TaskTagsTable, TaskTagData> {
  $$TaskTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$AppDatabase db) => db.tasks.createAlias(
    $_aliasNameGenerator(db.taskTags.taskId, db.tasks.id),
  );

  $$TasksTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias($_aliasNameGenerator(db.taskTags.tagId, db.tags.id));

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TaskTagsTableFilterComposer
    extends Composer<_$AppDatabase, $TaskTagsTable> {
  $$TaskTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskTagsTable> {
  $$TaskTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskTagsTable> {
  $$TaskTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaskTagsTable,
          TaskTagData,
          $$TaskTagsTableFilterComposer,
          $$TaskTagsTableOrderingComposer,
          $$TaskTagsTableAnnotationComposer,
          $$TaskTagsTableCreateCompanionBuilder,
          $$TaskTagsTableUpdateCompanionBuilder,
          (TaskTagData, $$TaskTagsTableReferences),
          TaskTagData,
          PrefetchHooks Function({bool taskId, bool tagId})
        > {
  $$TaskTagsTableTableManager(_$AppDatabase db, $TaskTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> taskId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  TaskTagsCompanion(taskId: taskId, tagId: tagId, rowid: rowid),
          createCompanionCallback:
              ({
                required String taskId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => TaskTagsCompanion.insert(
                taskId: taskId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TaskTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false, tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable: $$TaskTagsTableReferences
                                    ._taskIdTable(db),
                                referencedColumn: $$TaskTagsTableReferences
                                    ._taskIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$TaskTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$TaskTagsTableReferences
                                    ._tagIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TaskTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaskTagsTable,
      TaskTagData,
      $$TaskTagsTableFilterComposer,
      $$TaskTagsTableOrderingComposer,
      $$TaskTagsTableAnnotationComposer,
      $$TaskTagsTableCreateCompanionBuilder,
      $$TaskTagsTableUpdateCompanionBuilder,
      (TaskTagData, $$TaskTagsTableReferences),
      TaskTagData,
      PrefetchHooks Function({bool taskId, bool tagId})
    >;
typedef $$DailyReviewsTableCreateCompanionBuilder =
    DailyReviewsCompanion Function({
      Value<String> id,
      required int reviewDate,
      required int dayRating,
      Value<String?> wentWell,
      Value<String?> couldBeBetter,
      required String gratitude1,
      required String gratitude2,
      required String gratitude3,
      Value<double> taskCompletionRate,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$DailyReviewsTableUpdateCompanionBuilder =
    DailyReviewsCompanion Function({
      Value<String> id,
      Value<int> reviewDate,
      Value<int> dayRating,
      Value<String?> wentWell,
      Value<String?> couldBeBetter,
      Value<String> gratitude1,
      Value<String> gratitude2,
      Value<String> gratitude3,
      Value<double> taskCompletionRate,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$DailyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $DailyReviewsTable> {
  $$DailyReviewsTableFilterComposer({
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

  ColumnFilters<int> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayRating => $composableBuilder(
    column: $table.dayRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wentWell => $composableBuilder(
    column: $table.wentWell,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get couldBeBetter => $composableBuilder(
    column: $table.couldBeBetter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gratitude1 => $composableBuilder(
    column: $table.gratitude1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gratitude2 => $composableBuilder(
    column: $table.gratitude2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gratitude3 => $composableBuilder(
    column: $table.gratitude3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taskCompletionRate => $composableBuilder(
    column: $table.taskCompletionRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyReviewsTable> {
  $$DailyReviewsTableOrderingComposer({
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

  ColumnOrderings<int> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayRating => $composableBuilder(
    column: $table.dayRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wentWell => $composableBuilder(
    column: $table.wentWell,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get couldBeBetter => $composableBuilder(
    column: $table.couldBeBetter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gratitude1 => $composableBuilder(
    column: $table.gratitude1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gratitude2 => $composableBuilder(
    column: $table.gratitude2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gratitude3 => $composableBuilder(
    column: $table.gratitude3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taskCompletionRate => $composableBuilder(
    column: $table.taskCompletionRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyReviewsTable> {
  $$DailyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get reviewDate => $composableBuilder(
    column: $table.reviewDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayRating =>
      $composableBuilder(column: $table.dayRating, builder: (column) => column);

  GeneratedColumn<String> get wentWell =>
      $composableBuilder(column: $table.wentWell, builder: (column) => column);

  GeneratedColumn<String> get couldBeBetter => $composableBuilder(
    column: $table.couldBeBetter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gratitude1 => $composableBuilder(
    column: $table.gratitude1,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gratitude2 => $composableBuilder(
    column: $table.gratitude2,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gratitude3 => $composableBuilder(
    column: $table.gratitude3,
    builder: (column) => column,
  );

  GeneratedColumn<double> get taskCompletionRate => $composableBuilder(
    column: $table.taskCompletionRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DailyReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyReviewsTable,
          DailyReviewData,
          $$DailyReviewsTableFilterComposer,
          $$DailyReviewsTableOrderingComposer,
          $$DailyReviewsTableAnnotationComposer,
          $$DailyReviewsTableCreateCompanionBuilder,
          $$DailyReviewsTableUpdateCompanionBuilder,
          (
            DailyReviewData,
            BaseReferences<_$AppDatabase, $DailyReviewsTable, DailyReviewData>,
          ),
          DailyReviewData,
          PrefetchHooks Function()
        > {
  $$DailyReviewsTableTableManager(_$AppDatabase db, $DailyReviewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> reviewDate = const Value.absent(),
                Value<int> dayRating = const Value.absent(),
                Value<String?> wentWell = const Value.absent(),
                Value<String?> couldBeBetter = const Value.absent(),
                Value<String> gratitude1 = const Value.absent(),
                Value<String> gratitude2 = const Value.absent(),
                Value<String> gratitude3 = const Value.absent(),
                Value<double> taskCompletionRate = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DailyReviewsCompanion(
                id: id,
                reviewDate: reviewDate,
                dayRating: dayRating,
                wentWell: wentWell,
                couldBeBetter: couldBeBetter,
                gratitude1: gratitude1,
                gratitude2: gratitude2,
                gratitude3: gratitude3,
                taskCompletionRate: taskCompletionRate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required int reviewDate,
                required int dayRating,
                Value<String?> wentWell = const Value.absent(),
                Value<String?> couldBeBetter = const Value.absent(),
                required String gratitude1,
                required String gratitude2,
                required String gratitude3,
                Value<double> taskCompletionRate = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => DailyReviewsCompanion.insert(
                id: id,
                reviewDate: reviewDate,
                dayRating: dayRating,
                wentWell: wentWell,
                couldBeBetter: couldBeBetter,
                gratitude1: gratitude1,
                gratitude2: gratitude2,
                gratitude3: gratitude3,
                taskCompletionRate: taskCompletionRate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyReviewsTable,
      DailyReviewData,
      $$DailyReviewsTableFilterComposer,
      $$DailyReviewsTableOrderingComposer,
      $$DailyReviewsTableAnnotationComposer,
      $$DailyReviewsTableCreateCompanionBuilder,
      $$DailyReviewsTableUpdateCompanionBuilder,
      (
        DailyReviewData,
        BaseReferences<_$AppDatabase, $DailyReviewsTable, DailyReviewData>,
      ),
      DailyReviewData,
      PrefetchHooks Function()
    >;
typedef $$WeeklyPlansTableCreateCompanionBuilder =
    WeeklyPlansCompanion Function({
      Value<String> id,
      required int weekStartDate,
      Value<String?> theme,
      Value<String?> intentions,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$WeeklyPlansTableUpdateCompanionBuilder =
    WeeklyPlansCompanion Function({
      Value<String> id,
      Value<int> weekStartDate,
      Value<String?> theme,
      Value<String?> intentions,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$WeeklyPlansTableReferences
    extends BaseReferences<_$AppDatabase, $WeeklyPlansTable, WeeklyPlanData> {
  $$WeeklyPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WeeklyReviewsTable, List<WeeklyReviewData>>
  _weeklyReviewsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weeklyReviews,
    aliasName: $_aliasNameGenerator(
      db.weeklyPlans.weekStartDate,
      db.weeklyReviews.weekStartDate,
    ),
  );

  $$WeeklyReviewsTableProcessedTableManager get weeklyReviewsRefs {
    final manager = $$WeeklyReviewsTableTableManager($_db, $_db.weeklyReviews)
        .filter(
          (f) => f.weekStartDate.weekStartDate.sqlEquals(
            $_itemColumn<int>('week_start_date')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_weeklyReviewsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WeeklyGoalsTable, List<WeeklyGoalData>>
  _weeklyGoalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.weeklyGoals,
    aliasName: $_aliasNameGenerator(
      db.weeklyPlans.weekStartDate,
      db.weeklyGoals.weekStartDate,
    ),
  );

  $$WeeklyGoalsTableProcessedTableManager get weeklyGoalsRefs {
    final manager = $$WeeklyGoalsTableTableManager($_db, $_db.weeklyGoals)
        .filter(
          (f) => f.weekStartDate.weekStartDate.sqlEquals(
            $_itemColumn<int>('week_start_date')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_weeklyGoalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WeeklyPlansTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyPlansTable> {
  $$WeeklyPlansTableFilterComposer({
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

  ColumnFilters<int> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intentions => $composableBuilder(
    column: $table.intentions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> weeklyReviewsRefs(
    Expression<bool> Function($$WeeklyReviewsTableFilterComposer f) f,
  ) {
    final $$WeeklyReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyReviews,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyReviewsTableFilterComposer(
            $db: $db,
            $table: $db.weeklyReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> weeklyGoalsRefs(
    Expression<bool> Function($$WeeklyGoalsTableFilterComposer f) f,
  ) {
    final $$WeeklyGoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyGoals,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyGoalsTableFilterComposer(
            $db: $db,
            $table: $db.weeklyGoals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeeklyPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyPlansTable> {
  $$WeeklyPlansTableOrderingComposer({
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

  ColumnOrderings<int> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intentions => $composableBuilder(
    column: $table.intentions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeeklyPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyPlansTable> {
  $$WeeklyPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<String> get intentions => $composableBuilder(
    column: $table.intentions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> weeklyReviewsRefs<T extends Object>(
    Expression<T> Function($$WeeklyReviewsTableAnnotationComposer a) f,
  ) {
    final $$WeeklyReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyReviews,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklyReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> weeklyGoalsRefs<T extends Object>(
    Expression<T> Function($$WeeklyGoalsTableAnnotationComposer a) f,
  ) {
    final $$WeeklyGoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyGoals,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyGoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklyGoals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WeeklyPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyPlansTable,
          WeeklyPlanData,
          $$WeeklyPlansTableFilterComposer,
          $$WeeklyPlansTableOrderingComposer,
          $$WeeklyPlansTableAnnotationComposer,
          $$WeeklyPlansTableCreateCompanionBuilder,
          $$WeeklyPlansTableUpdateCompanionBuilder,
          (WeeklyPlanData, $$WeeklyPlansTableReferences),
          WeeklyPlanData,
          PrefetchHooks Function({bool weeklyReviewsRefs, bool weeklyGoalsRefs})
        > {
  $$WeeklyPlansTableTableManager(_$AppDatabase db, $WeeklyPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> weekStartDate = const Value.absent(),
                Value<String?> theme = const Value.absent(),
                Value<String?> intentions = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyPlansCompanion(
                id: id,
                weekStartDate: weekStartDate,
                theme: theme,
                intentions: intentions,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required int weekStartDate,
                Value<String?> theme = const Value.absent(),
                Value<String?> intentions = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => WeeklyPlansCompanion.insert(
                id: id,
                weekStartDate: weekStartDate,
                theme: theme,
                intentions: intentions,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeeklyPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({weeklyReviewsRefs = false, weeklyGoalsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (weeklyReviewsRefs) db.weeklyReviews,
                    if (weeklyGoalsRefs) db.weeklyGoals,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (weeklyReviewsRefs)
                        await $_getPrefetchedData<
                          WeeklyPlanData,
                          $WeeklyPlansTable,
                          WeeklyReviewData
                        >(
                          currentTable: table,
                          referencedTable: $$WeeklyPlansTableReferences
                              ._weeklyReviewsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeeklyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).weeklyReviewsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.weekStartDate == item.weekStartDate,
                              ),
                          typedResults: items,
                        ),
                      if (weeklyGoalsRefs)
                        await $_getPrefetchedData<
                          WeeklyPlanData,
                          $WeeklyPlansTable,
                          WeeklyGoalData
                        >(
                          currentTable: table,
                          referencedTable: $$WeeklyPlansTableReferences
                              ._weeklyGoalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WeeklyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).weeklyGoalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.weekStartDate == item.weekStartDate,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WeeklyPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyPlansTable,
      WeeklyPlanData,
      $$WeeklyPlansTableFilterComposer,
      $$WeeklyPlansTableOrderingComposer,
      $$WeeklyPlansTableAnnotationComposer,
      $$WeeklyPlansTableCreateCompanionBuilder,
      $$WeeklyPlansTableUpdateCompanionBuilder,
      (WeeklyPlanData, $$WeeklyPlansTableReferences),
      WeeklyPlanData,
      PrefetchHooks Function({bool weeklyReviewsRefs, bool weeklyGoalsRefs})
    >;
typedef $$WeeklyReviewsTableCreateCompanionBuilder =
    WeeklyReviewsCompanion Function({
      Value<String> id,
      required int weekStartDate,
      Value<int?> themeAchieved,
      Value<String?> reflectionNotes,
      required int weekRating,
      Value<double> goalHitRate,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$WeeklyReviewsTableUpdateCompanionBuilder =
    WeeklyReviewsCompanion Function({
      Value<String> id,
      Value<int> weekStartDate,
      Value<int?> themeAchieved,
      Value<String?> reflectionNotes,
      Value<int> weekRating,
      Value<double> goalHitRate,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$WeeklyReviewsTableReferences
    extends
        BaseReferences<_$AppDatabase, $WeeklyReviewsTable, WeeklyReviewData> {
  $$WeeklyReviewsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WeeklyPlansTable _weekStartDateTable(_$AppDatabase db) =>
      db.weeklyPlans.createAlias(
        $_aliasNameGenerator(
          db.weeklyReviews.weekStartDate,
          db.weeklyPlans.weekStartDate,
        ),
      );

  $$WeeklyPlansTableProcessedTableManager get weekStartDate {
    final $_column = $_itemColumn<int>('week_start_date')!;

    final manager = $$WeeklyPlansTableTableManager(
      $_db,
      $_db.weeklyPlans,
    ).filter((f) => f.weekStartDate.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_weekStartDateTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeeklyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableFilterComposer({
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

  ColumnFilters<int> get themeAchieved => $composableBuilder(
    column: $table.themeAchieved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reflectionNotes => $composableBuilder(
    column: $table.reflectionNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekRating => $composableBuilder(
    column: $table.weekRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get goalHitRate => $composableBuilder(
    column: $table.goalHitRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$WeeklyPlansTableFilterComposer get weekStartDate {
    final $$WeeklyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyPlans,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyPlansTableFilterComposer(
            $db: $db,
            $table: $db.weeklyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableOrderingComposer({
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

  ColumnOrderings<int> get themeAchieved => $composableBuilder(
    column: $table.themeAchieved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reflectionNotes => $composableBuilder(
    column: $table.reflectionNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekRating => $composableBuilder(
    column: $table.weekRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get goalHitRate => $composableBuilder(
    column: $table.goalHitRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeeklyPlansTableOrderingComposer get weekStartDate {
    final $$WeeklyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyPlans,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.weeklyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get themeAchieved => $composableBuilder(
    column: $table.themeAchieved,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reflectionNotes => $composableBuilder(
    column: $table.reflectionNotes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weekRating => $composableBuilder(
    column: $table.weekRating,
    builder: (column) => column,
  );

  GeneratedColumn<double> get goalHitRate => $composableBuilder(
    column: $table.goalHitRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$WeeklyPlansTableAnnotationComposer get weekStartDate {
    final $$WeeklyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyPlans,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyReviewsTable,
          WeeklyReviewData,
          $$WeeklyReviewsTableFilterComposer,
          $$WeeklyReviewsTableOrderingComposer,
          $$WeeklyReviewsTableAnnotationComposer,
          $$WeeklyReviewsTableCreateCompanionBuilder,
          $$WeeklyReviewsTableUpdateCompanionBuilder,
          (WeeklyReviewData, $$WeeklyReviewsTableReferences),
          WeeklyReviewData,
          PrefetchHooks Function({bool weekStartDate})
        > {
  $$WeeklyReviewsTableTableManager(_$AppDatabase db, $WeeklyReviewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> weekStartDate = const Value.absent(),
                Value<int?> themeAchieved = const Value.absent(),
                Value<String?> reflectionNotes = const Value.absent(),
                Value<int> weekRating = const Value.absent(),
                Value<double> goalHitRate = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyReviewsCompanion(
                id: id,
                weekStartDate: weekStartDate,
                themeAchieved: themeAchieved,
                reflectionNotes: reflectionNotes,
                weekRating: weekRating,
                goalHitRate: goalHitRate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required int weekStartDate,
                Value<int?> themeAchieved = const Value.absent(),
                Value<String?> reflectionNotes = const Value.absent(),
                required int weekRating,
                Value<double> goalHitRate = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => WeeklyReviewsCompanion.insert(
                id: id,
                weekStartDate: weekStartDate,
                themeAchieved: themeAchieved,
                reflectionNotes: reflectionNotes,
                weekRating: weekRating,
                goalHitRate: goalHitRate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeeklyReviewsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({weekStartDate = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (weekStartDate) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.weekStartDate,
                                referencedTable: $$WeeklyReviewsTableReferences
                                    ._weekStartDateTable(db),
                                referencedColumn: $$WeeklyReviewsTableReferences
                                    ._weekStartDateTable(db)
                                    .weekStartDate,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeeklyReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyReviewsTable,
      WeeklyReviewData,
      $$WeeklyReviewsTableFilterComposer,
      $$WeeklyReviewsTableOrderingComposer,
      $$WeeklyReviewsTableAnnotationComposer,
      $$WeeklyReviewsTableCreateCompanionBuilder,
      $$WeeklyReviewsTableUpdateCompanionBuilder,
      (WeeklyReviewData, $$WeeklyReviewsTableReferences),
      WeeklyReviewData,
      PrefetchHooks Function({bool weekStartDate})
    >;
typedef $$WeeklyGoalsTableCreateCompanionBuilder =
    WeeklyGoalsCompanion Function({
      Value<String> id,
      required int weekStartDate,
      required String title,
      Value<int> isAchieved,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$WeeklyGoalsTableUpdateCompanionBuilder =
    WeeklyGoalsCompanion Function({
      Value<String> id,
      Value<int> weekStartDate,
      Value<String> title,
      Value<int> isAchieved,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$WeeklyGoalsTableReferences
    extends BaseReferences<_$AppDatabase, $WeeklyGoalsTable, WeeklyGoalData> {
  $$WeeklyGoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $WeeklyPlansTable _weekStartDateTable(_$AppDatabase db) =>
      db.weeklyPlans.createAlias(
        $_aliasNameGenerator(
          db.weeklyGoals.weekStartDate,
          db.weeklyPlans.weekStartDate,
        ),
      );

  $$WeeklyPlansTableProcessedTableManager get weekStartDate {
    final $_column = $_itemColumn<int>('week_start_date')!;

    final manager = $$WeeklyPlansTableTableManager(
      $_db,
      $_db.weeklyPlans,
    ).filter((f) => f.weekStartDate.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_weekStartDateTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WeeklyGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyGoalsTable> {
  $$WeeklyGoalsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isAchieved => $composableBuilder(
    column: $table.isAchieved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$WeeklyPlansTableFilterComposer get weekStartDate {
    final $$WeeklyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyPlans,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyPlansTableFilterComposer(
            $db: $db,
            $table: $db.weeklyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyGoalsTable> {
  $$WeeklyGoalsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isAchieved => $composableBuilder(
    column: $table.isAchieved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$WeeklyPlansTableOrderingComposer get weekStartDate {
    final $$WeeklyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyPlans,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.weeklyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyGoalsTable> {
  $$WeeklyGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get isAchieved => $composableBuilder(
    column: $table.isAchieved,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$WeeklyPlansTableAnnotationComposer get weekStartDate {
    final $$WeeklyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.weekStartDate,
      referencedTable: $db.weeklyPlans,
      getReferencedColumn: (t) => t.weekStartDate,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WeeklyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.weeklyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WeeklyGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyGoalsTable,
          WeeklyGoalData,
          $$WeeklyGoalsTableFilterComposer,
          $$WeeklyGoalsTableOrderingComposer,
          $$WeeklyGoalsTableAnnotationComposer,
          $$WeeklyGoalsTableCreateCompanionBuilder,
          $$WeeklyGoalsTableUpdateCompanionBuilder,
          (WeeklyGoalData, $$WeeklyGoalsTableReferences),
          WeeklyGoalData,
          PrefetchHooks Function({bool weekStartDate})
        > {
  $$WeeklyGoalsTableTableManager(_$AppDatabase db, $WeeklyGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> weekStartDate = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> isAchieved = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyGoalsCompanion(
                id: id,
                weekStartDate: weekStartDate,
                title: title,
                isAchieved: isAchieved,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required int weekStartDate,
                required String title,
                Value<int> isAchieved = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyGoalsCompanion.insert(
                id: id,
                weekStartDate: weekStartDate,
                title: title,
                isAchieved: isAchieved,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WeeklyGoalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({weekStartDate = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (weekStartDate) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.weekStartDate,
                                referencedTable: $$WeeklyGoalsTableReferences
                                    ._weekStartDateTable(db),
                                referencedColumn: $$WeeklyGoalsTableReferences
                                    ._weekStartDateTable(db)
                                    .weekStartDate,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WeeklyGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyGoalsTable,
      WeeklyGoalData,
      $$WeeklyGoalsTableFilterComposer,
      $$WeeklyGoalsTableOrderingComposer,
      $$WeeklyGoalsTableAnnotationComposer,
      $$WeeklyGoalsTableCreateCompanionBuilder,
      $$WeeklyGoalsTableUpdateCompanionBuilder,
      (WeeklyGoalData, $$WeeklyGoalsTableReferences),
      WeeklyGoalData,
      PrefetchHooks Function({bool weekStartDate})
    >;
typedef $$MonthlyPlansTableCreateCompanionBuilder =
    MonthlyPlansCompanion Function({
      Value<String> id,
      required String monthYear,
      Value<String?> intentions,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$MonthlyPlansTableUpdateCompanionBuilder =
    MonthlyPlansCompanion Function({
      Value<String> id,
      Value<String> monthYear,
      Value<String?> intentions,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$MonthlyPlansTableReferences
    extends BaseReferences<_$AppDatabase, $MonthlyPlansTable, MonthlyPlanData> {
  $$MonthlyPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MonthlyReviewsTable, List<MonthlyReviewData>>
  _monthlyReviewsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.monthlyReviews,
    aliasName: $_aliasNameGenerator(
      db.monthlyPlans.monthYear,
      db.monthlyReviews.monthYear,
    ),
  );

  $$MonthlyReviewsTableProcessedTableManager get monthlyReviewsRefs {
    final manager = $$MonthlyReviewsTableTableManager($_db, $_db.monthlyReviews)
        .filter(
          (f) => f.monthYear.monthYear.sqlEquals(
            $_itemColumn<String>('month_year')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_monthlyReviewsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MonthlyGoalsTable, List<MonthlyGoalData>>
  _monthlyGoalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.monthlyGoals,
    aliasName: $_aliasNameGenerator(
      db.monthlyPlans.monthYear,
      db.monthlyGoals.monthYear,
    ),
  );

  $$MonthlyGoalsTableProcessedTableManager get monthlyGoalsRefs {
    final manager = $$MonthlyGoalsTableTableManager($_db, $_db.monthlyGoals)
        .filter(
          (f) => f.monthYear.monthYear.sqlEquals(
            $_itemColumn<String>('month_year')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(_monthlyGoalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MonthlyPlansTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyPlansTable> {
  $$MonthlyPlansTableFilterComposer({
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

  ColumnFilters<String> get monthYear => $composableBuilder(
    column: $table.monthYear,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intentions => $composableBuilder(
    column: $table.intentions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> monthlyReviewsRefs(
    Expression<bool> Function($$MonthlyReviewsTableFilterComposer f) f,
  ) {
    final $$MonthlyReviewsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyReviews,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyReviewsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> monthlyGoalsRefs(
    Expression<bool> Function($$MonthlyGoalsTableFilterComposer f) f,
  ) {
    final $$MonthlyGoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyGoals,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyGoalsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyGoals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MonthlyPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyPlansTable> {
  $$MonthlyPlansTableOrderingComposer({
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

  ColumnOrderings<String> get monthYear => $composableBuilder(
    column: $table.monthYear,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intentions => $composableBuilder(
    column: $table.intentions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MonthlyPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyPlansTable> {
  $$MonthlyPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get monthYear =>
      $composableBuilder(column: $table.monthYear, builder: (column) => column);

  GeneratedColumn<String> get intentions => $composableBuilder(
    column: $table.intentions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> monthlyReviewsRefs<T extends Object>(
    Expression<T> Function($$MonthlyReviewsTableAnnotationComposer a) f,
  ) {
    final $$MonthlyReviewsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyReviews,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyReviewsTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyReviews,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> monthlyGoalsRefs<T extends Object>(
    Expression<T> Function($$MonthlyGoalsTableAnnotationComposer a) f,
  ) {
    final $$MonthlyGoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyGoals,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyGoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyGoals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MonthlyPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyPlansTable,
          MonthlyPlanData,
          $$MonthlyPlansTableFilterComposer,
          $$MonthlyPlansTableOrderingComposer,
          $$MonthlyPlansTableAnnotationComposer,
          $$MonthlyPlansTableCreateCompanionBuilder,
          $$MonthlyPlansTableUpdateCompanionBuilder,
          (MonthlyPlanData, $$MonthlyPlansTableReferences),
          MonthlyPlanData,
          PrefetchHooks Function({
            bool monthlyReviewsRefs,
            bool monthlyGoalsRefs,
          })
        > {
  $$MonthlyPlansTableTableManager(_$AppDatabase db, $MonthlyPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> monthYear = const Value.absent(),
                Value<String?> intentions = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyPlansCompanion(
                id: id,
                monthYear: monthYear,
                intentions: intentions,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String monthYear,
                Value<String?> intentions = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MonthlyPlansCompanion.insert(
                id: id,
                monthYear: monthYear,
                intentions: intentions,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MonthlyPlansTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({monthlyReviewsRefs = false, monthlyGoalsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (monthlyReviewsRefs) db.monthlyReviews,
                    if (monthlyGoalsRefs) db.monthlyGoals,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (monthlyReviewsRefs)
                        await $_getPrefetchedData<
                          MonthlyPlanData,
                          $MonthlyPlansTable,
                          MonthlyReviewData
                        >(
                          currentTable: table,
                          referencedTable: $$MonthlyPlansTableReferences
                              ._monthlyReviewsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyReviewsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.monthYear == item.monthYear,
                              ),
                          typedResults: items,
                        ),
                      if (monthlyGoalsRefs)
                        await $_getPrefetchedData<
                          MonthlyPlanData,
                          $MonthlyPlansTable,
                          MonthlyGoalData
                        >(
                          currentTable: table,
                          referencedTable: $$MonthlyPlansTableReferences
                              ._monthlyGoalsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyPlansTableReferences(
                                db,
                                table,
                                p0,
                              ).monthlyGoalsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.monthYear == item.monthYear,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MonthlyPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyPlansTable,
      MonthlyPlanData,
      $$MonthlyPlansTableFilterComposer,
      $$MonthlyPlansTableOrderingComposer,
      $$MonthlyPlansTableAnnotationComposer,
      $$MonthlyPlansTableCreateCompanionBuilder,
      $$MonthlyPlansTableUpdateCompanionBuilder,
      (MonthlyPlanData, $$MonthlyPlansTableReferences),
      MonthlyPlanData,
      PrefetchHooks Function({bool monthlyReviewsRefs, bool monthlyGoalsRefs})
    >;
typedef $$MonthlyReviewsTableCreateCompanionBuilder =
    MonthlyReviewsCompanion Function({
      Value<String> id,
      required String monthYear,
      required int overallRating,
      Value<String?> win1,
      Value<String?> win2,
      Value<String?> win3,
      Value<String?> challenge1,
      Value<String?> challenge2,
      Value<String?> challenge3,
      Value<String?> gratitudeSummary,
      Value<String?> intentionsNextMonth,
      Value<double> goalCompletionRate,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$MonthlyReviewsTableUpdateCompanionBuilder =
    MonthlyReviewsCompanion Function({
      Value<String> id,
      Value<String> monthYear,
      Value<int> overallRating,
      Value<String?> win1,
      Value<String?> win2,
      Value<String?> win3,
      Value<String?> challenge1,
      Value<String?> challenge2,
      Value<String?> challenge3,
      Value<String?> gratitudeSummary,
      Value<String?> intentionsNextMonth,
      Value<double> goalCompletionRate,
      Value<int> createdAt,
      Value<int> rowid,
    });

final class $$MonthlyReviewsTableReferences
    extends
        BaseReferences<_$AppDatabase, $MonthlyReviewsTable, MonthlyReviewData> {
  $$MonthlyReviewsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyPlansTable _monthYearTable(_$AppDatabase db) =>
      db.monthlyPlans.createAlias(
        $_aliasNameGenerator(
          db.monthlyReviews.monthYear,
          db.monthlyPlans.monthYear,
        ),
      );

  $$MonthlyPlansTableProcessedTableManager get monthYear {
    final $_column = $_itemColumn<String>('month_year')!;

    final manager = $$MonthlyPlansTableTableManager(
      $_db,
      $_db.monthlyPlans,
    ).filter((f) => f.monthYear.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_monthYearTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MonthlyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyReviewsTable> {
  $$MonthlyReviewsTableFilterComposer({
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

  ColumnFilters<int> get overallRating => $composableBuilder(
    column: $table.overallRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get win1 => $composableBuilder(
    column: $table.win1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get win2 => $composableBuilder(
    column: $table.win2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get win3 => $composableBuilder(
    column: $table.win3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get challenge1 => $composableBuilder(
    column: $table.challenge1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get challenge2 => $composableBuilder(
    column: $table.challenge2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get challenge3 => $composableBuilder(
    column: $table.challenge3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gratitudeSummary => $composableBuilder(
    column: $table.gratitudeSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intentionsNextMonth => $composableBuilder(
    column: $table.intentionsNextMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get goalCompletionRate => $composableBuilder(
    column: $table.goalCompletionRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MonthlyPlansTableFilterComposer get monthYear {
    final $$MonthlyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyPlans,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyPlansTableFilterComposer(
            $db: $db,
            $table: $db.monthlyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MonthlyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyReviewsTable> {
  $$MonthlyReviewsTableOrderingComposer({
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

  ColumnOrderings<int> get overallRating => $composableBuilder(
    column: $table.overallRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get win1 => $composableBuilder(
    column: $table.win1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get win2 => $composableBuilder(
    column: $table.win2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get win3 => $composableBuilder(
    column: $table.win3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get challenge1 => $composableBuilder(
    column: $table.challenge1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get challenge2 => $composableBuilder(
    column: $table.challenge2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get challenge3 => $composableBuilder(
    column: $table.challenge3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gratitudeSummary => $composableBuilder(
    column: $table.gratitudeSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intentionsNextMonth => $composableBuilder(
    column: $table.intentionsNextMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get goalCompletionRate => $composableBuilder(
    column: $table.goalCompletionRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyPlansTableOrderingComposer get monthYear {
    final $$MonthlyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyPlans,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.monthlyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MonthlyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyReviewsTable> {
  $$MonthlyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get overallRating => $composableBuilder(
    column: $table.overallRating,
    builder: (column) => column,
  );

  GeneratedColumn<String> get win1 =>
      $composableBuilder(column: $table.win1, builder: (column) => column);

  GeneratedColumn<String> get win2 =>
      $composableBuilder(column: $table.win2, builder: (column) => column);

  GeneratedColumn<String> get win3 =>
      $composableBuilder(column: $table.win3, builder: (column) => column);

  GeneratedColumn<String> get challenge1 => $composableBuilder(
    column: $table.challenge1,
    builder: (column) => column,
  );

  GeneratedColumn<String> get challenge2 => $composableBuilder(
    column: $table.challenge2,
    builder: (column) => column,
  );

  GeneratedColumn<String> get challenge3 => $composableBuilder(
    column: $table.challenge3,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gratitudeSummary => $composableBuilder(
    column: $table.gratitudeSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get intentionsNextMonth => $composableBuilder(
    column: $table.intentionsNextMonth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get goalCompletionRate => $composableBuilder(
    column: $table.goalCompletionRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MonthlyPlansTableAnnotationComposer get monthYear {
    final $$MonthlyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyPlans,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MonthlyReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyReviewsTable,
          MonthlyReviewData,
          $$MonthlyReviewsTableFilterComposer,
          $$MonthlyReviewsTableOrderingComposer,
          $$MonthlyReviewsTableAnnotationComposer,
          $$MonthlyReviewsTableCreateCompanionBuilder,
          $$MonthlyReviewsTableUpdateCompanionBuilder,
          (MonthlyReviewData, $$MonthlyReviewsTableReferences),
          MonthlyReviewData,
          PrefetchHooks Function({bool monthYear})
        > {
  $$MonthlyReviewsTableTableManager(
    _$AppDatabase db,
    $MonthlyReviewsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> monthYear = const Value.absent(),
                Value<int> overallRating = const Value.absent(),
                Value<String?> win1 = const Value.absent(),
                Value<String?> win2 = const Value.absent(),
                Value<String?> win3 = const Value.absent(),
                Value<String?> challenge1 = const Value.absent(),
                Value<String?> challenge2 = const Value.absent(),
                Value<String?> challenge3 = const Value.absent(),
                Value<String?> gratitudeSummary = const Value.absent(),
                Value<String?> intentionsNextMonth = const Value.absent(),
                Value<double> goalCompletionRate = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyReviewsCompanion(
                id: id,
                monthYear: monthYear,
                overallRating: overallRating,
                win1: win1,
                win2: win2,
                win3: win3,
                challenge1: challenge1,
                challenge2: challenge2,
                challenge3: challenge3,
                gratitudeSummary: gratitudeSummary,
                intentionsNextMonth: intentionsNextMonth,
                goalCompletionRate: goalCompletionRate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String monthYear,
                required int overallRating,
                Value<String?> win1 = const Value.absent(),
                Value<String?> win2 = const Value.absent(),
                Value<String?> win3 = const Value.absent(),
                Value<String?> challenge1 = const Value.absent(),
                Value<String?> challenge2 = const Value.absent(),
                Value<String?> challenge3 = const Value.absent(),
                Value<String?> gratitudeSummary = const Value.absent(),
                Value<String?> intentionsNextMonth = const Value.absent(),
                Value<double> goalCompletionRate = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MonthlyReviewsCompanion.insert(
                id: id,
                monthYear: monthYear,
                overallRating: overallRating,
                win1: win1,
                win2: win2,
                win3: win3,
                challenge1: challenge1,
                challenge2: challenge2,
                challenge3: challenge3,
                gratitudeSummary: gratitudeSummary,
                intentionsNextMonth: intentionsNextMonth,
                goalCompletionRate: goalCompletionRate,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MonthlyReviewsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monthYear = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (monthYear) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.monthYear,
                                referencedTable: $$MonthlyReviewsTableReferences
                                    ._monthYearTable(db),
                                referencedColumn:
                                    $$MonthlyReviewsTableReferences
                                        ._monthYearTable(db)
                                        .monthYear,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MonthlyReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyReviewsTable,
      MonthlyReviewData,
      $$MonthlyReviewsTableFilterComposer,
      $$MonthlyReviewsTableOrderingComposer,
      $$MonthlyReviewsTableAnnotationComposer,
      $$MonthlyReviewsTableCreateCompanionBuilder,
      $$MonthlyReviewsTableUpdateCompanionBuilder,
      (MonthlyReviewData, $$MonthlyReviewsTableReferences),
      MonthlyReviewData,
      PrefetchHooks Function({bool monthYear})
    >;
typedef $$MonthlyGoalsTableCreateCompanionBuilder =
    MonthlyGoalsCompanion Function({
      Value<String> id,
      required String monthYear,
      required String title,
      Value<int> isAchieved,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$MonthlyGoalsTableUpdateCompanionBuilder =
    MonthlyGoalsCompanion Function({
      Value<String> id,
      Value<String> monthYear,
      Value<String> title,
      Value<int> isAchieved,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$MonthlyGoalsTableReferences
    extends BaseReferences<_$AppDatabase, $MonthlyGoalsTable, MonthlyGoalData> {
  $$MonthlyGoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MonthlyPlansTable _monthYearTable(_$AppDatabase db) =>
      db.monthlyPlans.createAlias(
        $_aliasNameGenerator(
          db.monthlyGoals.monthYear,
          db.monthlyPlans.monthYear,
        ),
      );

  $$MonthlyPlansTableProcessedTableManager get monthYear {
    final $_column = $_itemColumn<String>('month_year')!;

    final manager = $$MonthlyPlansTableTableManager(
      $_db,
      $_db.monthlyPlans,
    ).filter((f) => f.monthYear.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_monthYearTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MonthlyGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyGoalsTable> {
  $$MonthlyGoalsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isAchieved => $composableBuilder(
    column: $table.isAchieved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$MonthlyPlansTableFilterComposer get monthYear {
    final $$MonthlyPlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyPlans,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyPlansTableFilterComposer(
            $db: $db,
            $table: $db.monthlyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MonthlyGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyGoalsTable> {
  $$MonthlyGoalsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isAchieved => $composableBuilder(
    column: $table.isAchieved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyPlansTableOrderingComposer get monthYear {
    final $$MonthlyPlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyPlans,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyPlansTableOrderingComposer(
            $db: $db,
            $table: $db.monthlyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MonthlyGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyGoalsTable> {
  $$MonthlyGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get isAchieved => $composableBuilder(
    column: $table.isAchieved,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$MonthlyPlansTableAnnotationComposer get monthYear {
    final $$MonthlyPlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthYear,
      referencedTable: $db.monthlyPlans,
      getReferencedColumn: (t) => t.monthYear,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyPlansTableAnnotationComposer(
            $db: $db,
            $table: $db.monthlyPlans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MonthlyGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyGoalsTable,
          MonthlyGoalData,
          $$MonthlyGoalsTableFilterComposer,
          $$MonthlyGoalsTableOrderingComposer,
          $$MonthlyGoalsTableAnnotationComposer,
          $$MonthlyGoalsTableCreateCompanionBuilder,
          $$MonthlyGoalsTableUpdateCompanionBuilder,
          (MonthlyGoalData, $$MonthlyGoalsTableReferences),
          MonthlyGoalData,
          PrefetchHooks Function({bool monthYear})
        > {
  $$MonthlyGoalsTableTableManager(_$AppDatabase db, $MonthlyGoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> monthYear = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> isAchieved = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyGoalsCompanion(
                id: id,
                monthYear: monthYear,
                title: title,
                isAchieved: isAchieved,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String monthYear,
                required String title,
                Value<int> isAchieved = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyGoalsCompanion.insert(
                id: id,
                monthYear: monthYear,
                title: title,
                isAchieved: isAchieved,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MonthlyGoalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monthYear = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (monthYear) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.monthYear,
                                referencedTable: $$MonthlyGoalsTableReferences
                                    ._monthYearTable(db),
                                referencedColumn: $$MonthlyGoalsTableReferences
                                    ._monthYearTable(db)
                                    .monthYear,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MonthlyGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyGoalsTable,
      MonthlyGoalData,
      $$MonthlyGoalsTableFilterComposer,
      $$MonthlyGoalsTableOrderingComposer,
      $$MonthlyGoalsTableAnnotationComposer,
      $$MonthlyGoalsTableCreateCompanionBuilder,
      $$MonthlyGoalsTableUpdateCompanionBuilder,
      (MonthlyGoalData, $$MonthlyGoalsTableReferences),
      MonthlyGoalData,
      PrefetchHooks Function({bool monthYear})
    >;
typedef $$GoalCategoriesTableCreateCompanionBuilder =
    GoalCategoriesCompanion Function({
      Value<String> id,
      required String name,
      Value<int> sortOrder,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$GoalCategoriesTableUpdateCompanionBuilder =
    GoalCategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> sortOrder,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$GoalCategoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $GoalCategoriesTable, GoalCategoryData> {
  $$GoalCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$GoalsTable, List<GoalData>> _goalsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.goals,
    aliasName: $_aliasNameGenerator(db.goalCategories.id, db.goals.categoryId),
  );

  $$GoalsTableProcessedTableManager get goalsRefs {
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GoalCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $GoalCategoriesTable> {
  $$GoalCategoriesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> goalsRefs(
    Expression<bool> Function($$GoalsTableFilterComposer f) f,
  ) {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalCategoriesTable> {
  $$GoalCategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalCategoriesTable> {
  $$GoalCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> goalsRefs<T extends Object>(
    Expression<T> Function($$GoalsTableAnnotationComposer a) f,
  ) {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalCategoriesTable,
          GoalCategoryData,
          $$GoalCategoriesTableFilterComposer,
          $$GoalCategoriesTableOrderingComposer,
          $$GoalCategoriesTableAnnotationComposer,
          $$GoalCategoriesTableCreateCompanionBuilder,
          $$GoalCategoriesTableUpdateCompanionBuilder,
          (GoalCategoryData, $$GoalCategoriesTableReferences),
          GoalCategoryData,
          PrefetchHooks Function({bool goalsRefs})
        > {
  $$GoalCategoriesTableTableManager(
    _$AppDatabase db,
    $GoalCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalCategoriesCompanion(
                id: id,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String name,
                Value<int> sortOrder = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => GoalCategoriesCompanion.insert(
                id: id,
                name: name,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GoalCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (goalsRefs) db.goals],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (goalsRefs)
                    await $_getPrefetchedData<
                      GoalCategoryData,
                      $GoalCategoriesTable,
                      GoalData
                    >(
                      currentTable: table,
                      referencedTable: $$GoalCategoriesTableReferences
                          ._goalsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GoalCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).goalsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GoalCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalCategoriesTable,
      GoalCategoryData,
      $$GoalCategoriesTableFilterComposer,
      $$GoalCategoriesTableOrderingComposer,
      $$GoalCategoriesTableAnnotationComposer,
      $$GoalCategoriesTableCreateCompanionBuilder,
      $$GoalCategoriesTableUpdateCompanionBuilder,
      (GoalCategoryData, $$GoalCategoriesTableReferences),
      GoalCategoryData,
      PrefetchHooks Function({bool goalsRefs})
    >;
typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      Value<String> id,
      required String title,
      Value<String?> description,
      Value<String?> categoryId,
      Value<String?> kpiDescription,
      Value<String?> startValue,
      Value<String?> targetValue,
      Value<String?> priority,
      Value<String?> urgency,
      Value<String?> why,
      Value<int?> startDate,
      Value<int?> targetDate,
      Value<String?> checkInFrequency,
      required String timeHorizon,
      required int createdAt,
      required int updatedAt,
      Value<int> rowid,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<String?> categoryId,
      Value<String?> kpiDescription,
      Value<String?> startValue,
      Value<String?> targetValue,
      Value<String?> priority,
      Value<String?> urgency,
      Value<String?> why,
      Value<int?> startDate,
      Value<int?> targetDate,
      Value<String?> checkInFrequency,
      Value<String> timeHorizon,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<int> rowid,
    });

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, GoalData> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.goalCategories.createAlias(
        $_aliasNameGenerator(db.goals.categoryId, db.goalCategories.id),
      );

  $$GoalCategoriesTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<String>('category_id');
    if ($_column == null) return null;
    final manager = $$GoalCategoriesTableTableManager(
      $_db,
      $_db.goalCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kpiDescription => $composableBuilder(
    column: $table.kpiDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get why => $composableBuilder(
    column: $table.why,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkInFrequency => $composableBuilder(
    column: $table.checkInFrequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeHorizon => $composableBuilder(
    column: $table.timeHorizon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalCategoriesTableFilterComposer get categoryId {
    final $$GoalCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.goalCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.goalCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kpiDescription => $composableBuilder(
    column: $table.kpiDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get why => $composableBuilder(
    column: $table.why,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkInFrequency => $composableBuilder(
    column: $table.checkInFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeHorizon => $composableBuilder(
    column: $table.timeHorizon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalCategoriesTableOrderingComposer get categoryId {
    final $$GoalCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.goalCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.goalCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kpiDescription => $composableBuilder(
    column: $table.kpiDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get urgency =>
      $composableBuilder(column: $table.urgency, builder: (column) => column);

  GeneratedColumn<String> get why =>
      $composableBuilder(column: $table.why, builder: (column) => column);

  GeneratedColumn<int> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<int> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checkInFrequency => $composableBuilder(
    column: $table.checkInFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<String> get timeHorizon => $composableBuilder(
    column: $table.timeHorizon,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$GoalCategoriesTableAnnotationComposer get categoryId {
    final $$GoalCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.goalCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.goalCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          GoalData,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (GoalData, $$GoalsTableReferences),
          GoalData,
          PrefetchHooks Function({bool categoryId})
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> kpiDescription = const Value.absent(),
                Value<String?> startValue = const Value.absent(),
                Value<String?> targetValue = const Value.absent(),
                Value<String?> priority = const Value.absent(),
                Value<String?> urgency = const Value.absent(),
                Value<String?> why = const Value.absent(),
                Value<int?> startDate = const Value.absent(),
                Value<int?> targetDate = const Value.absent(),
                Value<String?> checkInFrequency = const Value.absent(),
                Value<String> timeHorizon = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                title: title,
                description: description,
                categoryId: categoryId,
                kpiDescription: kpiDescription,
                startValue: startValue,
                targetValue: targetValue,
                priority: priority,
                urgency: urgency,
                why: why,
                startDate: startDate,
                targetDate: targetDate,
                checkInFrequency: checkInFrequency,
                timeHorizon: timeHorizon,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> kpiDescription = const Value.absent(),
                Value<String?> startValue = const Value.absent(),
                Value<String?> targetValue = const Value.absent(),
                Value<String?> priority = const Value.absent(),
                Value<String?> urgency = const Value.absent(),
                Value<String?> why = const Value.absent(),
                Value<int?> startDate = const Value.absent(),
                Value<int?> targetDate = const Value.absent(),
                Value<String?> checkInFrequency = const Value.absent(),
                required String timeHorizon,
                required int createdAt,
                required int updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                title: title,
                description: description,
                categoryId: categoryId,
                kpiDescription: kpiDescription,
                startValue: startValue,
                targetValue: targetValue,
                priority: priority,
                urgency: urgency,
                why: why,
                startDate: startDate,
                targetDate: targetDate,
                checkInFrequency: checkInFrequency,
                timeHorizon: timeHorizon,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GoalsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (categoryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.categoryId,
                                referencedTable: $$GoalsTableReferences
                                    ._categoryIdTable(db),
                                referencedColumn: $$GoalsTableReferences
                                    ._categoryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      GoalData,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (GoalData, $$GoalsTableReferences),
      GoalData,
      PrefetchHooks Function({bool categoryId})
    >;
typedef $$GCalSyncQueueTableCreateCompanionBuilder =
    GCalSyncQueueCompanion Function({
      Value<String> id,
      required String taskId,
      required String operation,
      required String payload,
      Value<int> retryCount,
      required int createdAt,
      Value<int> rowid,
    });
typedef $$GCalSyncQueueTableUpdateCompanionBuilder =
    GCalSyncQueueCompanion Function({
      Value<String> id,
      Value<String> taskId,
      Value<String> operation,
      Value<String> payload,
      Value<int> retryCount,
      Value<int> createdAt,
      Value<int> rowid,
    });

class $$GCalSyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $GCalSyncQueueTable> {
  $$GCalSyncQueueTableFilterComposer({
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

  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GCalSyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $GCalSyncQueueTable> {
  $$GCalSyncQueueTableOrderingComposer({
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

  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GCalSyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $GCalSyncQueueTable> {
  $$GCalSyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$GCalSyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GCalSyncQueueTable,
          GCalSyncQueueData,
          $$GCalSyncQueueTableFilterComposer,
          $$GCalSyncQueueTableOrderingComposer,
          $$GCalSyncQueueTableAnnotationComposer,
          $$GCalSyncQueueTableCreateCompanionBuilder,
          $$GCalSyncQueueTableUpdateCompanionBuilder,
          (
            GCalSyncQueueData,
            BaseReferences<
              _$AppDatabase,
              $GCalSyncQueueTable,
              GCalSyncQueueData
            >,
          ),
          GCalSyncQueueData,
          PrefetchHooks Function()
        > {
  $$GCalSyncQueueTableTableManager(_$AppDatabase db, $GCalSyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GCalSyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GCalSyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GCalSyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> taskId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GCalSyncQueueCompanion(
                id: id,
                taskId: taskId,
                operation: operation,
                payload: payload,
                retryCount: retryCount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String taskId,
                required String operation,
                required String payload,
                Value<int> retryCount = const Value.absent(),
                required int createdAt,
                Value<int> rowid = const Value.absent(),
              }) => GCalSyncQueueCompanion.insert(
                id: id,
                taskId: taskId,
                operation: operation,
                payload: payload,
                retryCount: retryCount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GCalSyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GCalSyncQueueTable,
      GCalSyncQueueData,
      $$GCalSyncQueueTableFilterComposer,
      $$GCalSyncQueueTableOrderingComposer,
      $$GCalSyncQueueTableAnnotationComposer,
      $$GCalSyncQueueTableCreateCompanionBuilder,
      $$GCalSyncQueueTableUpdateCompanionBuilder,
      (
        GCalSyncQueueData,
        BaseReferences<_$AppDatabase, $GCalSyncQueueTable, GCalSyncQueueData>,
      ),
      GCalSyncQueueData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RecurrenceRulesTableTableManager get recurrenceRules =>
      $$RecurrenceRulesTableTableManager(_db, _db.recurrenceRules);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$SubtasksTableTableManager get subtasks =>
      $$SubtasksTableTableManager(_db, _db.subtasks);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$TaskTagsTableTableManager get taskTags =>
      $$TaskTagsTableTableManager(_db, _db.taskTags);
  $$DailyReviewsTableTableManager get dailyReviews =>
      $$DailyReviewsTableTableManager(_db, _db.dailyReviews);
  $$WeeklyPlansTableTableManager get weeklyPlans =>
      $$WeeklyPlansTableTableManager(_db, _db.weeklyPlans);
  $$WeeklyReviewsTableTableManager get weeklyReviews =>
      $$WeeklyReviewsTableTableManager(_db, _db.weeklyReviews);
  $$WeeklyGoalsTableTableManager get weeklyGoals =>
      $$WeeklyGoalsTableTableManager(_db, _db.weeklyGoals);
  $$MonthlyPlansTableTableManager get monthlyPlans =>
      $$MonthlyPlansTableTableManager(_db, _db.monthlyPlans);
  $$MonthlyReviewsTableTableManager get monthlyReviews =>
      $$MonthlyReviewsTableTableManager(_db, _db.monthlyReviews);
  $$MonthlyGoalsTableTableManager get monthlyGoals =>
      $$MonthlyGoalsTableTableManager(_db, _db.monthlyGoals);
  $$GoalCategoriesTableTableManager get goalCategories =>
      $$GoalCategoriesTableTableManager(_db, _db.goalCategories);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$GCalSyncQueueTableTableManager get gCalSyncQueue =>
      $$GCalSyncQueueTableTableManager(_db, _db.gCalSyncQueue);
}
