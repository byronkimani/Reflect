import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/gcal/data/sources/gcal_api_service.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/tasks/data/repositories/task_repository_impl.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockGCalApiService extends Mock implements GCalApiService {}

class MockRecurrenceEngine extends Mock implements RecurrenceEngine {}

class MockNotificationScheduler extends Mock implements NotificationScheduler {}

void main() {
  late AppDatabase db;
  late TaskRepositoryImpl repo;
  late MockNetworkInfo mockNetworkInfo;
  late MockNotificationScheduler mockNotificationScheduler;

  final now = DateTime(2025, 3, 18, 12, 0);
  final todayStart = DateTime(2025, 3, 18);

  setUpAll(() {
    registerFallbackValue(
      Task(id: '', title: '', createdAt: now, updatedAt: now),
    );
  });

  setUp(() async {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    mockNetworkInfo = MockNetworkInfo();
    mockNotificationScheduler = MockNotificationScheduler();
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    when(
      () => mockNotificationScheduler.scheduleTaskReminder(any()),
    ).thenAnswer((_) async {});
    when(
      () => mockNotificationScheduler.cancelTaskReminder(any()),
    ).thenAnswer((_) async {});

    repo = TaskRepositoryImpl(
      db,
      mockNetworkInfo,
      MockGCalApiService(),
      RecurrenceEngineImpl(),
      mockNotificationScheduler,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('TaskRepositoryImpl updateTask', () {
    test(
      'updateTask persists subtasks so getTasksForDate returns updated task',
      () async {
        final taskId = 'task-1';
        final sub1 = Subtask(
          id: 'sub-1',
          taskId: taskId,
          title: 'Original subtask',
          isCompleted: false,
          sortOrder: 0,
          createdAt: now,
        );
        final task = Task(
          id: taskId,
          title: 'Task',
          priority: TaskPriority.p4,
          dueDate: todayStart,
          createdAt: now,
          updatedAt: now,
          subtasks: [sub1],
        );

        final createResult = await repo.createTask(task);
        expect(createResult.isRight(), true);

        final sub2 = Subtask(
          id: 'sub-2',
          taskId: taskId,
          title: 'New subtask',
          isCompleted: false,
          sortOrder: 1,
          createdAt: now,
        );
        final updatedTask = task.copyWith(
          title: 'Updated title',
          notes: 'Updated notes',
          updatedAt: now.add(const Duration(minutes: 1)),
          subtasks: [sub1, sub2],
        );

        final updateResult = await repo.updateTask(updatedTask);
        expect(updateResult.isRight(), true);

        final getResult = await repo.getTasksForDate(todayStart);
        expect(getResult.isRight(), true);
        final list = getResult.getOrElse((l) => []);
        expect(list.length, 1);
        expect(list.first.id, taskId);
        expect(list.first.title, 'Updated title');
        expect(list.first.notes, 'Updated notes');
        expect(list.first.subtasks.length, 2);
        expect(list.first.subtasks.map((s) => s.title).toList(), [
          'Original subtask',
          'New subtask',
        ]);
      },
    );

    test('updateTask with empty subtasks removes all subtasks', () async {
      final taskId = 'task-2';
      final sub = Subtask(
        id: 'sub-1',
        taskId: taskId,
        title: 'Only subtask',
        isCompleted: false,
        sortOrder: 0,
        createdAt: now,
      );
      final task = Task(
        id: taskId,
        title: 'Task with one',
        priority: TaskPriority.p4,
        dueDate: todayStart,
        createdAt: now,
        updatedAt: now,
        subtasks: [sub],
      );

      await repo.createTask(task);

      final updatedTask = task.copyWith(
        updatedAt: now.add(const Duration(minutes: 1)),
        subtasks: [],
      );
      final updateResult = await repo.updateTask(updatedTask);
      expect(updateResult.isRight(), true);

      final getResult = await repo.getTasksForDate(todayStart);
      final list = getResult.getOrElse((l) => []);
      final t = list.where((x) => x.id == taskId).single;
      expect(t.subtasks, isEmpty);
    });
  });
}
