import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/widgets/mood_rating_row.dart';
import 'package:reflect/core/presentation/widgets/reflect_form_card.dart';
import 'package:reflect/core/presentation/widgets/reflect_pill.dart';
import 'package:reflect/core/presentation/widgets/reflect_primary_button.dart';
import 'package:reflect/core/presentation/widgets/reflect_soft_field.dart';
import 'package:reflect/core/presentation/widgets/reflect_page_header.dart';
import 'package:reflect/core/presentation/widgets/reflect_sticky_bottom_bar.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';

class DailyReviewPage extends StatefulWidget {
  const DailyReviewPage({super.key});

  @override
  State<DailyReviewPage> createState() => _DailyReviewPageState();
}

class _DailyReviewPageState extends State<DailyReviewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DailyReviewCubit>().startWatchingTodayTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyReviewCubit, DailyReviewState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Daily Review saved!'),
              backgroundColor: ReflectColors.ink,
            ),
          );
          if (context.canPop()) {
            context.pop();
          }
        }
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
        final dateLabel = DateFormat('EEEE, MMM d').format(DateTime.now());
        final cubit = context.read<DailyReviewCubit>();

        return Scaffold(
          backgroundColor: ReflectColors.pageBackground,
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReflectPageHeader(
                  eyebrow: 'Reflect',
                  title: dateLabel,
                ),
                if (state.showTaskChip)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                    child: ReflectPill(
                      label:
                          '${state.tasksCompletedToday} of ${state.tasksTotalToday} tasks done today',
                      selected: false,
                    ),
                  ),
                ReflectFormCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How was your day?',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      MoodRatingRow(
                        selectedRating: state.dayRating,
                        onRatingChanged: cubit.ratingChanged,
                      ),
                    ],
                  ),
                ),
                ReflectFormCard(
                  title: 'Wins & Growth',
                  child: Column(
                    children: [
                      ReflectSoftField(
                        labelText: 'What went well?',
                        hintText: 'A win from today…',
                        maxLines: 2,
                        onChanged: cubit.wentWellChanged,
                      ),
                      const SizedBox(height: 16),
                      ReflectSoftField(
                        labelText: 'What could be better?',
                        hintText: 'One thing to improve…',
                        maxLines: 2,
                        onChanged: cubit.couldBeBetterChanged,
                      ),
                    ],
                  ),
                ),
                ReflectFormCard(
                  title: 'Gratitude',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share up to 3 things',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: ReflectColors.textSecondary),
                      ),
                      const SizedBox(height: 12),
                      for (var i = 0; i < state.gratitudeFieldCount; i++) ...[
                        if (i > 0) const SizedBox(height: 12),
                        _GratitudeField(
                          key: ValueKey('gratitude_$i'),
                          initialValue: switch (i) {
                            0 => state.gratitude1,
                            1 => state.gratitude2,
                            _ => state.gratitude3,
                          },
                          showRemove: i > 0,
                          onChanged: (text) => cubit.gratitudeChanged(i, text),
                          onRemove: () => cubit.removeGratitudeField(i),
                        ),
                      ],
                      if (state.gratitudeFieldCount < 3) ...[
                        const SizedBox(height: 12),
                        TextButton.icon(
                          onPressed: cubit.addGratitudeField,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add another'),
                          style: TextButton.styleFrom(
                            foregroundColor: ReflectColors.ink,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: ReflectStickyBottomBar(
            child: ReflectPrimaryButton(
              label: 'Save Review',
              isLoading: state.isSubmitting,
              onPressed: state.canSubmit && !state.isSubmitting
                  ? cubit.submitReview
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _GratitudeField extends StatelessWidget {
  const _GratitudeField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.showRemove,
    required this.onRemove,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool showRemove;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'I am grateful for…',
        filled: true,
        fillColor: ReflectColors.inputSurface,
        prefixIcon: const Icon(
          Icons.favorite_border,
          color: ReflectColors.textSecondary,
          size: 20,
        ),
        suffixIcon: showRemove
            ? IconButton(
                icon: const Icon(Icons.close, size: 20),
                tooltip: 'Remove',
                onPressed: onRemove,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: ReflectColors.ink,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}
