import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/core/presentation/widgets/reflect_fab.dart';
import 'package:reflect/features/tasks/presentation/pages/today_page.dart';

class MockTaskListBloc extends Mock implements TaskListBloc {}

class MockITaskRepository extends Mock implements ITaskRepository {}

void main() {
  late MockTaskListBloc mockTaskListBloc;
  late TaskSelectionCubit taskSelectionCubit;
  late MockITaskRepository mockRepo;
  final now = DateTime(2025, 3, 19, 12);

  setUpAll(() {
    registerFallbackValue(DateTime(2025, 3, 19));
  });

  setUp(() {
    mockRepo = MockITaskRepository();
    mockTaskListBloc = MockTaskListBloc();
    taskSelectionCubit = TaskSelectionCubit();

    when(() => mockTaskListBloc.state).thenReturn(const TaskListState.initial());
    when(() => mockTaskListBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockTaskListBloc.close()).thenAnswer((_) async {});
    when(
      () => mockRepo.watchTasksForDate(any()),
    ).thenAnswer((_) => Stream.value(const Right([])));
  });

  tearDown(() {
    taskSelectionCubit.close();
  });

  Widget buildWidget() {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => MultiBlocProvider(
              providers: [
                BlocProvider<TaskListBloc>.value(value: mockTaskListBloc),
                BlocProvider<TaskSelectionCubit>.value(
                  value: taskSelectionCubit,
                ),
              ],
              child: const TodayPage(),
            ),
          ),
          GoRoute(
            path: '/today/task/new',
            builder: (_, _) => const Scaffold(body: Text('New task form')),
          ),
        ],
      ),
    );
  }

  Widget buildWidgetWithRealBloc(TaskListBloc bloc) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TaskListBloc>.value(value: bloc),
          BlocProvider<TaskSelectionCubit>.value(value: taskSelectionCubit),
        ],
        child: const TodayPage(),
      ),
    );
  }

  Task testTask(String id, String title) => Task(
        id: id,
        title: title,
        createdAt: now,
        updatedAt: now,
      );

  testWidgets('shows loading indicator for initial and loading states', (
    tester,
  ) async {
    when(() => mockTaskListBloc.state).thenReturn(const TaskListState.initial());
    await tester.pumpWidget(buildWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    when(() => mockTaskListBloc.state).thenReturn(const TaskListState.loading());
    await tester.pumpWidget(buildWidget());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when state is error', (tester) async {
    when(() => mockTaskListBloc.state)
        .thenReturn(const TaskListState.error('Something broke'));
    await tester.pumpWidget(buildWidget());
    await tester.pumpAndSettle();

    expect(find.text('Error: Something broke'), findsOneWidget);
  });

  testWidgets('sort button opens sort menu', (tester) async {
    when(() => mockTaskListBloc.state).thenReturn(
      const TaskListState.loaded(rawTasks: [], 
        pending: [],
        completed: [],
        overdue: [],
        sortMode: SortMode.statusPendingFirst,
        filter: TaskListFilter(),
      ),
    );
    await tester.pumpWidget(buildWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.sort_by_alpha));
    await tester.pumpAndSettle();

    expect(find.text('Sort by'), findsOneWidget);
  });

  testWidgets('FAB navigates to new task route', (tester) async {
    when(() => mockTaskListBloc.state).thenReturn(
      TaskListState.loaded(rawTasks: [], 
        pending: [testTask('1', 'Task 1')],
        completed: [],
        overdue: [],
      ),
    );
    await tester.pumpWidget(buildWidget());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ReflectFab));
    await tester.pumpAndSettle();

    expect(find.text('New task form'), findsOneWidget);
  });

  testWidgets('rebuilds when loaded task list changes', (tester) async {
    whenListen(
      mockTaskListBloc,
      Stream.fromIterable([
        TaskListState.loaded(
          rawTasks: [],
          pending: [testTask('1', 'First task')],
          completed: [],
          overdue: [],
        ),
        TaskListState.loaded(
          rawTasks: [],
          pending: [
            testTask('1', 'First task'),
            testTask('2', 'Second task'),
          ],
          completed: [],
          overdue: [],
        ),
      ]),
      initialState: const TaskListState.initial(),
    );

    await tester.pumpWidget(buildWidget());
    await tester.pump();
    await tester.pump();

    expect(find.text('First task'), findsOneWidget);
    expect(find.text('Second task'), findsOneWidget);
  });

  testWidgets('select-all checkbox clears selection when all selected', (
    tester,
  ) async {
    final tasks = [testTask('1', 'Task 1'), testTask('2', 'Task 2')];
    final taskListBloc = TaskListBloc(mockRepo);
    addTearDown(taskListBloc.close);

    taskListBloc.emit(
      TaskListState.loaded(rawTasks: [], 
        pending: tasks,
        completed: [],
        overdue: [],
      ),
    );

    await tester.pumpWidget(buildWidgetWithRealBloc(taskListBloc));
    await tester.pumpAndSettle();

    taskSelectionCubit.enterSelectionMode('1');
    taskSelectionCubit.toggleSelection('2');
    await tester.pumpAndSettle();

    expect(find.text('2 selected'), findsOneWidget);

    final overlay = find.ancestor(
      of: find.textContaining('selected'),
      matching: find.byType(Card),
    );
    await tester.tap(
      find.descendant(of: overlay, matching: find.byType(Checkbox)),
    );
    await tester.pumpAndSettle();

    expect(find.text('2 selected'), findsNothing);
  });
}
