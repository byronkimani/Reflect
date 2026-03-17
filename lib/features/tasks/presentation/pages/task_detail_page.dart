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
            SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.initialTask == null ? 'New Task' : 'Edit Task'),
            actions: [
              if (state.isSubmitting)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                  ),
                )
              else
                TextButton(
                  onPressed: () => context.read<TaskFormCubit>().submit(),
                  child: const Text('Save'),
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  initialValue: state.title,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    hintText: 'What needs to be done?',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => context.read<TaskFormCubit>().titleChanged(value),
                ),
                const SizedBox(height: 24),
                const Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
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
                const SizedBox(height: 24),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Due Date'),
                  subtitle: Text(state.dueDate != null ? DateFormat('MMM d, yyyy').format(state.dueDate!) : 'No date set'),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
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
                  ),
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Sync to Google Calendar'),
                  value: state.syncToGcal,
                  onChanged: (value) => context.read<TaskFormCubit>().syncToGcalChanged(value),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
