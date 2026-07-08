import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/subtask.dart';
import 'package:reflect/features/tasks/domain/entities/tag.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';

import 'package:bloc_test/bloc_test.dart';

import '../../../helpers/slidable_test_harness.dart';

class MockTaskListBloc extends MockBloc<TaskListEvent, TaskListState>
    implements TaskListBloc {}

class MockTaskSelectionCubit extends MockCubit<TaskSelectionState>
    implements TaskSelectionCubit {}

void main() {
  late MockTaskListBloc mockTaskListBloc;
  late MockTaskSelectionCubit mockSelectionCubit;
  late DateTime now;

  Task buildTask({
    String id = 'task-1',
    String title = 'Buy groceries',
    TaskStatus status = TaskStatus.pending,
    bool isOverdue = false,
    RecurrenceRule? recurrenceRule,
    String? dueTime,
    DateTime? dueDate,
  }) => Task(
    id: id,
    title: title,
    status: status,
    isOverdue: isOverdue,
    dueDate: dueDate ?? now,
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
    registerFallbackValue(
      TaskListEvent.rescheduleTask(
        taskId: 'x',
        newDueDate: DateTime(2026),
      ),
    );
  });

  setUp(() {
    now = DateTime.now();
    mockTaskListBloc = MockTaskListBloc();
    mockSelectionCubit = MockTaskSelectionCubit();
    when(() => mockTaskListBloc.state).thenReturn(const TaskListState.initial());
    when(() => mockSelectionCubit.state)
        .thenReturn(const TaskSelectionState());
    when(() => mockTaskListBloc.add(any())).thenReturn(null);
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

    testWidgets('navigates to task detail via Edit after expand', (tester) async {
      final task = buildTask();
      await tester.pumpWidget(buildWidget(task));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Buy groceries'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Edit'));
      await tester.tap(find.text('Edit'));
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



    testWidgets('shows overdue relative label for overdue pending tasks', (tester) async {
      await tester.pumpWidget(
        buildWidget(
          buildTask(
            isOverdue: true,
            dueDate: now.subtract(const Duration(days: 1)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Yesterday'), findsOneWidget);
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

      await SlidableTestHarness.performEndAction(
        tester,
        descendant: find.text('Buy groceries'),
        icon: Icons.delete_outline,
      );

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

    testWidgets('completing parent with incomplete subtasks shows dialog', (
      tester,
    ) async {
      final task = buildTask().copyWith(
        subtasks: [
          Subtask(
            id: 's1',
            taskId: 'task-1',
            title: 'Step one',
            sortOrder: 0,
            createdAt: now,
          ),
        ],
      );
      await tester.pumpWidget(buildWidget(task));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();

      expect(find.text('Mark all subtasks done too?'), findsOneWidget);
      await tester.tap(find.text('Parent only'));
      await tester.pumpAndSettle();

      verify(
        () => mockTaskListBloc.add(const TaskListEvent.completeTask('task-1')),
      ).called(1);
    });

    testWidgets('complete all subtasks from dialog completes parent', (
      tester,
    ) async {
      final task = buildTask().copyWith(
        subtasks: [
          Subtask(
            id: 's1',
            taskId: 'task-1',
            title: 'Step one',
            sortOrder: 0,
            createdAt: now,
          ),
        ],
      );
      await tester.pumpWidget(buildWidget(task));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Complete all'));
      await tester.pumpAndSettle();

      verify(
        () => mockTaskListBloc.add(
          const TaskListEvent.toggleSubtask(
            taskId: 'task-1',
            subtaskId: 's1',
          ),
        ),
      ).called(1);
      verify(
        () => mockTaskListBloc.add(const TaskListEvent.completeTask('task-1')),
      ).called(1);
    });

    testWidgets('cancel subtask dialog keeps task pending', (tester) async {
      final task = buildTask().copyWith(
        subtasks: [
          Subtask(
            id: 's1',
            taskId: 'task-1',
            title: 'Step one',
            sortOrder: 0,
            createdAt: now,
          ),
        ],
      );
      await tester.pumpWidget(buildWidget(task));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(
        () => mockTaskListBloc.add(const TaskListEvent.completeTask('task-1')),
      );
    });

    testWidgets('parent only option completes task without toggling subtasks', (
      tester,
    ) async {
      final task = buildTask().copyWith(
        subtasks: [
          Subtask(
            id: 's1',
            taskId: 'task-1',
            title: 'Step one',
            sortOrder: 0,
            createdAt: now,
          ),
        ],
      );
      await tester.pumpWidget(buildWidget(task));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Parent only'));
      await tester.pumpAndSettle();

      verify(
        () => mockTaskListBloc.add(const TaskListEvent.completeTask('task-1')),
      ).called(1);
      verifyNever(
        () => mockTaskListBloc.add(
          const TaskListEvent.toggleSubtask(taskId: 'task-1', subtaskId: 's1'),
        ),
      );
    });

    testWidgets('shows tag chips and overflow count', (tester) async {
      final tags = [
        Tag(id: 't1', name: 'Work', colour: '#FF5733', createdAt: now),
        Tag(id: 't2', name: 'Home', colour: '#33FF57', createdAt: now),
        Tag(id: 't3', name: 'Extra', colour: '#AABBCC', createdAt: now),
      ];
      await tester.pumpWidget(buildWidget(buildTask().copyWith(tags: tags)));
      await tester.pumpAndSettle();

      expect(find.text('Work'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('+1'), findsOneWidget);
    });

    testWidgets('renders tag with invalid colour using accent fallback', (
      tester,
    ) async {
      final tags = [
        Tag(id: 't1', name: 'Bad colour', colour: 'not-hex', createdAt: now),
      ];
      await tester.pumpWidget(buildWidget(buildTask().copyWith(tags: tags)));
      await tester.pumpAndSettle();

      expect(find.text('Bad colour'), findsOneWidget);
    });

    testWidgets('expanded subtask checkbox dispatches toggleSubtask', (
      tester,
    ) async {
      final task = buildTask().copyWith(
        subtasks: [
          Subtask(
            id: 's1',
            taskId: 'task-1',
            title: 'Step A',
            sortOrder: 0,
            createdAt: now,
          ),
        ],
      );
      await tester.pumpWidget(buildWidget(task));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Buy groceries'));
      await tester.pumpAndSettle();
      expect(find.text('Step A'), findsOneWidget);

      await tester.tap(find.byType(Checkbox).at(1));
      await tester.pumpAndSettle();

      verify(
        () => mockTaskListBloc.add(
          const TaskListEvent.toggleSubtask(
            taskId: 'task-1',
            subtaskId: 's1',
          ),
        ),
      ).called(1);
    });

    testWidgets('reschedule dispatches event when date confirmed', (
      tester,
    ) async {
      await tester.pumpWidget(buildWidget(buildTask()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Buy groceries'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Reschedule'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pump();

      verify(
        () => mockTaskListBloc.add(
          any(
            that: predicate<TaskListEvent>(
              (event) => event.maybeWhen(
                rescheduleTask: (taskId, newDueDate) => taskId == 'task-1',
                orElse: () => false,
              ),
            ),
          ),
        ),
      ).called(1);
    });

    testWidgets('title tap toggles selection in selection mode', (tester) async {
      when(() => mockSelectionCubit.state).thenReturn(
        const TaskSelectionState(
          isSelectionMode: true,
          selectedTaskIds: {},
        ),
      );
      when(() => mockSelectionCubit.toggleSelection(any())).thenReturn(null);

      await tester.pumpWidget(buildWidget(buildTask()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Buy groceries'));
      await tester.pumpAndSettle();

      verify(() => mockSelectionCubit.toggleSelection('task-1')).called(1);
    });
  });
}
