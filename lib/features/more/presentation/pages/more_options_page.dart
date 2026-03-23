import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoreOptionsPage extends StatelessWidget {
  const MoreOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('More options'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.settings_outlined, color: colorScheme.primary),
            title: const Text('Settings'),
            subtitle: const Text('Appearance & notifications'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/more/settings'),
          ),
          ListTile(
            leading: Icon(Icons.insights_outlined, color: colorScheme.primary),
            title: const Text('Analytics'),
            subtitle: const Text('Insights and trends'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/more/analytics'),
          ),
        ],
      ),
    );
  }
}
