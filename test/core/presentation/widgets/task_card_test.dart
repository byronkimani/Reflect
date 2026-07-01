import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';

import 'package:bloc_test/bloc_test.dart';

class MockTaskListBloc extends MockBloc<TaskListEvent, TaskListState>
    implements TaskListBloc {}

class MockTaskSelectionCubit extends MockCubit<TaskSelectionState>
    implements TaskSelectionCubit {}

void main() {
  late MockTaskListBloc mockTaskListBloc;
  late MockTaskSelectionCubit mockSelectionCubit;
  final now = DateTime(2025, 6, 30, 12);

  Task buildTask({
    String id = 'task-1',
    String title = 'Buy groceries',
    TaskStatus status = TaskStatus.pending,
    bool isOverdue = false,
    RecurrenceRule? recurrenceRule,
    String? dueTime,
  }) => Task(
    id: id,
    title: title,
    status: status,
    isOverdue: isOverdue,
    dueDate: now,
    dueTime: dueTime,
    recurrenceRule: recurrenceRule,
    createdAt: now,
    updatedAt: now,
  );

  Widget buildWidget(Task task, {String routePrefix = '/today'}) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => MultiBlocProvider(
              providers: [
                BlocProvider<TaskListBloc>.value(value: mockTaskListBloc),
                BlocProvider<TaskSelectionCubit>.value(
                  value: mockSelectionCubit,
                ),
              ],
              child: TaskCard(task: task, taskRoutePrefix: routePrefix),
            ),
          ),
          GoRoute(
            path: '/today/task/:id',
            builder: (_, state) => Scaffold(
              body: Text('Detail ${state.pathParameters['id']}'),
            ),
          ),
        ],
      ),
    );
  }

  setUpAll(() {
    registerFallbackValue(const TaskListEvent.completeTask('x'));
    registerFallbackValue('');
  });

  setUp(() {
    mockTaskListBloc = MockTaskListBloc();
    mockSelectionCubit = MockTaskSelectionCubit();
    when(() => mockTaskListBloc.state).thenReturn(const TaskListState.initial());
    when(() => mockSelectionCubit.state)
        .thenReturn(const TaskSelectionState());
  });

  group('TaskCard', () {
    testWidgets('completes task when checkbox checked', (tester) async {
      await tester.pumpWidget(buildWidget(buildTask()));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      verify(
        () => mockTaskListBloc.add(const TaskListEvent.completeTask('task-1')),
      ).called(1);
    });

    testWidgets('reopens completed task when checkbox unchecked', (tester) async {
      await tester.pumpWidget(
        buildWidget(buildTask(status: TaskStatus.completed)),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      verify(
        () => mockTaskListBloc.add(const TaskListEvent.reopenTask('task-1')),
      ).called(1);
    });

    testWidgets('navigates to task detail on tap', (tester) async {
      final task = buildTask();
      await tester.pumpWidget(buildWidget(task));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Buy groceries'));
      await tester.pumpAndSettle();

      expect(find.text('Detail task-1'), findsOneWidget);
    });

    testWidgets('shows overdue styling', (tester) async {
      await tester.pumpWidget(
        buildWidget(buildTask(isOverdue: true)),
      );
      await tester.pumpAndSettle();

      expect(find.text('Buy groceries'), findsOneWidget);
    });

    testWidgets('shows recurrence icon when task repeats', (tester) async {
      await tester.pumpWidget(
        buildWidget(
          buildTask(
            recurrenceRule: const RecurrenceRule(
              id: 'rule-1',
              frequency: RecurrenceFrequency.DAILY,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.repeat), findsOneWidget);
    });

    testWidgets('shows sync icon when task syncs to Google Calendar', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildWidget(buildTask().copyWith(syncToGcal: true)),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.sync), findsOneWidget);
    });

    testWidgets('shows OVERDUE badge for overdue pending tasks', (tester) async {
      await tester.pumpWidget(
        buildWidget(buildTask(isOverdue: true)),
      );
      await tester.pumpAndSettle();

      expect(find.text('OVERDUE'), findsOneWidget);
    });

    testWidgets('checkbox toggles selection in selection mode', (tester) async {
      when(() => mockSelectionCubit.state).thenReturn(
        const TaskSelectionState(
          isSelectionMode: true,
          selectedTaskIds: {},
        ),
      );
      when(() => mockSelectionCubit.toggleSelection(any())).thenReturn(null);

      await tester.pumpWidget(buildWidget(buildTask()));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      verify(() => mockSelectionCubit.toggleSelection('task-1')).called(1);
    });

    testWidgets('deletes task via slidable action', (tester) async {
      await tester.pumpWidget(buildWidget(buildTask()));
      await tester.pumpAndSettle();

      await tester.drag(find.text('Buy groceries'), const Offset(-300, 0));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();

      verify(
        () => mockTaskListBloc.add(const TaskListEvent.deleteTask('task-1')),
      ).called(1);
    });

    testWidgets('shows subtask progress when subtasks exist', (tester) async {
      await tester.pumpWidget(
        buildWidget(
          buildTask().copyWith(
            subtasks: [
              Subtask(
                id: 's1',
                taskId: 'task-1',
                title: 'Step',
                isCompleted: true,
                sortOrder: 0,
                createdAt: now,
              ),
              Subtask(
                id: 's2',
                taskId: 'task-1',
                title: 'Step 2',
                sortOrder: 1,
                createdAt: now,
              ),
            ],
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('1/2'), findsOneWidget);
    });

    testWidgets('wraps card in RepaintBoundary', (tester) async {
      await tester.pumpWidget(buildWidget(buildTask()));
      await tester.pumpAndSettle();

      expect(find.byType(RepaintBoundary), findsWidgets);
    });
  });
}
