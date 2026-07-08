import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_state.dart';

void main() {
  final now = DateTime(2026, 3, 18);
  final goal = Goal(
    id: 'g1',
    title: 'Goal',
    timeHorizon: GoalTimeHorizon.weekly,
    createdAt: now,
    updatedAt: now,
  );
  final category = GoalCategory(
    id: 'c1',
    name: 'Health',
    createdAt: now,
    updatedAt: now,
  );

  const base = GoalsState();

  group('goalsStateShouldRebuild', () {
    test('returns false when state is unchanged', () {
      expect(goalsStateShouldRebuild(base, base), isFalse);
    });

    test('returns true when loading changes', () {
      expect(
        goalsStateShouldRebuild(base, base.copyWith(loading: true)),
        isTrue,
      );
    });

    test('returns true when error changes', () {
      expect(
        goalsStateShouldRebuild(base, base.copyWith(error: 'oops')),
        isTrue,
      );
    });

    test('returns true when selectedHorizon changes', () {
      expect(
        goalsStateShouldRebuild(
          base,
          base.copyWith(selectedHorizon: GoalTimeHorizon.monthly),
        ),
        isTrue,
      );
    });

    test('returns true when goalsByHorizon reference changes', () {
      final withGoals = base.copyWith(
        goalsByHorizon: {GoalTimeHorizon.weekly: [goal]},
      );
      expect(goalsStateShouldRebuild(base, withGoals), isTrue);
    });

    test('returns true when categories reference changes', () {
      expect(
        goalsStateShouldRebuild(base, base.copyWith(categories: [category])),
        isTrue,
      );
    });
  });

  group('goalsListShouldRebuild', () {
    test('returns true when parent should rebuild', () {
      expect(
        goalsListShouldRebuild(base, base.copyWith(loading: true), GoalTimeHorizon.weekly),
        isTrue,
      );
    });

    test('returns true when horizon list changes', () {
      final previous = base.copyWith(
        goalsByHorizon: {GoalTimeHorizon.weekly: [goal]},
      );
      final current = base.copyWith(
        goalsByHorizon: {
          GoalTimeHorizon.weekly: [
            goal.copyWith(title: 'Updated'),
          ],
        },
      );
      expect(
        goalsListShouldRebuild(
          previous,
          current,
          GoalTimeHorizon.weekly,
        ),
        isTrue,
      );
    });

    test('returns false when unrelated horizon is unchanged', () {
      final state = base.copyWith(
        goalsByHorizon: {GoalTimeHorizon.monthly: [goal]},
      );
      expect(
        goalsListShouldRebuild(state, state, GoalTimeHorizon.weekly),
        isFalse,
      );
    });
  });

  group('goalsFor', () {
    test('returns empty list for missing horizon', () {
      expect(base.goalsFor(GoalTimeHorizon.yearly), isEmpty);
    });
  });
}
