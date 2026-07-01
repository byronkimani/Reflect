import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:reflect/core/presentation/app_dialog.dart';

void main() {
  group('AppDialog.show', () {
    testWidgets('shows AlertDialog on Android platform theme', (tester) async {
      var primaryCalled = false;

      await tester.pumpWidget(
        MaterialApp.router(
          theme: ThemeData(platform: TargetPlatform.android),
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context,
                        title: 'Delete item',
                        content: 'This cannot be undone.',
                        primaryActionText: 'Delete',
                        secondaryActionText: 'Cancel',
                        isDestructiveAction: true,
                        onPrimaryAction: () => primaryCalled = true,
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(CupertinoAlertDialog), findsNothing);

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(primaryCalled, isTrue);
    });

    testWidgets('shows CupertinoAlertDialog on iOS platform theme', (
      tester,
    ) async {
      var secondaryCalled = false;

      await tester.pumpWidget(
        MaterialApp.router(
          theme: ThemeData(platform: TargetPlatform.iOS),
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context,
                        title: 'Confirm',
                        content: 'Proceed?',
                        primaryActionText: 'OK',
                        secondaryActionText: 'Cancel',
                        onSecondaryAction: () => secondaryCalled = true,
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoAlertDialog), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(secondaryCalled, isTrue);
    });

    testWidgets('iOS primary action invokes callback and closes dialog', (
      tester,
    ) async {
      var primaryCalled = false;

      await tester.pumpWidget(
        MaterialApp.router(
          theme: ThemeData(platform: TargetPlatform.iOS),
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context,
                        title: 'Remove',
                        content: 'Are you sure?',
                        primaryActionText: 'Remove',
                        secondaryActionText: 'Cancel',
                        isDestructiveAction: true,
                        onPrimaryAction: () => primaryCalled = true,
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(CupertinoDialogAction).last);
      await tester.pumpAndSettle();

      expect(primaryCalled, isTrue);
      expect(find.byType(CupertinoAlertDialog), findsNothing);
    });

    testWidgets('Android secondary action invokes callback and closes dialog', (
      tester,
    ) async {
      var secondaryCalled = false;

      await tester.pumpWidget(
        MaterialApp.router(
          theme: ThemeData(platform: TargetPlatform.android),
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context,
                        title: 'Confirm',
                        content: 'Proceed?',
                        primaryActionText: 'OK',
                        secondaryActionText: 'Cancel',
                        onSecondaryAction: () => secondaryCalled = true,
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(secondaryCalled, isTrue);
      expect(find.byType(AlertDialog), findsNothing);
    });

    testWidgets('shows only primary action when secondary is omitted', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp.router(
          theme: ThemeData(platform: TargetPlatform.android),
          routerConfig: GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      AppDialog.show(
                        context,
                        title: 'Notice',
                        content: 'All set.',
                      );
                    },
                    child: const Text('Open'),
                  );
                },
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.text('OK'), findsOneWidget);
      expect(find.text('Cancel'), findsNothing);
    });
  });
}
