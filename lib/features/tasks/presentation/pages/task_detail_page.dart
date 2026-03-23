import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/subtask_form_item.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_state.dart';
import 'package:reflect/core/presentation/widgets/priority_chip.dart';
import 'package:reflect/main.dart';

class TaskDetailPage extends StatelessWidget {
  final String taskId;
  final Task? initialTask;
  final bool isBacklogContext;

  const TaskDetailPage({
    super.key,
    required this.taskId,
    this.initialTask,
    this.isBacklogContext = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskFormCubit(
        getIt<ITaskRepository>(),
        getIt<IGoalRepository>(),
        initialTask,
        isBacklogContext: isBacklogContext,
      ),
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
  final FocusNode _lastSubtaskFocusNode = FocusNode();

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
    _lastSubtaskFocusNode.dispose();
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
              if (state.initialTask != null &&
                  (state.dueDate != null || (state.dueTime != null && state.dueTime!.isNotEmpty)) &&
                  !state.isSubmitting)
                TextButton.icon(
                  onPressed: () async {
                    await context.read<TaskFormCubit>().moveToBacklog();
                  },
                  icon: const Icon(Icons.inventory_2_outlined, size: 20),
                  label: const Text('Add to backlog'),
                ),
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
                ),

            ],
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 80 + bottomPadding),
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
                if (state.availableGoals.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  Text(
                    'Goal (optional)',
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String?>(
                    value: state.selectedGoalId != null &&
                            state.availableGoals
                                .any((g) => g.id == state.selectedGoalId)
                        ? state.selectedGoalId
                        : null,
                    decoration: InputDecoration(
                      hintText: 'Link to a goal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    isExpanded: true,
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('None'),
                      ),
                      ...state.availableGoals.map(
                        (g) => DropdownMenuItem<String?>(
                          value: g.id,
                          child: Text(
                            g.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (id) =>
                        context.read<TaskFormCubit>().goalIdChanged(id),
                  ),
                ],
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
                  final isLast = index == state.subtaskItems.length - 1;
                  return _SubtaskFormTile(
                    key: ValueKey(item.id),
                    item: item,
                    index: index,
                    focusNode: isLast ? _lastSubtaskFocusNode : null,
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
                    FocusManager.instance.primaryFocus?.unfocus();
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
                const SizedBox(height: 16),
                // Optional time
                InkWell(
                  onTap: () async {
                    TimeOfDay initial = const TimeOfDay(hour: 9, minute: 0);
                    if (state.dueTime != null && state.dueTime!.isNotEmpty) {
                      final parts = state.dueTime!.split(':');
                      if (parts.length >= 2) {
                        initial = TimeOfDay(
                          hour: int.tryParse(parts[0]) ?? 9,
                          minute: int.tryParse(parts[1]) ?? 0,
                        );
                      }
                    }
                    final time = await showTimePicker(
                      context: context,
                      initialTime: initial,
                    );
                    if (time != null && context.mounted) {
                      context.read<TaskFormCubit>().dueTimeChanged(
                            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                          );
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time (optional)',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                state.dueTime != null && state.dueTime!.isNotEmpty
                                    ? state.dueTime!
                                    : 'No time set',
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
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Remind me when due',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: state.hasEnabledReminder,
                  onChanged: (value) => context
                      .read<TaskFormCubit>()
                      .hasEnabledReminderChanged(value),
                  activeThumbColor: colorScheme.primary,
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Repeats',
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: state.isRepeating,
                  onChanged: (value) => context
                      .read<TaskFormCubit>()
                      .isRepeatingChanged(value),
                  activeThumbColor: colorScheme.primary,
                ),
                if (state.isRepeating) ...[
                  const SizedBox(height: 12),
                  SegmentedButton<RecurrenceFrequency>(
                    segments: const [
                      ButtonSegment<RecurrenceFrequency>(
                        value: RecurrenceFrequency.DAILY,
                        label: Text('Daily'),
                        icon: Icon(Icons.today_outlined, size: 18),
                      ),
                      ButtonSegment<RecurrenceFrequency>(
                        value: RecurrenceFrequency.WEEKLY,
                        label: Text('Weekly'),
                        icon: Icon(Icons.date_range_outlined, size: 18),
                      ),
                    ],
                    selected: {state.recurrenceFrequency ?? RecurrenceFrequency.DAILY},
                    onSelectionChanged: (Set<RecurrenceFrequency> selected) {
                      context.read<TaskFormCubit>().recurrenceFrequencyChanged(
                            selected.first,
                          );
                    },
                  ),
                  if (state.recurrenceFrequency == RecurrenceFrequency.WEEKLY) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _DayPresetChip(
                          label: 'Weekdays',
                          isSelected: _listEquals(
                            state.recurrenceDaysOfWeek,
                            weekdaysPreset,
                          ),
                          onTap: () => context
                              .read<TaskFormCubit>()
                              .recurrenceDaysOfWeekChanged(weekdaysPreset),
                        ),
                        _DayPresetChip(
                          label: 'Every day',
                          isSelected: _listEquals(
                            state.recurrenceDaysOfWeek,
                            everyDayPreset,
                          ),
                          onTap: () => context
                              .read<TaskFormCubit>()
                              .recurrenceDaysOfWeekChanged(everyDayPreset),
                        ),
                        _DayPresetChip(
                          label: 'Weekend',
                          isSelected: _listEquals(
                            state.recurrenceDaysOfWeek,
                            weekendPreset,
                          ),
                          onTap: () => context
                              .read<TaskFormCubit>()
                              .recurrenceDaysOfWeekChanged(weekendPreset),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Custom',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                          .asMap()
                          .entries
                          .map((e) {
                        final weekday = e.key + 1; // 1 = Mon .. 7 = Sun
                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: FilterChip(
                            label: Text(e.value),
                            selected: state.recurrenceDaysOfWeek.contains(weekday),
                            onSelected: (_) => context
                                .read<TaskFormCubit>()
                                .toggleRecurrenceDay(weekday),
                            showCheckmark: true,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: state.isSubmitting
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FloatingActionButton.extended(
                      onPressed: () => context.read<TaskFormCubit>().submit(),
                      label: Text(
                        state.initialTask == null ? 'Create Task' : 'Save Changes',
                        style: textTheme.titleMedium?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: const Icon(Icons.check_circle_outline),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

bool _listEquals(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// Preset chip for weekly recurrence (Weekdays, Every day, Weekend).
class _DayPresetChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DayPresetChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      showCheckmark: true,
    );
  }
}

/// One subtask row: checkbox, title (editable), swipe to delete. No due date (inherits from parent).
/// When [focusNode] is provided (for the last subtask), focus is requested when the tile is first built.
class _SubtaskFormTile extends StatefulWidget {
  const _SubtaskFormTile({
    super.key,
    required this.item,
    required this.index,
    this.focusNode,
    required this.onToggle,
    required this.onTitleChanged,
    required this.onDelete,
  });

  final SubtaskFormItem item;
  final int index;
  final FocusNode? focusNode;
  final VoidCallback onToggle;
  final ValueChanged<String> onTitleChanged;
  final VoidCallback onDelete;

  @override
  State<_SubtaskFormTile> createState() => _SubtaskFormTileState();
}

class _SubtaskFormTileState extends State<_SubtaskFormTile> {
  bool _focusRequested = false;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_focusRequested && mounted) {
          _focusRequested = true;
          widget.focusNode!.requestFocus();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant _SubtaskFormTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != null && widget.focusNode != oldWidget.focusNode) {
      _focusRequested = false;
    }
    if (widget.focusNode != null && !_focusRequested) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_focusRequested && mounted) {
          _focusRequested = true;
          widget.focusNode!.requestFocus();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final item = widget.item;
    final index = widget.index;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (_) => widget.onDelete(),
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
              onChanged: (_) => widget.onToggle(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            title: TextFormField(
              focusNode: widget.focusNode,
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
              onChanged: widget.onTitleChanged,
            ),
          ),
        ),
      ),
    );
  }
}
