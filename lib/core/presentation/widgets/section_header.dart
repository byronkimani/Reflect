import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/widgets/reflect_section_label.dart';

/// Section header using Reflect design system labels.
class SectionHeader extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry padding;
  final Color? color;

  const SectionHeader({
    super.key,
    required this.title,
    this.padding = const EdgeInsets.fromLTRB(16, 24, 16, 8),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ReflectSectionLabel(
      title: title,
      padding: padding,
      color: color,
    );
  }
}
