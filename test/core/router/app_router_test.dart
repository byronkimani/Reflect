import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/analytics/domain/entities/analytics_models.dart';
import 'package:reflect/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import '../../helpers/router_test_helpers.dart';

void main() {
  late RouterTestHarness harness;

  setUpAll(() {
    registerFallbackValue(const TaskListEvent.loadBacklog());
    registerFallbackValue(GoalTimeHorizon.weekly);
    registerFallbackValue(const AnalyticsEvent.load(DateRange.last7Days));
    registerFallbackValue(
      Task(id: '', title: '', createdAt: DateTime(2025), updatedAt: DateTime(2025)),
    );
  });

  setUp(() async {
    harness = await RouterTestHarness.create();
  });

  tearDown(() async {
    await harness.dispose();
  });

  group('createAppRouter', () {
    testWidgets('starts on today route with tasks section', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      expect(find.text('TASKS'), findsOneWidget);
    });

    testWidgets('navigates to backlog branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.go('/backlog');
      await tester.pumpAndSettle();

      expect(find.text('Backlog'), findsAtLeastNWidgets(1));
    });

    testWidgets('navigates to goals branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.go('/goals');
      await tester.pumpAndSettle();

      expect(find.text('Weekly'), findsOneWidget);
    });

    testWidgets('navigates to reflect branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.go('/reflect');
      await tester.pumpAndSettle();

      expect(find.text('Daily Review'), findsOneWidget);
    });

    testWidgets('navigates to more options branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.go('/more');
      await tester.pumpAndSettle();

      expect(find.text('More options'), findsOneWidget);
    });

    testWidgets('opens new task form from today branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/today/task/new');
      await tester.pumpAndSettle();

      expect(find.text('New Task'), findsOneWidget);
    });

    testWidgets('opens edit task form with extra task from today branch', (
      tester,
    ) async {
      final now = DateTime(2025, 6, 30);
      final task = Task(
        id: 'task-1',
        title: 'Ship release',
        createdAt: now,
        updatedAt: now,
      );

      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/today/task/task-1', extra: task);
      await tester.pumpAndSettle();

      expect(find.text('Edit Task'), findsOneWidget);
      expect(find.text('Ship release'), findsOneWidget);
    });

    testWidgets('opens planning page from today branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/today/planning');
      await tester.pumpAndSettle();

      expect(find.text('Morning Planning Page'), findsOneWidget);
    });

    testWidgets('opens daily review from today branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/today/review');
      await tester.pumpAndSettle();

      expect(find.text('Daily Review'), findsOneWidget);
    });

    testWidgets('opens backlog task form with backlog context', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/backlog/task/new');
      await tester.pumpAndSettle();

      expect(find.text('New Task'), findsOneWidget);
    });

    testWidgets('opens new goal form with time horizon extra', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/goals/new', extra: GoalTimeHorizon.yearly);
      await tester.pumpAndSettle();

      expect(find.text('New Goal'), findsOneWidget);
    });

    testWidgets('opens edit goal form when extra is a Goal', (tester) async {
      final now = DateTime(2025, 6, 30);
      final goal = Goal(
        id: 'goal-1',
        title: 'Run marathon',
        timeHorizon: GoalTimeHorizon.yearly,
        createdAt: now,
        updatedAt: now,
      );

      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/goals/goal-1', extra: goal);
      await tester.pumpAndSettle();

      expect(find.text('Edit Goal'), findsOneWidget);
      expect(find.text('Run marathon'), findsOneWidget);
    });

    testWidgets('opens goal form without goal when extra is invalid', (
      tester,
    ) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/goals/goal-1', extra: 'not-a-goal');
      await tester.pumpAndSettle();

      expect(find.text('New Goal'), findsOneWidget);
    });

    testWidgets('opens settings from more branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/more/settings');
      await tester.pumpAndSettle();

      expect(find.text('Settings'), findsOneWidget);
    });

    testWidgets('opens analytics from more branch', (tester) async {
      await tester.pumpWidget(harness.buildApp());
      await tester.pumpAndSettle();

      harness.router.push('/more/analytics');
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
