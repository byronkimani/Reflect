import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

class ReflectProgressBar extends StatelessWidget {
  final double progress;
  final String? label;

  const ReflectProgressBar({
    super.key,
    required this.progress,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: clamped,
              minHeight: 4,
              backgroundColor: ReflectColors.inputSurface,
              color: ReflectColors.accentPrimary,
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(width: 12),
          Text(
            label!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ReflectColors.textSecondary,
                ),
          ),
        ],
      ],
    );
  }
}
