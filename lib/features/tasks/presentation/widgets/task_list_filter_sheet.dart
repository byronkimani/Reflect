import 'package:flutter/material.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

void showTaskListSortMenu(
  BuildContext context,
  TaskListBloc bloc,
  SortMode current,
) {
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
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ...SortMode.values.map((mode) {
            return ListTile(
              title: Text(sortModeLabel(mode)),
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

void showTaskListFilterSheet(
  BuildContext context,
  TaskListBloc bloc,
  TaskListFilter current,
) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (context) => TaskListFilterSheetContent(
      initialFilter: current,
      onApply: (filter) {
        bloc.add(TaskListEvent.filterChanged(filter));
        Navigator.of(context).pop();
      },
    ),
  );
}

String sortModeLabel(SortMode mode) {
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

class TaskListFilterSheetContent extends StatefulWidget {
  const TaskListFilterSheetContent({
    super.key,
    required this.initialFilter,
    required this.onApply,
  });

  final TaskListFilter initialFilter;
  final void Function(TaskListFilter filter) onApply;

  @override
  State<TaskListFilterSheetContent> createState() =>
      _TaskListFilterSheetContentState();
}

class _TaskListFilterSheetContentState extends State<TaskListFilterSheetContent> {
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
                  final selected = _filter.priorities != null &&
                      _filter.priorities!.contains(p);
                  return FilterChip(
                    label: Text(priorityLabel(p)),
                    selected: selected,
                    onSelected: (value) {
                      setState(() {
                        Set<TaskPriority>? next;
                        if (value == true) {
                          next = _filter.priorities == null
                              ? {p}
                              : Set<TaskPriority>.from(_filter.priorities!)..add(p);
                        } else {
                          if (_filter.priorities != null) {
                            final s =
                                Set<TaskPriority>.from(_filter.priorities!);
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
                  label: Text(statusFilterLabel(s)),
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

String priorityLabel(TaskPriority p) {
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

String statusFilterLabel(TaskStatusFilter s) {
  switch (s) {
    case TaskStatusFilter.all:
      return 'All';
    case TaskStatusFilter.pendingOnly:
      return 'Pending only';
    case TaskStatusFilter.completedOnly:
      return 'Completed only';
  }
}
