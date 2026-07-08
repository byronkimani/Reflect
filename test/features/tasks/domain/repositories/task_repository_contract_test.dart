import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';

class MockITaskRepository extends Mock implements ITaskRepository {}

class MockRecurrenceEngine extends Mock implements RecurrenceEngine {}

class MockNotificationScheduler extends Mock implements NotificationScheduler {}

class FakeTask extends Fake implements Task {}

void main() {
  final now = DateTime(2026, 6, 30, 12);

  Task sampleTask([String id = 'task-1']) => Task(
        id: id,
        title: 'Sample',
        createdAt: now,
        updatedAt: now,
      );

  group('ITaskRepository contract', () {
    late MockITaskRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeTask());
      registerFallbackValue(now);
    });

    setUp(() {
      repository = MockITaskRepository();
    });

    test('watch and read methods return stubbed streams and futures', () async {
      final date = DateTime(2026, 6, 30);
      final tasks = [sampleTask()];

      when(() => repository.watchTasksForDate(any()))
          .thenAnswer((_) => Stream.value(Right(tasks)));
      when(() => repository.watchBacklogTasks())
          .thenAnswer((_) => Stream.value(Right(tasks)));
      when(() => repository.getTasksForDate(any()))
          .thenAnswer((_) async => Right(tasks));
      when(() => repository.getBacklogTasks())
          .thenAnswer((_) async => Right(tasks));

      expect(await repository.watchTasksForDate(date).first, Right(tasks));
      expect(await repository.watchBacklogTasks().first, Right(tasks));
      expect(await repository.getTasksForDate(date), Right(tasks));
      expect(await repository.getBacklogTasks(), Right(tasks));
    });

    test('mutation methods return stubbed task or unit results', () async {
      final task = sampleTask();

      when(() => repository.createTask(any()))
          .thenAnswer((_) async => Right(task));
      when(() => repository.updateTask(any()))
          .thenAnswer((_) async => Right(task));
      when(() => repository.toggleSubtask(any(), any()))
          .thenAnswer((_) async => Right(task));
      when(() => repository.completeTask(any()))
          .thenAnswer((_) async => Right(task));
      when(() => repository.reopenTask(any()))
          .thenAnswer((_) async => Right(task));
      when(() => repository.deleteTask(any()))
          .thenAnswer((_) async => const Right(unit));
      when(() => repository.completeTasks(any()))
          .thenAnswer((_) async => const Right(unit));
      when(() => repository.reopenTasks(any()))
          .thenAnswer((_) async => const Right(unit));
      when(() => repository.moveTasksToBacklog(any()))
          .thenAnswer((_) async => const Right(unit));
      when(() => repository.deleteTasks(any()))
          .thenAnswer((_) async => const Right(unit));

      expect(await repository.createTask(task), Right(task));
      expect(await repository.updateTask(task), Right(task));
      expect(await repository.toggleSubtask('task-1', 'sub-1'), Right(task));
      expect(await repository.completeTask('task-1'), Right(task));
      expect(await repository.reopenTask('task-1'), Right(task));
      expect(await repository.deleteTask('task-1'), const Right(unit));
      expect(await repository.completeTasks(['task-1']), const Right(unit));
      expect(await repository.reopenTasks(['task-1']), const Right(unit));
      expect(
        await repository.moveTasksToBacklog(['task-1']),
        const Right(unit),
      );
      expect(await repository.deleteTasks(['task-1']), const Right(unit));
    });

    test('failure results propagate through the interface', () async {
      const failure = CacheFailure(errorMessage: 'offline');

      when(() => repository.getTasksForDate(any()))
          .thenAnswer((_) async => const Left(failure));
      when(() => repository.deleteTask(any()))
          .thenAnswer((_) async => const Left(failure));

      final readResult = await repository.getTasksForDate(now);
      final deleteResult = await repository.deleteTask('task-1');

      expect(readResult, const Left(failure));
      expect(deleteResult, const Left(failure));
    });
  });

  group('ITaskRepository implementation binding', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    });

    tearDown(() async {
      await db.close();
    });

    test('TaskRepositoryImpl satisfies the interface', () {
      final repository = TaskRepositoryImpl(
        db,
        MockRecurrenceEngine(),
        MockNotificationScheduler(),
      );

      expect(repository, isA<ITaskRepository>());
    });
  });
}
