import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/app_scaffold.dart';
import 'package:reflect/features/post/presentation/post_detail_screen.dart';
import 'package:reflect/features/post/presentation/posts_screen.dart';

import 'package:reflect/features/profile/profile.dart';

// Create a function so we can pass the bloc for redirection logic
GoRouter createAppRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final sectionNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    routes: [
      // StatefulShellRoute implements the persistent bottom navigation
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Branch 1: Posts
          StatefulShellBranch(
            navigatorKey: sectionNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const PostsScreen(),
                routes: [
                  // This child route will cover the bottom nav when opened.
                  // To make it appear *inside* the tab (with nav bar still visible),
                  // just move 'parentNavigatorKey' to sectionNavigatorKey.
                  GoRoute(
                    path: 'posts/:postId',
                    parentNavigatorKey: rootNavigatorKey, // Covers bottom nav
                    builder: (context, state) {
                      final postId = state.pathParameters['postId'];
                      return PostDetailScreen(postId: postId ?? '0');
                    },
                  ),
                ],
              ),
            ],
          ),
          // Branch 2: Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
