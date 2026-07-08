import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

const priorityLabels = {
  TaskPriority.p1: 'Highest',
  TaskPriority.p2: 'High',
  TaskPriority.p3: 'Medium',
  TaskPriority.p4: 'Lowest',
};

/// Glow-dot priority lozenge per design system.
class PriorityLozenge extends StatelessWidget {
  final TaskPriority priority;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool compact;

  const PriorityLozenge({
    super.key,
    required this.priority,
    this.isSelected = false,
    this.onTap,
    this.compact = true,
  });

  static Color colorFor(TaskPriority priority) =>
      ReflectColors.priorityColor(priority.index);

  static String labelFor(TaskPriority priority) => priorityLabels[priority]!;

  @override
  Widget build(BuildContext context) {
    final dotColor = colorFor(priority);
    final label = 'P${priority.index + 1}';

    final child = Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: ReflectColors.priorityWash(dotColor),
        borderRadius: BorderRadius.circular(ReflectSpacing.pillRadius),
        border: isSelected
            ? Border.all(color: ReflectColors.accentPrimary, width: 1.5)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 6 : 8,
            height: compact ? 6 : 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: dotColor.withValues(alpha: 0.35),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          SizedBox(width: compact ? 4 : 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: dotColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );

    if (onTap == null) return child;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ReflectSpacing.pillRadius),
        child: child,
      ),
    );
  }
}
