import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';

class MockGoalRepository extends Mock implements IGoalRepository {}

void main() {
  late MockGoalRepository mockRepo;

  setUp(() {
    mockRepo = MockGoalRepository();
    // Default mock behavior for streams
    for (final h in GoalTimeHorizon.values) {
      when(() => mockRepo.watchGoalsByHorizon(h))
          .thenAnswer((_) => Stream.value(const Right([])));
    }
    when(() => mockRepo.watchCategories())
        .thenAnswer((_) => Stream.value(const Right([])));
  });

  group('GoalsCubit', () {
    final now = DateTime.now();
    final testGoal = Goal(
      id: 'g1',
      title: 'Goal 1',
      timeHorizon: GoalTimeHorizon.monthly,
      createdAt: now,
      updatedAt: now,
    );
    final testCategory = GoalCategory(
      id: 'c1',
      name: 'Cat 1',
      sortOrder: 0,
      createdAt: now,
      updatedAt: now,
    );

    test('initial state sets up streams', () async {
      final cubit = GoalsCubit(mockRepo);
      // Let microtasks run so stream listeners fire
      await Future.delayed(Duration.zero);

      expect(cubit.state.selectedHorizon, GoalTimeHorizon.weekly);
      expect(cubit.state.goalsByHorizon[GoalTimeHorizon.monthly], []);
      expect(cubit.state.categories, []);
      
      cubit.close();
    });

    test('setHorizon updates selectedHorizon', () {
      final cubit = GoalsCubit(mockRepo);
      
      cubit.setHorizon(GoalTimeHorizon.yearly);
      
      expect(cubit.state.selectedHorizon, GoalTimeHorizon.yearly);
      cubit.close();
    });

    test('streams populate data on success', () async {
      when(() => mockRepo.watchGoalsByHorizon(GoalTimeHorizon.monthly))
          .thenAnswer((_) => Stream.value(Right([testGoal])));
      when(() => mockRepo.watchCategories())
          .thenAnswer((_) => Stream.value(Right([testCategory])));

      final cubit = GoalsCubit(mockRepo);
      await Future.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.goalsFor(GoalTimeHorizon.monthly).length, 1);
      expect(cubit.state.goalsFor(GoalTimeHorizon.monthly).first.id, 'g1');
      expect(cubit.state.categories.length, 1);
      expect(cubit.state.categories.first.id, 'c1');
      expect(cubit.state.error, isNull);

      cubit.close();
    });

    test('streams populate error on failure', () async {
      for (final h in GoalTimeHorizon.values) {
        when(() => mockRepo.watchGoalsByHorizon(h))
            .thenAnswer((_) => Stream.value(Left(CacheFailure(errorMessage: 'G Fail'))));
      }
      when(() => mockRepo.watchCategories()).thenAnswer((_) => const Stream.empty());

      final cubit = GoalsCubit(mockRepo);
      await Future.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.error, 'Failed to load goals');

      cubit.close();
    });

    test('categories stream emits error on failure', () async {
      when(() => mockRepo.watchCategories()).thenAnswer(
        (_) => Stream.value(Left(CacheFailure(errorMessage: 'Cat Fail'))),
      );

      final cubit = GoalsCubit(mockRepo);
      await Future.delayed(const Duration(milliseconds: 10));

      expect(cubit.state.error, 'Failed to load categories');

      cubit.close();
    });

    test('createGoal succeeds without error', () async {
      when(() => mockRepo.createGoal(testGoal))
          .thenAnswer((_) async => Right(testGoal));

      final cubit = GoalsCubit(mockRepo);
      await cubit.createGoal(testGoal);

      expect(cubit.state.error, isNull);
      cubit.close();
    });

    test('updateGoal succeeds without error', () async {
      when(() => mockRepo.updateGoal(testGoal))
          .thenAnswer((_) async => Right(testGoal));

      final cubit = GoalsCubit(mockRepo);
      await cubit.updateGoal(testGoal);

      expect(cubit.state.error, isNull);
      cubit.close();
    });

    test('deleteGoal succeeds without error', () async {
      when(() => mockRepo.deleteGoal('g1'))
          .thenAnswer((_) async => const Right(unit));

      final cubit = GoalsCubit(mockRepo);
      await cubit.deleteGoal('g1');

      expect(cubit.state.error, isNull);
      cubit.close();
    });

    test('createCategory succeeds without error', () async {
      when(() => mockRepo.createCategory(testCategory))
          .thenAnswer((_) async => Right(testCategory));

      final cubit = GoalsCubit(mockRepo);
      await cubit.createCategory(testCategory);

      expect(cubit.state.error, isNull);
      cubit.close();
    });

    test('updateCategory succeeds without error', () async {
      when(() => mockRepo.updateCategory(testCategory))
          .thenAnswer((_) async => Right(testCategory));

      final cubit = GoalsCubit(mockRepo);
      await cubit.updateCategory(testCategory);

      expect(cubit.state.error, isNull);
      cubit.close();
    });

    test('deleteCategory succeeds without error', () async {
      when(() => mockRepo.deleteCategory('c1'))
          .thenAnswer((_) async => const Right(unit));

      final cubit = GoalsCubit(mockRepo);
      await cubit.deleteCategory('c1');

      expect(cubit.state.error, isNull);
      cubit.close();
    });

    test('setHorizon is no-op when horizon unchanged', () {
      final cubit = GoalsCubit(mockRepo);
      final before = cubit.state;

      cubit.setHorizon(GoalTimeHorizon.weekly);

      expect(cubit.state, before);
      cubit.close();
    });

    test('createGoal updates error on failure', () async {
      when(() => mockRepo.createGoal(testGoal))
          .thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Create Fail')));

      final cubit = GoalsCubit(mockRepo);
      await cubit.createGoal(testGoal);

      expect(cubit.state.error, 'Create Fail');
      cubit.close();
    });

    test('updateGoal updates error on failure', () async {
      when(() => mockRepo.updateGoal(testGoal))
          .thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Update Fail')));

      final cubit = GoalsCubit(mockRepo);
      await cubit.updateGoal(testGoal);

      expect(cubit.state.error, 'Update Fail');
      cubit.close();
    });

    test('deleteGoal updates error on failure', () async {
      when(() => mockRepo.deleteGoal('g1'))
          .thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Delete Fail')));

      final cubit = GoalsCubit(mockRepo);
      await cubit.deleteGoal('g1');

      expect(cubit.state.error, 'Delete Fail');
      cubit.close();
    });

    test('createCategory updates error on failure', () async {
      when(() => mockRepo.createCategory(testCategory))
          .thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Create Cat Fail')));

      final cubit = GoalsCubit(mockRepo);
      await cubit.createCategory(testCategory);

      expect(cubit.state.error, 'Create Cat Fail');
      cubit.close();
    });

    test('updateCategory updates error on failure', () async {
      when(() => mockRepo.updateCategory(testCategory))
          .thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Update Cat Fail')));

      final cubit = GoalsCubit(mockRepo);
      await cubit.updateCategory(testCategory);

      expect(cubit.state.error, 'Update Cat Fail');
      cubit.close();
    });

    test('deleteCategory updates error on failure', () async {
      when(() => mockRepo.deleteCategory('c1'))
          .thenAnswer((_) async => Left(CacheFailure(errorMessage: 'Delete Cat Fail')));

      final cubit = GoalsCubit(mockRepo);
      await cubit.deleteCategory('c1');

      expect(cubit.state.error, 'Delete Cat Fail');
      cubit.close();
    });
  });
}
