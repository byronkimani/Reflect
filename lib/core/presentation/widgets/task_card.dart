import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/core/presentation/widgets/priority_badge.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;
    final isOverdue = task.isOverdue && !isCompleted;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: isOverdue 
          ? Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.5)
          : isCompleted 
              ? Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isOverdue 
            ? BorderSide(color: Theme.of(context).colorScheme.error, width: 1)
            : BorderSide.none,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Checkbox(
          value: isCompleted,
          onChanged: (value) {
            if (value != null && value) {
              context.read<TaskListBloc>().add(CompleteTask(task.id));
            }
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: isCompleted ? TextDecoration.lineThrough : null,
            color: isCompleted ? Colors.grey : null,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Row(
          children: [
            PriorityBadge(priority: task.priority),
            if (task.subtasks.isNotEmpty) ...[
              const SizedBox(width: 8),
              Icon(Icons.list, size: 14, color: Colors.grey[600]),
              const SizedBox(width: 2),
              Text(
                '${task.subtasks.where((s) => s.isCompleted).length}/${task.subtasks.length}',
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
            ],
            if (task.syncToGcal) ...[
              const SizedBox(width: 8),
              Icon(Icons.sync, size: 14, color: Colors.grey[600]),
            ],
            if (isOverdue) ...[
              const Spacer(),
              const Text(
                'Overdue',
                style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
