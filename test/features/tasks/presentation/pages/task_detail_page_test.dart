import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';
import 'package:reflect/features/tasks/presentation/pages/task_detail_page.dart';

class MockITaskRepository extends Mock implements ITaskRepository {}

class MockIGoalRepository extends Mock implements IGoalRepository {}

void main() {
  late MockITaskRepository mockRepo;
  late MockIGoalRepository mockGoalRepo;
  final now = DateTime(2025, 3, 18, 12, 0);

  Task task({
    String id = 'task-1',
    String title = 'Existing task',
    List<Subtask> subtasks = const [],
    DateTime? dueDate,
    String? notes,
  }) => Task(
    id: id,
    title: title,
    priority: TaskPriority.p4,
    dueDate: dueDate ?? now,
    notes: notes,
    createdAt: now,
    updatedAt: now,
    subtasks: subtasks,
  );

  Subtask subtask({
    String id = 'sub-1',
    String title = 'Subtask one',
    bool isCompleted = false,
  }) => Subtask(
    id: id,
    taskId: 'task-1',
    title: title,
    isCompleted: isCompleted,
    sortOrder: 0,
    createdAt: now,
  );

  Widget buildTestWidget({String taskId = 'new', Task? initialTask}) {
    final navigatorKey = GlobalKey<NavigatorState>();
    final router = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: '/edit',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: SizedBox.shrink()),
          routes: [
            GoRoute(
              path: 'edit',
              builder: (_, _) => BlocProvider<TaskFormCubit>(
                create: (_) => TaskFormCubit(
                  mockRepo,
                  mockGoalRepo,
                  initialTask,
                ),
                child: const TaskFormView(),
              ),
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }

  setUp(() {
    mockRepo = MockITaskRepository();
    mockGoalRepo = MockIGoalRepository();
    when(() => mockGoalRepo.watchAllGoals()).thenAnswer(
      (_) => Stream.value(const Right(<Goal>[])),
    );
  });

  setUpAll(() {
    registerFallbackValue(
      Task(id: '', title: '', createdAt: now, updatedAt: now),
    );
  });

  group('TaskDetailPage / TaskFormView', () {
    testWidgets('new task shows title "New Task" and empty form', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('New Task'), findsOneWidget);
      expect(find.byType(TextField), findsWidgets);
    });

    testWidgets('edit task shows title "Edit Task" and prefilled task title', (
      tester,
    ) async {
      final t = task(title: 'My existing task');
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      expect(find.text('Edit Task'), findsOneWidget);
      expect(find.text('My existing task'), findsOneWidget);
    });

    testWidgets('edit task with subtasks shows existing subtask titles', (
      tester,
    ) async {
      final sub1 = subtask(id: 's1', title: 'First step');
      final sub2 = subtask(id: 's2', title: 'Second step');
      final t = task(title: 'Task with steps', subtasks: [sub1, sub2]);
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      expect(find.text('First step'), findsOneWidget);
      expect(find.text('Second step'), findsOneWidget);
    });

    testWidgets('tap Save with empty title shows error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Title cannot be empty'), findsOneWidget);
    });

    testWidgets(
      'edit task: add subtask, tap Save, calls updateTask with new subtask',
      (tester) async {
        final t = task(
          id: 'task-1',
          title: 'Original',
          subtasks: [subtask(id: 's1', title: 'Existing')],
        );
        when(
          () => mockRepo.updateTask(any()),
        ).thenAnswer((_) async => Right(t));
        await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Add Sub Task'));
        await tester.pumpAndSettle();

        final textFields = find.byType(TextField);
        expect(textFields.evaluate().length, greaterThanOrEqualTo(3));
        await tester.enterText(textFields.at(2), 'New step');
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final captured = verify(
          () => mockRepo.updateTask(captureAny()),
        ).captured;
        expect(captured.length, 1);
        final updated = captured[0] as Task;
        expect(updated.subtasks.length, 2);
        expect(updated.subtasks.any((s) => s.title == 'Existing'), isTrue);
        expect(updated.subtasks.any((s) => s.title == 'New step'), isTrue);
      },
    );

    testWidgets(
      'edit task: change title and Save calls updateTask with new title',
      (tester) async {
        final t = task(id: 'task-1', title: 'Old title');
        when(
          () => mockRepo.updateTask(any()),
        ).thenAnswer((_) async => Right(t));
        await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField).first, 'Updated title');
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        final captured = verify(
          () => mockRepo.updateTask(captureAny()),
        ).captured;
        expect((captured[0] as Task).title, 'Updated title');
      },
    );

    testWidgets('new task: enter title and Save calls createTask', (
      tester,
    ) async {
      when(
        () => mockRepo.createTask(any()),
      ).thenAnswer((_) async => Right(task()));
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'New task title');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      verify(() => mockRepo.createTask(any())).called(1);
    });

    testWidgets(
      'after edit and save, re-opening form shows updated task with all subtasks',
      (tester) async {
        final sub1 = subtask(id: 's1', title: 'Step one');
        final t = task(id: 'task-1', title: 'Original title', subtasks: [sub1]);
        Task? capturedTask;
        when(() => mockRepo.updateTask(any())).thenAnswer((invocation) async {
          capturedTask = invocation.positionalArguments[0] as Task;
          return Right(capturedTask!);
        });
        await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField).first, 'Edited title');
        await tester.pumpAndSettle();

        await tester.tap(find.text('Add Sub Task'));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextField).at(2), 'Step two');
        await tester.pumpAndSettle();

        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 100));

        expect(capturedTask, isNotNull);
        expect(capturedTask!.title, 'Edited title');
        expect(capturedTask!.subtasks.length, 2);
        expect(
          capturedTask!.subtasks.any((s) => s.title == 'Step one'),
          isTrue,
        );
        expect(
          capturedTask!.subtasks.any((s) => s.title == 'Step two'),
          isTrue,
        );

        await tester.pumpWidget(
          buildTestWidget(taskId: capturedTask!.id, initialTask: capturedTask),
        );
        await tester.pumpAndSettle();

        expect(find.text('Edit Task'), findsOneWidget);
        expect(find.text('Edited title'), findsOneWidget);
        expect(find.text('Step one'), findsOneWidget);
        expect(find.text('Step two'), findsOneWidget);
      },
    );

    testWidgets('editing notes and saving passes notes to updateTask', (
      tester,
    ) async {
      final t = task(id: 'task-1', title: 'Task', notes: 'Old notes');
      when(() => mockRepo.updateTask(any())).thenAnswer((invocation) async {
        return Right(invocation.positionalArguments[0] as Task);
      });
      await tester.pumpWidget(buildTestWidget(taskId: t.id, initialTask: t));
      await tester.pumpAndSettle();

      final textFields = find.byType(TextField);
      expect(textFields.evaluate().length, greaterThanOrEqualTo(2));
      await tester.enterText(textFields.at(1), 'New notes');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      final captured = verify(() => mockRepo.updateTask(captureAny())).captured;
      expect((captured[0] as Task).notes, 'New notes');
    });
  });
}
