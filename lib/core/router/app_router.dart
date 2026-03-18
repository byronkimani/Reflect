import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/app_scaffold.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:reflect/features/tasks/presentation/pages/today_page.dart';
import 'package:reflect/features/tasks/presentation/pages/backlog_page.dart';
import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/features/goals/presentation/pages/goals_page.dart';
import 'package:reflect/features/goals/presentation/pages/goal_form_page.dart';
import 'package:reflect/features/review/presentation/pages/daily_review_page.dart';
import 'package:reflect/features/analytics/presentation/pages/insights_page.dart';
import 'package:reflect/features/tasks/presentation/pages/task_detail_page.dart';
import 'package:reflect/features/planning/presentation/pages/planning_page.dart';
import 'package:reflect/main.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createAppRouter() {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/today',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Today
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/today',
                builder: (context, state) => const TodayPage(),
                routes: [
                  GoRoute(
                    path: 'task/:id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final id = state.pathParameters['id'] ?? 'new';
                      final task = state.extra as Task?;
                      return TaskDetailPage(taskId: id, initialTask: task);
                    },
                  ),
                  GoRoute(
                    path: 'planning',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const PlanningPage(),
                  ),
                  GoRoute(
                    path: 'review',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const DailyReviewPage(),
                  ),
                ],
              ),
            ],
          ),
          // Branch 2: Backlog
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/backlog',
                builder: (context, state) => const BacklogPage(),
                routes: [
                  GoRoute(
                    path: 'task/:id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final id = state.pathParameters['id'] ?? 'new';
                      final task = state.extra is Task ? state.extra as Task? : null;
                      return TaskDetailPage(
                        taskId: id,
                        initialTask: task,
                        isBacklogContext: true,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          // Branch 3: Goals
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/goals',
                builder: (context, state) => BlocProvider(
                  create: (_) => getIt<GoalsCubit>(),
                  child: const GoalsPage(),
                ),
                routes: [
                  GoRoute(
                    path: 'new',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final horizon = state.extra is GoalTimeHorizon
                          ? state.extra as GoalTimeHorizon
                          : GoalTimeHorizon.weekly;
                      return GoalFormPage(initialGoal: null, timeHorizon: horizon);
                    },
                  ),
                  GoRoute(
                    path: ':id',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      final goal = state.extra is Goal ? state.extra as Goal : null;
                      return GoalFormPage(initialGoal: goal);
                    },
                  ),
                ],
              ),
            ],
          ),
          // Branch 4: Reflect
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reflect',
                builder: (context, state) => const DailyReviewPage(),
              ),
            ],
          ),
          // Branch 5: Insights
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/insights',
                builder: (context, state) => const InsightsPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
