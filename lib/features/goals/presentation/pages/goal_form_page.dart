import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/widgets/priority_chip.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goal_form_cubit.dart';
import 'package:reflect/features/goals/presentation/cubit/goal_form_state.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/main.dart';

class GoalFormPage extends StatelessWidget {
  const GoalFormPage({
    super.key,
    this.initialGoal,
    this.timeHorizon,
    IGoalRepository? goalRepo,
    Stream<dynamic>? categoriesStream,
  }) : _goalRepo = goalRepo,
       _categoriesStream = categoriesStream;

  final Goal? initialGoal;
  final GoalTimeHorizon? timeHorizon;
  final IGoalRepository? _goalRepo;
  final Stream<dynamic>? _categoriesStream;

  IGoalRepository get _repo => _goalRepo ?? getIt<IGoalRepository>();
  Stream<dynamic> get _categories =>
      _categoriesStream ?? getIt<IGoalRepository>().watchCategories();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GoalFormCubit(
        _repo,
        initialGoal: initialGoal,
        timeHorizon: timeHorizon,
      ),
      child: _GoalFormView(categoriesStream: _categories, goalRepo: _repo),
    );
  }
}

class _GoalFormView extends StatelessWidget {
  const _GoalFormView({required this.categoriesStream, required this.goalRepo});

  final Stream<dynamic> categoriesStream;
  final IGoalRepository goalRepo;

  static const int _maxWordsDescription = 120;
  static const int _maxWordsWhy = 120;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoalFormCubit, GoalFormState>(
      listener: (context, state) {
        if (state.isSuccess) context.pop();
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;
        final textTheme = theme.textTheme;

        return PopScope(
          canPop: !state.isModified,
          onPopInvokedWithResult: (bool didPop, dynamic result) async {
            if (didPop) return;
            final shouldDiscard = await _showDiscardDialog(context);
            if (shouldDiscard && context.mounted) {
              context.pop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  if (state.isModified) {
                    final shouldDiscard = await _showDiscardDialog(context);
                    if (shouldDiscard && context.mounted) {
                      context.pop();
                    }
                  } else {
                    context.pop();
                  }
                },
              ),
              title: Text(state.initialGoal == null ? 'New Goal' : 'Edit Goal'),
              actions: [
                if (state.isSubmitting)
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder<dynamic>(
                stream: categoriesStream,
                builder: (context, snapshot) {
                  final categories = snapshot.hasData && snapshot.data != null
                      ? (snapshot.data!.fold(
                          (l) => <GoalCategory>[],
                          (r) => r as List<GoalCategory>,
                        ))
                      : <GoalCategory>[];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Title *',
                        style: textTheme.titleSmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      TextFormField(
                        initialValue: state.title,
                        decoration: const InputDecoration(
                          hintText: 'Goal title',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: context.read<GoalFormCubit>().titleChanged,
                      ),
                      const SizedBox(height: 20),
                      if (state.initialGoal == null) ...[
                        _sectionLabel(textTheme, colorScheme, 'Time Frame'),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SegmentedButton<GoalTimeHorizon>(
                            segments: GoalTimeHorizon.values
                                .map(
                                  (h) => ButtonSegment<GoalTimeHorizon>(
                                    value: h,
                                    label: Text(
                                      h.name[0].toUpperCase() +
                                          h.name.substring(1),
                                    ),
                                  ),
                                )
                                .toList(),
                            selected: {state.timeHorizon},
                            onSelectionChanged: (s) {
                              if (s.isNotEmpty) {
                                context
                                    .read<GoalFormCubit>()
                                    .timeHorizonChanged(s.first);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Category (optional)',
                      ),
                      _CategorySelector(
                        categories: categories,
                        selectedId: state.categoryId,
                        onSelected: (id) =>
                            context.read<GoalFormCubit>().categoryIdChanged(id),
                        onManageCategories: () => _openManageCategories(
                          context,
                          categories,
                          goalRepo,
                        ),
                      ),
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Is the KPI measurable?',
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<bool>(
                        segments: const [
                          ButtonSegment<bool>(
                            value: true,
                            label: Text('Yes'),
                            icon: Icon(Icons.check_circle_outline),
                          ),
                          ButtonSegment<bool>(
                            value: false,
                            label: Text('No'),
                            icon: Icon(Icons.cancel_outlined),
                          ),
                        ],
                        selected: {state.isMeasurable},
                        onSelectionChanged: (s) {
                          if (s.isNotEmpty) {
                            context.read<GoalFormCubit>().isMeasurableChanged(
                              s.first,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      if (state.isMeasurable) ...[
                        _sectionLabel(
                          textTheme,
                          colorScheme,
                          'KPI being tracked (optional)',
                        ),
                        TextFormField(
                          initialValue: state.kpiDescription ?? '',
                          decoration: const InputDecoration(
                            hintText: 'What KPI measures progress?',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (v) => context
                              .read<GoalFormCubit>()
                              .kpiDescriptionChanged(v.isEmpty ? null : v),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Start value',
                                    style: textTheme.labelMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    initialValue: state.startValue ?? '',
                                    decoration: const InputDecoration(
                                      hintText: 'Start',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                    onChanged: (v) => context
                                        .read<GoalFormCubit>()
                                        .startValueChanged(
                                          v.isEmpty ? null : v,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Target value',
                                    style: textTheme.labelMedium,
                                  ),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    initialValue: state.targetValue ?? '',
                                    decoration: const InputDecoration(
                                      hintText: 'Target',
                                      border: OutlineInputBorder(),
                                      isDense: true,
                                    ),
                                    onChanged: (v) => context
                                        .read<GoalFormCubit>()
                                        .targetValueChanged(
                                          v.isEmpty ? null : v,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Priority (optional)',
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 12,
                        children: TaskPriority.values.map((p) {
                          final showLabel =
                              p == TaskPriority.p1 || p == TaskPriority.p4;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PriorityChip(
                                priority: p,
                                compact: false,
                                isSelected: state.priority == p,
                                onTap: () => context
                                    .read<GoalFormCubit>()
                                    .priorityChanged(
                                      state.priority == p ? null : p,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              if (showLabel)
                                Text(
                                  PriorityChip.labelFor(p),
                                  style: textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              else
                                const SizedBox(
                                  height: 14,
                                ), // placeholder for text height
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Urgency (optional)',
                      ),
                      Wrap(
                        spacing: 8,
                        runSpacing: 12,
                        children: TaskPriority.values.map((p) {
                          final showLabel =
                              p == TaskPriority.p1 || p == TaskPriority.p4;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              PriorityChip(
                                priority: p,
                                compact: false,
                                isSelected: state.urgency == p,
                                onTap: () => context
                                    .read<GoalFormCubit>()
                                    .urgencyChanged(
                                      state.urgency == p ? null : p,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              if (showLabel)
                                Text(
                                  PriorityChip.labelFor(p),
                                  style: textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              else
                                const SizedBox(
                                  height: 14,
                                ), // placeholder for text height
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Why this goal (optional, ~$_maxWordsWhy words)',
                      ),
                      TextFormField(
                        initialValue: state.why ?? '',
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: 'Why you are setting this goal',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        onChanged: (v) => context
                            .read<GoalFormCubit>()
                            .whyChanged(v.isEmpty ? null : v),
                      ),
                      const SizedBox(height: 20),
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Start date (optional)',
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          state.startDate != null
                              ? DateFormat.yMMMd().format(state.startDate!)
                              : 'Pick start date',
                          style: textTheme.bodyLarge,
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: state.startDate ?? DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (date != null && context.mounted) {
                            context.read<GoalFormCubit>().startDateChanged(
                              date,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 8),
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Target date (optional)',
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          state.targetDate != null
                              ? DateFormat.yMMMd().format(state.targetDate!)
                              : 'Pick target date',
                          style: textTheme.bodyLarge,
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate:
                                state.targetDate ??
                                state.startDate ??
                                DateTime.now(),
                            firstDate: state.startDate ?? DateTime(2020),
                            lastDate: DateTime(2100),
                          );
                          if (date != null && context.mounted) {
                            context.read<GoalFormCubit>().targetDateChanged(
                              date,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Check-in frequency (optional)',
                      ),
                      Wrap(
                        spacing: 8,
                        children: [
                          ...CheckInFrequency.values.map((f) {
                            final label = _checkInLabel(f);
                            final selected = state.checkInFrequency == f;
                            return FilterChip(
                              label: Text(label),
                              selected: selected,
                              onSelected: (_) => context
                                  .read<GoalFormCubit>()
                                  .checkInFrequencyChanged(selected ? null : f),
                            );
                          }),
                        ],
                      ),
                      _sectionLabel(
                        textTheme,
                        colorScheme,
                        'Description (optional, max $_maxWordsDescription words)',
                      ),
                      TextFormField(
                        initialValue: state.description ?? '',
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Brief description',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        onChanged: (v) => context
                            .read<GoalFormCubit>()
                            .descriptionChanged(v.isEmpty ? null : v),
                      ),
                      const SizedBox(height: 120),
                    ],
                  );
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: state.isSubmitting
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FloatingActionButton.extended(
                        heroTag: null,
                        onPressed: () => context.read<GoalFormCubit>().submit(),
                        label: Text(
                          state.initialGoal == null
                              ? 'Create Goal'
                              : 'Save Changes',
                          style: textTheme.titleMedium?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: const Icon(Icons.check_circle_outline),
                      ),
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

  static Widget _sectionLabel(
    TextTheme textTheme,
    ColorScheme colorScheme,
    String label,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: textTheme.labelMedium?.copyWith(color: colorScheme.primary),
      ),
    );
  }

  static String _checkInLabel(CheckInFrequency f) {
    switch (f) {
      case CheckInFrequency.none:
        return 'None';
      case CheckInFrequency.daily:
        return 'Daily';
      case CheckInFrequency.weekly:
        return 'Weekly';
      case CheckInFrequency.biWeekly:
        return 'Bi-weekly';
      case CheckInFrequency.monthly:
        return 'Monthly';
    }
  }

  static void _openManageCategories(
    BuildContext context,
    List<GoalCategory> categories,
    IGoalRepository repo,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => _ManageCategoriesSheet(
        categories: categories,
        onAdd: () => _showAddCategoryDialog(ctx, repo),
        onEdit: (c) => _showEditCategoryDialog(ctx, repo, c),
        onDelete: (c) => _confirmDeleteCategory(context, ctx, repo, c),
      ),
    );
  }

  static void _showAddCategoryDialog(
    BuildContext context,
    IGoalRepository repo,
  ) {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('New category'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                await repo.createCategory(
                  GoalCategory(
                    id: '',
                    name: name,
                    sortOrder: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
                if (!ctx.mounted) return;
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  static void _showEditCategoryDialog(
    BuildContext context,
    IGoalRepository repo,
    GoalCategory category,
  ) {
    final controller = TextEditingController(text: category.name);
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit category'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                await repo.updateCategory(category.copyWith(name: name));
                if (!ctx.mounted) return;
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  static void _confirmDeleteCategory(
    BuildContext dialogContext,
    BuildContext sheetContext,
    IGoalRepository repo,
    GoalCategory category,
  ) {
    showDialog<void>(
      context: dialogContext,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete category?'),
        content: Text('Delete "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await repo.deleteCategory(category.id);
              if (!ctx.mounted) return;
              Navigator.of(ctx).pop();
              if (!sheetContext.mounted) return;
              Navigator.of(sheetContext).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({
    required this.categories,
    required this.selectedId,
    required this.onSelected,
    required this.onManageCategories,
  });

  final List<GoalCategory> categories;
  final String? selectedId;
  final void Function(String?) onSelected;
  final VoidCallback onManageCategories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String?>(
          initialValue: selectedId,
          isExpanded: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            isDense: true,
          ),
          items: [
            const DropdownMenuItem(value: null, child: Text('None')),
            ...categories.map(
              (c) => DropdownMenuItem<String?>(
                value: c.id,
                child: Text(c.name, overflow: TextOverflow.ellipsis),
              ),
            ),
          ],
          onChanged: (v) => onSelected(v),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: onManageCategories,
          icon: const Icon(Icons.settings, size: 18),
          label: const Text('Manage categories'),
        ),
      ],
    );
  }
}

class _ManageCategoriesSheet extends StatelessWidget {
  const _ManageCategoriesSheet({
    required this.categories,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  final List<GoalCategory> categories;
  final VoidCallback onAdd;
  final void Function(GoalCategory) onEdit;
  final void Function(GoalCategory) onDelete;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, scrollController) => SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton.icon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final c = categories[index];
                  return ListTile(
                    title: Text(c.name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit_outlined),
                          onPressed: () => onEdit(c),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => onDelete(c),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
