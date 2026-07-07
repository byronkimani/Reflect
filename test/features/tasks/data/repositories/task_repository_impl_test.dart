import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:reflect/core/storage/database/app_database.dart';

import 'package:reflect/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';



class MockRecurrenceEngine extends Mock implements RecurrenceEngine {}
class MockNotificationScheduler extends Mock implements NotificationScheduler {}
class FakeTask extends Fake implements Task {}

void main() {
  late AppDatabase db;


  late MockRecurrenceEngine mockRecurrenceEngine;
  late MockNotificationScheduler mockNotificationScheduler;
  late TaskRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));


    mockRecurrenceEngine = MockRecurrenceEngine();
    mockNotificationScheduler = MockNotificationScheduler();

    repository = TaskRepositoryImpl(
      db,

      mockRecurrenceEngine,
      mockNotificationScheduler,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('TaskRepositoryImpl', () {
    final testDate = DateTime(2023, 10, 10, 10, 0);
    final task1 = Task(
      id: 't1',
      title: 'Task 1',
      createdAt: testDate,
      updatedAt: testDate,
      dueDate: testDate,
      status: TaskStatus.pending,
    );

    test('createTask inserts task into database', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      
      final result = await repository.createTask(task1);
      
      expect(result.isRight(), isTrue);
      
      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.length, 1);
      expect(dbTasks.first.id, 't1');
      expect(dbTasks.first.title, 'Task 1');
    });

    test('getTasksForDate retrieves tasks for a specific date', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      await repository.createTask(task1);
      
      final result = await repository.getTasksForDate(testDate);
      
      expect(result.isRight(), isTrue);
      final tasks = result.getOrElse((_) => []);
      expect(tasks.length, 1);
      expect(tasks.first.id, 't1');
    });

    test('getTasksForDate excludes tasks due on a different local day', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any()))
          .thenAnswer((_) async {});
      await repository.createTask(task1);

      final otherDay = DateTime(2023, 10, 11);
      final result = await repository.getTasksForDate(otherDay);

      expect(result.isRight(), isTrue);
      expect(result.getOrElse((_) => []), isEmpty);
    });

    test('getBacklogTasks retrieves tasks without due dates or past due', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      
      final backlogTask = Task(
        id: 'b1',
        title: 'Backlog Task',
        createdAt: testDate,
        updatedAt: testDate,
        dueDate: null, // No due date = backlog
        status: TaskStatus.pending,
      );

      await repository.createTask(backlogTask);
      
      final result = await repository.getBacklogTasks();
      
      expect(result.isRight(), isTrue);
      final tasks = result.getOrElse((_) => []);
      expect(tasks.length, 1);
      expect(tasks.first.id, 'b1');
    });

    test('completeTask updates status to completed', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      await repository.createTask(task1);
      
      final result = await repository.completeTask('t1');
      
      expect(result.isRight(), isTrue);
      final updatedTask = result.getOrElse((_) => throw Exception());
      expect(updatedTask.status, TaskStatus.completed);
      
      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.first.status, 'completed');
    });

    test('deleteTask removes task from database', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      await repository.createTask(task1);
      
      var dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.length, 1);
      
      final result = await repository.deleteTask('t1');
      expect(result.isRight(), isTrue);
      
      dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.length, 0);
    });

    test('moveTasksToBacklog removes due dates', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      await repository.createTask(task1);
      
      final result = await repository.moveTasksToBacklog(['t1']);
      expect(result.isRight(), isTrue);
      
      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.first.dueDate, null);
    });

    test('updateTask updates task in database', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      await repository.createTask(task1);
      final updatedTask = task1.copyWith(title: 'Updated Task 1');
      final result = await repository.updateTask(updatedTask);
      expect(result.isRight(), isTrue);
      
      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.first.title, 'Updated Task 1');
    });

    test('reopenTask reverts status to pending', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      await repository.createTask(task1);
      await repository.completeTask('t1');
      
      final result = await repository.reopenTask('t1');
      expect(result.isRight(), isTrue);
      
      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.first.status, 'pending');
    });
    test('watchTasksForDate emits tasks', () async {
      final testDate = DateTime(2023, 10, 10, 10, 0);
      final tTask = Task(
        id: 't1',
        title: 'Test',
        status: TaskStatus.pending,
        createdAt: testDate,
        updatedAt: testDate,
        dueDate: testDate,
      );
      await repository.createTask(tTask);
      final stream = repository.watchTasksForDate(testDate);
      final result = await stream.first;
      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('err'),
        (r) => expect(r.length, 1),
      );
    });

    test('watchBacklogTasks emits tasks', () async {
      final testDate = DateTime(2023, 10, 10, 10, 0);
      final tBacklog = Task(
        id: 't2',
        title: 'Test',
        status: TaskStatus.pending,
        createdAt: testDate,
        updatedAt: testDate,
      );
      await repository.createTask(tBacklog);
      final stream = repository.watchBacklogTasks();
      final result = await stream.first;
      expect(result.isRight(), isTrue);
      result.fold(
        (l) => fail('err'),
        (r) {
          expect(r.length, 1);
          expect(r.first.id, 't2');
        },
      );
    });

    test('completeTasks updates statuses to completed', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      final t1 = Task(id: 'task-1', title: 'A', status: TaskStatus.pending, priority: TaskPriority.p1, subtasks: [], tags: [], createdAt: DateTime.now(), updatedAt: DateTime.now());
      final t2 = Task(id: 'task-2', title: 'B', status: TaskStatus.pending, priority: TaskPriority.p1, subtasks: [], tags: [], createdAt: DateTime.now(), updatedAt: DateTime.now());
      await repository.createTask(t1);
      await repository.createTask(t2);

      await repository.completeTasks(['task-1', 'task-2']);
      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.every((t) => t.status == 'completed'), isTrue);
    });

    test('reopenTasks updates statuses to pending', () async {
      when(() => mockNotificationScheduler.scheduleTaskReminder(any())).thenAnswer((_) async {});
      final t1 = Task(id: 'task-1', title: 'A', status: TaskStatus.completed, priority: TaskPriority.p1, subtasks: [], tags: [], createdAt: DateTime.now(), updatedAt: DateTime.now());
      final t2 = Task(id: 'task-2', title: 'B', status: TaskStatus.completed, priority: TaskPriority.p1, subtasks: [], tags: [], createdAt: DateTime.now(), updatedAt: DateTime.now());
      await repository.createTask(t1);
      await repository.createTask(t2);

      await repository.reopenTasks(['task-1', 'task-2']);
      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.every((t) => t.status == 'pending'), isTrue);
    });

    test('deleteTasks removes tasks from database', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any())).thenAnswer((_) async {});
      final t1 = Task(id: 'task-1', title: 'A', status: TaskStatus.pending, priority: TaskPriority.p1, subtasks: [], tags: [], createdAt: DateTime.now(), updatedAt: DateTime.now());
      final t2 = Task(id: 'task-2', title: 'B', status: TaskStatus.pending, priority: TaskPriority.p1, subtasks: [], tags: [], createdAt: DateTime.now(), updatedAt: DateTime.now());
      await repository.createTask(t1);
      await repository.createTask(t2);

      await repository.deleteTasks(['task-1', 'task-2']);
      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.isEmpty, isTrue);
    });
    test('createTask returns left on database error', () async {
      final badDb = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
      final repo = TaskRepositoryImpl(badDb, mockRecurrenceEngine, mockNotificationScheduler);
      await badDb.close(); // closing it will cause errors on queries
      
      final task = Task(id: 'err1', title: 'Error', status: TaskStatus.pending, createdAt: DateTime.now(), updatedAt: DateTime.now());
      final result = await repo.createTask(task);
      expect(result.isLeft(), isTrue);
    });

    test('deleteTask returns Left when reminder cancellation fails', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any()))
          .thenAnswer((_) async {});
      await repository.createTask(task1);

      when(() => mockNotificationScheduler.cancelTaskReminder('t1'))
          .thenThrow(Exception('cancel failed'));

      final result = await repository.deleteTask('t1');

      expect(result.isLeft(), isTrue);
    });

    test('reopenTasks returns Left when database is unavailable', () async {
      when(() => mockNotificationScheduler.cancelTaskReminder(any()))
          .thenAnswer((_) async {});
      final localDb =
          AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
      final localRepo = TaskRepositoryImpl(
        localDb,
        mockRecurrenceEngine,
        mockNotificationScheduler,
      );
      await localRepo.createTask(task1.copyWith(status: TaskStatus.completed));
      await localDb.close();

      final result = await localRepo.reopenTasks(['t1']);

      expect(result.isLeft(), isTrue);
    });
  });
}
