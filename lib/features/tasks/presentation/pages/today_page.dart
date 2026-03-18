import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/widgets/section_header.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/widgets/task_list_filter_sheet.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

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
                displayedOverdue,
                displayedPending,
                displayedCompleted,
              ) = applyTaskListFilterAndSort(
                overdue,
                pending,
                completed,
                sortMode,
                filter,
              );

              final now = DateTime.now();
              final hour = now.hour;
              String greeting = 'Good morning';
              if (hour >= 12 && hour < 17) {
                greeting = 'Good afternoon';
              } else if (hour >= 17) {
                greeting = 'Good evening';
              }

              // Single list: pending first, then completed at bottom (no separate COMPLETED section).
              final allTasks = [...displayedPending, ...displayedCompleted];

              return CustomScrollView(
                slivers: [
                  SliverAppBar.large(
                    expandedHeight: 180.0,
                    backgroundColor: colorScheme.surface,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    surfaceTintColor: Colors.transparent,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greeting,
                            style: textTheme.titleMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            DateFormat('EEEE, MMM d').format(now),
                            style: textTheme.headlineMedium,
                          ),
                        ],
                      ),
                      centerTitle: false,
                      titlePadding: const EdgeInsetsDirectional.only(
                        start: 16,
                        bottom: 10,
                      ),
                    ),
                  ),
                  if (displayedOverdue.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: SectionHeader(
                        title: 'OVERDUE',
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            TaskCard(task: displayedOverdue[index]),
                        childCount: displayedOverdue.length,
                      ),
                    ),
                  ],
                  // TASKS title and filter/sort on same row so they stay together when scrolling.
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
                                Icons.done_all,
                                size: 48,
                                color: colorScheme.outlineVariant,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No tasks for today. Plus some rest?',
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
                        (context, index) => TaskCard(task: allTasks[index]),
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
        onPressed: () => context.go('/today/task/new'),
        child: const Icon(Icons.add),
      ),
    );
  }

}
