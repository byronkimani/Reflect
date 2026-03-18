import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

part 'task_list_state.freezed.dart';

/// How to sort tasks within each section. Default: highest priority unfinished at top.
enum SortMode {
  /// Pending first, then by priority (default).
  statusPendingFirst,
  /// By priority (P1 first).
  priority,
  /// By due date and time (soonest first).
  dueDateTime,
  /// Repeating tasks first.
  repeats,
}

/// Filter for which tasks to show.
class TaskListFilter {
  const TaskListFilter({
    this.priorities,
    this.hasDueTimeOnly,
    this.repeatingOnly,
    this.statusFilter = TaskStatusFilter.all,
  });

  /// If set, show only tasks with these priorities.
  final Set<TaskPriority>? priorities;
  /// If true, show only tasks with due time set; if false, only without; if null, any.
  final bool? hasDueTimeOnly;
  /// If true, show only repeating; if false, only non-repeating; if null, any.
  final bool? repeatingOnly;
  final TaskStatusFilter statusFilter;

  TaskListFilter copyWith({
    Set<TaskPriority>? priorities,
    bool? hasDueTimeOnly,
    bool? repeatingOnly,
    TaskStatusFilter? statusFilter,
  }) {
    return TaskListFilter(
      priorities: priorities ?? this.priorities,
      hasDueTimeOnly: hasDueTimeOnly ?? this.hasDueTimeOnly,
      repeatingOnly: repeatingOnly ?? this.repeatingOnly,
      statusFilter: statusFilter ?? this.statusFilter,
    );
  }
}

enum TaskStatusFilter { all, pendingOnly, completedOnly }

/// Applies [filter] and [sortMode] to the raw section lists and returns
/// (displayedOverdue, displayedPending, displayedCompleted).
(List<Task> overdue, List<Task> pending, List<Task> completed) applyTaskListFilterAndSort(
  List<Task> rawOverdue,
  List<Task> rawPending,
  List<Task> rawCompleted,
  SortMode sortMode,
  TaskListFilter filter,
) {
  List<Task> filterList(List<Task> list) {
    return list.where((t) {
      if (filter.priorities != null && !filter.priorities!.contains(t.priority)) return false;
      if (filter.hasDueTimeOnly != null) {
        final hasTime = t.dueTime != null && t.dueTime!.isNotEmpty;
        if (hasTime != filter.hasDueTimeOnly) return false;
      }
      if (filter.repeatingOnly != null) {
        final repeating = t.recurrenceRule != null;
        if (repeating != filter.repeatingOnly) return false;
      }
      return true;
    }).toList();
  }

  List<Task> sortList(List<Task> list) {
    final sorted = List<Task>.from(list);
    switch (sortMode) {
      case SortMode.statusPendingFirst:
        sorted.sort((a, b) {
          final statusCompare = a.status.index.compareTo(b.status.index);
          if (statusCompare != 0) return statusCompare;
          return a.priority.index.compareTo(b.priority.index);
        });
        break;
      case SortMode.priority:
        sorted.sort((a, b) => a.priority.index.compareTo(b.priority.index));
        break;
      case SortMode.dueDateTime:
        sorted.sort((a, b) {
          final aDt = _taskDueDateTime(a);
          final bDt = _taskDueDateTime(b);
          if (aDt == null && bDt == null) return 0;
          if (aDt == null) return 1;
          if (bDt == null) return -1;
          return aDt.compareTo(bDt);
        });
        break;
      case SortMode.repeats:
        sorted.sort((a, b) {
          final aR = a.recurrenceRule != null ? 0 : 1;
          final bR = b.recurrenceRule != null ? 0 : 1;
          if (aR != bR) return aR.compareTo(bR);
          return a.priority.index.compareTo(b.priority.index);
        });
        break;
    }
    return sorted;
  }

  final showOverdue = filter.statusFilter != TaskStatusFilter.completedOnly;
  final showPending = filter.statusFilter != TaskStatusFilter.completedOnly;
  final showCompleted = filter.statusFilter != TaskStatusFilter.pendingOnly;

  final overdue = showOverdue ? sortList(filterList(rawOverdue)) : <Task>[];
  final pending = showPending ? sortList(filterList(rawPending)) : <Task>[];
  final completed = showCompleted ? sortList(filterList(rawCompleted)) : <Task>[];

  return (overdue, pending, completed);
}

DateTime? _taskDueDateTime(Task t) {
  if (t.dueDate == null) return null;
  if (t.dueTime != null && t.dueTime!.isNotEmpty) {
    final parts = t.dueTime!.split(':');
    if (parts.length >= 2) {
      final h = int.tryParse(parts[0]) ?? 0;
      final m = int.tryParse(parts[1]) ?? 0;
      return DateTime(t.dueDate!.year, t.dueDate!.month, t.dueDate!.day, h, m);
    }
  }
  return DateTime(t.dueDate!.year, t.dueDate!.month, t.dueDate!.day);
}

@freezed
class TaskListState with _$TaskListState {
  const factory TaskListState.initial() = _Initial;
  const factory TaskListState.loading() = _Loading;
  const factory TaskListState.loaded({
    required List<Task> pending,
    required List<Task> completed,
    required List<Task> overdue,
    @Default(SortMode.statusPendingFirst) SortMode sortMode,
    @Default(TaskListFilter()) TaskListFilter filter,
  }) = _Loaded;
  const factory TaskListState.error(String message) = _Error;
}
