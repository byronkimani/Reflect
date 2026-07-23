import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/utils/reflect_page_insets.dart';
import 'package:reflect/core/presentation/widgets/reflect_sticky_bottom_bar.dart';

class MoreOptionsPage extends StatelessWidget {
  const MoreOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReflectColors.pageBackground,
      appBar: AppBar(
        title: const Text('More options'),
        backgroundColor: ReflectColors.pageBackground,
        elevation: 0,
      ),
      body: ReflectTabPageSafeArea(
        child: ListView(
          padding: reflectTabScrollPadding(context).copyWith(top: 8),
          children: [
          ListTile(
            leading: const Icon(
              Icons.settings_outlined,
              color: ReflectColors.accentPrimary,
            ),
            title: const Text('Settings'),
            subtitle: const Text('Appearance & notifications'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/more/settings'),
          ),
          ],
        ),
      ),
    );
  }
}
