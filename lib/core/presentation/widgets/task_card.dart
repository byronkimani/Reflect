import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reflect/core/presentation/widgets/priority_chip.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isCompleted = task.status == TaskStatus.completed;
    final isOverdue = task.isOverdue && !isCompleted;

    return Slidable(
      key: ValueKey(task.id),
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
        color: isOverdue
            ? colorScheme.errorContainer.withValues(alpha: 0.2)
            : isCompleted
                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
                : colorScheme.surfaceContainerLow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: isOverdue ? BorderSide(color: colorScheme.error, width: 1.5) : BorderSide.none,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: isCompleted,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              onChanged: (value) {
                if (value == null) return;
                if (value) {
                  context.read<TaskListBloc>().add(TaskListEvent.completeTask(task.id));
                } else {
                  context.read<TaskListBloc>().add(TaskListEvent.reopenTask(task.id));
                }
              },
            ),
          ),
        title: Text(
          task.title,
          style: textTheme.titleMedium?.copyWith(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? colorScheme.outline : colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: PriorityChip(priority: task.priority),
              ),
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
  }
}
