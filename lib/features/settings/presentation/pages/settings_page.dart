import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Appearance',
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text('System'),
                      icon: Icon(Icons.brightness_auto_outlined, size: 18),
                    ),
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode_outlined, size: 18),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode_outlined, size: 18),
                    ),
                  ],
                  selected: {state.themeMode},
                  onSelectionChanged: (selected) {
                    if (selected.isNotEmpty) {
                      context.read<SettingsCubit>().setThemeMode(selected.first);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 8),
                child: Text(
                  'Notifications',
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SwitchListTile(
                title: const Text('Morning planning'),
                subtitle: const Text('Daily reminder to plan your day'),
                value: state.morningPlanningEnabled,
                onChanged: (v) =>
                    context.read<SettingsCubit>().setMorningPlanningEnabled(v),
              ),
              SwitchListTile(
                title: const Text('Evening review'),
                subtitle: const Text('Daily reflection reminder'),
                value: state.eveningReviewEnabled,
                onChanged: (v) =>
                    context.read<SettingsCubit>().setEveningReviewEnabled(v),
              ),
              SwitchListTile(
                title: const Text('Weekly planning'),
                subtitle: const Text('Sunday weekly review reminder'),
                value: state.weeklyPlanningEnabled,
                onChanged: (v) =>
                    context.read<SettingsCubit>().setWeeklyPlanningEnabled(v),
              ),
              SwitchListTile(
                title: const Text('Monthly planning'),
                subtitle: const Text('First of month goal reminder'),
                value: state.monthlyPlanningEnabled,
                onChanged: (v) =>
                    context.read<SettingsCubit>().setMonthlyPlanningEnabled(v),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Task due reminders are controlled per task when you enable '
                  '"Remind me when due".',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
