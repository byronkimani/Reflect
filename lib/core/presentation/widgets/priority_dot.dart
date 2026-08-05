import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/widgets/priority_lozenge.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

/// Small priority dot for feed rows (v2 lists).
class PriorityDot extends StatelessWidget {
  final TaskPriority priority;
  final bool showLabel;

  const PriorityDot({
    super.key,
    required this.priority,
    this.showLabel = false,
  });

  @override
  Widget build(BuildContext context) {
    final dotColor = PriorityLozenge.colorFor(priority);
    final label = 'P${priority.index + 1}';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        if (showLabel) ...[
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: ReflectColors.textSecondary,
                  letterSpacing: 1.2,
                  fontSize: 11,
                ),
          ),
        ],
      ],
    );
  }
}
