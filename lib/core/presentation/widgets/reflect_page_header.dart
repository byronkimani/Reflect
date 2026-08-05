import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

/// Eyebrow + Sora display title with optional trailing actions.
class ReflectPageHeader extends StatelessWidget {
  final String? eyebrow;
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  const ReflectPageHeader({
    super.key,
    this.eyebrow,
    required this.title,
    this.trailing,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 16),
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eyebrow != null) ...[
                  Text(
                    eyebrow!.toUpperCase(),
                    style: textTheme.labelSmall?.copyWith(
                      color: ReflectColors.textSecondary,
                      letterSpacing: 2.4,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
                Text(
                  title,
                  style: GoogleFonts.sora(
                    textStyle: textTheme.headlineLarge?.copyWith(
                      fontSize: 34,
                      height: 1.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}
