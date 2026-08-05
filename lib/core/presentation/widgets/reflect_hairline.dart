import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

/// 1px hairline divider used between feed rows and sections.
class ReflectHairline extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  const ReflectHairline({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: 1,
      color: ReflectColors.hairline,
    );
  }
}
