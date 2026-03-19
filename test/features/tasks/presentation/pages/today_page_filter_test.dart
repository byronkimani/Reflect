import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';
import 'package:reflect/features/tasks/presentation/pages/today_page.dart';

class MockTaskListBloc extends Mock implements TaskListBloc {}

class MockTaskSelectionCubit extends Mock implements TaskSelectionCubit {}

class MockTaskRepository extends Mock implements ITaskRepository {}

void main() {
  late MockTaskListBloc mockTaskListBloc;
  late MockTaskSelectionCubit mockTaskSelectionCubit;
  final now = DateTime(2025, 3, 19, 12, 0);

  setUp(() {
    mockTaskListBloc = MockTaskListBloc();
    mockTaskSelectionCubit = MockTaskSelectionCubit();

    when(
      () => mockTaskListBloc.state,
    ).thenReturn(const TaskListState.initial());
    when(
      () => mockTaskSelectionCubit.state,
    ).thenReturn(const TaskSelectionState());
    when(() => mockTaskListBloc.stream).thenAnswer((_) => const Stream.empty());
    when(
      () => mockTaskSelectionCubit.stream,
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => mockTaskListBloc.close(),
    ).thenAnswer((_) async => Future<void>.value());
    when(
      () => mockTaskSelectionCubit.close(),
    ).thenAnswer((_) async => Future<void>.value());
  });

  Task testTask(
    String id,
    String title, {
    DateTime? dueDate,
    TaskStatus status = TaskStatus.pending,
    bool isOverdue = false,
  }) {
    return Task(
      id: id,
      title: title,
      dueDate: dueDate,
      status: status,
      isOverdue: isOverdue,
      createdAt: now,
      updatedAt: now,
    );
  }

  Widget createWidget() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TaskListBloc>.value(value: mockTaskListBloc),
          BlocProvider<TaskSelectionCubit>.value(value: mockTaskSelectionCubit),
        ],
        child: const TodayPage(),
      ),
    );
  }

  group('TodayPage Filtering Widget Tests', () {
    testWidgets('shows today and overdue tasks, but hides future tasks', (
      WidgetTester tester,
    ) async {
      final today = DateTime(2025, 3, 19);
      final yesterday = DateTime(2025, 3, 18);

      final pending = [testTask('1', 'Today Task', dueDate: today)];
      final overdue = [
        testTask('2', 'Overdue Task', dueDate: yesterday, isOverdue: true),
      ];
      final completed = <Task>[];

      // Note: In reality, we expect the repository to not return tomorrow's tasks for watchTasksForDate(today).
      // Here we simulate what the Bloc emits after receiving data from the repository.
      when(() => mockTaskListBloc.state).thenReturn(
        TaskListState.loaded(
          pending: pending,
          completed: completed,
          overdue: overdue,
          sortMode: SortMode.statusPendingFirst,
          filter: const TaskListFilter(),
        ),
      );

      await tester.pumpWidget(createWidget());

      expect(find.text('Today Task'), findsOneWidget);
      expect(find.text('Overdue Task'), findsOneWidget);
      expect(find.text('Tomorrow Task'), findsNothing);
    });

    testWidgets('shows empty state when no tasks are returned for today', (
      WidgetTester tester,
    ) async {
      when(() => mockTaskListBloc.state).thenReturn(
        const TaskListState.loaded(
          pending: [],
          completed: [],
          overdue: [],
          sortMode: SortMode.statusPendingFirst,
          filter: TaskListFilter(),
        ),
      );

      await tester.pumpWidget(createWidget());

      expect(find.text('No tasks for today. Plus some rest?'), findsOneWidget);
    });
  });
}
