import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  GoalsCubit(this._repo) : super(const GoalsState()) {
    for (final h in GoalTimeHorizon.values) {
      _goalSubs[h] = _repo.watchGoalsByHorizon(h).listen((either) {
        either.fold(
          (_) => emit(state.copyWith(error: 'Failed to load goals')),
          (list) {
            _goalsByHorizon[h] = list;
            emit(state.copyWith(
              goalsByHorizon: Map.from(_goalsByHorizon),
              error: null,
            ));
          },
        );
      });
    }
    _categoriesSub = _repo.watchCategories().listen(_onCategoriesData);
  }

  final IGoalRepository _repo;
  final Map<GoalTimeHorizon, StreamSubscription<Either<dynamic, List<Goal>>>> _goalSubs = {};
  final Map<GoalTimeHorizon, List<Goal>> _goalsByHorizon = {};
  StreamSubscription<Either<dynamic, List<GoalCategory>>>? _categoriesSub;

  void _onCategoriesData(Either<dynamic, List<GoalCategory>> either) {
    either.fold(
      (_) => emit(state.copyWith(error: 'Failed to load categories')),
      (list) => emit(state.copyWith(categories: list, error: null)),
    );
  }

  void setHorizon(GoalTimeHorizon horizon) {
    if (horizon == state.selectedHorizon) return;
    emit(state.copyWith(selectedHorizon: horizon));
  }

  Future<void> createGoal(Goal goal) async {
    final result = await _repo.createGoal(goal);
    result.fold(
      (f) => emit(state.copyWith(error: f.errorMessage)),
      (_) {},
    );
  }

  Future<void> updateGoal(Goal goal) async {
    final result = await _repo.updateGoal(goal);
    result.fold(
      (f) => emit(state.copyWith(error: f.errorMessage)),
      (_) {},
    );
  }

  Future<void> deleteGoal(String id) async {
    final result = await _repo.deleteGoal(id);
    result.fold(
      (f) => emit(state.copyWith(error: f.errorMessage)),
      (_) {},
    );
  }

  Future<void> createCategory(GoalCategory category) async {
    final result = await _repo.createCategory(category);
    result.fold(
      (f) => emit(state.copyWith(error: f.errorMessage)),
      (_) {},
    );
  }

  Future<void> updateCategory(GoalCategory category) async {
    final result = await _repo.updateCategory(category);
    result.fold(
      (f) => emit(state.copyWith(error: f.errorMessage)),
      (_) {},
    );
  }

  Future<void> deleteCategory(String id) async {
    final result = await _repo.deleteCategory(id);
    result.fold(
      (f) => emit(state.copyWith(error: f.errorMessage)),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    for (final sub in _goalSubs.values) {
      sub.cancel();
    }
    _categoriesSub?.cancel();
    return super.close();
  }
}
