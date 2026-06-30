import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/goals/data/repositories/goal_repository_impl.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  late AppDatabase db;
  late GoalRepositoryImpl repository;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    repository = GoalRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('GoalRepositoryImpl', () {
    final now = DateTime.now();
    final testGoal = Goal(
      id: 'g1',
      title: 'Goal 1',
      description: 'Desc',
      categoryId: 'cat1',
      timeHorizon: GoalTimeHorizon.monthly,
      priority: TaskPriority.p1,
      createdAt: now,
      updatedAt: now,
    );

    final testCategory = GoalCategory(
      id: 'cat1',
      name: 'Category 1',
      sortOrder: 0,
      createdAt: now,
      updatedAt: now,
    );

    test('createCategory inserts category', () async {
      final result = await repository.createCategory(testCategory);
      
      expect(result.isRight(), isTrue);
      
      final dbCategories = await db.select(db.goalCategories).get();
      expect(dbCategories.length, 1);
      expect(dbCategories.first.id, 'cat1');
    });

    test('watchCategories returns stream of categories', () async {
      await repository.createCategory(testCategory);
      
      final stream = repository.watchCategories();
      final categories = await stream.first;
      
      expect(categories.isRight(), isTrue);
      expect(categories.getOrElse((_) => []).length, 1);
      expect(categories.getOrElse((_) => []).first.id, 'cat1');
    });

    test('updateCategory updates category', () async {
      await repository.createCategory(testCategory);
      
      final updatedCat = testCategory.copyWith(name: 'Updated');
      final result = await repository.updateCategory(updatedCat);
      
      expect(result.isRight(), isTrue);
      
      final dbCategories = await db.select(db.goalCategories).get();
      expect(dbCategories.first.name, 'Updated');
    });

    test('deleteCategory deletes category', () async {
      await repository.createCategory(testCategory);
      
      var dbCategories = await db.select(db.goalCategories).get();
      expect(dbCategories.length, 1);
      
      final result = await repository.deleteCategory('cat1');
      expect(result.isRight(), isTrue);
      
      dbCategories = await db.select(db.goalCategories).get();
      expect(dbCategories.length, 0);
    });

    test('createGoal inserts goal', () async {
      await repository.createCategory(testCategory);
      final result = await repository.createGoal(testGoal);
      result.fold((l) => print(l.errorMessage), (r) => print('Success'));
      
      expect(result.isRight(), isTrue);
      
      final dbGoals = await db.select(db.goals).get();
      expect(dbGoals.length, 1);
      expect(dbGoals.first.id, 'g1');
      expect(dbGoals.first.title, 'Goal 1');
    });

    test('updateGoal updates goal', () async {
      await repository.createCategory(testCategory);
      await repository.createGoal(testGoal);
      
      final updatedGoal = testGoal.copyWith(title: 'Updated Goal');
      final result = await repository.updateGoal(updatedGoal);
      
      expect(result.isRight(), isTrue);
      
      final dbGoals = await db.select(db.goals).get();
      expect(dbGoals.first.title, 'Updated Goal');
    });

    test('deleteGoal removes goal', () async {
      await repository.createCategory(testCategory);
      await repository.createGoal(testGoal);
      
      var dbGoals = await db.select(db.goals).get();
      expect(dbGoals.length, 1);
      
      final result = await repository.deleteGoal('g1');
      expect(result.isRight(), isTrue);
      
      dbGoals = await db.select(db.goals).get();
      expect(dbGoals.length, 0);
    });

    test('watchAllGoals returns stream of goals', () async {
      await repository.createCategory(testCategory);
      await repository.createGoal(testGoal);
      
      final stream = repository.watchAllGoals();
      final goals = await stream.first;
      
      expect(goals.isRight(), isTrue);
      expect(goals.getOrElse((_) => []).length, 1);
      expect(goals.getOrElse((_) => []).first.id, 'g1');
    });

    test('watchGoalsByHorizon returns filtered stream', () async {
      await repository.createCategory(testCategory);
      await repository.createGoal(testGoal);
      
      final longTermGoal = testGoal.copyWith(id: 'g2', timeHorizon: GoalTimeHorizon.yearly);
      await repository.createGoal(longTermGoal);
      
      final stream = repository.watchGoalsByHorizon(GoalTimeHorizon.monthly);
      final goals = await stream.first;
      
      expect(goals.isRight(), isTrue);
      expect(goals.getOrElse((_) => []).length, 1);
      expect(goals.getOrElse((_) => []).first.id, 'g1');
    });
  });
}
