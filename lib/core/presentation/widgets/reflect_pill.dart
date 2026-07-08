import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

/// Selectable pill chip used for When, time, tags, etc.
class ReflectPill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final VoidCallback? onClear;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const ReflectPill({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.onClear,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: selected ? ReflectColors.accentPrimary : Colors.transparent,
      borderRadius: BorderRadius.circular(ReflectSpacing.pillRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ReflectSpacing.pillRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ReflectSpacing.pillRadius),
            border: Border.all(
              color: selected
                  ? ReflectColors.accentPrimary
                  : ReflectColors.textSecondary.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(
                  leadingIcon,
                  size: 16,
                  color: selected ? Colors.white : ReflectColors.textSecondary,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: textTheme.labelLarge?.copyWith(
                  color: selected ? Colors.white : ReflectColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (onClear != null) ...[
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: onClear,
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: selected ? Colors.white : ReflectColors.textSecondary,
                  ),
                ),
              ] else if (trailingIcon != null) ...[
                const SizedBox(width: 4),
                Icon(
                  trailingIcon,
                  size: 16,
                  color: selected ? Colors.white : ReflectColors.textSecondary,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
