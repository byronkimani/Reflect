import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

class PlanningPage extends StatelessWidget {
  const PlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReflectColors.pageBackground,
      appBar: AppBar(
        title: const Text('Morning Planning'),
        backgroundColor: ReflectColors.pageBackground,
        elevation: 0,
      ),
      body: Center(
        child: Text(
          'Morning Planning',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: ReflectColors.textSecondary,
              ),
        ),
      ),
    );
  }
}
