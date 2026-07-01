import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';

void main() {
  group('Subtask', () {
    final createdAt = DateTime(2025, 3, 1, 12, 0);

    test('fromJson deserializes fields with defaults', () {
      final subtask = Subtask.fromJson({
        'id': 'sub-1',
        'taskId': 'task-1',
        'title': 'Write tests',
        'createdAt': createdAt.toIso8601String(),
      });

      expect(subtask.id, 'sub-1');
      expect(subtask.taskId, 'task-1');
      expect(subtask.title, 'Write tests');
      expect(subtask.isCompleted, isFalse);
      expect(subtask.sortOrder, 0);
      expect(subtask.createdAt, createdAt);
    });

    test('toJson round-trips through fromJson', () {
      final original = Subtask(
        id: 'sub-2',
        taskId: 'task-2',
        title: 'Review PR',
        isCompleted: true,
        sortOrder: 2,
        createdAt: createdAt,
      );

      final restored = Subtask.fromJson(original.toJson());

      expect(restored, original);
    });

    test('copyWith updates selected fields', () {
      final subtask = Subtask(
        id: 'sub-3',
        taskId: 'task-3',
        title: 'Original',
        createdAt: createdAt,
      );

      final updated = subtask.copyWith(title: 'Updated', isCompleted: true);

      expect(updated.title, 'Updated');
      expect(updated.isCompleted, isTrue);
      expect(updated.id, subtask.id);
    });
  });
}
