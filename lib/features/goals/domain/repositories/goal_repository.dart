import 'package:fpdart/fpdart.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';

abstract class IGoalRepository {
  Stream<Either<Failure, List<Goal>>> watchGoalsByHorizon(GoalTimeHorizon horizon);
  Future<Either<Failure, Goal>> createGoal(Goal goal);
  Future<Either<Failure, Goal>> updateGoal(Goal goal);
  Future<Either<Failure, Unit>> deleteGoal(String id);

  Stream<Either<Failure, List<GoalCategory>>> watchCategories();
  Future<Either<Failure, GoalCategory>> createCategory(GoalCategory category);
  Future<Either<Failure, GoalCategory>> updateCategory(GoalCategory category);
  Future<Either<Failure, Unit>> deleteCategory(String id);
}
