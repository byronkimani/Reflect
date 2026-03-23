import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@DataClassName('TaskData')
class Tasks extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get title => text()();
  TextColumn get priority => text()(); // p1, p2, p3, p4
  IntColumn get dueDate => integer().nullable()(); // Unix epoch ms (local due date/time instant)
  /// Start of the due calendar day in the user's local timezone (epoch ms). Used for analytics and day bucketing.
  IntColumn get dueDateLocalDayStart => integer().nullable()();
  /// Canonical due instant as epoch ms (same convention as [DateTime.millisecondsSinceEpoch]). Reserved for sync / server use.
  IntColumn get dueDateUtcMs => integer().nullable()();
  IntColumn get dueTime => integer().nullable()(); // minutes from midnight
  TextColumn get notes => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('pending'))();
  IntColumn get isOverdue => integer().withDefault(const Constant(0))();
  IntColumn get overdueDay => integer().withDefault(const Constant(0))();
  
  TextColumn get recurrenceRuleId => 
      text().nullable().customConstraint('REFERENCES recurrence_rules(id) ON DELETE SET NULL')();
  TextColumn get recurrenceParentId => 
      text().nullable().customConstraint('REFERENCES tasks(id) ON DELETE CASCADE')();

  IntColumn get hasEnabledReminder => integer().withDefault(const Constant(0))();

  TextColumn get gcalEventId => text().nullable()();
  IntColumn get syncToGcal => integer().withDefault(const Constant(0))();

  TextColumn get goalId =>
      text().nullable().customConstraint('REFERENCES goals(id) ON DELETE SET NULL')();

  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SubtaskData')
class Subtasks extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get taskId => text().customConstraint('NOT NULL REFERENCES tasks(id) ON DELETE CASCADE')();
  TextColumn get title => text()();
  IntColumn get isCompleted => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TagData')
class Tags extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get name => text().unique()();
  TextColumn get colour => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('TaskTagData')
class TaskTags extends Table {
  TextColumn get taskId => text().customConstraint('NOT NULL REFERENCES tasks(id) ON DELETE CASCADE')();
  TextColumn get tagId => text().customConstraint('NOT NULL REFERENCES tags(id) ON DELETE CASCADE')();

  @override
  Set<Column> get primaryKey => {taskId, tagId};
}

@DataClassName('RecurrenceRuleData')
class RecurrenceRules extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get frequency => text()(); // DAILY, WEEKLY, MONTHLY, YEARLY
  IntColumn get intervalVal => integer().withDefault(const Constant(1))();
  TextColumn get daysOfWeek => text().nullable()(); // JSON array
  IntColumn get dayOfMonth => integer().nullable()();
  TextColumn get endType => text().withDefault(const Constant('NEVER'))(); // NEVER, DATE, COUNT
  IntColumn get endDate => integer().nullable()();
  IntColumn get endCount => integer().nullable()();
  IntColumn get occurrenceCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
