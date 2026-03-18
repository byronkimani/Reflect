import 'dart:async';
import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/gcal/data/sources/gcal_api_service.dart';
import 'package:reflect/features/tasks/data/models/mappers.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';

class TaskRepositoryImpl implements ITaskRepository {
  final AppDatabase _db;
  final NetworkInfo _networkInfo;
  final GCalApiService _gcalApiService;
  final RecurrenceEngine _recurrenceEngine;
  final NotificationScheduler _notificationScheduler;

  TaskRepositoryImpl(
    this._db,
    this._networkInfo,
    this._gcalApiService,
    this._recurrenceEngine,
    this._notificationScheduler,
  );

  Future<List<Task>> _loadTasksWithSubtasks(List<TaskData> rows) async {
    if (rows.isEmpty) return [];
    final taskIds = rows.map((r) => r.id).toList();
    final subtaskRows = await (_db.select(_db.subtasks)
          ..where((s) => s.taskId.isIn(taskIds)))
        .get();
    final subtasksByTask = <String, List<Subtask>>{};
    for (final s in subtaskRows) {
      subtasksByTask.putIfAbsent(s.taskId, () => []).add(s.toDomain());
    }
    final ruleIds = rows
        .map((r) => r.recurrenceRuleId)
        .whereType<String>()
        .toSet()
        .toList();
    final ruleMap = <String, RecurrenceRuleData>{};
    if (ruleIds.isNotEmpty) {
      final ruleRows = await (_db.select(_db.recurrenceRules)
            ..where((r) => r.id.isIn(ruleIds)))
          .get();
      for (final r in ruleRows) {
        ruleMap[r.id] = r;
      }
    }
    return rows.map((r) {
      final rule = r.recurrenceRuleId != null
          ? ruleMap[r.recurrenceRuleId]?.toDomain()
          : null;
      return r.toDomain(
        subtasks: subtasksByTask[r.id] ?? [],
        recurrenceRule: rule,
      );
    }).toList();
  }

  @override
  Stream<Either<Failure, List<Task>>> watchTasksForDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (_db.select(_db.tasks)
          ..where((t) =>
              t.dueDate.isBetweenValues(
                startOfDay.millisecondsSinceEpoch,
                endOfDay.millisecondsSinceEpoch,
              ) |
              t.dueDate.isNull()))
        .watch()
        .asyncMap((rows) async {
      try {
        final tasks = await _loadTasksWithSubtasks(rows);
        return Right(tasks);
      } catch (e) {
        return Left(CacheFailure(errorMessage: e.toString()));
      }
    });
  }

  @override
  Stream<Either<Failure, List<Task>>> watchBacklogTasks() {
    return (_db.select(_db.tasks)..where((t) => t.dueDate.isNull()))
        .watch()
        .asyncMap((rows) async {
      try {
        final tasks = await _loadTasksWithSubtasks(rows);
        return Right(tasks);
      } catch (e) {
        return Left(CacheFailure(errorMessage: e.toString()));
      }
    });
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksForDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    try {
      final rows = await (_db.select(_db.tasks)
            ..where((t) =>
                t.dueDate.isBetweenValues(
                  startOfDay.millisecondsSinceEpoch,
                  endOfDay.millisecondsSinceEpoch,
                ) |
                t.dueDate.isNull()))
          .get();
      final tasks = await _loadTasksWithSubtasks(rows);
      return Right(tasks);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getBacklogTasks() async {
    try {
      final rows = await (_db.select(_db.tasks)..where((t) => t.dueDate.isNull())).get();
      final tasks = await _loadTasksWithSubtasks(rows);
      return Right(tasks);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> createTask(Task task) async {
    try {
      if (task.recurrenceRule != null) {
        await _db.into(_db.recurrenceRules).insert(
              task.recurrenceRule!.toCompanion(),
              mode: InsertMode.insertOrReplace,
            );
      }
      final companion = task.toCompanion();
      await _db.into(_db.tasks).insert(companion);
      for (final subtask in task.subtasks) {
        await _db.into(_db.subtasks).insert(subtask.toCompanion());
      }
      if (task.syncToGcal) {
        _handleGCalSync(task, 'CREATE');
      }
      if (task.hasEnabledReminder && task.dueDate != null && task.dueTime != null) {
        await _notificationScheduler.scheduleTaskReminder(task);
      } else {
        await _notificationScheduler.cancelTaskReminder(task.id);
      }
      return Right(task);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      if (task.recurrenceRule != null) {
        await _db.into(_db.recurrenceRules).insert(
              task.recurrenceRule!.toCompanion(),
              mode: InsertMode.insertOrReplace,
            );
      }
      await (_db.delete(_db.subtasks)..where((s) => s.taskId.equals(task.id))).go();
      for (final subtask in task.subtasks) {
        await _db.into(_db.subtasks).insert(subtask.toCompanion());
      }
      await _db.update(_db.tasks).replace(task.toCompanion());
      if (task.syncToGcal) {
        _handleGCalSync(task, 'UPDATE');
      }
      if (task.hasEnabledReminder && task.dueDate != null && task.dueTime != null) {
        await _notificationScheduler.scheduleTaskReminder(task);
      } else {
        await _notificationScheduler.cancelTaskReminder(task.id);
      }
      return Right(task);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> completeTask(String id) async {
    try {
      final query = _db.select(_db.tasks)..where((t) => t.id.equals(id));
      final taskData = await query.getSingle();
      final tasks = await _loadTasksWithSubtasks([taskData]);
      final task = tasks.first;

      // 1. Update Drift
      final updatedTask = task.copyWith(
        status: TaskStatus.completed,
        updatedAt: DateTime.now(),
      );
      await _db.update(_db.tasks).replace(updatedTask.toCompanion());

      // 2. Handle Recurrence
      if (task.recurrenceRule != null) {
        final nextDate = _recurrenceEngine.getNextOccurrence(task);
        if (nextDate != null) {
          final nextTask = task.copyWith(
            id: const Uuid().v4(),
            dueDate: nextDate,
            status: TaskStatus.pending,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await _db.into(_db.tasks).insert(nextTask.toCompanion());
        }
      }

      // 3. GCal Sync
      if (task.syncToGcal) {
        _handleGCalSync(updatedTask, 'UPDATE');
      }

      return Right(updatedTask);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> reopenTask(String id) async {
    try {
      final query = _db.select(_db.tasks)..where((t) => t.id.equals(id));
      final taskData = await query.getSingle();
      final tasks = await _loadTasksWithSubtasks([taskData]);
      final task = tasks.first;

      final updatedTask = task.copyWith(
        status: TaskStatus.pending,
        updatedAt: DateTime.now(),
      );
      await _db.update(_db.tasks).replace(updatedTask.toCompanion());

      if (task.syncToGcal) {
        _handleGCalSync(updatedTask, 'UPDATE');
      }

      return Right(updatedTask);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(String id) async {
    try {
      final query = _db.select(_db.tasks)..where((t) => t.id.equals(id));
      final taskData = await query.getSingleOrNull();
      
      if (taskData != null) {
        final task = taskData.toDomain();
        await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
        await _notificationScheduler.cancelTaskReminder(id);
        if (task.syncToGcal && task.gcalEventId != null) {
          _handleGCalSync(task, 'DELETE');
        }
      }
      
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _handleGCalSync(Task task, String operation) async {
    final isConnected = await _networkInfo.isConnected;
    
    if (isConnected) {
      late Either<Failure, dynamic> result;
      switch (operation) {
        case 'CREATE':
          result = await _gcalApiService.createEvent(task);
          if (result.isRight()) {
            final gcalId = result.getOrElse((_) => '');
            await _db.update(_db.tasks).replace(
              task.copyWith(gcalEventId: gcalId).toCompanion(),
            );
          }
          break;
        case 'UPDATE':
          result = await _gcalApiService.updateEvent(task);
          break;
        case 'DELETE':
          if (task.gcalEventId != null) {
            result = await _gcalApiService.deleteEvent(task.gcalEventId!);
          }
          break;
      }
      
      if (result.isLeft()) {
        _enqueueGCalSync(task, operation);
      }
    } else {
      _enqueueGCalSync(task, operation);
    }
  }

  Future<void> _enqueueGCalSync(Task task, String operation) async {
    final payload = jsonEncode(task.toJson());
    await _db.into(_db.gCalSyncQueue).insert(
      GCalSyncQueueCompanion.insert(
        taskId: task.id,
        operation: operation,
        payload: payload,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }
}
