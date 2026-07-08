import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/presentation/widgets/reflect_fab.dart';
import 'package:reflect/core/presentation/widgets/reflect_progress_bar.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';
import 'package:reflect/features/tasks/presentation/pages/today_page.dart';

class MockTaskSelectionCubit extends Mock implements TaskSelectionCubit {}

class MockITaskRepository extends Mock implements ITaskRepository {}

void main() {
  late TaskListBloc taskListBloc;
  late MockTaskSelectionCubit taskSelectionCubit;
  late MockITaskRepository mockRepo;

  final now = DateTime(2026, 3, 18, 10, 0);
  final pending = Task(
    id: 'p1',
    title: 'Pending task',
    createdAt: now,
    updatedAt: now,
    dueDate: now,
  );
  final completed = Task(
    id: 'c1',
    title: 'Done task',
    status: TaskStatus.completed,
    createdAt: now,
    updatedAt: now,
    dueDate: now,
  );

  setUp(() {
    mockRepo = MockITaskRepository();
    taskListBloc = TaskListBloc(mockRepo);
    taskSelectionCubit = MockTaskSelectionCubit();

    when(() => taskSelectionCubit.state).thenReturn(const TaskSelectionState());
    when(() => taskSelectionCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => taskSelectionCubit.close()).thenAnswer((_) async {});
    when(() => mockRepo.watchTasksForDate(any())).thenAnswer((_) => const Stream.empty());
  });

  tearDown(() {
    taskListBloc.close();
  });

  Future<void> pumpLoaded(WidgetTester tester) async {
    taskListBloc.emit(
      TaskListState.loaded(
        rawTasks: [pending, completed],
        pending: [pending],
        completed: [completed],
        overdue: const [],
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<TaskListBloc>.value(value: taskListBloc),
            BlocProvider<TaskSelectionCubit>.value(value: taskSelectionCubit),
          ],
          child: const TodayPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('TodayPage shows progress bar and ReflectFab when loaded',
      (tester) async {
    await pumpLoaded(tester);

    expect(find.byType(ReflectProgressBar), findsOneWidget);
    expect(find.byType(ReflectFab), findsOneWidget);
    expect(find.text('1 of 2 done today'), findsOneWidget);
  });

  testWidgets('TodayPage shows TODAY section label', (tester) async {
    await pumpLoaded(tester);

    expect(find.text('TODAY'), findsOneWidget);
    expect(find.text('Pending task'), findsOneWidget);
  });
}
