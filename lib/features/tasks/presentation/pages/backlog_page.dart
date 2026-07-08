import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';
import 'package:reflect/core/presentation/widgets/reflect_fab.dart';
import 'package:reflect/core/presentation/widgets/reflect_icon_button.dart';
import 'package:reflect/core/presentation/widgets/reflect_section_label.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/widgets/task_list_filter_sheet.dart';

class BacklogPage extends StatelessWidget {
  const BacklogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocBuilder<TaskListBloc, TaskListState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            loaded: (rawTasks, pending, completed, overdue, sortMode, filter) {
              final allTasks = [...pending, ...completed];

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 56, 16, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              'Backlog',
                              style: textTheme.headlineMedium,
                            ),
                          ),
                          ReflectIconButton(
                            icon: Icons.tune,
                            tooltip: 'Filter',
                            onPressed: () => showTaskListFilterSheet(
                              context,
                              context.read<TaskListBloc>(),
                              filter,
                            ),
                          ),
                          ReflectIconButton(
                            icon: Icons.sort_by_alpha,
                            tooltip: 'Sort',
                            onPressed: () => showTaskListSortMenu(
                              context,
                              context.read<TaskListBloc>(),
                              sortMode,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: ReflectSectionLabel(title: 'TASKS'),
                  ),
                  if (allTasks.isEmpty)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Center(
                          child: Text(
                            'Backlog is empty',
                            style: textTheme.bodyMedium?.copyWith(
                              color: ReflectColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => TaskCard(
                          task: allTasks[index],
                          taskRoutePrefix: '/backlog',
                        ),
                        childCount: allTasks.length,
                      ),
                    ),
                  const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: ReflectFab(
        heroTag: 'backlog_fab',
        onPressed: () => context.go('/backlog/task/new'),
      ),
    );
  }
}
