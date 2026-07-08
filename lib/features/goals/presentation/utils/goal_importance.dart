import 'package:reflect/features/tasks/domain/entities/task.dart';

/// Combined importance level for goals (maps to priority + urgency).
enum GoalImportance { low, medium, high, critical }

abstract final class GoalImportanceMapper {
  static GoalImportance? fromPriorities(
    TaskPriority? priority,
    TaskPriority? urgency,
  ) {
    if (priority == null && urgency == null) return null;
    final p = priority ?? urgency;
    final u = urgency ?? priority;
    if (p == TaskPriority.p1 && u == TaskPriority.p1) {
      return GoalImportance.critical;
    }
    if (p == TaskPriority.p2 && u == TaskPriority.p2) {
      return GoalImportance.high;
    }
    if (p == TaskPriority.p3 && u == TaskPriority.p3) {
      return GoalImportance.medium;
    }
    if (p == TaskPriority.p4 && u == TaskPriority.p4) {
      return GoalImportance.low;
    }
    return null;
  }

  static (TaskPriority?, TaskPriority?) toPriorities(GoalImportance? level) {
    return switch (level) {
      GoalImportance.critical => (TaskPriority.p1, TaskPriority.p1),
      GoalImportance.high => (TaskPriority.p2, TaskPriority.p2),
      GoalImportance.medium => (TaskPriority.p3, TaskPriority.p3),
      GoalImportance.low => (TaskPriority.p4, TaskPriority.p4),
      null => (null, null),
    };
  }

  static String label(GoalImportance level) => switch (level) {
        GoalImportance.low => 'Low',
        GoalImportance.medium => 'Medium',
        GoalImportance.high => 'High',
        GoalImportance.critical => 'Critical',
      };
}
