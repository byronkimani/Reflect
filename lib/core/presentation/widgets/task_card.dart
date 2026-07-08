import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/utils/task_due_format.dart';
import 'package:reflect/core/presentation/widgets/priority_lozenge.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final String taskRoutePrefix;

  const TaskCard({
    super.key,
    required this.task,
    this.taskRoutePrefix = '/today',
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _expanded = false;

  Task get task => widget.task;

  void _toggleExpand() {
    setState(() => _expanded = !_expanded);
  }

  Future<void> _onParentCheckboxChanged(bool? value) async {
    if (value == null) return;
    final bloc = context.read<TaskListBloc>();
    if (!value) {
      bloc.add(TaskListEvent.reopenTask(task.id));
      return;
    }
    if (task.hasSubtasks && !task.allSubtasksDone) {
      final choice = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Mark all subtasks done too?'),
          content: const Text(
            'Some subtasks are not complete. What would you like to do?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'parent'),
              child: const Text('Parent only'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, 'all'),
              child: const Text('Complete all'),
            ),
          ],
        ),
      );
      if (!mounted || choice == null || choice == 'cancel') return;
      if (choice == 'all') {
        for (final sub in task.subtasks.where((s) => !s.isCompleted)) {
          bloc.add(
            TaskListEvent.toggleSubtask(
              taskId: task.id,
              subtaskId: sub.id,
            ),
          );
        }
      }
    }
    bloc.add(TaskListEvent.completeTask(task.id));
  }

  Future<void> _onReschedule() async {
    final date = await showDatePicker(
      context: context,
      initialDate: task.dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (date != null && mounted) {
      context.read<TaskListBloc>().add(
            TaskListEvent.rescheduleTask(
              taskId: task.id,
              newDueDate: date,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isCompleted = task.status == TaskStatus.completed;
    final relativeDue = formatTaskRelativeDue(task);

    return RepaintBoundary(
      child: BlocBuilder<TaskSelectionCubit, TaskSelectionState>(
        buildWhen: (previous, current) {
          return previous.selectedTaskIds.contains(task.id) !=
                  current.selectedTaskIds.contains(task.id) ||
              previous.isSelectionMode != current.isSelectionMode;
        },
        builder: (context, selectionState) {
          final isSelected = selectionState.selectedTaskIds.contains(task.id);
          final isSelectionMode = selectionState.isSelectionMode;

          return Slidable(
            key: ValueKey(task.id),
            enabled: !isSelectionMode,
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: (_) {
                    context.read<TaskListBloc>().add(
                          TaskListEvent.deleteTask(task.id),
                        );
                  },
                  backgroundColor: colorScheme.error,
                  foregroundColor: colorScheme.onError,
                  icon: Icons.delete_outline,
                ),
              ],
            ),
            child: Card(
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              color: isSelected
                  ? ReflectColors.accentSoft
                  : ReflectColors.cardSurface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ReflectSpacing.cardRadius),
                side: isSelected
                    ? const BorderSide(color: ReflectColors.accentPrimary, width: 2)
                    : BorderSide.none,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isSelectionMode ? isSelected : isCompleted,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          onChanged: (value) {
                            if (isSelectionMode) {
                              context.read<TaskSelectionCubit>().toggleSelection(
                                    task.id,
                                  );
                            } else {
                              _onParentCheckboxChanged(value);
                            }
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              if (isSelectionMode) {
                                context
                                    .read<TaskSelectionCubit>()
                                    .toggleSelection(task.id);
                              } else {
                                _toggleExpand();
                              }
                            },
                            onLongPress: isSelectionMode
                                ? null
                                : () => context
                                    .read<TaskSelectionCubit>()
                                    .enterSelectionMode(task.id),
                            behavior: HitTestBehavior.opaque,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        task.title,
                                        style: textTheme.titleMedium?.copyWith(
                                          decoration: isCompleted && !isSelectionMode
                                              ? TextDecoration.lineThrough
                                              : null,
                                          color: isCompleted && !isSelectionMode
                                              ? ReflectColors.textSecondary
                                              : ReflectColors.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    if (relativeDue.isNotEmpty)
                                      Text(
                                        relativeDue,
                                        style: textTheme.bodySmall?.copyWith(
                                          color: ReflectColors.textSecondary,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 6,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    PriorityLozenge(
                                      priority: task.priority,
                                      compact: true,
                                    ),
                                    if (task.recurrenceRule != null)
                                      Icon(
                                        Icons.repeat,
                                        size: 16,
                                        color: ReflectColors.textSecondary,
                                      ),
                                    if (task.hasSubtasks)
                                      GestureDetector(
                                        onTap: _toggleExpand,
                                        child: _SubtaskChip(
                                          completed: task.completedSubtasks,
                                          total: task.subtasks.length,
                                          expanded: _expanded,
                                        ),
                                      ),
                                    ...task.tags.take(2).map(
                                          (tag) => _TagChip(
                                            name: tag.name,
                                            color: _parseColor(tag.colour),
                                          ),
                                        ),
                                    if (task.tags.length > 2)
                                      Text(
                                        '+${task.tags.length - 2}',
                                        style: textTheme.bodySmall?.copyWith(
                                          color: ReflectColors.textSecondary,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_expanded) ...[
                      if (task.hasSubtasks) ...[
                        const SizedBox(height: 8),
                        ...task.subtasks.map(
                          (sub) => Padding(
                            padding: const EdgeInsets.only(left: 48, bottom: 4),
                            child: Row(
                              children: [
                                Checkbox(
                                  value: sub.isCompleted,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                  onChanged: (_) {
                                    context.read<TaskListBloc>().add(
                                          TaskListEvent.toggleSubtask(
                                            taskId: task.id,
                                            subtaskId: sub.id,
                                          ),
                                        );
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    sub.title,
                                    style: textTheme.bodyMedium?.copyWith(
                                      decoration: sub.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: sub.isCompleted
                                          ? ReflectColors.textSecondary
                                          : ReflectColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      Padding(
                        padding: const EdgeInsets.only(left: 40, top: 4),
                        child: Row(
                          children: [
                            TextButton(
                              onPressed: () => context.push(
                                '${widget.taskRoutePrefix}/task/${task.id}',
                                extra: task,
                              ),
                              child: const Text('Edit'),
                            ),
                            TextButton(
                              onPressed: _onReschedule,
                              child: const Text('Reschedule'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _parseColor(String hex) {
    try {
      final value = hex.replaceFirst('#', '');
      return Color(int.parse('FF$value', radix: 16));
    } catch (_) {
      return ReflectColors.accentPrimary;
    }
  }
}

class _SubtaskChip extends StatelessWidget {
  final int completed;
  final int total;
  final bool expanded;

  const _SubtaskChip({
    required this.completed,
    required this.total,
    required this.expanded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: ReflectColors.inputSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.checklist_outlined, size: 14),
          const SizedBox(width: 4),
          Text(
            '$completed/$total',
            style: Theme.of(context).textTheme.labelSmall,
          ),
          Icon(
            expanded ? Icons.expand_less : Icons.expand_more,
            size: 16,
          ),
        ],
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String name;
  final Color color;

  const _TagChip({required this.name, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text(name, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
