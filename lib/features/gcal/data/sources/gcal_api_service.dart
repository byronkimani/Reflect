import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

abstract class GCalApiService {
  Future<Either<Failure, String>> createEvent(Task task);
  Future<Either<Failure, Unit>> updateEvent(Task task);
  Future<Either<Failure, Unit>> deleteEvent(String gcalEventId);
}

class GCalApiServiceImpl implements GCalApiService {
  @override
  Future<Either<Failure, String>> createEvent(Task task) async {
    // Placeholder implementation
    return const Right('placeholder_gcal_id');
  }

  @override
  Future<Either<Failure, Unit>> updateEvent(Task task) async {
    // Placeholder implementation
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> deleteEvent(String gcalEventId) async {
    // Placeholder implementation
    return const Right(unit);
  }
}
