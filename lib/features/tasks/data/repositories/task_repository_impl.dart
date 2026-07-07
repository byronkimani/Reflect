import 'dart:async';


import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/errors/failure_mapper.dart';

import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/tasks/data/models/mappers.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';

class TaskRepositoryImpl implements ITaskRepository {
  final AppDatabase _db;
  final RecurrenceEngine _recurrenceEngine;
  final NotificationScheduler _notificationScheduler;
  TaskRepositoryImpl(
    this._db,

    this._recurrenceEngine,
    this._notificationScheduler,
  );

  Future<List<Task>> _loadTasksWithSubtasks(List<TaskData> rows) async {
    if (rows.isEmpty) return [];
    final taskIds = rows.map((r) => r.id).toList();
    final subtaskRows = await (_db.select(_db.subtasks)
          ..where((s) => s.taskId.isIn(taskIds))
          ..orderBy([(s) => OrderingTerm.asc(s.sortOrder)]))
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
    final dayStart = DateTime(date.year, date.month, date.day)
        .millisecondsSinceEpoch;

    return (_db.select(_db.tasks)
          ..where((t) => t.dueDateLocalDayStart.equals(dayStart)))
        .watch()
        .asyncMap((rows) async {
      try {
        final tasks = await _loadTasksWithSubtasks(rows);
        return Right(tasks);
      } catch (e) {
        return Left(FailureMapper.cacheFailure(e));
      }
    });
  }

  @override
  Stream<Either<Failure, List<Task>>> watchBacklogTasks() {
    final todayStart = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).millisecondsSinceEpoch;
    return (_db.select(_db.tasks)
          ..where((t) =>
              t.dueDateLocalDayStart.isNull() |
              t.dueDateLocalDayStart.isBiggerThanValue(todayStart)))
        .watch()
        .asyncMap((rows) async {
      try {
        final tasks = await _loadTasksWithSubtasks(rows);
        return Right(tasks);
      } catch (e) {
        return Left(FailureMapper.cacheFailure(e));
      }
    });
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksForDate(DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day)
        .millisecondsSinceEpoch;

    try {
      final rows = await (_db.select(_db.tasks)
            ..where((t) => t.dueDateLocalDayStart.equals(dayStart)))
          .get();
      final tasks = await _loadTasksWithSubtasks(rows);
      return Right(tasks);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getBacklogTasks() async {
    final todayStart = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).millisecondsSinceEpoch;
    try {
      final rows = await (_db.select(_db.tasks)
            ..where((t) =>
                t.dueDateLocalDayStart.isNull() |
                t.dueDateLocalDayStart.isBiggerThanValue(todayStart)))
          .get();
      final tasks = await _loadTasksWithSubtasks(rows);
      return Right(tasks);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, Task>> createTask(Task task) async {
    try {
      await _db.transaction(() async {
        if (task.recurrenceRule != null) {
          await _db.into(_db.recurrenceRules).insert(
                task.recurrenceRule!.toCompanion(),
                mode: InsertMode.insertOrReplace,
              );
        }
        await _db.into(_db.tasks).insert(task.toCompanion());
        
        if (task.subtasks.isNotEmpty) {
          await _db.batch((batch) {
            for (final subtask in task.subtasks) {
              batch.insert(_db.subtasks, subtask.toCompanion());
            }
          });
        }
      });

      if (task.hasEnabledReminder && task.dueDate != null && task.dueTime != null) {
        await _notificationScheduler.scheduleTaskReminder(task);
      } else {
        await _notificationScheduler.cancelTaskReminder(task.id);
      }
      return Right(task);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      await _db.transaction(() async {
        if (task.recurrenceRule != null) {
          await _db.into(_db.recurrenceRules).insert(
                task.recurrenceRule!.toCompanion(),
                mode: InsertMode.insertOrReplace,
              );
        }
        await (_db.delete(_db.subtasks)..where((s) => s.taskId.equals(task.id))).go();
        if (task.subtasks.isNotEmpty) {
          await _db.batch((batch) {
            for (final subtask in task.subtasks) {
              batch.insert(_db.subtasks, subtask.toCompanion());
            }
          });
        }
        await _db.update(_db.tasks).replace(task.toCompanion());
      });

      if (task.hasEnabledReminder && task.dueDate != null && task.dueTime != null) {
        await _notificationScheduler.scheduleTaskReminder(task);
      } else {
        await _notificationScheduler.cancelTaskReminder(task.id);
      }
      return Right(task);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
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

      // 3. (Removed GCal Sync)

      return Right(updatedTask);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
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

      return Right(updatedTask);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTask(String id) async {
    try {
      final query = _db.select(_db.tasks)..where((t) => t.id.equals(id));
      final taskData = await query.getSingleOrNull();
      
      if (taskData != null) {

        await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
        await _notificationScheduler.cancelTaskReminder(id);
      }
      
      return const Right(unit);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> completeTasks(List<String> ids) async {
    try {
      await _db.transaction(() async {
        for (final id in ids) {
          await completeTask(id);
        }
      });
      return const Right(unit);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> reopenTasks(List<String> ids) async {
    try {
      await _db.transaction(() async {
        for (final id in ids) {
          await reopenTask(id);
        }
      });
      return const Right(unit);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> moveTasksToBacklog(List<String> ids) async {
    try {
      await _db.transaction(() async {
        final now = DateTime.now();
        for (final id in ids) {
          final query = _db.select(_db.tasks)..where((t) => t.id.equals(id));
          final taskData = await query.getSingle();
          final task = taskData.toDomain();
          
          final updatedTask = task.copyWith(
            dueDate: null,
            dueTime: null,
            updatedAt: now,
          );
          
          await _db.update(_db.tasks).replace(updatedTask.toCompanion());
          await _notificationScheduler.cancelTaskReminder(id);
        }
      });
      return const Right(unit);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTasks(List<String> ids) async {
    try {
      await _db.transaction(() async {
        for (final id in ids) {
          await deleteTask(id);
        }
      });
      return const Right(unit);
    } catch (e) {
      return Left(FailureMapper.cacheFailure(e));
    }
  }
}
