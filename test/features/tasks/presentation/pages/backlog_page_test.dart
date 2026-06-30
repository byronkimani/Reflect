import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';
import 'package:reflect/features/tasks/presentation/pages/backlog_page.dart';
import 'package:bloc_test/bloc_test.dart';

class MockTaskListBloc extends MockBloc<TaskListEvent, TaskListState> implements TaskListBloc {}
class MockTaskSelectionCubit extends MockBloc<void, TaskSelectionState> implements TaskSelectionCubit {}

void main() {
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

  testWidgets('BacklogPage shows loading indicator when initial/loading state', (tester) async {
    when(() => mockBloc.state).thenReturn(const TaskListState.initial());
    await tester.pumpWidget(buildPage());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    when(() => mockBloc.state).thenReturn(const TaskListState.loading());
    await tester.pumpWidget(buildPage());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('BacklogPage shows error message', (tester) async {
    when(() => mockBloc.state).thenReturn(const TaskListState.error('Failed'));
    await tester.pumpWidget(buildPage());
    expect(find.text('Error: Failed'), findsOneWidget);
  });

  testWidgets('BacklogPage shows empty message when no tasks', (tester) async {
    when(() => mockBloc.state).thenReturn(const TaskListState.loaded(
      pending: [],
      completed: [],
      overdue: [],
      sortMode: SortMode.statusPendingFirst,
      filter: const TaskListFilter(),
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
    when(() => mockBloc.state).thenReturn(TaskListState.loaded(
      pending: [t1],
      completed: [t2],
      overdue: [],
      sortMode: SortMode.statusPendingFirst,
      filter: const TaskListFilter(),
    ));
    await tester.pumpWidget(buildPage());
    
    expect(find.text('Backlog 1'), findsOneWidget);
    expect(find.text('Backlog 2'), findsOneWidget);
  });
}
