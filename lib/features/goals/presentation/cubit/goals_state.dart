import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';

class GoalsState {
  const GoalsState({
    this.goalsByHorizon = const {},
    this.categories = const [],
    this.selectedHorizon = GoalTimeHorizon.weekly,
    this.loading = false,
    this.error,
  });

  final Map<GoalTimeHorizon, List<Goal>> goalsByHorizon;
  final List<GoalCategory> categories;
  final GoalTimeHorizon selectedHorizon;
  final bool loading;
  final String? error;

  List<Goal> goalsFor(GoalTimeHorizon horizon) =>
      goalsByHorizon[horizon] ?? const [];

  GoalsState copyWith({
    Map<GoalTimeHorizon, List<Goal>>? goalsByHorizon,
    List<GoalCategory>? categories,
    GoalTimeHorizon? selectedHorizon,
    bool? loading,
    String? error,
  }) {
    return GoalsState(
      goalsByHorizon: goalsByHorizon ?? this.goalsByHorizon,
      categories: categories ?? this.categories,
      selectedHorizon: selectedHorizon ?? this.selectedHorizon,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
