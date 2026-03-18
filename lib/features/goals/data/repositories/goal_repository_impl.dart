import 'package:drift/drift.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';
import 'package:reflect/core/errors/failure.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/goals/data/mappers/goal_mappers.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';

class GoalRepositoryImpl implements IGoalRepository {
  final AppDatabase _db;

  GoalRepositoryImpl(this._db);

  @override
  Stream<Either<Failure, List<Goal>>> watchGoalsByHorizon(
    GoalTimeHorizon horizon,
  ) {
    return (_db.select(_db.goals)
          ..where((g) => g.timeHorizon.equals(horizon.name))
          ..orderBy([(g) => OrderingTerm(expression: g.createdAt, mode: OrderingMode.desc)]))
        .watch()
        .map((rows) => Right(rows.map((r) => r.toDomain()).toList()));
  }

  @override
  Future<Either<Failure, Goal>> createGoal(Goal goal) async {
    try {
      final now = DateTime.now();
      final id = goal.id.isEmpty ? const Uuid().v4() : goal.id;
      final companion = goal.copyWith(id: id).toCompanion();
      await _db.into(_db.goals).insert(
            companion.copyWith(
              id: Value(id),
              createdAt: Value(now.millisecondsSinceEpoch),
              updatedAt: Value(now.millisecondsSinceEpoch),
            ),
          );
      return Right(goal.copyWith(
        id: id,
        createdAt: now,
        updatedAt: now,
      ));
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Goal>> updateGoal(Goal goal) async {
    try {
      final now = DateTime.now();
      await (_db.update(_db.goals)..where((g) => g.id.equals(goal.id)))
          .write(goal.toCompanion().copyWith(
                updatedAt: Value(now.millisecondsSinceEpoch),
              ));
      return Right(goal.copyWith(updatedAt: now));
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteGoal(String id) async {
    try {
      await (_db.delete(_db.goals)..where((g) => g.id.equals(id))).go();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<GoalCategory>>> watchCategories() {
    return Stream.fromFuture(_db.seedGoalCategoriesIfEmpty())
        .asyncExpand((_) => (_db.select(_db.goalCategories)
              ..orderBy([(c) => OrderingTerm(expression: c.sortOrder, mode: OrderingMode.asc)]))
            .watch()
            .map((rows) => Right(rows.map((r) => r.toDomain()).toList())));
  }

  @override
  Future<Either<Failure, GoalCategory>> createCategory(
    GoalCategory category,
  ) async {
    try {
      final now = DateTime.now();
      final id =
          category.id.isEmpty ? const Uuid().v4() : category.id;
      await _db.into(_db.goalCategories).insert(
            GoalCategoriesCompanion.insert(
              name: category.name,
              createdAt: now.millisecondsSinceEpoch,
              updatedAt: now.millisecondsSinceEpoch,
              id: Value(id),
              sortOrder: Value(category.sortOrder),
            ),
          );
      return Right(category.copyWith(
        id: id,
        createdAt: now,
        updatedAt: now,
      ));
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GoalCategory>> updateCategory(
    GoalCategory category,
  ) async {
    try {
      final now = DateTime.now();
      await (_db.update(_db.goalCategories)
            ..where((c) => c.id.equals(category.id)))
          .write(
        GoalCategoriesCompanion(
          name: Value(category.name),
          sortOrder: Value(category.sortOrder),
          updatedAt: Value(now.millisecondsSinceEpoch),
        ),
      );
      return Right(category.copyWith(updatedAt: now));
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory(String id) async {
    try {
      await (_db.delete(_db.goalCategories)..where((c) => c.id.equals(id)))
          .go();
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }
}
