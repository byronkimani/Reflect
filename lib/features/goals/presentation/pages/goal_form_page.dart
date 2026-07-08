import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/widgets/expandable_section_row.dart';
import 'package:reflect/core/presentation/widgets/reflect_form_card.dart';
import 'package:reflect/core/presentation/widgets/reflect_pill.dart';
import 'package:reflect/core/presentation/widgets/reflect_primary_button.dart';
import 'package:reflect/core/presentation/widgets/reflect_section_label.dart';
import 'package:reflect/core/presentation/widgets/reflect_soft_field.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goal_form_cubit.dart';
import 'package:reflect/features/goals/presentation/cubit/goal_form_state.dart';
import 'package:reflect/features/goals/presentation/utils/goal_importance.dart';
import 'package:reflect/main.dart';

class GoalFormPage extends StatelessWidget {
  const GoalFormPage({
    super.key,
    this.initialGoal,
    this.timeHorizon,
    this.goalRepo,
    this.categoriesStream,
  })  : _goalRepo = goalRepo,
        _categoriesStream = categoriesStream;

  final Goal? initialGoal;
  final GoalTimeHorizon? timeHorizon;
  final IGoalRepository? goalRepo;
  final Stream<dynamic>? categoriesStream;

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

class _GoalFormView extends StatefulWidget {
  const _GoalFormView({required this.categoriesStream, required this.goalRepo});

  final Stream<dynamic> categoriesStream;
  final IGoalRepository goalRepo;

  @override
  State<_GoalFormView> createState() => _GoalFormViewState();
}

class _GoalFormViewState extends State<_GoalFormView> {
  bool _timelineExpanded = true;
  bool _motivationExpanded = true;
  bool _importanceExpanded = false;

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
        final cubit = context.read<GoalFormCubit>();

        return PopScope(
          canPop: !state.isModified,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) return;
            final shouldDiscard = await _showDiscardDialog(context);
            if (shouldDiscard && context.mounted) context.pop();
          },
          child: Scaffold(
            backgroundColor: ReflectColors.pageBackground,
            appBar: AppBar(
              backgroundColor: ReflectColors.pageBackground,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  if (state.isModified) {
                    final shouldDiscard = await _showDiscardDialog(context);
                    if (shouldDiscard && context.mounted) context.pop();
                  } else {
                    context.pop();
                  }
                },
              ),
              title: Text(
                state.initialGoal == null ? 'New Goal' : 'Edit Goal',
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: StreamBuilder<dynamic>(
                      stream: widget.categoriesStream,
                      builder: (context, snapshot) {
                        final categories =
                            snapshot.hasData && snapshot.data != null
                                ? (snapshot.data!.fold(
                                    (l) => <GoalCategory>[],
                                    (r) => r as List<GoalCategory>,
                                  ))
                                : <GoalCategory>[];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              initialValue: state.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              decoration: const InputDecoration(
                                hintText: 'What do you want to achieve?',
                                border: InputBorder.none,
                              ),
                              onChanged: cubit.titleChanged,
                            ),
                            const SizedBox(height: 16),
                            if (state.initialGoal == null) ...[
                              const ReflectSectionLabel(
                                title: 'Time Frame',
                                padding: EdgeInsets.only(bottom: 8),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: GoalTimeHorizon.values.map((h) {
                                  final label = h.name[0].toUpperCase() +
                                      h.name.substring(1);
                                  return ReflectPill(
                                    label: label,
                                    selected: state.timeHorizon == h,
                                    onTap: () => cubit.timeHorizonChanged(h),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 16),
                            ],
                            const ReflectSectionLabel(
                              title: 'Category',
                              padding: EdgeInsets.only(bottom: 8),
                            ),
                            _CategorySelector(
                              categories: categories,
                              selectedId: state.categoryId,
                              onSelected: cubit.categoryIdChanged,
                              onManageCategories: () => _openManageCategories(
                                context,
                                categories,
                                widget.goalRepo,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ReflectFormCard(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: ExpandableSectionRow(
                                title: 'Timeline',
                                icon: Icons.calendar_today_outlined,
                                expanded: _timelineExpanded,
                                onTap: () => setState(
                                  () => _timelineExpanded = !_timelineExpanded,
                                ),
                                child: _TimelineSection(state: state),
                              ),
                            ),
                            ReflectFormCard(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: ExpandableSectionRow(
                                title: 'Track a KPI',
                                icon: Icons.trending_up_outlined,
                                expanded: state.isMeasurable,
                                onTap: cubit.toggleKpiExpanded,
                                child: _KpiSection(state: state),
                              ),
                            ),
                            ReflectFormCard(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: ExpandableSectionRow(
                                title: 'Motivation',
                                icon: Icons.lightbulb_outline,
                                expanded: _motivationExpanded,
                                onTap: () => setState(
                                  () =>
                                      _motivationExpanded = !_motivationExpanded,
                                ),
                                child: _MotivationSection(state: state),
                              ),
                            ),
                            ReflectFormCard(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              child: ExpandableSectionRow(
                                title: 'Importance',
                                icon: Icons.flag_outlined,
                                expanded: _importanceExpanded,
                                onTap: () => setState(
                                  () =>
                                      _importanceExpanded = !_importanceExpanded,
                                ),
                                child: _ImportanceSection(
                                  selected: cubit.importance,
                                  onChanged: cubit.importanceChanged,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  child: ReflectPrimaryButton(
                    label: state.initialGoal == null
                        ? 'Create Goal'
                        : 'Save Changes',
                    isLoading: state.isSubmitting,
                    icon: Icons.check_circle_outline,
                    onPressed:
                        state.isSubmitting ? null : () => cubit.submit(),
                  ),
                ),
              ],
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

class _TimelineSection extends StatelessWidget {
  const _TimelineSection({required this.state});

  final GoalFormState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GoalFormCubit>();
    final dateFormat = DateFormat.yMMMd();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ReflectPill(
              label: state.startDate != null
                  ? 'Start ${dateFormat.format(state.startDate!)}'
                  : 'Start date',
              selected: state.startDate != null,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: state.startDate ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (date != null && context.mounted) {
                  cubit.startDateChanged(date);
                }
              },
              onClear: state.startDate != null ? cubit.clearStartDate : null,
            ),
            ReflectPill(
              label: state.targetDate != null
                  ? 'Target ${dateFormat.format(state.targetDate!)}'
                  : 'Target date',
              selected: state.targetDate != null,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate:
                      state.targetDate ?? state.startDate ?? DateTime.now(),
                  firstDate: state.startDate ?? DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (date != null && context.mounted) {
                  cubit.targetDateChanged(date);
                }
              },
              onClear: state.targetDate != null ? cubit.clearTargetDate : null,
            ),
          ],
        ),
        const SizedBox(height: 16),
        const ReflectSectionLabel(
          title: 'Check-in',
          padding: EdgeInsets.only(bottom: 8),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: CheckInFrequency.values.map((f) {
            final label = _checkInLabel(f);
            final selected = state.checkInFrequency == f;
            return ReflectPill(
              label: label,
              selected: selected,
              onTap: () => cubit.checkInFrequencyChanged(
                selected ? null : f,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  static String _checkInLabel(CheckInFrequency f) {
    return switch (f) {
      CheckInFrequency.none => 'None',
      CheckInFrequency.daily => 'Daily',
      CheckInFrequency.weekly => 'Weekly',
      CheckInFrequency.biWeekly => 'Bi-weekly',
      CheckInFrequency.monthly => 'Monthly',
    };
  }
}

class _KpiSection extends StatelessWidget {
  const _KpiSection({required this.state});

  final GoalFormState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GoalFormCubit>();

    return Column(
      children: [
        ReflectSoftField(
          labelText: 'KPI description',
          hintText: 'What KPI measures progress?',
          initialValue: state.kpiDescription ?? '',
          onChanged: (v) =>
              cubit.kpiDescriptionChanged(v.isEmpty ? null : v),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ReflectSoftField(
                labelText: 'Start value',
                hintText: 'Start',
                initialValue: state.startValue ?? '',
                onChanged: (v) =>
                    cubit.startValueChanged(v.isEmpty ? null : v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ReflectSoftField(
                labelText: 'Target value',
                hintText: 'Target',
                initialValue: state.targetValue ?? '',
                onChanged: (v) =>
                    cubit.targetValueChanged(v.isEmpty ? null : v),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MotivationSection extends StatelessWidget {
  const _MotivationSection({required this.state});

  final GoalFormState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GoalFormCubit>();

    return Column(
      children: [
        ReflectSoftField(
          labelText: 'Why this goal?',
          hintText: 'Why you are setting this goal',
          maxLines: 4,
          initialValue: state.why ?? '',
          onChanged: (v) => cubit.whyChanged(v.isEmpty ? null : v),
        ),
        const SizedBox(height: 12),
        ReflectSoftField(
          labelText: 'Description',
          hintText: 'Brief description',
          maxLines: 3,
          initialValue: state.description ?? '',
          onChanged: (v) => cubit.descriptionChanged(v.isEmpty ? null : v),
        ),
      ],
    );
  }
}

class _ImportanceSection extends StatelessWidget {
  const _ImportanceSection({
    required this.selected,
    required this.onChanged,
  });

  final GoalImportance? selected;
  final ValueChanged<GoalImportance?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: GoalImportance.values.map((level) {
        final isSelected = selected == level;
        return ReflectPill(
          label: GoalImportanceMapper.label(level),
          selected: isSelected,
          onTap: () => onChanged(isSelected ? null : level),
        );
      }).toList(),
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
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ReflectPill(
              label: 'None',
              selected: selectedId == null,
              onTap: () => onSelected(null),
            ),
            ...categories.map(
              (c) => ReflectPill(
                label: c.name,
                selected: selectedId == c.id,
                onTap: () => onSelected(c.id),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: onManageCategories,
          icon: const Icon(Icons.settings, size: 18),
          label: const Text('Manage categories'),
          style: TextButton.styleFrom(
            foregroundColor: ReflectColors.accentPrimary,
          ),
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
