import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/utils/adaptive_dialog.dart';
import 'package:reflect/core/presentation/widgets/section_header.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';
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
              final allDisplayableTaskIds = [
                ...displayedOverdue.map((t) => t.id),
                ...allTasks.map((t) => t.id),
              ];

              return Stack(
                children: [
                  CustomScrollView(
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
                  ),
                  _SelectionOverlay(allTaskIds: allDisplayableTaskIds),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: BlocBuilder<TaskSelectionCubit, TaskSelectionState>(
        builder: (context, selectionState) {
          if (selectionState.isSelectionMode) return const SizedBox.shrink();
          return FloatingActionButton(
            heroTag: 'today_fab',
            onPressed: () => context.go('/today/task/new'),
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }
}

class _SelectionOverlay extends StatelessWidget {
  final List<String> allTaskIds;

  const _SelectionOverlay({required this.allTaskIds});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<TaskSelectionCubit, TaskSelectionState>(
      builder: (context, state) {
        if (!state.isSelectionMode) return const SizedBox.shrink();

        final selectedCount = state.selectedTaskIds.length;
        final isAllSelected = selectedCount == allTaskIds.length;

        return Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: SafeArea(
            child: Card(
              elevation: 8,
              shadowColor: Colors.black45,
              color: colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isAllSelected,
                          tristate: selectedCount > 0 && !isAllSelected,
                          onChanged: (val) {
                            if (isAllSelected) {
                              context.read<TaskSelectionCubit>().clearSelection();
                            } else {
                              context.read<TaskSelectionCubit>().selectAll(allTaskIds);
                            }
                          },
                        ),
                        Text(
                          '$selectedCount selected',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                color: colorScheme.onSecondaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => context.read<TaskSelectionCubit>().clearSelection(),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                    const Divider(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _ActionButton(
                          icon: Icons.check_circle_outline,
                          label: 'Done',
                          onTap: () {
                            context.read<TaskListBloc>().add(
                                  TaskListEvent.bulkCompleteTasks(
                                    state.selectedTaskIds.toList(),
                                  ),
                                );
                            context.read<TaskSelectionCubit>().clearSelection();
                          },
                        ),
                        _ActionButton(
                          icon: Icons.radio_button_unchecked,
                          label: 'Undone',
                          onTap: () {
                            context.read<TaskListBloc>().add(
                                  TaskListEvent.bulkReopenTasks(
                                    state.selectedTaskIds.toList(),
                                  ),
                                );
                            context.read<TaskSelectionCubit>().clearSelection();
                          },
                        ),
                        _ActionButton(
                          icon: Icons.inventory_2_outlined,
                          label: 'Backlog',
                          onTap: () {
                            context.read<TaskListBloc>().add(
                                  TaskListEvent.bulkMoveToBacklog(
                                    state.selectedTaskIds.toList(),
                                  ),
                                );
                            context.read<TaskSelectionCubit>().clearSelection();
                          },
                        ),
                        _ActionButton(
                          icon: Icons.delete_outline,
                          label: 'Delete',
                          isDestructive: true,
                          onTap: () async {
                            final confirmed = await showAdaptiveConfirmationDialog(
                              context: context,
                              title: 'Delete Tasks',
                              message: 'Are you sure you want to delete $selectedCount tasks?',
                            );
                            if (confirmed == true) {
                              if (context.mounted) {
                                context.read<TaskListBloc>().add(
                                      TaskListEvent.bulkDeleteTasks(
                                        state.selectedTaskIds.toList(),
                                      ),
                                    );
                                context.read<TaskSelectionCubit>().clearSelection();
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = isDestructive ? colorScheme.error : colorScheme.onSecondaryContainer;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
