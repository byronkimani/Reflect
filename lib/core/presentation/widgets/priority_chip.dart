import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/widgets/priority_lozenge.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

export 'package:reflect/core/presentation/widgets/priority_lozenge.dart'
    show priorityLabels;

/// Backward-compatible wrapper — delegates to [PriorityLozenge].
class PriorityChip extends StatelessWidget {
  final TaskPriority priority;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool compact;

  const PriorityChip({
    super.key,
    required this.priority,
    this.isSelected = false,
    this.onTap,
    this.compact = true,
  });

  static Color colorFor(TaskPriority priority) =>
      PriorityLozenge.colorFor(priority);

  static String labelFor(TaskPriority priority) =>
      PriorityLozenge.labelFor(priority);

  @override
  Widget build(BuildContext context) {
    return PriorityLozenge(
      priority: priority,
      isSelected: isSelected,
      onTap: onTap,
      compact: compact,
    );
  }
}
