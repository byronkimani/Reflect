import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

abstract class IGCalRepository {
  Future<Either<Failure, String>> pushEvent(Task task);
  Future<Either<Failure, Unit>> updateEvent(Task task);
  Future<Either<Failure, Unit>> processQueue();
  Stream<int> watchQueueDepth();
  Future<Either<Failure, Unit>> signIn();
  Future<Either<Failure, Unit>> signOut();
}
