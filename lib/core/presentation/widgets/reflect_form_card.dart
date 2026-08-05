import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

/// Flat v2 form section (hairline border, no shadow).
class ReflectFormCard extends StatelessWidget {
  final String? title;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const ReflectFormCard({
    super.key,
    this.title,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null) ...[
            Text(
              title!.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ReflectColors.textSecondary,
                    letterSpacing: 2,
                  ),
            ),
            const SizedBox(height: 12),
          ],
          Padding(padding: padding, child: child),
          const Divider(height: 1, color: ReflectColors.hairline),
        ],
      ),
    );
  }
}
