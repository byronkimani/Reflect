import 'package:drift/drift.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/tag.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'dart:convert';

extension TaskDataX on TaskData {
  Task toDomain({
    List<Subtask> subtasks = const [],
    List<Tag> tags = const [],
    RecurrenceRule? recurrenceRule,
  }) {
    return Task(
      id: id,
      title: title,
      priority: TaskPriority.values.firstWhere(
        (e) => e.name == priority,
        orElse: () => TaskPriority.p4,
      ),
      dueDate: dueDate != null ? DateTime.fromMillisecondsSinceEpoch(dueDate!) : null,
      dueTime: dueTime != null ? '${(dueTime! ~/ 60).toString().padLeft(2, '0')}:${(dueTime! % 60).toString().padLeft(2, '0')}' : null,
      notes: notes,
      status: TaskStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => TaskStatus.pending,
      ),
      isOverdue: isOverdue == 1,
      overdueDay: overdueDay,
      recurrenceRule: recurrenceRule,
      recurrenceParentId: recurrenceParentId,
      subtasks: subtasks,
      tags: tags,
      gcalEventId: gcalEventId,
      syncToGcal: syncToGcal == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt),
    );
  }
}

extension TaskX on Task {
  TasksCompanion toCompanion() {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      priority: Value(priority.name),
      dueDate: Value(dueDate?.millisecondsSinceEpoch),
      dueTime: Value(dueTime != null ? int.parse(dueTime!.split(':')[0]) * 60 + int.parse(dueTime!.split(':')[1]) : null),
      notes: Value(notes),
      status: Value(status.name),
      isOverdue: Value(isOverdue ? 1 : 0),
      overdueDay: Value(overdueDay),
      recurrenceRuleId: Value(recurrenceRule?.id),
      recurrenceParentId: Value(recurrenceParentId),
      gcalEventId: Value(gcalEventId),
      syncToGcal: Value(syncToGcal ? 1 : 0),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
      updatedAt: Value(updatedAt.millisecondsSinceEpoch),
    );
  }
}

extension SubtaskDataX on SubtaskData {
  Subtask toDomain() {
    return Subtask(
      id: id,
      taskId: taskId,
      title: title,
      isCompleted: isCompleted == 1,
      sortOrder: sortOrder,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }
}

extension SubtaskX on Subtask {
  SubtasksCompanion toCompanion() {
    return SubtasksCompanion(
      id: Value(id),
      taskId: Value(taskId),
      title: Value(title),
      isCompleted: Value(isCompleted ? 1 : 0),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
    );
  }
}

extension TagDataX on TagData {
  Tag toDomain() {
    return Tag(
      id: id,
      name: name,
      colour: colour,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
    );
  }
}

extension TagX on Tag {
  TagsCompanion toCompanion() {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      colour: Value(colour),
      createdAt: Value(createdAt.millisecondsSinceEpoch),
    );
  }
}

extension RecurrenceRuleDataX on RecurrenceRuleData {
  RecurrenceRule toDomain() {
    return RecurrenceRule(
      id: id,
      frequency: RecurrenceFrequency.values.firstWhere((e) => e.name == frequency),
      intervalVal: intervalVal,
      daysOfWeek: daysOfWeek != null ? List<int>.from(jsonDecode(daysOfWeek!)) : null,
      dayOfMonth: dayOfMonth,
      endType: RecurrenceEndType.values.firstWhere((e) => e.name == endType),
      endDate: endDate != null ? DateTime.fromMillisecondsSinceEpoch(endDate!) : null,
      endCount: endCount,
      occurrenceCount: occurrenceCount,
    );
  }
}

extension RecurrenceRuleX on RecurrenceRule {
  RecurrenceRulesCompanion toCompanion() {
    return RecurrenceRulesCompanion(
      id: Value(id),
      frequency: Value(frequency.name),
      intervalVal: Value(intervalVal),
      daysOfWeek: Value(daysOfWeek != null ? jsonEncode(daysOfWeek) : null),
      dayOfMonth: Value(dayOfMonth),
      endType: Value(endType.name),
      endDate: Value(endDate?.millisecondsSinceEpoch),
      endCount: Value(endCount),
      occurrenceCount: Value(occurrenceCount),
    );
  }
}
