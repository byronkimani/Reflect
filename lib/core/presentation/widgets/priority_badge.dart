import 'package:flutter/material.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

class PriorityBadge extends StatelessWidget {
  final TaskPriority priority;

  const PriorityBadge({super.key, required this.priority});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (priority) {
      case TaskPriority.p1:
        color = Colors.red;
        label = 'P1';
        break;
      case TaskPriority.p2:
        color = Colors.orange;
        label = 'P2';
        break;
      case TaskPriority.p3:
        color = Colors.blue;
        label = 'P3';
        break;
      case TaskPriority.p4:
        color = Colors.grey;
        label = 'P4';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
