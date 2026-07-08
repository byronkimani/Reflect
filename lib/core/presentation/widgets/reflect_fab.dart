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
      backgroundColor: ReflectColors.accentPrimary,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ReflectSpacing.fabRadius),
      ),
      child: const Icon(Icons.add),
    );
  }
}
