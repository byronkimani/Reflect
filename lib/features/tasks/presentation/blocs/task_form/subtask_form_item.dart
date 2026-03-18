/// Represents a subtask in the task form (no due date; inherits from parent task).
class SubtaskFormItem {
  final String id;
  final String title;
  final bool isCompleted;

  const SubtaskFormItem({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  SubtaskFormItem copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return SubtaskFormItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubtaskFormItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          isCompleted == other.isCompleted;

  @override
  int get hashCode => Object.hash(id, title, isCompleted);
}
