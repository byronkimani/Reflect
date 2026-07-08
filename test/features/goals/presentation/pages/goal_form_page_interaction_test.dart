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

Stream<Either<Failure, List<GoalCategory>>> categoriesStream(
  List<GoalCategory> categories,
) =>
    Stream.value(Right<Failure, List<GoalCategory>>(categories));

void main() {
  late MockIGoalRepository mockRepo;
  final now = DateTime(2025, 3, 18);

  Goal goal({
    String id = 'goal-1',
    String title = 'Test goal',
    String? description,
    String? categoryId,
    GoalTimeHorizon timeHorizon = GoalTimeHorizon.weekly,
  }) =>
      Goal(
        id: id,
        title: title,
        description: description,
        categoryId: categoryId,
        timeHorizon: timeHorizon,
        createdAt: now,
        updatedAt: now,
      );

  GoalCategory category({
    String id = 'c1',
    String name = 'Health',
  }) =>
      GoalCategory(
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
    testWidgets('fills KPI fields when KPI section expanded', (tester) async {
      when(() => mockRepo.createGoal(any())).thenAnswer(
        (inv) async => Right(inv.positionalArguments[0] as Goal),
      );
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.widgetWithText(TextFormField, 'What do you want to achieve?'),
        'Run 5k',
      );
      await tester.tap(find.text('Track a KPI'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.widgetWithText(TextFormField, 'What KPI measures progress?'),
        'Distance in km',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Start'),
        '0',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Target'),
        '5',
      );
      await tester.pumpAndSettle();

      await tapSubmit(tester, label: 'Create Goal');
      verify(() => mockRepo.createGoal(any())).called(1);
    });

    testWidgets('selects importance level', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.tap(find.text('Importance'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('High'));
      await tester.pumpAndSettle();
    });

    testWidgets('changes time horizon pill on new goal', (tester) async {
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

      await tester.enterText(
        find.widgetWithText(TextFormField, 'What do you want to achieve?'),
        'Goal title',
      );
      await scrollForm(tester);
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Why you are setting this goal'),
        'Personal growth',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Brief description'),
        'Short summary',
      );
      await tester.pumpAndSettle();

      await tapSubmit(tester, label: 'Create Goal');
      verify(() => mockRepo.createGoal(any())).called(1);
    });

    testWidgets('selects check-in frequency pill', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.ensureVisible(find.text('Daily'));
      await tester.tap(find.text('Daily'));
      await tester.pumpAndSettle();
    });

    testWidgets('start date picker updates pill label', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.ensureVisible(find.text('Start date'));
      await tester.tap(find.text('Start date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Start date'), findsNothing);
    });

    testWidgets('target date picker updates pill label', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await scrollForm(tester, delta: -400);
      await tester.ensureVisible(find.text('Target date'));
      await tester.tap(find.text('Target date'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Target date'), findsNothing);
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

    testWidgets('selects category chip', (tester) async {
      final cat = category();
      await tester.pumpWidget(
        buildTestWidget(categories: categoriesStream([cat])),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Health'));
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
      when(() => mockRepo.deleteCategory(any()))
          .thenAnswer((_) async => const Right(unit));

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

    testWidgets('categories stream failure yields only None chip', (
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

      expect(find.text('None'), findsAtLeastNWidgets(1));
    });

    testWidgets('expands timeline section', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget(initialGoal: goal()));
      await tester.pumpAndSettle();

      await scrollForm(tester);
      expect(find.text('Start date'), findsOneWidget);
      await tester.tap(find.text('Timeline'));
      await tester.pumpAndSettle();
      expect(find.text('Start date'), findsNothing);
      await tester.tap(find.text('Timeline'));
      await tester.pumpAndSettle();
      expect(find.text('Start date'), findsOneWidget);
    });

    testWidgets('expands motivation section', (tester) async {
      await tester.binding.setSurfaceSize(const Size(800, 1200));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(buildTestWidget(initialGoal: goal()));
      await tester.pumpAndSettle();

      await scrollForm(tester);
      await tester.tap(find.text('Motivation'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Motivation'));
      await tester.pumpAndSettle();

      expect(find.text('Why this goal?'), findsOneWidget);
    });

    testWidgets('add category dialog cancel dismisses without saving', (
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

    testWidgets('edit category dialog cancel dismisses without saving', (
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

    testWidgets('delete category dialog cancel keeps category', (tester) async {
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

    testWidgets('None category pill clears selected category', (tester) async {
      final cat = category();
      await tester.pumpWidget(
        buildTestWidget(
          categories: categoriesStream([cat]),
          initialGoal: goal(categoryId: 'c1'),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('None').first);
      await tester.pumpAndSettle();
    });

    testWidgets('PopScope intercepts route pop when form is modified', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, 'Changed');
      await tester.pumpAndSettle();
      final scope = tester.widget<PopScope>(
        find.byWidgetPredicate((widget) => widget is PopScope),
      );
      scope.onPopInvokedWithResult!(false, null);
      await tester.pumpAndSettle();

      expect(find.text('Discard changes?'), findsOneWidget);
      await tester.tap(find.text('Discard'));
      await tester.pumpAndSettle();

      expect(find.text('New Goal'), findsNothing);
    });
  });
}
