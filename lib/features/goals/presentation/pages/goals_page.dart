import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/utils/reflect_page_insets.dart';
import 'package:reflect/core/presentation/widgets/priority_lozenge.dart';
import 'package:reflect/core/presentation/widgets/reflect_fab.dart';
import 'package:reflect/core/presentation/widgets/reflect_pill.dart';
import 'package:reflect/core/presentation/widgets/reflect_sticky_bottom_bar.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_state.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsCubit, GoalsState>(
      buildWhen: goalsStateShouldRebuild,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ReflectColors.pageBackground,
          body: ReflectTabPageSafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text(
                    'My Goals',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: ReflectColors.textPrimary,
                        ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: GoalTimeHorizon.values.map((horizon) {
                      final selected = state.selectedHorizon == horizon;
                      final label = horizon.name[0].toUpperCase() +
                          horizon.name.substring(1);
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ReflectPill(
                          label: label,
                          selected: selected,
                          onTap: () => context
                              .read<GoalsCubit>()
                              .setHorizon(horizon),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: state.error != null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              state.error!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                        )
                      : _GoalList(horizon: state.selectedHorizon),
                ),
              ],
            ),
          ),
          floatingActionButton: ReflectFab(
            heroTag: 'goals_fab',
            onPressed: () {
              final horizon = context.read<GoalsCubit>().state.selectedHorizon;
              context.push('/goals/new', extra: horizon);
            },
          ),
        );
      },
    );
  }
}

class _GoalList extends StatelessWidget {
  const _GoalList({required this.horizon});

  final GoalTimeHorizon horizon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsCubit, GoalsState>(
      buildWhen: (p, c) => goalsListShouldRebuild(p, c, horizon),
      builder: (context, state) {
        final goals = state.goalsFor(horizon);
        if (goals.isEmpty) {
          return Center(
            child: Text(
              'No ${horizon.name} goals yet.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ReflectColors.textSecondary,
                  ),
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(
            16,
            8,
            16,
            kReflectTabBarScrollClearance,
          ),
          itemCount: goals.length,
          itemBuilder: (context, index) {
            final goal = goals[index];
            return _GoalCard(
              goal: goal,
              onTap: () => context.push('/goals/${goal.id}', extra: goal),
              onDelete: () => _confirmDelete(
                context,
                goal.id,
                goal.title,
                context.read<GoalsCubit>(),
              ),
            );
          },
        );
      },
    );
  }

  void _confirmDelete(
    BuildContext context,
    String id,
    String title,
    GoalsCubit cubit,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete goal?'),
        content: Text('Delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              cubit.deleteGoal(id);
              Navigator.of(ctx).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.onTap,
    required this.onDelete,
  });

  final Goal goal;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        onLongPress: onDelete,
        borderRadius: BorderRadius.circular(ReflectSpacing.cardRadius),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      goal.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (goal.priority != null)
                    PriorityLozenge(priority: goal.priority!),
                ],
              ),
              if (goal.description != null &&
                  goal.description!.trim().isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  goal.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodySmall?.copyWith(
                    color: ReflectColors.textSecondary,
                  ),
                ),
              ],
              if (goal.targetDate != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Target ${DateFormat.yMMMd().format(goal.targetDate!)}',
                  style: textTheme.labelSmall?.copyWith(
                    color: ReflectColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
