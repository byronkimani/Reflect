import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

part 'task_list_event.freezed.dart';

@freezed
class TaskListEvent with _$TaskListEvent {
  const factory TaskListEvent.loadTasksForDate(DateTime date) = LoadTasksForDate;
  const factory TaskListEvent.loadBacklog() = LoadBacklog;
  const factory TaskListEvent.completeTask(String id) = CompleteTask;
  const factory TaskListEvent.reopenTask(String id) = ReopenTask;
  const factory TaskListEvent.pushToTomorrow(String id) = PushToTomorrow;
  const factory TaskListEvent.deleteTask(String id) = DeleteTask;
  const factory TaskListEvent.bulkCompleteTasks(List<String> ids) = BulkCompleteTasks;
  const factory TaskListEvent.bulkReopenTasks(List<String> ids) = BulkReopenTasks;
  const factory TaskListEvent.bulkMoveToBacklog(List<String> ids) = BulkMoveToBacklog;
  const factory TaskListEvent.bulkDeleteTasks(List<String> ids) = BulkDeleteTasks;
  const factory TaskListEvent.sortChanged(SortMode sortMode) = SortChanged;
  const factory TaskListEvent.filterChanged(TaskListFilter filter) = FilterChanged;
}
