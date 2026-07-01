import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/gcal/data/sources/gcal_api_service.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/tasks/data/models/mappers.dart';
import 'package:reflect/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGCalApiService extends Mock implements GCalApiService {}

class MockRecurrenceEngine extends Mock implements RecurrenceEngine {}

class MockNotificationScheduler extends Mock implements NotificationScheduler {}

class FakeTask extends Fake implements Task {}

void main() {
  late AppDatabase db;
  late MockNetworkInfo mockNetworkInfo;
  late MockGCalApiService mockGCalApiService;
  late MockRecurrenceEngine mockRecurrenceEngine;
  late MockNotificationScheduler mockNotificationScheduler;
  late TaskRepositoryImpl repository;

  final testDate = DateTime(2025, 6, 15, 9, 0);
  final todayStart = DateTime(2025, 6, 15);

  setUpAll(() {
    registerFallbackValue(FakeTask());
  });

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    mockNetworkInfo = MockNetworkInfo();
    mockGCalApiService = MockGCalApiService();
    mockRecurrenceEngine = MockRecurrenceEngine();
    mockNotificationScheduler = MockNotificationScheduler();

    when(
      () => mockNotificationScheduler.cancelTaskReminder(any()),
    ).thenAnswer((_) async {});
    when(
      () => mockNotificationScheduler.scheduleTaskReminder(any()),
    ).thenAnswer((_) async {});

    repository = TaskRepositoryImpl(
      db,
      mockNetworkInfo,
      mockGCalApiService,
      mockRecurrenceEngine,
      mockNotificationScheduler,
    );
  });

  tearDown(() async {
    await db.close();
  });

  Task buildTask({
    String id = 't1',
    bool syncToGcal = false,
    String? gcalEventId,
    RecurrenceRule? recurrenceRule,
    List<Subtask> subtasks = const [],
    bool hasEnabledReminder = false,
    String? dueTime,
  }) {
    return Task(
      id: id,
      title: 'Task $id',
      createdAt: testDate,
      updatedAt: testDate,
      dueDate: todayStart,
      dueTime: dueTime,
      status: TaskStatus.pending,
      syncToGcal: syncToGcal,
      gcalEventId: gcalEventId,
      recurrenceRule: recurrenceRule,
      subtasks: subtasks,
      hasEnabledReminder: hasEnabledReminder,
    );
  }

  group('TaskRepositoryImpl GCal sync', () {
    test('createTask enqueues sync when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask(syncToGcal: true);
      final result = await repository.createTask(task);

      expect(result.isRight(), isTrue);
      final queue = await db.select(db.gCalSyncQueue).get();
      expect(queue.length, 1);
      expect(queue.first.operation, 'CREATE');
      expect(queue.first.taskId, 't1');
    });

    test('createTask updates gcalEventId when online and API succeeds', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockGCalApiService.createEvent(any())).thenAnswer(
        (_) async => const Right('gcal-new-id'),
      );

      final task = buildTask(syncToGcal: true);
      await repository.createTask(task);

      await Future<void>.delayed(Duration.zero);

      final row = await (db.select(db.tasks)..where((t) => t.id.equals('t1')))
          .getSingle();
      expect(row.gcalEventId, 'gcal-new-id');
      final queue = await db.select(db.gCalSyncQueue).get();
      expect(queue, isEmpty);
    });

    test('createTask enqueues sync when online but API fails', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockGCalApiService.createEvent(any())).thenAnswer(
        (_) async => const Left(ServerFailure(errorMessage: 'API error')),
      );

      final task = buildTask(syncToGcal: true);
      await repository.createTask(task);

      await Future<void>.delayed(Duration.zero);

      final queue = await db.select(db.gCalSyncQueue).get();
      expect(queue.length, 1);
      expect(queue.first.operation, 'CREATE');
    });

    test('updateTask triggers GCal UPDATE when syncToGcal is true', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask(syncToGcal: true);
      await repository.createTask(task);
      await Future<void>.delayed(Duration.zero);

      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockGCalApiService.updateEvent(any())).thenAnswer(
        (_) async => const Right(unit),
      );

      final updated = task.copyWith(title: 'Updated', syncToGcal: true);
      await repository.updateTask(updated);

      await Future<void>.delayed(Duration.zero);

      verify(() => mockGCalApiService.updateEvent(any())).called(1);
    });

    test('deleteTask calls GCal delete when online and task has gcalEventId',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockGCalApiService.createEvent(any())).thenAnswer(
        (_) async => const Right('gcal-existing'),
      );
      when(() => mockGCalApiService.deleteEvent(any())).thenAnswer(
        (_) async => const Right(unit),
      );

      final task = buildTask(syncToGcal: true, gcalEventId: 'gcal-existing');
      await repository.createTask(task);
      await Future<void>.delayed(Duration.zero);

      await repository.deleteTask('t1');
      await Future<void>.delayed(Duration.zero);

      verify(() => mockGCalApiService.deleteEvent('gcal-existing')).called(1);
    });

    test('deleteTask enqueues DELETE when offline and task has gcalEventId',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask(syncToGcal: true, gcalEventId: 'gcal-offline');
      await repository.createTask(task);
      await Future<void>.delayed(Duration.zero);

      final result = await repository.deleteTask('t1');

      expect(result.isRight(), isTrue);
      final queue = await db.select(db.gCalSyncQueue).get();
      expect(queue.length, 1);
      expect(queue.single.operation, 'DELETE');
      expect(queue.single.taskId, 't1');

      final tasks = await db.select(db.tasks).get();
      expect(tasks, isEmpty);
    });

    test('deleteTask enqueues DELETE when online API fails', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockGCalApiService.createEvent(any())).thenAnswer(
        (_) async => const Right('gcal-retry'),
      );
      when(() => mockGCalApiService.deleteEvent(any())).thenAnswer(
        (_) async => const Left(ServerFailure(errorMessage: 'GCal unavailable')),
      );

      final task = buildTask(syncToGcal: true, gcalEventId: 'gcal-retry');
      await repository.createTask(task);
      await Future<void>.delayed(Duration.zero);

      final result = await repository.deleteTask('t1');

      expect(result.isRight(), isTrue);
      final queue = await db.select(db.gCalSyncQueue).get();
      expect(queue.length, 1);
      expect(queue.single.operation, 'DELETE');
    });

    test('deleteTask removes pending CREATE and enqueues DELETE instead',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask(syncToGcal: true);
      await repository.createTask(task);
      await Future<void>.delayed(Duration.zero);

      final queueBefore = await db.select(db.gCalSyncQueue).get();
      expect(queueBefore.any((q) => q.operation == 'CREATE'), isTrue);

      final taskWithGcal = task.copyWith(gcalEventId: 'gcal-pending');
      await db.update(db.tasks).replace(taskWithGcal.toCompanion());

      await repository.deleteTask('t1');

      final queueAfter = await db.select(db.gCalSyncQueue).get();
      expect(queueAfter.any((q) => q.operation == 'CREATE'), isFalse);
      expect(queueAfter.where((q) => q.operation == 'DELETE').length, 1);
    });

    test('moveTasksToBacklog calls GCal update when online and syncToGcal is true',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask(syncToGcal: true);
      await repository.createTask(task);
      await Future<void>.delayed(Duration.zero);

      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockGCalApiService.updateEvent(any())).thenAnswer(
        (_) async => const Right(unit),
      );

      await repository.moveTasksToBacklog(['t1']);
      await Future<void>.delayed(Duration.zero);

      verify(() => mockGCalApiService.updateEvent(any())).called(1);
      verify(() => mockNotificationScheduler.cancelTaskReminder('t1'))
          .called(2);
    });
  });

  group('TaskRepositoryImpl reminders', () {
    test('createTask schedules reminder when enabled with due date and time',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask(
        hasEnabledReminder: true,
        dueTime: '09:00',
      );
      await repository.createTask(task);

      verify(() => mockNotificationScheduler.scheduleTaskReminder(task))
          .called(1);
    });

    test('createTask cancels reminder when reminder disabled', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask(hasEnabledReminder: false);
      await repository.createTask(task);

      verify(() => mockNotificationScheduler.cancelTaskReminder('t1'))
          .called(1);
    });
  });

  group('TaskRepositoryImpl recurrence and relations', () {
    test('getTasksForDate loads subtasks and recurrence rule', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      const rule = RecurrenceRule(
        id: 'rule-1',
        frequency: RecurrenceFrequency.DAILY,
        intervalVal: 1,
      );
      final subtask = Subtask(
        id: 'sub-1',
        taskId: 't1',
        title: 'Subtask A',
        sortOrder: 0,
        createdAt: testDate,
      );
      final task = buildTask(recurrenceRule: rule, subtasks: [subtask]);

      await repository.createTask(task);

      final result = await repository.getTasksForDate(todayStart);
      expect(result.isRight(), isTrue);

      final tasks = result.getOrElse((_) => []);
      expect(tasks.length, 1);
      expect(tasks.first.subtasks.length, 1);
      expect(tasks.first.subtasks.first.title, 'Subtask A');
      expect(tasks.first.recurrenceRule?.id, 'rule-1');
      expect(tasks.first.recurrenceRule?.frequency, RecurrenceFrequency.DAILY);
    });

    test('completeTask spawns next recurring task when engine returns date',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockRecurrenceEngine.getNextOccurrence(any())).thenReturn(
        DateTime(2025, 6, 16),
      );

      const rule = RecurrenceRule(
        id: 'rule-2',
        frequency: RecurrenceFrequency.DAILY,
      );
      final task = buildTask(recurrenceRule: rule);
      await repository.createTask(task);

      final result = await repository.completeTask('t1');
      expect(result.isRight(), isTrue);

      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.length, 2);
      expect(dbTasks.any((t) => t.id != 't1' && t.status == 'pending'), isTrue);
    });

    test('completeTask does not spawn task when recurrence engine returns null',
        () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(() => mockRecurrenceEngine.getNextOccurrence(any())).thenReturn(null);

      const rule = RecurrenceRule(
        id: 'rule-3',
        frequency: RecurrenceFrequency.DAILY,
      );
      final task = buildTask(recurrenceRule: rule);
      await repository.createTask(task);

      await repository.completeTask('t1');

      final dbTasks = await db.select(db.tasks).get();
      expect(dbTasks.length, 1);
    });
  });

  group('TaskRepositoryImpl error paths', () {
    test('updateTask returns Left when database is closed', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask();
      await repository.createTask(task);
      await db.close();

      final result = await repository.updateTask(task.copyWith(title: 'Fail'));

      expect(result.isLeft(), isTrue);
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (_) => fail('Expected Left'),
      );
    });

    test('completeTask returns Left for non-existent task id', () async {
      final result = await repository.completeTask('missing-id');

      expect(result.isLeft(), isTrue);
    });

    test('reopenTask returns Left for non-existent task id', () async {
      final result = await repository.reopenTask('missing-id');

      expect(result.isLeft(), isTrue);
    });

    test('deleteTask succeeds for non-existent task id', () async {
      final result = await repository.deleteTask('missing-id');

      expect(result, const Right(unit));
    });

    test('completeTasks returns Left when database is closed', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      final task = buildTask(id: 'valid-1');
      await repository.createTask(task);
      await db.close();

      final result = await repository.completeTasks(['valid-1']);

      expect(result.isLeft(), isTrue);
    });

    test('moveTasksToBacklog returns Left for non-existent task id', () async {
      final result = await repository.moveTasksToBacklog(['missing']);

      expect(result.isLeft(), isTrue);
    });

    test('reopenTask triggers GCal UPDATE when syncToGcal is true', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(() => mockGCalApiService.createEvent(any()))
          .thenAnswer((_) async => const Right('gcal-created'));
      when(() => mockGCalApiService.updateEvent(any()))
          .thenAnswer((_) async => const Right(unit));

      final task = buildTask(syncToGcal: true);
      await repository.createTask(task);
      await Future<void>.delayed(Duration.zero);
      await repository.completeTask('t1');

      final result = await repository.reopenTask('t1');
      expect(result.isRight(), isTrue);

      await Future<void>.delayed(const Duration(milliseconds: 50));
      verify(() => mockGCalApiService.updateEvent(any())).called(greaterThanOrEqualTo(1));
    });
  });
}
