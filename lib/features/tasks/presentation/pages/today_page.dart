import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/utils/adaptive_dialog.dart';
import 'package:reflect/core/presentation/utils/day_greeting.dart';
import 'package:reflect/core/presentation/widgets/reflect_fab.dart';
import 'package:reflect/core/presentation/widgets/reflect_icon_button.dart';
import 'package:reflect/core/presentation/widgets/reflect_progress_bar.dart';
import 'package:reflect/core/presentation/widgets/reflect_section_label.dart';
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocBuilder<TaskListBloc, TaskListState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            loaded: (rawTasks, pending, completed, overdue, sortMode, filter) {
              final allTasks = [...pending, ...completed];
              final allDisplayableTaskIds = [
                ...overdue.map((t) => t.id),
                ...allTasks.map((t) => t.id),
              ];
              final now = DateTime.now();
              final totalToday = pending.length + completed.length;
              final doneToday = completed.length;
              final progress = totalToday == 0 ? 0.0 : doneToday / totalToday;

              String greeting = dayGreetingForHour(now.hour);

              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 56, 16, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          greeting,
                                          style: textTheme.titleMedium
                                              ?.copyWith(
                                            color: ReflectColors.textSecondary,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('EEEE, MMM d').format(now),
                                          style: textTheme.headlineMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                  ReflectIconButton(
                                    icon: Icons.tune,
                                    tooltip: 'Filter',
                                    onPressed: () => showTaskListFilterSheet(
                                      context,
                                      context.read<TaskListBloc>(),
                                      filter,
                                    ),
                                  ),
                                  ReflectIconButton(
                                    icon: Icons.sort_by_alpha,
                                    tooltip: 'Sort',
                                    onPressed: () => showTaskListSortMenu(
                                      context,
                                      context.read<TaskListBloc>(),
                                      sortMode,
                                    ),
                                  ),
                                ],
                              ),
                              if (totalToday > 0) ...[
                                const SizedBox(height: 12),
                                ReflectProgressBar(
                                  progress: progress,
                                  label: '$doneToday of $totalToday done today',
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      if (overdue.isNotEmpty) ...[
                        const SliverToBoxAdapter(
                          child: ReflectSectionLabel(
                            title: 'OVERDUE',
                            color: ReflectColors.overdue,
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) =>
                                TaskCard(task: overdue[index]),
                            childCount: overdue.length,
                          ),
                        ),
                      ],
                      const SliverToBoxAdapter(
                        child: ReflectSectionLabel(
                          title: 'TODAY',
                          color: ReflectColors.accentPrimary,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Text(
                            'TASKS',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              color: ReflectColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      if (allTasks.isEmpty)
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.done_all,
                                    size: 48,
                                    color: ReflectColors.textSecondary
                                        .withValues(alpha: 0.5),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No tasks for today. Plus some rest?',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: ReflectColors.textSecondary,
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
          return ReflectFab(
            heroTag: 'today_fab',
            onPressed: () => context.go('/today/task/new'),
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
              color: colorScheme.secondaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
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
                              context.read<TaskSelectionCubit>().selectAll(
                                    allTaskIds,
                                  );
                            }
                          },
                        ),
                        Text(
                          '$selectedCount selected',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () =>
                              context.read<TaskSelectionCubit>().clearSelection(),
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
                            final confirmed =
                                await showAdaptiveConfirmationDialog(
                              context: context,
                              title: 'Delete Tasks',
                              message:
                                  'Are you sure you want to delete $selectedCount tasks?',
                            );
                            if (confirmed == true && context.mounted) {
                              context.read<TaskListBloc>().add(
                                    TaskListEvent.bulkDeleteTasks(
                                      state.selectedTaskIds.toList(),
                                    ),
                                  );
                              context.read<TaskSelectionCubit>().clearSelection();
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
    final color = isDestructive
        ? Theme.of(context).colorScheme.error
        : ReflectColors.textPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
      ),
    );
  }
}
