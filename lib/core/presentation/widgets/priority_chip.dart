import 'package:flutter/material.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

/// Jira-like solid priority colors: Critical, High, Medium, Low.
const priorityChipColors = [
  Color(0xFFDE350B), // P1 Critical - red
  Color(0xFFFFAB00), // P2 High - amber
  Color(0xFF0052CC), // P3 Medium - blue
  Color(0xFF6B778C), // P4 Low - gray
];

/// Same chip style as the New Task page: pill shape, solid colors.
/// Use for display (e.g. Today page) or selectable (e.g. task form with [onTap] and [isSelected]).
class PriorityChip extends StatelessWidget {
  final TaskPriority priority;
  final bool isSelected;
  final VoidCallback? onTap;

  const PriorityChip({
    super.key,
    required this.priority,
    this.isSelected = false,
    this.onTap,
  });

  static Color colorFor(TaskPriority priority) =>
      priorityChipColors[priority.index];

  @override
  Widget build(BuildContext context) {
    final color = colorFor(priority);
    final backgroundColor = isSelected ? color.withValues(alpha: 0.75) : color;
    final textTheme = Theme.of(context).textTheme;

    final child = Container(
      width: 52,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? Border.all(color: Colors.white, width: 2)
            : null,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Text(
              'P${priority.index + 1}',
              style: textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              top: -4,
              right: -4,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.check,
                  color: color,
                  size: 14,
                ),
              ),
            ),
        ],
      ),
    );

    if (onTap != null) {
      return Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: child,
        ),
      );
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
      child: child,
    );
  }
}
