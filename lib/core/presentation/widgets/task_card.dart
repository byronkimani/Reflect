import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/widgets/priority_chip.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  /// Route prefix for task detail (e.g. '/today' or '/backlog'). Defaults to '/today'.
  final String taskRoutePrefix;

  const TaskCard({super.key, required this.task, this.taskRoutePrefix = '/today'});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isCompleted = task.status == TaskStatus.completed;
    final isOverdue = task.isOverdue && !isCompleted;

    return BlocBuilder<TaskSelectionCubit, TaskSelectionState>(
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
                  context.read<TaskListBloc>().add(TaskListEvent.deleteTask(task.id));
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
                ? colorScheme.primaryContainer.withValues(alpha: 0.5)
                : isOverdue
                    ? colorScheme.errorContainer.withValues(alpha: 0.25)
                    : isCompleted
                        ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5)
                        : colorScheme.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: isSelected
                  ? BorderSide(color: colorScheme.primary, width: 2)
                  : isOverdue
                      ? BorderSide(color: colorScheme.error, width: 1.5)
                      : BorderSide.none,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onTap: () {
                if (isSelectionMode) {
                  context.read<TaskSelectionCubit>().toggleSelection(task.id);
                } else {
                  context.push('$taskRoutePrefix/task/${task.id}', extra: task);
                }
              },
              onLongPress: () {
                if (!isSelectionMode) {
                  context.read<TaskSelectionCubit>().enterSelectionMode(task.id);
                }
              },
              leading: Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: isSelectionMode ? isSelected : isCompleted,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  onChanged: (value) {
                    if (value == null) return;
                    if (isSelectionMode) {
                      context.read<TaskSelectionCubit>().toggleSelection(task.id);
                    } else {
                      if (value) {
                        context.read<TaskListBloc>().add(TaskListEvent.completeTask(task.id));
                      } else {
                        context.read<TaskListBloc>().add(TaskListEvent.reopenTask(task.id));
                      }
                    }
                  },
                ),
              ),
              title: Text(
                task.title,
                style: textTheme.titleMedium?.copyWith(
                  decoration: (isCompleted && !isSelectionMode) ? TextDecoration.lineThrough : null,
                  color: (isCompleted && !isSelectionMode)
                      ? colorScheme.outline
                      : isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: PriorityChip(priority: task.priority, compact: true),
                    ),
                    if (task.recurrenceRule != null) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.repeat, size: 16, color: colorScheme.onSurfaceVariant),
                    ],
                    if (task.subtasks.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      Icon(Icons.checklist_outlined, size: 16, color: colorScheme.onSurfaceVariant),
                      const SizedBox(width: 4),
                      Text(
                        '${task.subtasks.where((s) => s.isCompleted).length}/${task.subtasks.length}',
                        style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                    if (task.syncToGcal) ...[
                      const SizedBox(width: 12),
                      Icon(Icons.sync, size: 16, color: colorScheme.onSurfaceVariant),
                    ],
                    if (isOverdue) ...[
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'OVERDUE',
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onError,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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
