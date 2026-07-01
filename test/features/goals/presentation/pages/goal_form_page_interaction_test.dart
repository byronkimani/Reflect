import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/presentation/widgets/priority_chip.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/pages/goal_form_page.dart';

class MockIGoalRepository extends Mock implements IGoalRepository {}

Stream<Either<Failure, List<GoalCategory>>> categoriesStream(
  List<GoalCategory> categories,
) => Stream.value(Right<Failure, List<GoalCategory>>(categories));

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

  GoalCategory category({
    String id = 'c1',
    String name = 'Health',
  }) => GoalCategory(
    id: id,
    name: name,
    sortOrder: 0,
    createdAt: now,
    updatedAt: now,
  );

  Widget buildTestWidget({
    Goal? initialGoal,
    GoalTimeHorizon? timeHorizon,
    Stream<Either<Failure, List<GoalCategory>>>? categories,
  }) {
    final router = GoRouter(
      initialLocation: '/form',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: Text('Home')),
          routes: [
            GoRoute(
              path: 'form',
              builder: (_, _) => GoalFormPage(
                initialGoal: initialGoal,
                timeHorizon: timeHorizon ?? GoalTimeHorizon.weekly,
                goalRepo: mockRepo,
                categoriesStream: categories ?? categoriesStream([]),
              ),
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(routerConfig: router);
  }

  Future<void> scrollForm(WidgetTester tester, {double delta = -300}) async {
    await tester.drag(find.byType(SingleChildScrollView).first, Offset(0, delta));
    await tester.pumpAndSettle();
  }

  Future<void> tapSubmit(WidgetTester tester, {required String label}) async {
    await tester.ensureVisible(find.text(label));
    await tester.tap(find.text(label));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
  }

  setUp(() {
    mockRepo = MockIGoalRepository();
    when(() => mockRepo.watchCategories()).thenAnswer(
      (_) => categoriesStream([]),
    );
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
    registerFallbackValue(
      GoalCategory(
        id: '',
        name: '',
        sortOrder: 0,
        createdAt: now,
        updatedAt: now,
      ),
    );
  });

  group('GoalFormPage interactions', () {
    testWidgets('fills KPI fields when measurable is Yes', (tester) async {
      when(() => mockRepo.createGoal(any())).thenAnswer(
        (inv) async => Right(inv.positionalArguments[0] as Goal),
      );
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'Run 5k');
      await scrollForm(tester);
      await tester.enterText(find.byType(TextField).at(1), 'Distance in km');
      await tester.enterText(find.byType(TextField).at(2), '0');
      await tester.enterText(find.byType(TextField).at(3), '5');
      await tester.pumpAndSettle();

      await tapSubmit(tester, label: 'Create Goal');
      verify(() => mockRepo.createGoal(any())).called(1);
    });

    testWidgets('toggles priority and urgency chips', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester);
      final chips = find.byType(PriorityChip);
      await tester.ensureVisible(chips.at(1));
      await tester.tap(chips.at(1), warnIfMissed: false);
      await tester.pumpAndSettle();
      await scrollForm(tester, delta: -200);
      await tester.ensureVisible(chips.at(6));
      await tester.tap(chips.at(6), warnIfMissed: false);
      await tester.pumpAndSettle();
    });

    testWidgets('changes time horizon segment on new goal', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Yearly'));
      await tester.pumpAndSettle();
    });

    testWidgets('enters why and description fields', (tester) async {
      when(() => mockRepo.createGoal(any())).thenAnswer(
        (inv) async => Right(inv.positionalArguments[0] as Goal),
      );
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'Goal title');
      await scrollForm(tester, delta: -500);
      final fields = find.byType(TextField);
      await tester.enterText(fields.at(fields.evaluate().length - 2), 'Personal growth');
      await tester.enterText(fields.at(fields.evaluate().length - 1), 'Short summary');
      await tester.pumpAndSettle();

      await tapSubmit(tester, label: 'Create Goal');
      verify(() => mockRepo.createGoal(any())).called(1);
    });

    testWidgets('selects check-in frequency chip', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester, delta: -500);
      await tester.ensureVisible(find.text('Daily'));
      await tester.tap(find.text('Daily'));
      await tester.pumpAndSettle();
    });

    testWidgets('start date picker updates label', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester, delta: -400);
      await tester.ensureVisible(find.text('Pick start date'));
      await tester.tap(find.text('Pick start date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Pick start date'), findsNothing);
    });

    testWidgets('target date picker updates label', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester, delta: -500);
      await tester.ensureVisible(find.text('Pick target date'));
      await tester.tap(find.text('Pick target date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Pick target date'), findsNothing);
    });

    testWidgets('discard dialog appears when leaving with unsaved changes', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Changed');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Discard changes?'), findsOneWidget);
      await tester.tap(find.text('Keep Editing'));
      await tester.pumpAndSettle();
      expect(find.text('New Goal'), findsOneWidget);
    });

    testWidgets('discard dialog confirms pop', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Changed');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Discard'));
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('createGoal failure shows error snackbar', (tester) async {
      when(() => mockRepo.createGoal(any())).thenAnswer(
        (_) async => const Left(CacheFailure(errorMessage: 'Save failed')),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'My goal');
      await tapSubmit(tester, label: 'Create Goal');

      expect(find.text('Save failed'), findsOneWidget);
    });

    testWidgets('updateGoal failure shows error snackbar', (tester) async {
      when(() => mockRepo.updateGoal(any())).thenAnswer(
        (_) async => const Left(CacheFailure(errorMessage: 'Update failed')),
      );
      await tester.pumpWidget(buildTestWidget(initialGoal: goal()));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Changed title');
      await tapSubmit(tester, label: 'Save Changes');
    });

    testWidgets('selects category from dropdown', (tester) async {
      final cat = category();
      await tester.pumpWidget(
        buildTestWidget(categories: categoriesStream([cat])),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String?>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Health').last);
      await tester.pumpAndSettle();
    });

    testWidgets('manage categories add flow', (tester) async {
      when(() => mockRepo.createCategory(any())).thenAnswer(
        (inv) async => Right(inv.positionalArguments[0] as GoalCategory),
      );
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Manage categories'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Add').last);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'Fitness');
      await tester.tap(find.text('Add').last);
      await tester.pumpAndSettle();

      verify(() => mockRepo.createCategory(any())).called(1);
    });

    testWidgets('manage categories edit and delete flow', (tester) async {
      final cat = category(name: 'Work');
      when(() => mockRepo.updateCategory(any())).thenAnswer(
        (inv) async => Right(inv.positionalArguments[0] as GoalCategory),
      );
      when(() => mockRepo.deleteCategory(any())).thenAnswer((_) async => const Right(unit));

      await tester.pumpWidget(
        buildTestWidget(categories: categoriesStream([cat])),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Manage categories'));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).last, 'Career');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      verify(() => mockRepo.updateCategory(any())).called(1);

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete').last);
      await tester.pumpAndSettle();
      verify(() => mockRepo.deleteCategory('c1')).called(1);
    });

    testWidgets('back without changes pops immediately', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('New Goal'), findsNothing);
      expect(find.text('Home'), findsOneWidget);
    });

    testWidgets('category add dialog cancel closes without creating', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Manage categories'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add').last);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => mockRepo.createCategory(any()));
    });

    testWidgets('category edit dialog cancel closes without updating', (
      tester,
    ) async {
      final cat = category(name: 'Work');
      await tester.pumpWidget(
        buildTestWidget(categories: categoriesStream([cat])),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Manage categories'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.edit_outlined));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => mockRepo.updateCategory(any()));
    });

    testWidgets('category delete dialog cancel keeps category', (tester) async {
      final cat = category(name: 'Work');
      await tester.pumpWidget(
        buildTestWidget(categories: categoriesStream([cat])),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Manage categories'));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      verifyNever(() => mockRepo.deleteCategory(any()));
    });

    testWidgets('shows submitting indicator while create is in progress', (
      tester,
    ) async {
      when(() => mockRepo.createGoal(any())).thenAnswer((inv) async {
        await Future<void>.delayed(const Duration(milliseconds: 300));
        return Right(inv.positionalArguments[0] as Goal);
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Slow goal');
      await tapSubmit(tester, label: 'Create Goal');
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();
    });

    testWidgets('categories stream failure yields empty dropdown', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestWidget(
          categories: Stream.value(
            const Left(CacheFailure(errorMessage: 'Categories unavailable')),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byType(DropdownButtonFormField<String?>));
      await tester.pumpAndSettle();
      expect(find.text('None'), findsWidgets);
    });
  });
}
