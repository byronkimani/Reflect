import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_list_event.freezed.dart';

@freezed
class TaskListEvent with _$TaskListEvent {
  const factory TaskListEvent.loadTasksForDate(DateTime date) = LoadTasksForDate;
  const factory TaskListEvent.loadBacklog() = LoadBacklog;
  const factory TaskListEvent.completeTask(String id) = CompleteTask;
  const factory TaskListEvent.reopenTask(String id) = ReopenTask;
  const factory TaskListEvent.pushToTomorrow(String id) = PushToTomorrow;
  const factory TaskListEvent.deleteTask(String id) = DeleteTask;
}
