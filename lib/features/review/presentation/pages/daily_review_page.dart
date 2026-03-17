import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';

class DailyReviewPage extends StatelessWidget {
  const DailyReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyReviewCubit, DailyReviewState>(
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Daily Review saved!'), backgroundColor: Colors.green),
          );
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
            title: const Text('Daily Review'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('How was your day?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Center(
                  child: SegmentedButton<int>(
                    segments: const [
                      ButtonSegment(value: 1, label: Text('1')),
                      ButtonSegment(value: 2, label: Text('2')),
                      ButtonSegment(value: 3, label: Text('3')),
                      ButtonSegment(value: 4, label: Text('4')),
                      ButtonSegment(value: 5, label: Text('5')),
                    ],
                    selected: {state.dayRating},
                    onSelectionChanged: (value) => context.read<DailyReviewCubit>().ratingChanged(value.first),
                  ),
                ),
                const SizedBox(height: 32),
                const Text('What went well?', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) => context.read<DailyReviewCubit>().wentWellChanged(value),
                  maxLines: 2,
                  decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Reflect on your wins...'),
                ),
                const SizedBox(height: 24),
                const Text('What could be better?', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (value) => context.read<DailyReviewCubit>().couldBeBetterChanged(value),
                  maxLines: 2,
                  decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Potential improvements?'),
                ),
                const SizedBox(height: 32),
                const Text('Gratitude (3 mandatory)', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _GratitudeField(
                  index: 0,
                  label: '1. I am grateful for...',
                  initialValue: state.gratitude1,
                  onChanged: (text) => context.read<DailyReviewCubit>().gratitudeChanged(0, text),
                ),
                const SizedBox(height: 12),
                _GratitudeField(
                  index: 1,
                  label: '2. I am grateful for...',
                  initialValue: state.gratitude2,
                  onChanged: (text) => context.read<DailyReviewCubit>().gratitudeChanged(1, text),
                ),
                const SizedBox(height: 12),
                _GratitudeField(
                  index: 2,
                  label: '3. I am grateful for...',
                  initialValue: state.gratitude3,
                  onChanged: (text) => context.read<DailyReviewCubit>().gratitudeChanged(2, text),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FilledButton(
                    onPressed: state.canSubmit && !state.isSubmitting
                        ? () => context.read<DailyReviewCubit>().submitReview()
                        : null,
                    child: state.isSubmitting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                        : const Text('Save Review'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _GratitudeField extends StatelessWidget {
  final int index;
  final String label;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const _GratitudeField({
    required this.index,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.favorite, color: Colors.pink, size: 20),
      ),
    );
  }
}
