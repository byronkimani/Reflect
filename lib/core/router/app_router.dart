import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/app_scaffold.dart';
import 'package:reflect/features/tasks/presentation/pages/today_page.dart';
import 'package:reflect/features/tasks/presentation/pages/backlog_page.dart';
import 'package:reflect/features/goals/presentation/pages/goals_page.dart';
import 'package:reflect/features/review/presentation/pages/daily_review_page.dart';
import 'package:reflect/features/analytics/presentation/pages/insights_page.dart';
import 'package:reflect/features/tasks/presentation/pages/task_detail_page.dart';
import 'package:reflect/features/planning/presentation/pages/planning_page.dart';

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
                      return TaskDetailPage(taskId: id);
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
              ),
            ],
          ),
          // Branch 3: Goals
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/goals',
                builder: (context, state) => const GoalsPage(),
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
