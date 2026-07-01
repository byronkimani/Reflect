import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/app_snackbar.dart';

Widget _snackbarHost({required void Function(BuildContext context) onShow}) {
  return MaterialApp(
    home: Scaffold(
      body: Builder(
        builder: (context) {
          return ElevatedButton(
            onPressed: () => onShow(context),
            child: const Text('Show'),
          );
        },
      ),
    ),
  );
}

void main() {
  group('AppSnackbar', () {
    testWidgets('show displays message with dismiss action', (tester) async {
      await tester.pumpWidget(
        _snackbarHost(
          onShow: (context) => AppSnackbar.show(context, 'Saved'),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      expect(find.text('Saved'), findsOneWidget);
      expect(find.text('DISMISS'), findsOneWidget);
    });

    testWidgets('dismiss action hides the snackbar', (tester) async {
      await tester.pumpWidget(
        _snackbarHost(
          onShow: (context) => AppSnackbar.show(context, 'Dismiss me'),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      expect(find.byType(SnackBar), findsOneWidget);

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      snackBar.action!.onPressed();
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsNothing);
    });

    testWidgets('showSuccess uses primary styling', (tester) async {
      final theme = ThemeData(useMaterial3: true);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => AppSnackbar.showSuccess(context, 'Done'),
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, theme.colorScheme.primary);
    });

    testWidgets('showError uses error styling', (tester) async {
      final theme = ThemeData(useMaterial3: true);

      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => AppSnackbar.showError(context, 'Failed'),
                  child: const Text('Show'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();

      final snackBar = tester.widget<SnackBar>(find.byType(SnackBar));
      expect(snackBar.backgroundColor, theme.colorScheme.error);
    });

    testWidgets('show replaces an existing snackbar', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => AppSnackbar.show(context, 'First'),
                      child: const Text('First'),
                    ),
                    ElevatedButton(
                      onPressed: () => AppSnackbar.show(context, 'Second'),
                      child: const Text('Second'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('First'));
      await tester.pump();
      expect(
        find.descendant(of: find.byType(SnackBar), matching: find.text('First')),
        findsOneWidget,
      );

      await tester.tap(find.text('Second'));
      await tester.pump();

      expect(
        find.descendant(of: find.byType(SnackBar), matching: find.text('First')),
        findsNothing,
      );
      expect(
        find.descendant(of: find.byType(SnackBar), matching: find.text('Second')),
        findsOneWidget,
      );
    });
  });
}
