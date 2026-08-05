import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

class ReflectFab extends StatelessWidget {
  final VoidCallback onPressed;
  final String heroTag;

  const ReflectFab({
    super.key,
    required this.onPressed,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor: ReflectColors.ink,
      foregroundColor: ReflectColors.paper,
      elevation: 0,
      shape: const CircleBorder(),
      child: const Icon(Icons.add),
    );
  }
}
