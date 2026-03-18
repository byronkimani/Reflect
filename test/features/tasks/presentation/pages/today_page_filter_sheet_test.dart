import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/pages/today_page.dart';

class MockITaskRepository extends Mock implements ITaskRepository {}

void main() {
  late TaskListBloc taskListBloc;
  late MockITaskRepository mockRepo;

  setUp(() {
    mockRepo = MockITaskRepository();
    taskListBloc = TaskListBloc(mockRepo);
  });

  tearDown(() {
    taskListBloc.close();
  });

  Widget buildTestWidget() {
    return MaterialApp(
      home: BlocProvider<TaskListBloc>.value(
        value: taskListBloc,
        child: const TodayPage(),
      ),
    );
  }

  Future<void> pumpWithLoadedState(
    WidgetTester tester, {
    TaskListFilter filter = const TaskListFilter(),
  }) async {
    taskListBloc.emit(
      TaskListState.loaded(
        pending: [],
        completed: [],
        overdue: [],
        sortMode: SortMode.statusPendingFirst,
        filter: filter,
      ),
    );
    await tester.pumpWidget(buildTestWidget());
  }

  /// Scroll the filter sheet down so content like Apply button is visible.
  Future<void> scrollSheetTo(WidgetTester tester) async {
    final listView = find.ancestor(
      of: find.text('Filter'),
      matching: find.byType(ListView),
    );
    await tester.drag(listView, const Offset(0, -400));
    await tester.pumpAndSettle();
  }

  group('TodayPage filter sheet', () {
    testWidgets('filter icon is present when state is loaded', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.tune), findsOneWidget);
    });

    testWidgets('tapping filter icon opens bottom sheet with title Filter', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      expect(find.text('Filter'), findsOneWidget);
    });

    testWidgets('filter sheet shows Clear all button', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      expect(find.text('Clear all'), findsOneWidget);
    });

    testWidgets('filter sheet shows Apply button', (WidgetTester tester) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      await scrollSheetTo(tester);
      expect(find.text('Apply'), findsOneWidget);
    });

    testWidgets(
      'filter sheet shows section labels: Priority, Due time, Repeats, Status',
      (WidgetTester tester) async {
        await pumpWithLoadedState(tester);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        expect(find.text('Priority'), findsOneWidget);
        expect(find.text('Due time'), findsOneWidget);
        expect(find.text('Repeats'), findsOneWidget);
        expect(find.text('Status'), findsOneWidget);
      },
    );

    testWidgets('filter sheet shows priority chips All and P1-P4', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      expect(find.text('All'), findsWidgets);
      expect(find.text('P1'), findsOneWidget);
      expect(find.text('P2'), findsOneWidget);
      expect(find.text('P3'), findsOneWidget);
      expect(find.text('P4'), findsOneWidget);
    });

    testWidgets(
      'filter sheet shows Due time options: Any, With time, No time',
      (WidgetTester tester) async {
        await pumpWithLoadedState(tester);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        expect(find.text('Any'), findsWidgets);
        expect(find.text('With time'), findsOneWidget);
        expect(find.text('No time'), findsOneWidget);
      },
    );

    testWidgets('filter sheet shows Repeats options: Repeating, One-time', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      expect(find.text('Repeating'), findsOneWidget);
      expect(find.text('One-time'), findsOneWidget);
    });

    testWidgets(
      'filter sheet shows Status options: All, Pending only, Completed only',
      (WidgetTester tester) async {
        await pumpWithLoadedState(tester);
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        await scrollSheetTo(tester);
        expect(find.text('Pending only'), findsOneWidget);
        expect(find.text('Completed only'), findsOneWidget);
      },
    );

    testWidgets(
      'tapping Clear all applies default filter and sheet stays open with defaults',
      (WidgetTester tester) async {
        await pumpWithLoadedState(
          tester,
          filter: TaskListFilter(priorities: {TaskPriority.p1}),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        expect(find.text('Clear all'), findsOneWidget);
        await tester.tap(find.text('Clear all'));
        await tester.pumpAndSettle();

        final state = taskListBloc.state;
        state.maybeWhen(
          loaded: (_, _, _, _, filter) {
            expect(filter.priorities, isNull);
            expect(filter.hasDueTimeOnly, isNull);
            expect(filter.repeatingOnly, isNull);
            expect(filter.statusFilter, TaskStatusFilter.all);
          },
          orElse: () => fail('Expected loaded state after Clear all'),
        );
      },
    );

    testWidgets('tapping Apply with filter dispatches FilterChanged', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      await tester.tap(find.text('P1'));
      await tester.pumpAndSettle();

      await scrollSheetTo(tester);
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final state = taskListBloc.state;
      state.maybeWhen(
        loaded: (_, _, _, _, filter) {
          expect(filter.priorities, {TaskPriority.p1});
        },
        orElse: () => fail('Expected loaded state'),
      );
    });

    testWidgets('tapping With time then Apply updates filter', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      await tester.tap(find.text('With time'));
      await tester.pumpAndSettle();

      await scrollSheetTo(tester);
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final state = taskListBloc.state;
      state.maybeWhen(
        loaded: (_, _, _, _, filter) {
          expect(filter.hasDueTimeOnly, true);
        },
        orElse: () => fail('Expected loaded state'),
      );
    });

    testWidgets('tapping Repeating then Apply updates filter', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Repeating'));
      await tester.pumpAndSettle();

      await scrollSheetTo(tester);
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final state = taskListBloc.state;
      state.maybeWhen(
        loaded: (_, _, _, _, filter) {
          expect(filter.repeatingOnly, true);
        },
        orElse: () => fail('Expected loaded state'),
      );
    });

    testWidgets('tapping Pending only then Apply updates status filter', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      await scrollSheetTo(tester);
      await tester.tap(find.text('Pending only'));
      await tester.pumpAndSettle();

      await scrollSheetTo(tester);
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final state = taskListBloc.state;
      state.maybeWhen(
        loaded: (_, _, _, _, filter) {
          expect(filter.statusFilter, TaskStatusFilter.pendingOnly);
        },
        orElse: () => fail('Expected loaded state'),
      );
    });

    testWidgets(
      'tapping Priority All after selecting P1 resets priority to All',
      (WidgetTester tester) async {
        await pumpWithLoadedState(
          tester,
          filter: TaskListFilter(priorities: {TaskPriority.p1}),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        await tester.tap(find.text('All'));
        await tester.pumpAndSettle();

        await scrollSheetTo(tester);
        await tester.tap(find.text('Apply'));
        await tester.pumpAndSettle();

        final state = taskListBloc.state;
        state.maybeWhen(
          loaded: (_, _, _, _, filter) {
            expect(filter.priorities, isNull);
          },
          orElse: () => fail('Expected loaded state'),
        );
      },
    );

    testWidgets(
      'tapping Due time Any after selecting With time resets to Any',
      (WidgetTester tester) async {
        await pumpWithLoadedState(
          tester,
          filter: const TaskListFilter(hasDueTimeOnly: true),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Any').first);
        await tester.pumpAndSettle();

        await scrollSheetTo(tester);
        await tester.tap(find.text('Apply'));
        await tester.pumpAndSettle();

        final state = taskListBloc.state;
        state.maybeWhen(
          loaded: (_, _, _, _, filter) {
            expect(filter.hasDueTimeOnly, isNull);
          },
          orElse: () => fail('Expected loaded state'),
        );
      },
    );

    testWidgets('tapping Repeats Any after selecting Repeating resets to Any', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(
        tester,
        filter: const TaskListFilter(repeatingOnly: true),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      final anyChips = find.text('Any');
      await tester.tap(anyChips.at(1));
      await tester.pumpAndSettle();

      await scrollSheetTo(tester);
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final state = taskListBloc.state;
      state.maybeWhen(
        loaded: (_, _, _, _, filter) {
          expect(filter.repeatingOnly, isNull);
        },
        orElse: () => fail('Expected loaded state'),
      );
    });

    testWidgets(
      'tapping Status All after selecting Pending only resets to All',
      (WidgetTester tester) async {
        await pumpWithLoadedState(
          tester,
          filter: const TaskListFilter(
            statusFilter: TaskStatusFilter.pendingOnly,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.tune));
        await tester.pumpAndSettle();

        await scrollSheetTo(tester);
        await tester.tap(find.text('All').last);
        await tester.pumpAndSettle();

        await tester.tap(find.text('Apply'));
        await tester.pumpAndSettle();

        final state = taskListBloc.state;
        state.maybeWhen(
          loaded: (_, _, _, _, filter) {
            expect(filter.statusFilter, TaskStatusFilter.all);
          },
          orElse: () => fail('Expected loaded state'),
        );
      },
    );

    testWidgets('tapping one default chip leaves other categories unchanged', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(
        tester,
        filter: TaskListFilter(
          priorities: {TaskPriority.p2},
          hasDueTimeOnly: true,
          repeatingOnly: false,
          statusFilter: TaskStatusFilter.completedOnly,
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      await tester.tap(find.text('All'));
      await tester.pumpAndSettle();

      await scrollSheetTo(tester);
      await tester.tap(find.text('Apply'));
      await tester.pumpAndSettle();

      final state = taskListBloc.state;
      state.maybeWhen(
        loaded: (_, _, _, _, filter) {
          expect(filter.priorities, isNull);
          expect(filter.hasDueTimeOnly, true);
          expect(filter.repeatingOnly, false);
          expect(filter.statusFilter, TaskStatusFilter.completedOnly);
        },
        orElse: () => fail('Expected loaded state'),
      );
    });

    testWidgets('sheet can be dismissed by tapping outside or back', (
      WidgetTester tester,
    ) async {
      await pumpWithLoadedState(tester);
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.tune));
      await tester.pumpAndSettle();

      expect(find.text('Filter'), findsOneWidget);

      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(find.text('Filter'), findsNothing);
    });
  });
}
