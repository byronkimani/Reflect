import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/widgets/expandable_section_row.dart';
import 'package:reflect/core/presentation/widgets/reflect_segmented_control.dart';
import 'package:reflect/core/presentation/widgets/reflect_pill.dart';
import 'package:reflect/core/presentation/widgets/reflect_primary_button.dart';
import 'package:reflect/core/presentation/widgets/reflect_soft_field.dart';
import 'package:reflect/core/presentation/widgets/reflect_sticky_bottom_bar.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/tasks/domain/entities/recurrence_rule.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/subtask_form_item.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_form/task_form_state.dart';
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
        analyticsService: getIt<AppAnalyticsService>(),
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

  DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  bool _isToday(DateTime? date) {
    if (date == null) return false;
    return _dateOnly(date) == _dateOnly(DateTime.now());
  }

  bool _isTomorrow(DateTime? date) {
    if (date == null) return false;
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return _dateOnly(date) == _dateOnly(tomorrow);
  }

  bool _isCustomDate(DateTime? date) {
    if (date == null) return false;
    return !_isToday(date) && !_isTomorrow(date);
  }

  String _formatTimeDisplay(String? dueTime) {
    if (dueTime == null || dueTime.isEmpty) return 'Add time';
    final parts = dueTime.split(':');
    if (parts.length < 2) return dueTime;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    return DateFormat.jm().format(DateTime(2000, 1, 1, hour, minute));
  }

  void _openExtrasSheet(BuildContext context, TaskFormState state) {
    final cubit = context.read<TaskFormCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Notes, goal & tags',
                  style: Theme.of(ctx).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                ReflectSoftField(
                  labelText: 'Notes',
                  hintText: 'Add details or context...',
                  maxLines: 4,
                  initialValue: state.notes,
                  onChanged: cubit.notesChanged,
                ),
                if (state.availableGoals.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String?>(
                    key: ValueKey(state.selectedGoalId),
                    initialValue: state.selectedGoalId != null &&
                            state.availableGoals
                                .any((g) => g.id == state.selectedGoalId)
                        ? state.selectedGoalId
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Goal',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('None'),
                      ),
                      ...state.availableGoals.map(
                        (g) => DropdownMenuItem<String?>(
                          value: g.id,
                          child: Text(g.title, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                    onChanged: cubit.goalIdChanged,
                  ),
                ],
                const SizedBox(height: 24),
                ReflectPrimaryButton(
                  label: 'Done',
                  icon: Icons.check_circle_outline,
                  onPressed: () {
                    FocusScope.of(ctx).unfocus();
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskFormCubit, TaskFormState>(
      listener: (context, state) {
        if (state.isSuccess) context.pop();
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
        final textTheme = Theme.of(context).textTheme;
        final bottomPadding = MediaQuery.paddingOf(context).bottom;
        final cubit = context.read<TaskFormCubit>();

        return PopScope(
          canPop: !state.isModified,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            if (await _showDiscardDialog(context) && context.mounted) {
              context.pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  if (state.isModified) {
                    if (await _showDiscardDialog(context) && context.mounted) {
                      context.pop();
                    }
                  } else {
                    context.pop();
                  }
                },
              ),
              title: Text(
                state.initialTask == null ? 'New Task' : 'Edit Task',
              ),
              actions: [
                if (state.initialTask != null &&
                    state.dueDate != null &&
                    !state.isSubmitting)
                  TextButton(
                    onPressed: cubit.moveToBacklog,
                    child: const Text('Add to backlog'),
                  ),
                if (state.isSubmitting)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 100 + bottomPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    focusNode: _titleFocusNode,
                    initialValue: state.title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'What needs doing?',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: ReflectColors.hairline),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ReflectColors.hairline),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: ReflectColors.ink, width: 2),
                      ),
                    ),
                    onChanged: cubit.titleChanged,
                  ),
                  const SizedBox(height: 20),
                  ReflectSegmentedControl.priority(
                    selected: state.priority,
                    onChanged: cubit.priorityChanged,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'When',
                    style: textTheme.labelLarge?.copyWith(
                      color: ReflectColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      ReflectPill(
                        label: 'Today',
                        selected: _isToday(state.dueDate),
                        onTap: () {
                          if (_isToday(state.dueDate)) {
                            cubit.clearDueDate();
                          } else {
                            cubit.setDueToday();
                          }
                        },
                      ),
                      ReflectPill(
                        label: 'Tomorrow',
                        selected: _isTomorrow(state.dueDate),
                        onTap: () {
                          if (_isTomorrow(state.dueDate)) {
                            cubit.clearDueDate();
                          } else {
                            cubit.setDueTomorrow();
                          }
                        },
                      ),
                      ReflectPill(
                        label: _isCustomDate(state.dueDate)
                            ? DateFormat('MMM d').format(state.dueDate!)
                            : 'Pick date',
                        selected: _isCustomDate(state.dueDate),
                        leadingIcon: Icons.calendar_today_outlined,
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
                          if (date != null) cubit.dueDateChanged(date);
                        },
                        onClear: _isCustomDate(state.dueDate)
                            ? cubit.clearDueDate
                            : null,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ReflectPill(
                    label: _formatTimeDisplay(state.dueTime),
                    selected: state.dueTime != null && state.dueTime!.isNotEmpty,
                    leadingIcon: Icons.access_time,
                    onTap: () async {
                      var initial = const TimeOfDay(hour: 9, minute: 0);
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
                      if (time != null) {
                        cubit.dueTimeChanged(
                          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                        );
                      }
                    },
                    onClear: state.dueTime != null && state.dueTime!.isNotEmpty
                        ? cubit.clearDueTime
                        : null,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Remind me when due'),
                    value: state.hasEnabledReminder,
                    onChanged: cubit.hasEnabledReminderChanged,
                    activeThumbColor: ReflectColors.accentPrimary,
                  ),
                  ExpandableSectionRow(
                    title: 'Repeats',
                    icon: Icons.repeat,
                    expanded: state.isRepeating,
                    onTap: cubit.toggleRepeatsExpanded,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SegmentedButton<RecurrenceFrequency>(
                          segments: const [
                            ButtonSegment(
                              value: RecurrenceFrequency.DAILY,
                              label: Text('Daily'),
                            ),
                            ButtonSegment(
                              value: RecurrenceFrequency.WEEKLY,
                              label: Text('Weekly'),
                            ),
                          ],
                          selected: {
                            state.recurrenceFrequency ??
                                RecurrenceFrequency.DAILY,
                          },
                          onSelectionChanged: (s) {
                            if (s.isNotEmpty) {
                              cubit.recurrenceFrequencyChanged(s.first);
                            }
                          },
                        ),
                        if (state.recurrenceFrequency ==
                            RecurrenceFrequency.WEEKLY) ...[
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            children: [
                              _DayPresetChip(
                                label: 'Weekdays',
                                isSelected: _listEquals(
                                  state.recurrenceDaysOfWeek,
                                  weekdaysPreset,
                                ),
                                onTap: () => cubit.recurrenceDaysOfWeekChanged(
                                  weekdaysPreset,
                                ),
                              ),
                              _DayPresetChip(
                                label: 'Every day',
                                isSelected: _listEquals(
                                  state.recurrenceDaysOfWeek,
                                  everyDayPreset,
                                ),
                                onTap: () => cubit.recurrenceDaysOfWeekChanged(
                                  everyDayPreset,
                                ),
                              ),
                              _DayPresetChip(
                                label: 'Weekend',
                                isSelected: _listEquals(
                                  state.recurrenceDaysOfWeek,
                                  weekendPreset,
                                ),
                                onTap: () => cubit.recurrenceDaysOfWeekChanged(
                                  weekendPreset,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Subtasks',
                    style: textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...state.subtaskItems.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return _SubtaskFormTile(
                      key: ValueKey(item.id),
                      item: item,
                      index: index,
                      isLast: index == state.subtaskItems.length - 1,
                      focusNode:
                          index == state.subtaskItems.length - 1
                              ? _lastSubtaskFocusNode
                              : null,
                      onToggle: () =>
                          cubit.toggleSubtaskCompletedAt(index),
                      onTitleChanged: (v) => cubit.updateSubtaskAt(index, v),
                      onDelete: () => cubit.removeSubtaskAt(index),
                    );
                  }),
                  TextButton.icon(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      cubit.addSubtask('');
                    },
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add step'),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Notes, goal & tags'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _openExtrasSheet(context, state),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: ReflectStickyBottomBar(
              child: ReflectPrimaryButton(
                label: state.initialTask == null
                    ? 'Create Task'
                    : 'Save Changes',
                icon: Icons.check_circle_outline,
                isLoading: state.isSubmitting,
                onPressed: state.isSubmitting ? null : cubit.submit,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _showDiscardDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Discard changes?'),
            content: const Text(
              'You have unsaved changes. Are you sure you want to discard them?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Keep Editing'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Discard'),
              ),
            ],
          ),
        ) ??
        false;
  }
}

bool _listEquals(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

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

class _SubtaskFormTile extends StatefulWidget {
  const _SubtaskFormTile({
    super.key,
    required this.item,
    required this.index,
    required this.isLast,
    this.focusNode,
    required this.onToggle,
    required this.onTitleChanged,
    required this.onDelete,
  });

  final SubtaskFormItem item;
  final int index;
  final bool isLast;
  final FocusNode? focusNode;
  final VoidCallback onToggle;
  final ValueChanged<String> onTitleChanged;
  final VoidCallback onDelete;

  @override
  State<_SubtaskFormTile> createState() => _SubtaskFormTileState();
}

class _SubtaskFormTileState extends State<_SubtaskFormTile> {
  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Slidable(
        key: ValueKey(item.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => widget.onDelete(),
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
            ),
          ],
        ),
        child: Row(
          children: [
            Checkbox(
              value: item.isCompleted,
              onChanged: (_) => widget.onToggle(),
            ),
            Expanded(
              child: TextFormField(
                focusNode: widget.focusNode,
                initialValue: item.title,
                decoration: InputDecoration(
                  hintText: 'Step ${widget.index + 1}',
                  border: InputBorder.none,
                ),
                onChanged: widget.onTitleChanged,
                onFieldSubmitted: (_) {
                  if (widget.isLast) {
                    context.read<TaskFormCubit>().addSubtask('');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
