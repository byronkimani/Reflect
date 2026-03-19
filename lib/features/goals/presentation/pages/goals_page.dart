import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_state.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalsCubit, GoalsState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          initialIndex: state.selectedHorizon.index,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Goals'),
              bottom: TabBar(
                onTap: (index) {
                  context.read<GoalsCubit>().setHorizon(
                        GoalTimeHorizon.values[index],
                      );
                },
                tabs: const [
                  Tab(text: 'Weekly'),
                  Tab(text: 'Monthly'),
                  Tab(text: 'Yearly'),
                ],
              ),
            ),
            body: state.error != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        state.error!,
                        style: TextStyle(color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                  )
                : TabBarView(
                    children: [
                      _GoalList(horizon: GoalTimeHorizon.weekly),
                      _GoalList(horizon: GoalTimeHorizon.monthly),
                      _GoalList(horizon: GoalTimeHorizon.yearly),
                    ],
                  ),
            floatingActionButton: FloatingActionButton(
              heroTag: 'goals_fab',
              onPressed: () {
                final horizon = context.read<GoalsCubit>().state.selectedHorizon;
                context.push('/goals/new', extra: horizon);
              },
              child: const Icon(Icons.add),
            ),
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
      builder: (context, state) {
        final goals = state.goalsFor(horizon);
        if (goals.isEmpty) {
          return Center(
            child: Text(
              'No ${horizon.name} goals yet.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: goals.length,
          itemBuilder: (context, index) {
            final goal = goals[index];
            return ListTile(
              title: Text(goal.title),
              subtitle: goal.description != null
                  ? Text(
                      goal.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  : null,
              trailing: IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () =>
                    context.push('/goals/${goal.id}', extra: goal),
              ),
              onLongPress: () {
                _confirmDelete(context, goal.id, goal.title, context.read<GoalsCubit>());
              },
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
