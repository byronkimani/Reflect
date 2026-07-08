import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';

void main() {
  group('Task Entity', () {
    final now = DateTime.now();

    test('fromJson deserializes task fields', () {
      final task = Task.fromJson({
        'id': '1',
        'title': 'Test',
        'createdAt': now.toIso8601String(),
        'updatedAt': now.toIso8601String(),
        'tags': [
          {
            'id': 'tag-1',
            'name': 'Work',
            'colour': '#FF0000',
            'createdAt': now.toIso8601String(),
          },
        ],
      });

      expect(task.id, '1');
      expect(task.title, 'Test');
      expect(task.tags, hasLength(1));
      expect(task.tags.first.name, 'Work');
    });

    test('isBacklog returns true when dueDate is null', () {
      final task = Task(
        id: '1',
        title: 'Test',
        createdAt: now,
        updatedAt: now,
        dueDate: null,
      );
      expect(task.isBacklog, isTrue);
    });

    test('isBacklog returns false when dueDate is not null', () {
      final task = Task(
        id: '1',
        title: 'Test',
        createdAt: now,
        updatedAt: now,
        dueDate: now,
      );
      expect(task.isBacklog, isFalse);
    });

    test('hasSubtasks returns true when subtasks list is not empty', () {
      final task = Task(
        id: '1',
        title: 'Test',
        createdAt: now,
        updatedAt: now,
        subtasks: [
          Subtask(id: 's1', taskId: '1', title: 'sub1', isCompleted: false, createdAt: now),
        ],
      );
      expect(task.hasSubtasks, isTrue);
    });

    test('completedSubtasks counts only completed subtasks', () {
      final task = Task(
        id: '1',
        title: 'Test',
        createdAt: now,
        updatedAt: now,
        subtasks: [
          Subtask(id: 's1', taskId: '1', title: 'sub1', isCompleted: true, createdAt: now),
          Subtask(id: 's2', taskId: '1', title: 'sub2', isCompleted: false, createdAt: now),
          Subtask(id: 's3', taskId: '1', title: 'sub3', isCompleted: true, createdAt: now),
        ],
      );
      expect(task.completedSubtasks, 2);
    });

    test('allSubtasksDone returns true when all subtasks are completed', () {
      final task = Task(
        id: '1',
        title: 'Test',
        createdAt: now,
        updatedAt: now,
        subtasks: [
          Subtask(id: 's1', taskId: '1', title: 'sub1', isCompleted: true, createdAt: now),
          Subtask(id: 's2', taskId: '1', title: 'sub2', isCompleted: true, createdAt: now),
        ],
      );
      expect(task.allSubtasksDone, isTrue);
    });

    test('allSubtasksDone returns false when at least one subtask is not completed', () {
      final task = Task(
        id: '1',
        title: 'Test',
        createdAt: now,
        updatedAt: now,
        subtasks: [
          Subtask(id: 's1', taskId: '1', title: 'sub1', isCompleted: true, createdAt: now),
          Subtask(id: 's2', taskId: '1', title: 'sub2', isCompleted: false, createdAt: now),
        ],
      );
      expect(task.allSubtasksDone, isFalse);
    });

    test('allSubtasksDone returns false when there are no subtasks', () {
      final task = Task(
        id: '1',
        title: 'Test',
        createdAt: now,
        updatedAt: now,
        subtasks: [],
      );
      expect(task.allSubtasksDone, isFalse);
    });
  });
}
