import 'package:reflect/features/tasks/domain/entities/task.dart';

abstract class TaskRepository {
  Stream<List<Task>> watchTasksForDate(DateTime date);
  Stream<List<Task>> watchBacklog();
  Future<void> completeTask(String id);
  Future<void> pushToTomorrow(String id);
  Future<void> deleteTask(String id);
  Future<void> pullTaskFromBacklog(String taskId, DateTime date);
  Future<void> pushTaskFurther(String taskId, DateTime newDate);
  Future<void> moveToBacklog(String taskId);
  Future<List<Task>> getYesterdayIncomplete();
  Future<List<Task>> getBacklogTasks();
}
