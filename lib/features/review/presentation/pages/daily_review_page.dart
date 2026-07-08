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
      context.read<DailyReviewCubit>().initializeForToday();
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
              backgroundColor: ReflectColors.accentPrimary,
            ),
          );
          context.pop();
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

        return Scaffold(
          backgroundColor: ReflectColors.pageBackground,
          appBar: AppBar(
            title: const Text('Daily Review'),
            backgroundColor: ReflectColors.pageBackground,
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Text(
                          dateLabel,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ReflectColors.textSecondary,
                              ),
                        ),
                      ),
                      if (state.showTaskChip)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
                              onRatingChanged: (rating) => context
                                  .read<DailyReviewCubit>()
                                  .ratingChanged(rating),
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
                              onChanged: (value) => context
                                  .read<DailyReviewCubit>()
                                  .wentWellChanged(value),
                            ),
                            const SizedBox(height: 16),
                            ReflectSoftField(
                              labelText: 'What could be better?',
                              hintText: 'One thing to improve…',
                              maxLines: 2,
                              onChanged: (value) => context
                                  .read<DailyReviewCubit>()
                                  .couldBeBetterChanged(value),
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
                                index: i,
                                onChanged: (text) => context
                                    .read<DailyReviewCubit>()
                                    .gratitudeChanged(i, text),
                              ),
                            ],
                            if (state.gratitudeFieldCount < 3) ...[
                              const SizedBox(height: 12),
                              TextButton.icon(
                                onPressed: () => context
                                    .read<DailyReviewCubit>()
                                    .addGratitudeField(),
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text('Add another'),
                                style: TextButton.styleFrom(
                                  foregroundColor: ReflectColors.accentPrimary,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: ReflectPrimaryButton(
                  label: 'Save Review',
                  isLoading: state.isSubmitting,
                  onPressed: state.canSubmit && !state.isSubmitting
                      ? () => context.read<DailyReviewCubit>().submitReview()
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GratitudeField extends StatelessWidget {
  const _GratitudeField({
    required this.index,
    required this.onChanged,
  });

  final int index;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'I am grateful for…',
        filled: true,
        fillColor: ReflectColors.inputSurface,
        prefixIcon: const Icon(
          Icons.favorite_border,
          color: ReflectColors.accentPrimary,
          size: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: ReflectColors.accentPrimary,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      ),
    );
  }
}
