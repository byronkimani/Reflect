import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNavBar({required this.navigationShell, Key? key})
      : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  static const _destinations = [
    (icon: Icons.today_outlined, selectedIcon: Icons.today, label: 'Today'),
    (
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2,
      label: 'Backlog',
    ),
    (icon: Icons.flag_outlined, selectedIcon: Icons.flag, label: 'Goals'),
    (
      icon: Icons.auto_awesome_mosaic_outlined,
      selectedIcon: Icons.auto_awesome_mosaic,
      label: 'Reflect',
    ),
    (icon: Icons.more_horiz, selectedIcon: Icons.more_horiz, label: 'More'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          color: ReflectColors.paper,
          border: Border(
            top: BorderSide(color: ReflectColors.hairline, width: 1),
          ),
        ),
        child: SafeArea(
          child: SizedBox(
            height: 56,
            child: Row(
              children: List.generate(_destinations.length, (index) {
                final dest = _destinations[index];
                final selected = navigationShell.currentIndex == index;
                return Expanded(
                  child: _NavItem(
                    icon: selected ? dest.selectedIcon : dest.icon,
                    label: dest.label,
                    selected: selected,
                    onTap: () => _onTap(context, index),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    final switchingTab = index != navigationShell.currentIndex;
    if (switchingTab) {
      final bloc = context.read<TaskListBloc>();
      if (index == 0) {
        bloc.add(TaskListEvent.loadTasksForDate(DateTime.now()));
      } else if (index == 1) {
        bloc.add(const TaskListEvent.loadBacklog());
      }
    }
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        selected ? ReflectColors.ink : ReflectColors.textSecondary;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(height: 2),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              letterSpacing: 0.8,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
