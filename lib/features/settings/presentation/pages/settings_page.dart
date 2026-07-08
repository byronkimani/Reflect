import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/widgets/reflect_section_label.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReflectColors.pageBackground,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: ReflectColors.pageBackground,
        elevation: 0,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: settingsStateShouldRebuild,
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              const ReflectSectionLabel(title: 'Appearance'),
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
              const ReflectSectionLabel(title: 'Notifications'),
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
              const ReflectSectionLabel(title: 'Privacy'),
              SwitchListTile(
                title: const Text('Usage analytics'),
                subtitle: const Text(
                  'Share anonymous product events to improve Reflect (opt-in)',
                ),
                value: state.analyticsEnabled,
                onChanged: (v) =>
                    context.read<SettingsCubit>().setAnalyticsEnabled(v),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Task due reminders are controlled per task when you enable '
                  '"Remind me when due".',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: ReflectColors.textSecondary,
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
