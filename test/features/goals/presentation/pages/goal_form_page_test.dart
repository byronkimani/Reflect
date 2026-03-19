import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/pages/goal_form_page.dart';

class MockIGoalRepository extends Mock implements IGoalRepository {}

Stream<Either<Failure, List<GoalCategory>>> get emptyCategoriesStream =>
    Stream.value(Right<Failure, List<GoalCategory>>(<GoalCategory>[]));

void main() {
  late MockIGoalRepository mockRepo;
  final now = DateTime(2025, 3, 18);

  Goal goal({
    String id = 'goal-1',
    String title = 'Test goal',
    String? description,
    GoalTimeHorizon timeHorizon = GoalTimeHorizon.weekly,
  }) => Goal(
    id: id,
    title: title,
    description: description,
    timeHorizon: timeHorizon,
    createdAt: now,
    updatedAt: now,
  );

  Widget buildTestWidget({
    Goal? initialGoal,
    GoalTimeHorizon? timeHorizon,
    Stream<Either<Failure, List<GoalCategory>>>? categoriesStream,
  }) {
    final router = GoRouter(
      initialLocation: '/form',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: SizedBox.shrink()),
          routes: [
            GoRoute(
              path: 'form',
              builder: (_, _) => GoalFormPage(
                initialGoal: initialGoal,
                timeHorizon: timeHorizon ?? GoalTimeHorizon.weekly,
                goalRepo: mockRepo,
                categoriesStream: categoriesStream ?? emptyCategoriesStream,
              ),
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }

  setUp(() {
    mockRepo = MockIGoalRepository();
    when(
      () => mockRepo.watchCategories(),
    ).thenAnswer((_) => emptyCategoriesStream);
  });

  setUpAll(() {
    registerFallbackValue(
      Goal(
        id: '',
        title: '',
        timeHorizon: GoalTimeHorizon.weekly,
        createdAt: now,
        updatedAt: now,
      ),
    );
  });

  group('GoalFormPage', () {
    testWidgets('new goal shows title "New Goal" and Save button', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('New Goal'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Title *'), findsOneWidget);
    });

    testWidgets('edit goal shows title "Edit Goal" and prefilled title', (
      tester,
    ) async {
      final g = goal(title: 'My existing goal');
      await tester.pumpWidget(buildTestWidget(initialGoal: g));
      await tester.pumpAndSettle();

      expect(find.text('Edit Goal'), findsOneWidget);
      expect(find.text('My existing goal'), findsOneWidget);
    });

    testWidgets('new goal shows time horizon section', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Time horizon'), findsOneWidget);
    });

    testWidgets('edit goal does not show time horizon section', (tester) async {
      await tester.pumpWidget(buildTestWidget(initialGoal: goal()));
      await tester.pumpAndSettle();

      expect(find.text('Time horizon'), findsNothing);
    });

    testWidgets('tap Save with empty title shows error snackbar', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.text('Title is required'), findsOneWidget);
    });

    testWidgets('enter title and tap Save calls createGoal', (tester) async {
      when(
        () => mockRepo.createGoal(any()),
      ).thenAnswer((_) async => Right(goal(id: 'new-id', title: 'New goal')));
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'My new goal');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      verify(() => mockRepo.createGoal(any())).called(1);
    });

    testWidgets('edit goal and Save calls updateGoal', (tester) async {
      final g = goal(id: 'existing', title: 'Original');
      when(
        () => mockRepo.updateGoal(any()),
      ).thenAnswer((inv) async => Right(inv.positionalArguments[0] as Goal));
      await tester.pumpWidget(buildTestWidget(initialGoal: g));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Updated title');
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      final captured = verify(() => mockRepo.updateGoal(captureAny())).captured;
      expect(captured.length, 1);
      expect((captured[0] as Goal).title, 'Updated title');
      expect((captured[0] as Goal).id, 'existing');
    });

    testWidgets('shows priority and urgency sections', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Priority (optional)'), findsOneWidget);
      expect(find.text('Urgency (optional)'), findsOneWidget);
    });

    testWidgets('shows category selector and Manage categories', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Category (optional)'), findsOneWidget);
      expect(find.text('Manage categories'), findsOneWidget);
    });

    testWidgets('shows check-in frequency chips', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Check-in frequency (optional)'), findsOneWidget);
      expect(find.text('None'), findsAtLeastNWidgets(1));
      expect(find.text('Weekly'), findsAtLeastNWidgets(1));
      expect(find.text('Monthly'), findsAtLeastNWidgets(1));
    });

    testWidgets('shows Start date and Target date pickers', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Start date (optional)'), findsOneWidget);
      expect(find.text('Target date (optional)'), findsOneWidget);
      expect(find.text('Pick start date'), findsOneWidget);
      expect(find.text('Pick target date'), findsOneWidget);
    });

    testWidgets('successful save calls createGoal and does not show error', (
      tester,
    ) async {
      when(
        () => mockRepo.createGoal(any()),
      ).thenAnswer((_) async => Right(goal(id: 'new-id', title: 'Goal title')));
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Goal title');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));

      verify(() => mockRepo.createGoal(any())).called(1);
      expect(find.text('Title is required'), findsNothing);
    });

    testWidgets('no horizontal overflow at narrow width', (tester) async {
      await tester.binding.setSurfaceSize(const Size(320, 800));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('categories stream emits list and dropdown shows categories', (
      tester,
    ) async {
      final categories = [
        GoalCategory(
          id: 'c1',
          name: 'Category One',
          sortOrder: 0,
          createdAt: now,
          updatedAt: now,
        ),
      ];
      final stream = Stream<Either<Failure, List<GoalCategory>>>.value(
        Right<Failure, List<GoalCategory>>(categories),
      );
      when(() => mockRepo.watchCategories()).thenAnswer((_) => stream);

      await tester.pumpWidget(buildTestWidget(categoriesStream: stream));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String?>));
      await tester.pumpAndSettle();

      expect(find.text('Category One'), findsOneWidget);
    });
  });
}
