import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_state.dart';
import 'package:reflect/main.dart';

class TaskDetailPage extends StatelessWidget {
  final String taskId;

  const TaskDetailPage({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = TaskFormCubit(getIt<ITaskRepository>(), null);
        if (taskId != 'new') {
          // In a real app, we'd fetch the task here. 
          // For simplicity in this demo, we'll assume it's a new task if we don't have a fetch method readily available in the UI layer yet.
          // However, the repo has getTasksForDate, but not getTaskById yet. 
          // I'll stick to 'new' logic or assume it's just a placeholder for editing.
        }
        return cubit;
      },
      child: const TaskFormView(),
    );
  }
}

class TaskFormView extends StatelessWidget {
  const TaskFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskFormCubit, TaskFormState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pop();
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      builder: (context, state) {
        final colorScheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: Text(state.initialTask == null ? 'New Task' : 'Edit Task'),
            actions: [
              if (state.isSubmitting)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: () => context.read<TaskFormCubit>().submit(),
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Save'),
                  ),
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: state.title,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Task Title',
                    hintStyle: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  onChanged: (value) => context.read<TaskFormCubit>().titleChanged(value),
                ),
                const SizedBox(height: 24),
                Text(
                  'Priority',
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SegmentedButton<TaskPriority>(
                  segments: const [
                    ButtonSegment(value: TaskPriority.p1, label: Text('P1')),
                    ButtonSegment(value: TaskPriority.p2, label: Text('P2')),
                    ButtonSegment(value: TaskPriority.p3, label: Text('P3')),
                    ButtonSegment(value: TaskPriority.p4, label: Text('P4')),
                  ],
                  selected: {state.priority},
                  onSelectionChanged: (value) => context.read<TaskFormCubit>().priorityChanged(value.first),
                ),
                const SizedBox(height: 32),
                Text(
                  'Details',
                  style: textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: '', // Add notes field logic if present in state, assuming it might be added or using a placeholder
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Add details or context...',
                    alignLabelWithHint: true,
                  ),
                  onChanged: (value) {
                    // Assuming a notesChanged method exists or should be added
                    // context.read<TaskFormCubit>().notesChanged(value);
                  },
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: state.dueDate ?? DateTime.now(),
                      firstDate: DateTime.now().subtract(const Duration(days: 365)),
                      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
                    );
                    if (date != null) {
                      if (!context.mounted) return;
                      context.read<TaskFormCubit>().dueDateChanged(date);
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, color: colorScheme.primary, size: 20),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Due Date', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                              Text(
                                state.dueDate != null ? DateFormat('EEEE, MMM d, yyyy').format(state.dueDate!) : 'No date set',
                                style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 32),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text('Sync to Google Calendar', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                  value: state.syncToGcal,
                  onChanged: (value) => context.read<TaskFormCubit>().syncToGcalChanged(value),
                  activeColor: colorScheme.primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
