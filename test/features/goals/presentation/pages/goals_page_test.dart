import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_state.dart';
import 'package:reflect/features/goals/presentation/pages/goals_page.dart';
import 'package:reflect/core/presentation/widgets/reflect_fab.dart';

class MockGoalsCubit extends Mock implements GoalsCubit {}

void main() {
  late MockGoalsCubit mockGoalsCubit;

  setUpAll(() {
    registerFallbackValue(GoalTimeHorizon.weekly);
    registerFallbackValue('');
  });

  setUp(() {
    mockGoalsCubit = MockGoalsCubit();
  });

  Widget buildPage() {
    return MaterialApp.router(
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => BlocProvider<GoalsCubit>.value(
              value: mockGoalsCubit,
              child: const GoalsPage(),
            ),
          ),
          GoRoute(
            path: '/goals/new',
            builder: (_, state) => Scaffold(
              body: Text('New goal ${state.extra}'),
            ),
          ),
          GoRoute(
            path: '/goals/:id',
            builder: (_, state) => Scaffold(
              body: Text('Edit goal ${state.pathParameters['id']}'),
            ),
          ),
        ],
      ),
    );
  }

  testWidgets('GoalsPage displays error when state has error', (tester) async {
    when(() => mockGoalsCubit.state).thenReturn(const GoalsState(error: 'Load Failed'));
    when(() => mockGoalsCubit.stream).thenAnswer((_) => Stream.value(const GoalsState(error: 'Load Failed')));
    
    await tester.pumpWidget(buildPage());
    
    expect(find.text('Load Failed'), findsOneWidget);
  });

  testWidgets('GoalsPage shows tabs and initial list of goals', (tester) async {
    final goal = Goal(
      id: 'g1',
      title: 'First Goal',
      description: 'Desc',
      timeHorizon: GoalTimeHorizon.weekly,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    when(() => mockGoalsCubit.state).thenReturn(GoalsState(
      goalsByHorizon: {GoalTimeHorizon.weekly: [goal]},
      selectedHorizon: GoalTimeHorizon.weekly,
    ));
    when(() => mockGoalsCubit.stream).thenAnswer((_) => const Stream.empty());
    
    await tester.pumpWidget(buildPage());
    
    expect(find.text('Weekly'), findsOneWidget);
    expect(find.text('Monthly'), findsOneWidget);
    
    expect(find.text('First Goal'), findsOneWidget);
    expect(find.text('Desc'), findsOneWidget);
  });

  testWidgets('GoalsPage shows empty message when no goals', (tester) async {
    when(() => mockGoalsCubit.state).thenReturn(const GoalsState(
      goalsByHorizon: {},
      selectedHorizon: GoalTimeHorizon.monthly,
    ));
    when(() => mockGoalsCubit.stream).thenAnswer((_) => const Stream.empty());
    
    await tester.pumpWidget(buildPage());
    
    expect(find.text('No monthly goals yet.'), findsOneWidget);
  });

  testWidgets('GoalsPage tapping tab calls setHorizon', (tester) async {
    when(() => mockGoalsCubit.state).thenReturn(const GoalsState());
    when(() => mockGoalsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockGoalsCubit.setHorizon(any())).thenReturn(null);
    
    await tester.pumpWidget(buildPage());
    
    await tester.tap(find.text('Monthly'));
    await tester.pumpAndSettle();
    
    verify(() => mockGoalsCubit.setHorizon(GoalTimeHorizon.monthly)).called(1);
  });

  testWidgets('GoalsPage long press on goal shows delete dialog and deletes', (tester) async {
    final goal = Goal(
      id: 'g1',
      title: 'Delete Me',
      timeHorizon: GoalTimeHorizon.weekly,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    when(() => mockGoalsCubit.state).thenReturn(GoalsState(
      goalsByHorizon: {GoalTimeHorizon.weekly: [goal]},
      selectedHorizon: GoalTimeHorizon.weekly,
    ));
    when(() => mockGoalsCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockGoalsCubit.deleteGoal(any())).thenAnswer((_) async {});
    
    await tester.pumpWidget(buildPage());
    
    await tester.longPress(find.text('Delete Me'));
    await tester.pumpAndSettle();
    
    expect(find.text('Delete goal?'), findsOneWidget);
    
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    
    verify(() => mockGoalsCubit.deleteGoal('g1')).called(1);
  });

  testWidgets('GoalsPage delete dialog cancel does not delete goal', (tester) async {
    final goal = Goal(
      id: 'g1',
      title: 'Keep Me',
      timeHorizon: GoalTimeHorizon.weekly,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(() => mockGoalsCubit.state).thenReturn(GoalsState(
      goalsByHorizon: {GoalTimeHorizon.weekly: [goal]},
      selectedHorizon: GoalTimeHorizon.weekly,
    ));
    when(() => mockGoalsCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    await tester.longPress(find.text('Keep Me'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    verifyNever(() => mockGoalsCubit.deleteGoal(any()));
  });

  testWidgets('GoalsPage FAB navigates to new goal with selected horizon', (
    tester,
  ) async {
    when(() => mockGoalsCubit.state).thenReturn(
      const GoalsState(selectedHorizon: GoalTimeHorizon.quarterly),
    );
    when(() => mockGoalsCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    await tester.tap(find.byType(ReflectFab));
    await tester.pumpAndSettle();

    expect(find.text('New goal GoalTimeHorizon.quarterly'), findsOneWidget);
  });

  testWidgets('GoalsPage tapping goal card navigates to goal form', (tester) async {
    final goal = Goal(
      id: 'g-edit',
      title: 'Editable Goal',
      timeHorizon: GoalTimeHorizon.weekly,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(() => mockGoalsCubit.state).thenReturn(GoalsState(
      goalsByHorizon: {GoalTimeHorizon.weekly: [goal]},
      selectedHorizon: GoalTimeHorizon.weekly,
    ));
    when(() => mockGoalsCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Editable Goal'));
    await tester.pumpAndSettle();

    expect(find.text('Edit goal g-edit'), findsOneWidget);
  });

  testWidgets('GoalsPage goal card shows priority and target date', (
    tester,
  ) async {
    final goal = Goal(
      id: 'g1',
      title: 'Run 5K',
      description: 'Training plan',
      priority: TaskPriority.p2,
      targetDate: DateTime(2026, 12, 31),
      timeHorizon: GoalTimeHorizon.yearly,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    when(() => mockGoalsCubit.state).thenReturn(GoalsState(
      goalsByHorizon: {GoalTimeHorizon.yearly: [goal]},
      selectedHorizon: GoalTimeHorizon.yearly,
    ));
    when(() => mockGoalsCubit.stream).thenAnswer((_) => const Stream.empty());

    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    expect(find.text('Run 5K'), findsOneWidget);
    expect(find.text('Training plan'), findsOneWidget);
    expect(find.textContaining('Target'), findsOneWidget);
    expect(find.text('P2'), findsOneWidget);
  });
}
