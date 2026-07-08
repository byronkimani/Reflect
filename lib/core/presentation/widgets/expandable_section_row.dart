import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

class ExpandableSectionRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool expanded;
  final VoidCallback onTap;
  final Widget? child;

  const ExpandableSectionRow({
    super.key,
    required this.title,
    required this.icon,
    required this.expanded,
    required this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                Icon(icon, size: 20, color: ReflectColors.accentPrimary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: ReflectColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        if (expanded && child != null) ...[
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: child,
          ),
        ],
      ],
    );
  }
}
