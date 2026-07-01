import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/subtask_form_item.dart';

void main() {
  test('equality compares id, title, and completion', () {
    const a = SubtaskFormItem(id: '1', title: 'Step', isCompleted: false);
    const b = SubtaskFormItem(id: '1', title: 'Step', isCompleted: false);
    const c = SubtaskFormItem(id: '1', title: 'Other', isCompleted: false);

    expect(a, b);
    expect(a.hashCode, b.hashCode);
    expect(a == c, isFalse);
  });

  test('copyWith updates provided fields', () {
    const original = SubtaskFormItem(id: '1', title: 'Step', isCompleted: false);

    final updated = original.copyWith(title: 'Done step', isCompleted: true);

    expect(updated.title, 'Done step');
    expect(updated.isCompleted, isTrue);
    expect(updated.id, '1');
  });
}
