import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/subtask_form_item.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_state.dart';
import 'package:reflect/core/presentation/widgets/priority_chip.dart';
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
        }
        return cubit;
      },
      child: const TaskFormView(),
    );
  }
}

class TaskFormView extends StatefulWidget {
  const TaskFormView({super.key});

  @override
  State<TaskFormView> createState() => _TaskFormViewState();
}

class _TaskFormViewState extends State<TaskFormView> {
  final FocusNode _titleFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    super.dispose();
  }

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
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final textTheme = theme.textTheme;
        final bottomPadding = MediaQuery.paddingOf(context).bottom;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
            title: Text(state.initialTask == null ? 'New Task' : 'Edit Task'),
            actions: [
              if (state.isSubmitting)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: TextButton(
                    onPressed: () => context.read<TaskFormCubit>().submit(),
                    child: const Text('Save'),
                  ),
                ),
            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title – no border when focused
                TextFormField(
                  focusNode: _titleFocusNode,
                  initialValue: state.title,
                  style: textTheme.headlineSmall,
                  autocorrect: true,
                  enableSuggestions: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Task Title',
                    hintStyle: textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.6,
                      ),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) =>
                      context.read<TaskFormCubit>().titleChanged(value),
                ),
                const SizedBox(height: 24),
                Text(
                  'Priority',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: TaskPriority.values.map((priority) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: PriorityChip(
                        priority: priority,
                        isSelected: state.priority == priority,
                        onTap: () => context
                            .read<TaskFormCubit>()
                            .priorityChanged(priority),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Text(
                  'Sub Tasks',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                ...state.subtaskItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return _SubtaskFormTile(
                    key: ValueKey(item.id),
                    item: item,
                    index: index,
                    onToggle: () => context
                        .read<TaskFormCubit>()
                        .toggleSubtaskCompletedAt(index),
                    onTitleChanged: (value) => context
                        .read<TaskFormCubit>()
                        .updateSubtaskAt(index, value),
                    onDelete: () =>
                        context.read<TaskFormCubit>().removeSubtaskAt(index),
                  );
                }),
                OutlinedButton.icon(
                  onPressed: () {
                    context.read<TaskFormCubit>().addSubtask('');
                  },
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Add Sub Task'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: state.dueDate ?? DateTime.now(),
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 365),
                      ),
                      lastDate: DateTime.now().add(
                        const Duration(days: 365 * 5),
                      ),
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
                        Icon(
                          Icons.calendar_today_outlined,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Due Date',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                state.dueDate != null
                                    ? DateFormat(
                                        'EEEE, MMM d, yyyy',
                                      ).format(state.dueDate!)
                                    : 'No date set',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Details',
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                // Details – no border when focused
                TextFormField(
                  initialValue: state.notes,
                  maxLines: 5,
                  autocorrect: true,
                  enableSuggestions: true,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    hintText: 'Add details or context...',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    filled: true,
                    fillColor: colorScheme.surfaceContainerHighest.withValues(
                      alpha: 0.3,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  onChanged: (value) =>
                      context.read<TaskFormCubit>().notesChanged(value),
                ),
                const Divider(height: 32),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Sync to Google Calendar',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: state.syncToGcal,
                  onChanged: (value) =>
                      context.read<TaskFormCubit>().syncToGcalChanged(value),
                  activeThumbColor: colorScheme.primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// One subtask row: checkbox, title (editable), swipe to delete. No due date (inherits from parent).
class _SubtaskFormTile extends StatelessWidget {
  final SubtaskFormItem item;
  final int index;
  final VoidCallback onToggle;
  final ValueChanged<String> onTitleChanged;
  final VoidCallback onDelete;

  const _SubtaskFormTile({
    super.key,
    required this.item,
    required this.index,
    required this.onToggle,
    required this.onTitleChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (_) => onDelete(),
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              icon: Icons.delete_outline,
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: item.isCompleted
              ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
              : colorScheme.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            leading: Checkbox(
              value: item.isCompleted,
              onChanged: (_) => onToggle(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: TextFormField(
              initialValue: item.title,
              style: textTheme.titleMedium?.copyWith(
                decoration: item.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
                color: item.isCompleted
                    ? colorScheme.outline
                    : colorScheme.onSurface,
              ),
              autocorrect: true,
              enableSuggestions: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Step ${index + 1}',
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 0,
                ),
              ),
              onChanged: onTitleChanged,
            ),
          ),
        ),
      ),
    );
  }
}
