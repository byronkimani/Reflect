import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:reflect/core/presentation/widgets/task_card.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => Center(child: Text('Error: $message')),
            loaded: (pending, completed, overdue, sortMode) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    expandedHeight: 120.0,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        DateFormat('EEEE, MMM d').format(DateTime.now()),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      centerTitle: false,
                      titlePadding: const EdgeInsetsDirectional.only(
                        start: 16,
                        bottom: 16,
                      ),
                    ),
                  ),
                  if (overdue.isNotEmpty) ...[
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                        child: Text(
                          'Overdue',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => TaskCard(task: overdue[index]),
                        childCount: overdue.length,
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                      child: Text(
                        'Tasks',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (pending.isEmpty)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(
                          child: Text(
                            'No tasks for today. Plus some rest?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          // Already sorted by priority in Bloc ideally, but we'll ensure here if needed
                          final sortedPending = List.from(pending)
                            ..sort((a, b) => a.priority.index.compareTo(b.priority.index));
                          return TaskCard(task: sortedPending[index]);
                        },
                        childCount: pending.length,
                      ),
                    ),
                  if (completed.isNotEmpty) ...[
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => TaskCard(task: completed[index]),
                        childCount: completed.length,
                      ),
                    ),
                  ],
                  // Extra space at bottom for FAB
                  const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/today/task/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
