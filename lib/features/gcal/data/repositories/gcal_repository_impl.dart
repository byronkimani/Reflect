import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/gcal/data/sources/gcal_api_service.dart';
import 'package:reflect/features/gcal/domain/repositories/gcal_repository.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

class GCalRepositoryImpl implements IGCalRepository {
  final AppDatabase _db;
  final GCalApiService _apiService;

  GCalRepositoryImpl(this._db, this._apiService);

  @override
  Future<Either<Failure, String>> pushEvent(Task task) async {
    return _apiService.createEvent(task);
  }

  @override
  Future<Either<Failure, Unit>> updateEvent(Task task) async {
    return _apiService.updateEvent(task);
  }

  @override
  Future<Either<Failure, Unit>> processQueue() async {
    try {
      final queueItems = await _db.select(_db.gCalSyncQueue).get();
      
      for (final item in queueItems) {
        if (item.retryCount >= 3) continue; // Max 3 retries policy

        final taskJson = jsonDecode(item.payload);
        final task = Task.fromJson(taskJson);
        
        late Either<Failure, dynamic> result;
        switch (item.operation) {
          case 'CREATE':
            result = await _apiService.createEvent(task);
            if (result.isRight()) {
              final gcalId = result.getOrElse((_) => '');
              // Update task with gcalId
              await (_db.update(_db.tasks)..where((t) => t.id.equals(task.id)))
                  .write(TasksCompanion(gcalEventId: Value(gcalId)));
            }
            break;
          case 'UPDATE':
            result = await _apiService.updateEvent(task);
            break;
          case 'DELETE':
            if (task.gcalEventId != null) {
              result = await _apiService.deleteEvent(task.gcalEventId!);
            } else {
              result = const Right(unit);
            }
            break;
          default:
            result = const Right(unit);
        }

        if (result.isRight()) {
          await (_db.delete(_db.gCalSyncQueue)..where((t) => t.id.equals(item.id))).go();
        } else {
          // Increment retry count
          await (_db.update(_db.gCalSyncQueue)..where((t) => t.id.equals(item.id)))
              .write(GCalSyncQueueCompanion(retryCount: Value(item.retryCount + 1)));
        }
      }
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Stream<int> watchQueueDepth() {
    return _db.select(_db.gCalSyncQueue).watch().map((list) => list.length);
  }

  @override
  Future<Either<Failure, Unit>> signIn() async {
    // Placeholder logic
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    // Placeholder logic
    return const Right(unit);
  }
}
