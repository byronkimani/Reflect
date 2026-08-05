import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/utils/reflect_page_insets.dart';
import 'package:reflect/core/presentation/widgets/reflect_hairline.dart';
import 'package:reflect/core/presentation/widgets/reflect_page_header.dart';
import 'package:reflect/core/presentation/widgets/reflect_sticky_bottom_bar.dart';

class MoreOptionsPage extends StatelessWidget {
  const MoreOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReflectColors.pageBackground,
      body: ReflectTabPageSafeArea(
        child: ListView(
          padding: reflectTabScrollPadding(context).copyWith(top: 0),
          children: [
            const ReflectPageHeader(title: 'More'),
            _MoreRow(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'Appearance & notifications',
              onTap: () => context.push('/more/settings'),
            ),
            const ReflectHairline(),
          ],
        ),
      ),
    );
  }
}

class _MoreRow extends StatelessWidget {
  const _MoreRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: ReflectColors.textSecondary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ReflectColors.textSecondary,
                        ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: ReflectColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
