import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

abstract class ITaskRepository {
  Stream<Either<Failure, List<Task>>> watchTasksForDate(DateTime date);
  Stream<Either<Failure, List<Task>>> watchBacklogTasks();

  Future<Either<Failure, List<Task>>> getTasksForDate(DateTime date);
  Future<Either<Failure, List<Task>>> getBacklogTasks();

  Future<Either<Failure, Task>> createTask(Task task);
  Future<Either<Failure, Task>> updateTask(Task task);
  Future<Either<Failure, Task>> completeTask(String id);
  Future<Either<Failure, Task>> reopenTask(String id);
  Future<Either<Failure, Unit>> deleteTask(String id);

  Future<Either<Failure, Unit>> completeTasks(List<String> ids);
  Future<Either<Failure, Unit>> reopenTasks(List<String> ids);
  Future<Either<Failure, Unit>> moveTasksToBacklog(List<String> ids);
  Future<Either<Failure, Unit>> deleteTasks(List<String> ids);
}
