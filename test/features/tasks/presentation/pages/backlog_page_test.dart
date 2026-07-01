import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';
import 'package:reflect/features/tasks/presentation/pages/backlog_page.dart';

class MockTaskListBloc extends MockBloc<TaskListEvent, TaskListState>
    implements TaskListBloc {}

class MockTaskSelectionCubit extends MockBloc<void, TaskSelectionState>
    implements TaskSelectionCubit {}

void main() {
  setUpAll(() {
    registerFallbackValue(const TaskListEvent.filterChanged(TaskListFilter()));
  });

  late MockTaskListBloc mockBloc;
  late MockTaskSelectionCubit mockSelectionCubit;

  setUp(() {
    mockBloc = MockTaskListBloc();
    mockSelectionCubit = MockTaskSelectionCubit();
    when(() => mockSelectionCubit.state).thenReturn(const TaskSelectionState());
  });

  Widget buildPage() {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TaskListBloc>.value(value: mockBloc),
          BlocProvider<TaskSelectionCubit>.value(value: mockSelectionCubit),
        ],
        child: const BacklogPage(),
      ),
    );
  }

  testWidgets('BacklogPage shows loading indicator for initial and loading states',
      (tester) async {
    whenListen(
      mockBloc,
      Stream.fromIterable([
        const TaskListState.initial(),
        const TaskListState.loading(),
      ]),
      initialState: const TaskListState.initial(),
    );

    await tester.pumpWidget(buildPage());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('BacklogPage filter button opens filter sheet', (tester) async {
    when(() => mockBloc.state).thenReturn(const TaskListState.loaded(rawTasks: [], 
      pending: [],
      completed: [],
      overdue: [],
      sortMode: SortMode.statusPendingFirst,
      filter: TaskListFilter(),
    ));
    when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.tune));
    await tester.pumpAndSettle();

    expect(find.text('Filter'), findsOneWidget);
  });

  testWidgets('BacklogPage shows error message', (tester) async {
    when(() => mockBloc.state).thenReturn(const TaskListState.error('Failed'));
    await tester.pumpWidget(buildPage());
    expect(find.text('Error: Failed'), findsOneWidget);
  });

  testWidgets('BacklogPage shows empty message when no tasks', (tester) async {
    when(() => mockBloc.state).thenReturn(const TaskListState.loaded(rawTasks: [], 
      pending: [],
      completed: [],
      overdue: [],
      sortMode: SortMode.statusPendingFirst,
      filter: TaskListFilter(),
    ));
    await tester.pumpWidget(buildPage());
    expect(find.text('No tasks in backlog.'), findsOneWidget);
  });

  testWidgets('BacklogPage shows tasks from pending and completed', (tester) async {
    final t1 = Task(
      id: 't1',
      title: 'Backlog 1',
      status: TaskStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final t2 = Task(
      id: 't2',
      title: 'Backlog 2',
      status: TaskStatus.completed,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    when(() => mockBloc.state).thenReturn(TaskListState.loaded(rawTasks: [], 
      pending: [t1],
      completed: [t2],
      overdue: [],
      sortMode: SortMode.statusPendingFirst,
      filter: TaskListFilter(),
    ));
    await tester.pumpWidget(buildPage());
    
    expect(find.text('Backlog 1'), findsOneWidget);
    expect(find.text('Backlog 2'), findsOneWidget);
  });

  testWidgets('BacklogPage sort button opens sort menu', (tester) async {
    when(() => mockBloc.state).thenReturn(const TaskListState.loaded(rawTasks: [], 
      pending: [],
      completed: [],
      overdue: [],
      sortMode: SortMode.statusPendingFirst,
      filter: TaskListFilter(),
    ));
    when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.sort_by_alpha));
    await tester.pumpAndSettle();

    expect(find.text('Sort by'), findsOneWidget);
  });

  testWidgets('BacklogPage FAB is present', (tester) async {
    when(() => mockBloc.state).thenReturn(const TaskListState.loaded(rawTasks: [], 
      pending: [],
      completed: [],
      overdue: [],
    ));
    when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (_, _) => MultiBlocProvider(
                providers: [
                  BlocProvider<TaskListBloc>.value(value: mockBloc),
                  BlocProvider<TaskSelectionCubit>.value(value: mockSelectionCubit),
                ],
                child: const BacklogPage(),
              ),
            ),
            GoRoute(
              path: '/backlog/task/new',
              builder: (_, _) => const Scaffold(body: Text('New backlog task')),
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('New backlog task'), findsOneWidget);
  });
}
