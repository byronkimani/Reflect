import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/tasks/data/models/mappers.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  group('TaskDataX and TaskX', () {
    final now = DateTime.now();
    final taskData = TaskData(
      id: 'task1',
      title: 'Test Task',
      priority: 'p1',
      dueDate: now.millisecondsSinceEpoch,
      dueDateLocalDayStart: now.millisecondsSinceEpoch,
      dueDateUtcMs: now.millisecondsSinceEpoch,
      dueTime: 605, // 10:05
      notes: 'Test Notes',
      status: 'pending',
      isOverdue: 0,
      overdueDay: 0,
      recurrenceRuleId: null,
      recurrenceParentId: null,
      gcalEventId: null,
      syncToGcal: 0,
      goalId: null,
      hasEnabledReminder: 1,
      createdAt: now.millisecondsSinceEpoch,
      updatedAt: now.millisecondsSinceEpoch,
    );

    test('TaskData toDomain maps correctly', () {
      final task = taskData.toDomain();
      expect(task.id, 'task1');
      expect(task.title, 'Test Task');
      expect(task.priority, TaskPriority.p1);
      expect(task.dueDate!.millisecondsSinceEpoch, now.millisecondsSinceEpoch);
      expect(task.dueTime, '10:05');
      expect(task.notes, 'Test Notes');
      expect(task.status, TaskStatus.pending);
      expect(task.isOverdue, isFalse);
      expect(task.hasEnabledReminder, isTrue);
    });

    test('TaskData toDomain falls back for unknown priority and status', () {
      final invalid = TaskData(
        id: 'task2',
        title: 'Invalid enums',
        priority: 'not-a-priority',
        dueDate: null,
        dueDateLocalDayStart: null,
        dueDateUtcMs: null,
        dueTime: null,
        notes: null,
        status: 'not-a-status',
        isOverdue: 0,
        overdueDay: 0,
        recurrenceRuleId: null,
        recurrenceParentId: null,
        gcalEventId: null,
        syncToGcal: 0,
        goalId: null,
        hasEnabledReminder: 0,
        createdAt: now.millisecondsSinceEpoch,
        updatedAt: now.millisecondsSinceEpoch,
      );

      final task = invalid.toDomain();

      expect(task.priority, TaskPriority.p4);
      expect(task.status, TaskStatus.pending);
    });

    test('Task toCompanion maps correctly', () {
      final task = taskData.toDomain();
      final companion = task.toCompanion();
      expect(companion.id.value, 'task1');
      expect(companion.title.value, 'Test Task');
      expect(companion.priority.value, 'p1');
      expect(companion.dueTime.value, 605);
      expect(companion.hasEnabledReminder.value, 1);
    });
  });

  group('SubtaskDataX and SubtaskX', () {
    final now = DateTime.now();
    final subtaskData = SubtaskData(
      id: 'sub1',
      taskId: 'task1',
      title: 'Sub',
      isCompleted: 1,
      sortOrder: 1,
      createdAt: now.millisecondsSinceEpoch,
    );

    test('SubtaskData toDomain maps correctly', () {
      final subtask = subtaskData.toDomain();
      expect(subtask.id, 'sub1');
      expect(subtask.isCompleted, isTrue);
    });

    test('Subtask toCompanion maps correctly', () {
      final subtask = subtaskData.toDomain();
      final companion = subtask.toCompanion();
      expect(companion.id.value, 'sub1');
      expect(companion.isCompleted.value, 1);
    });
  });

  group('TagDataX and TagX', () {
    final now = DateTime.now();
    final tagData = TagData(
      id: 'tag1',
      name: 'Work',
      colour: 'red',
      createdAt: now.millisecondsSinceEpoch,
    );

    test('TagData toDomain maps correctly', () {
      final tag = tagData.toDomain();
      expect(tag.id, 'tag1');
      expect(tag.name, 'Work');
    });

    test('Tag toCompanion maps correctly', () {
      final tag = tagData.toDomain();
      final companion = tag.toCompanion();
      expect(companion.id.value, 'tag1');
      expect(companion.name.value, 'Work');
    });
  });

  group('RecurrenceRuleDataX and RecurrenceRuleX', () {
    final recurrenceData = RecurrenceRuleData(
      id: 'rule1',
      frequency: 'DAILY',
      intervalVal: 1,
      daysOfWeek: jsonEncode([1, 2]),
      dayOfMonth: 5,
      endType: 'NEVER',
      endDate: null,
      endCount: null,
      occurrenceCount: 0,
    );

    test('RecurrenceRuleData toDomain maps correctly', () {
      final rule = recurrenceData.toDomain();
      expect(rule.id, 'rule1');
      expect(rule.frequency, RecurrenceFrequency.DAILY);
      expect(rule.daysOfWeek, [1, 2]);
    });

    test('RecurrenceRule toCompanion maps correctly', () {
      final rule = recurrenceData.toDomain();
      final companion = rule.toCompanion();
      expect(companion.id.value, 'rule1');
      expect(companion.frequency.value, 'DAILY');
      expect(companion.daysOfWeek.value, jsonEncode([1, 2]));
    });
  });
}
