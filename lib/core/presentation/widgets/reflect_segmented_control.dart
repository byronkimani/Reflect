import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/widgets/priority_dot.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

/// Segmented P1–P4 control for forms (v2).
class ReflectSegmentedControl<T> extends StatelessWidget {
  final List<T> values;
  final T selected;
  final ValueChanged<T> onChanged;
  final String Function(T value) labelBuilder;
  final Widget Function(T value, bool selected)? leadingBuilder;

  const ReflectSegmentedControl({
    super.key,
    required this.values,
    required this.selected,
    required this.onChanged,
    required this.labelBuilder,
    this.leadingBuilder,
  });

  static ReflectSegmentedControl<TaskPriority> priority({
    required TaskPriority selected,
    required ValueChanged<TaskPriority> onChanged,
  }) {
    return ReflectSegmentedControl<TaskPriority>(
      values: TaskPriority.values,
      selected: selected,
      onChanged: onChanged,
      labelBuilder: (p) => 'P${p.index + 1}',
      leadingBuilder: (p, _) => PriorityDot(priority: p),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: ReflectColors.hairline),
        borderRadius: BorderRadius.circular(ReflectSpacing.cardRadius),
      ),
      child: Row(
        children: values.map((value) {
          final isSelected = value == selected;
          final index = values.indexOf(value);
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(value),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? ReflectColors.ink : Colors.transparent,
                  borderRadius: BorderRadius.horizontal(
                    left: index == 0
                        ? const Radius.circular(ReflectSpacing.cardRadius - 1)
                        : Radius.zero,
                    right: index == values.length - 1
                        ? const Radius.circular(ReflectSpacing.cardRadius - 1)
                        : Radius.zero,
                  ),
                  border: index > 0
                      ? const Border(
                          left: BorderSide(color: ReflectColors.hairline),
                        )
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (leadingBuilder != null) ...[
                      leadingBuilder!(value, isSelected),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      labelBuilder(value),
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: isSelected
                                ? ReflectColors.paper
                                : ReflectColors.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
