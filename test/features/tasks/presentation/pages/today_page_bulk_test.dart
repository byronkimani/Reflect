import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/pages/today_page.dart';

class MockITaskRepository extends Mock implements ITaskRepository {}

void main() {
  late TaskListBloc taskListBloc;
  late TaskSelectionCubit taskSelectionCubit;
  late MockITaskRepository mockRepo;

  setUp(() {
    mockRepo = MockITaskRepository();
    taskListBloc = TaskListBloc(mockRepo);
    taskSelectionCubit = TaskSelectionCubit();

    // Default setup for watchTasksForDate
    when(
      () => mockRepo.watchTasksForDate(any()),
    ).thenAnswer((_) => Stream.value(const Right([])));
  });

  tearDown(() {
    taskListBloc.close();
    taskSelectionCubit.close();
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TaskListBloc>.value(value: taskListBloc),
          BlocProvider<TaskSelectionCubit>.value(value: taskSelectionCubit),
        ],
        child: const TodayPage(),
      ),
    );
  }

  Task testTask(String id, String title) {
    return Task(
      id: id,
      title: title,
      priority: TaskPriority.p4,
      status: TaskStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  group('TodayPage Bulk Actions', () {
    testWidgets('shows Selection Bar when tasks are selected', (
      WidgetTester tester,
    ) async {
      final tasks = [testTask('1', 'Task 1'), testTask('2', 'Task 2')];

      taskListBloc.emit(
        TaskListState.loaded(pending: tasks, completed: [], overdue: []),
      );

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Long press first task to select it
      await tester.longPress(find.text('Task 1'));
      await tester.pumpAndSettle();

      // Verify Selection Bar is visible
      expect(find.text('1 selected'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget); // Done
      expect(
        find.byIcon(Icons.radio_button_unchecked),
        findsOneWidget,
      ); // Undone
      expect(
        find.byIcon(Icons.inventory_2_outlined),
        findsOneWidget,
      ); // Backlog
      expect(find.byIcon(Icons.delete_outline), findsOneWidget); // Delete
    });

    testWidgets('Select All checkbox selects all tasks', (
      WidgetTester tester,
    ) async {
      final tasks = [testTask('1', 'Task 1'), testTask('2', 'Task 2')];

      taskListBloc.emit(
        TaskListState.loaded(pending: tasks, completed: [], overdue: []),
      );

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Enter selection mode
      await tester.longPress(find.text('Task 1'));
      await tester.pumpAndSettle();

      // Find the select all Checkbox in the overlay
      final overlay = find.ancestor(
        of: find.textContaining('selected'),
        matching: find.byType(Card),
      );
      final selectAllCheckbox = find.descendant(
        of: overlay,
        matching: find.byType(Checkbox),
      );

      await tester.tap(selectAllCheckbox);
      await tester.pumpAndSettle();

      expect(find.text('2 selected'), findsOneWidget);
    });

    testWidgets('Cancel button exits selection mode', (
      WidgetTester tester,
    ) async {
      final tasks = [testTask('1', 'Task 1')];

      taskListBloc.emit(
        TaskListState.loaded(pending: tasks, completed: [], overdue: []),
      );

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.longPress(find.text('Task 1'));
      await tester.pumpAndSettle();

      expect(find.text('1 selected'), findsOneWidget);

      // Tap Cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('1 selected'), findsNothing);
    });

    testWidgets('Delete icon shows confirmation dialog', (
      WidgetTester tester,
    ) async {
      final tasks = [testTask('1', 'Task 1')];

      taskListBloc.emit(
        TaskListState.loaded(pending: tasks, completed: [], overdue: []),
      );

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.longPress(find.text('Task 1'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      // Verify dialog appears
      expect(find.text('Delete Tasks'), findsOneWidget);
      expect(
        find.text('Are you sure you want to delete 1 tasks?'),
        findsOneWidget,
      );
    });
  });
}
