import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/goals/data/repositories/goal_repository_impl.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';

class MockIGoalRepository extends Mock implements IGoalRepository {}

class FakeGoal extends Fake implements Goal {}

class FakeGoalCategory extends Fake implements GoalCategory {}

void main() {
  final now = DateTime(2026, 6, 30, 12);

  Goal sampleGoal() => Goal(
        id: 'goal-1',
        title: 'Sample goal',
        timeHorizon: GoalTimeHorizon.weekly,
        createdAt: now,
        updatedAt: now,
      );

  GoalCategory sampleCategory() => GoalCategory(
        id: 'cat-1',
        name: 'Health',
        createdAt: now,
        updatedAt: now,
      );

  group('IGoalRepository contract', () {
    late MockIGoalRepository repository;

    setUpAll(() {
      registerFallbackValue(FakeGoal());
      registerFallbackValue(FakeGoalCategory());
      registerFallbackValue(GoalTimeHorizon.weekly);
    });

    setUp(() {
      repository = MockIGoalRepository();
    });

    test('watch methods return stubbed goal and category streams', () async {
      final goals = [sampleGoal()];
      final categories = [sampleCategory()];

      when(() => repository.watchAllGoals())
          .thenAnswer((_) => Stream.value(Right(goals)));
      when(() => repository.watchGoalsByHorizon(any()))
          .thenAnswer((_) => Stream.value(Right(goals)));
      when(() => repository.watchCategories())
          .thenAnswer((_) => Stream.value(Right(categories)));

      expect(await repository.watchAllGoals().first, Right(goals));
      expect(
        await repository.watchGoalsByHorizon(GoalTimeHorizon.monthly).first,
        Right(goals),
      );
      expect(await repository.watchCategories().first, Right(categories));
    });

    test('mutation methods return stubbed goal or category results', () async {
      final goal = sampleGoal();
      final category = sampleCategory();

      when(() => repository.createGoal(any()))
          .thenAnswer((_) async => Right(goal));
      when(() => repository.updateGoal(any()))
          .thenAnswer((_) async => Right(goal));
      when(() => repository.deleteGoal(any()))
          .thenAnswer((_) async => const Right(unit));
      when(() => repository.createCategory(any()))
          .thenAnswer((_) async => Right(category));
      when(() => repository.updateCategory(any()))
          .thenAnswer((_) async => Right(category));
      when(() => repository.deleteCategory(any()))
          .thenAnswer((_) async => const Right(unit));

      expect(await repository.createGoal(goal), Right(goal));
      expect(await repository.updateGoal(goal), Right(goal));
      expect(await repository.deleteGoal('goal-1'), const Right(unit));
      expect(await repository.createCategory(category), Right(category));
      expect(await repository.updateCategory(category), Right(category));
      expect(await repository.deleteCategory('cat-1'), const Right(unit));
    });

    test('failure results propagate through the interface', () async {
      const failure = CacheFailure(errorMessage: 'cache miss');

      when(() => repository.createGoal(any()))
          .thenAnswer((_) async => const Left(failure));
      when(() => repository.deleteCategory(any()))
          .thenAnswer((_) async => const Left(failure));

      final createResult = await repository.createGoal(sampleGoal());
      final deleteResult = await repository.deleteCategory('cat-1');

      expect(createResult, const Left(failure));
      expect(deleteResult, const Left(failure));
    });
  });

  group('IGoalRepository implementation binding', () {
    late AppDatabase db;

    setUp(() {
      db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    });

    tearDown(() async {
      await db.close();
    });

    test('GoalRepositoryImpl satisfies the interface', () {
      expect(GoalRepositoryImpl(db), isA<IGoalRepository>());
    });
  });
}
