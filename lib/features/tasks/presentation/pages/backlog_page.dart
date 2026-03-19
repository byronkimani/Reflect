import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/widgets/task_list_filter_sheet.dart';

class BacklogPage extends StatelessWidget {
  const BacklogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            loaded: (pending, completed, overdue, sortMode, filter) {
              final (
                _,
                displayedPending,
                displayedCompleted,
              ) = applyTaskListFilterAndSort(
                overdue,
                pending,
                completed,
                sortMode,
                filter,
              );
              final allTasks = [...displayedPending, ...displayedCompleted];

              return CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    expandedHeight: 120.0,
                    backgroundColor: colorScheme.surface,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    surfaceTintColor: Colors.transparent,
                    title: Text(
                      'Backlog',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'TASKS',
                              style: textTheme.titleMedium?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.tune),
                            onPressed: () => showTaskListFilterSheet(
                              context,
                              context.read<TaskListBloc>(),
                              filter,
                            ),
                            tooltip: 'Filter',
                          ),
                          IconButton(
                            icon: const Icon(Icons.sort_by_alpha),
                            onPressed: () => showTaskListSortMenu(
                              context,
                              context.read<TaskListBloc>(),
                              sortMode,
                            ),
                            tooltip: 'Sort',
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (allTasks.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 48,
                                color: colorScheme.outlineVariant,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No tasks in backlog.',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.outline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => TaskCard(
                          task: allTasks[index],
                          taskRoutePrefix: '/backlog',
                        ),
                        childCount: allTasks.length,
                      ),
                    ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'backlog_fab',
        onPressed: () => context.go('/backlog/task/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
