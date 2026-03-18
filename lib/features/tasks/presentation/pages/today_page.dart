import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/widgets/section_header.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

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
                            onPressed: () => _showFilterSheet(context, filter),
                            tooltip: 'Filter',
                          ),
                          IconButton(
                            icon: const Icon(Icons.sort_by_alpha),
                            onPressed: () => _showSortMenu(context, sortMode),
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

  void _showSortMenu(BuildContext context, SortMode current) {
    final bloc = context.read<TaskListBloc>();
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Sort by',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ...SortMode.values.map((mode) {
              return ListTile(
                title: Text(_sortModeLabel(mode)),
                leading: Icon(
                  mode == current ? Icons.check : null,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () {
                  bloc.add(TaskListEvent.sortChanged(mode));
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet(BuildContext context, TaskListFilter current) {
    final bloc = context.read<TaskListBloc>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _FilterSheetContent(
        initialFilter: current,
        onApply: (filter) {
          bloc.add(TaskListEvent.filterChanged(filter));
          Navigator.of(context).pop();
        },
      ),
    );
  }

  static String _sortModeLabel(SortMode mode) {
    switch (mode) {
      case SortMode.statusPendingFirst:
        return 'Status (pending first)';
      case SortMode.priority:
        return 'Priority (high first)';
      case SortMode.dueDateTime:
        return 'Due date & time';
      case SortMode.repeats:
        return 'Repeats first';
    }
  }
}

class _FilterSheetContent extends StatefulWidget {
  const _FilterSheetContent({
    required this.initialFilter,
    required this.onApply,
  });

  final TaskListFilter initialFilter;
  final void Function(TaskListFilter filter) onApply;

  @override
  State<_FilterSheetContent> createState() => _FilterSheetContentState();
}

class _FilterSheetContentState extends State<_FilterSheetContent> {
  late TaskListFilter _filter;

  @override
  void initState() {
    super.initState();
    _filter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => SafeArea(
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'Filter',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() => _filter = const TaskListFilter());
                    widget.onApply(const TaskListFilter());
                  },
                  icon: const Icon(Icons.clear_all, size: 18),
                  label: const Text('Clear all'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Priority', style: theme.textTheme.labelMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: _filter.priorities == null,
                  onSelected: (_) => setState(
                    () => _filter = TaskListFilter(
                      priorities: null,
                      hasDueTimeOnly: _filter.hasDueTimeOnly,
                      repeatingOnly: _filter.repeatingOnly,
                      statusFilter: _filter.statusFilter,
                    ),
                  ),
                ),
                ...TaskPriority.values.map((p) {
                  final selected =
                      _filter.priorities != null &&
                      _filter.priorities!.contains(p);
                  return FilterChip(
                    label: Text(_priorityLabel(p)),
                    selected: selected,
                    onSelected: (value) {
                      setState(() {
                        Set<TaskPriority>? next;
                        if (value == true) {
                          next =
                              _filter.priorities == null
                                    ? {p}
                                    : Set<TaskPriority>.from(
                                        _filter.priorities!,
                                      )
                                ..add(p);
                        } else {
                          if (_filter.priorities != null) {
                            final s = Set<TaskPriority>.from(
                              _filter.priorities!,
                            );
                            s.remove(p);
                            next = s.isEmpty ? null : s;
                          } else {
                            next = null;
                          }
                        }
                        _filter = _filter.copyWith(priorities: next);
                      });
                    },
                  );
                }),
              ],
            ),
            const SizedBox(height: 16),
            Text('Due time', style: theme.textTheme.labelMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Any'),
                  selected: _filter.hasDueTimeOnly == null,
                  onSelected: (_) => setState(
                    () => _filter = TaskListFilter(
                      priorities: _filter.priorities,
                      hasDueTimeOnly: null,
                      repeatingOnly: _filter.repeatingOnly,
                      statusFilter: _filter.statusFilter,
                    ),
                  ),
                ),
                FilterChip(
                  label: const Text('With time'),
                  selected: _filter.hasDueTimeOnly == true,
                  onSelected: (value) => setState(() {
                    _filter = _filter.copyWith(
                      hasDueTimeOnly: value == true ? true : null,
                    );
                  }),
                ),
                FilterChip(
                  label: const Text('No time'),
                  selected: _filter.hasDueTimeOnly == false,
                  onSelected: (value) => setState(() {
                    _filter = _filter.copyWith(
                      hasDueTimeOnly: value == true ? false : null,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Repeats', style: theme.textTheme.labelMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Any'),
                  selected: _filter.repeatingOnly == null,
                  onSelected: (_) => setState(
                    () => _filter = TaskListFilter(
                      priorities: _filter.priorities,
                      hasDueTimeOnly: _filter.hasDueTimeOnly,
                      repeatingOnly: null,
                      statusFilter: _filter.statusFilter,
                    ),
                  ),
                ),
                FilterChip(
                  label: const Text('Repeating'),
                  selected: _filter.repeatingOnly == true,
                  onSelected: (value) => setState(() {
                    _filter = _filter.copyWith(
                      repeatingOnly: value == true ? true : null,
                    );
                  }),
                ),
                FilterChip(
                  label: const Text('One-time'),
                  selected: _filter.repeatingOnly == false,
                  onSelected: (value) => setState(() {
                    _filter = _filter.copyWith(
                      repeatingOnly: value == true ? false : null,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('Status', style: theme.textTheme.labelMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: TaskStatusFilter.values.map((s) {
                return FilterChip(
                  label: Text(_statusFilterLabel(s)),
                  selected: _filter.statusFilter == s,
                  onSelected: (_) => setState(() {
                    _filter = _filter.copyWith(
                      statusFilter: _filter.statusFilter == s
                          ? TaskStatusFilter.all
                          : s,
                    );
                  }),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => widget.onApply(_filter),
              child: const Text('Apply'),
            ),
          ],
        ),
      ),
    );
  }
}

String _priorityLabel(TaskPriority p) {
  switch (p) {
    case TaskPriority.p1:
      return 'P1';
    case TaskPriority.p2:
      return 'P2';
    case TaskPriority.p3:
      return 'P3';
    case TaskPriority.p4:
      return 'P4';
  }
}

String _statusFilterLabel(TaskStatusFilter s) {
  switch (s) {
    case TaskStatusFilter.all:
      return 'All';
    case TaskStatusFilter.pendingOnly:
      return 'Pending only';
    case TaskStatusFilter.completedOnly:
      return 'Completed only';
  }
}
