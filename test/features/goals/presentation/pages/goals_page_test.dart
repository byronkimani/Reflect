import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_state.dart';
import 'package:reflect/features/goals/presentation/pages/goals_page.dart';

class MockGoalsCubit extends Mock implements GoalsCubit {}

void main() {
  late MockGoalsCubit mockGoalsCubit;

  setUpAll(() {
    registerFallbackValue(GoalTimeHorizon.weekly);
  });

  setUp(() {
    mockGoalsCubit = MockGoalsCubit();
  });

  Widget buildPage() {
    return MaterialApp(
      home: BlocProvider<GoalsCubit>.value(
        value: mockGoalsCubit,
        child: const GoalsPage(),
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
}
