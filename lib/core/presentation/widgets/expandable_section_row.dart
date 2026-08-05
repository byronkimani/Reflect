import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

class ExpandableSectionRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool expanded;
  final VoidCallback onTap;
  final Widget? child;
  final String? summary;

  const ExpandableSectionRow({
    super.key,
    required this.title,
    required this.icon,
    required this.expanded,
    required this.onTap,
    this.child,
    this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(height: 1, color: ReflectColors.hairline),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
            child: Row(
              children: [
                Icon(icon, size: 18, color: ReflectColors.textSecondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      if (summary != null && summary!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          summary!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: ReflectColors.textSecondary,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: ReflectColors.textSecondary,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        if (expanded && child != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, right: 4, bottom: 12),
            child: child,
          ),
        ],
      ],
    );
  }
}
