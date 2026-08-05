import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

/// Five-step mood rating (maps to dayRating 1–5).
class MoodRatingRow extends StatelessWidget {
  final int selectedRating;
  final ValueChanged<int> onRatingChanged;

  const MoodRatingRow({
    super.key,
    required this.selectedRating,
    required this.onRatingChanged,
  });

  static const _icons = [
    Icons.sentiment_very_dissatisfied_outlined,
    Icons.sentiment_dissatisfied_outlined,
    Icons.sentiment_neutral_outlined,
    Icons.sentiment_satisfied_outlined,
    Icons.sentiment_very_satisfied_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(5, (index) {
            final rating = index + 1;
            final selected = selectedRating == rating;
            return GestureDetector(
              onTap: () => onRatingChanged(rating),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: selected
                      ? Border.all(color: ReflectColors.ink, width: 2)
                      : Border.all(color: ReflectColors.hairline),
                  color: selected
                      ? ReflectColors.paperSoft
                      : Colors.transparent,
                ),
                child: Icon(
                  _icons[index],
                  size: 28,
                  color: selected
                      ? ReflectColors.ink
                      : ReflectColors.textSecondary,
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Rough', style: TextStyle(color: ReflectColors.textSecondary, fontSize: 12)),
            Text('Great', style: TextStyle(color: ReflectColors.textSecondary, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
