import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/widgets/task_list_filter_sheet.dart';

class MockTaskListBloc extends MockBloc<TaskListEvent, TaskListState>
    implements TaskListBloc {}

void main() {
  setUpAll(() {
    registerFallbackValue(const TaskListEvent.sortChanged(SortMode.priority));
    registerFallbackValue(const TaskListEvent.filterChanged(TaskListFilter()));
  });

  group('sortModeLabel', () {
    test('returns human-readable labels', () {
      expect(sortModeLabel(SortMode.priority), 'Priority (high first)');
      expect(sortModeLabel(SortMode.dueDateTime), 'Due date & time');
    });
  });

  group('showTaskListSortMenu', () {
    late MockTaskListBloc mockBloc;

    setUp(() {
      mockBloc = MockTaskListBloc();
      when(() => mockBloc.state).thenReturn(const TaskListState.initial());
      when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('selecting sort mode dispatches SortChanged', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => showTaskListSortMenu(
                  context,
                  mockBloc,
                  SortMode.statusPendingFirst,
                ),
                child: const Text('Sort'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Sort'));
      await tester.pumpAndSettle();

      expect(find.text('Sort by'), findsOneWidget);
      await tester.tap(find.text('Priority (high first)'));
      await tester.pumpAndSettle();

      verify(
        () => mockBloc.add(const TaskListEvent.sortChanged(SortMode.priority)),
      ).called(1);
    });
  });

  group('priorityLabel', () {
    test('returns P1–P4 labels', () {
      expect(priorityLabel(TaskPriority.p1), 'P1');
      expect(statusFilterLabel(TaskStatusFilter.pendingOnly), 'Pending only');
    });
  });

  group('showTaskListFilterSheet', () {
    late MockTaskListBloc mockBloc;

    setUp(() {
      mockBloc = MockTaskListBloc();
      when(() => mockBloc.state).thenReturn(const TaskListState.initial());
      when(() => mockBloc.stream).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('apply dispatches FilterChanged with priority', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => showTaskListFilterSheet(
                  context,
                  mockBloc,
                  const TaskListFilter(),
                ),
                child: const Text('Filter'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Filter'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('P1'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Apply'),
        80,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final captured = verify(() => mockBloc.add(captureAny())).captured;
      expect(captured.length, 1);
      final event = captured.single as TaskListEvent;
      event.when(
        loadTasksForDate: (_) => fail('expected filterChanged'),
        loadBacklog: () => fail('expected filterChanged'),
        completeTask: (_) => fail('expected filterChanged'),
        reopenTask: (_) => fail('expected filterChanged'),
        pushToTomorrow: (_) => fail('expected filterChanged'),
        deleteTask: (_) => fail('expected filterChanged'),
        bulkCompleteTasks: (_) => fail('expected filterChanged'),
        bulkReopenTasks: (_) => fail('expected filterChanged'),
        bulkMoveToBacklog: (_) => fail('expected filterChanged'),
        bulkDeleteTasks: (_) => fail('expected filterChanged'),
        sortChanged: (_) => fail('expected filterChanged'),
        filterChanged: (f) =>
            expect(f.priorities, contains(TaskPriority.p1)),
        toggleSubtask: (_, _) => fail('expected filterChanged'),
        rescheduleTask: (_, _) => fail('expected filterChanged'),
      );
    });

    testWidgets('apply dispatches due-time and repeating filters', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => showTaskListFilterSheet(
                  context,
                  mockBloc,
                  const TaskListFilter(),
                ),
                child: const Text('Filter'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Filter'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('No time'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('One-time'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Apply'),
        80,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final captured = verify(() => mockBloc.add(captureAny())).captured;
      final event = captured.single as TaskListEvent;
      event.when(
        loadTasksForDate: (_) => fail('expected filterChanged'),
        loadBacklog: () => fail('expected filterChanged'),
        completeTask: (_) => fail('expected filterChanged'),
        reopenTask: (_) => fail('expected filterChanged'),
        pushToTomorrow: (_) => fail('expected filterChanged'),
        deleteTask: (_) => fail('expected filterChanged'),
        bulkCompleteTasks: (_) => fail('expected filterChanged'),
        bulkReopenTasks: (_) => fail('expected filterChanged'),
        bulkMoveToBacklog: (_) => fail('expected filterChanged'),
        bulkDeleteTasks: (_) => fail('expected filterChanged'),
        sortChanged: (_) => fail('expected filterChanged'),
        filterChanged: (f) {
          expect(f.hasDueTimeOnly, isFalse);
          expect(f.repeatingOnly, isFalse);
        },
        toggleSubtask: (_, _) => fail('expected filterChanged'),
        rescheduleTask: (_, _) => fail('expected filterChanged'),
      );
    });

    testWidgets('removing one priority keeps remaining priorities', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: ElevatedButton(
                onPressed: () => showTaskListFilterSheet(
                  context,
                  mockBloc,
                  const TaskListFilter(
                    priorities: {TaskPriority.p1, TaskPriority.p2},
                  ),
                ),
                child: const Text('Filter'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Filter'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('P1'));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Apply'),
        80,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final captured = verify(() => mockBloc.add(captureAny())).captured;
      final event = captured.single as TaskListEvent;
      event.when(
        loadTasksForDate: (_) => fail('expected filterChanged'),
        loadBacklog: () => fail('expected filterChanged'),
        completeTask: (_) => fail('expected filterChanged'),
        reopenTask: (_) => fail('expected filterChanged'),
        pushToTomorrow: (_) => fail('expected filterChanged'),
        deleteTask: (_) => fail('expected filterChanged'),
        bulkCompleteTasks: (_) => fail('expected filterChanged'),
        bulkReopenTasks: (_) => fail('expected filterChanged'),
        bulkMoveToBacklog: (_) => fail('expected filterChanged'),
        bulkDeleteTasks: (_) => fail('expected filterChanged'),
        sortChanged: (_) => fail('expected filterChanged'),
        filterChanged: (f) =>
            expect(f.priorities, equals({TaskPriority.p2})),
        toggleSubtask: (_, _) => fail('expected filterChanged'),
        rescheduleTask: (_, _) => fail('expected filterChanged'),
      );
    });
  });
}
