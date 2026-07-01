import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/utils/adaptive_dialog.dart';

void main() {
  group('showAdaptiveConfirmationDialog', () {
    testWidgets('renders CupertinoAlertDialog on iOS (using tap)', (tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showAdaptiveConfirmationDialog(
                    context: context,
                    title: 'Test Title',
                    message: 'Test Message',
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(CupertinoAlertDialog), findsOneWidget);
      expect(find.byType(AlertDialog), findsNothing);

      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(result, true);
    });

    testWidgets('renders AlertDialog on Android (using tap)', (tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showAdaptiveConfirmationDialog(
                    context: context,
                    title: 'Test Title',
                    message: 'Test Message',
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.byType(CupertinoAlertDialog), findsNothing);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(result, false);
    });

    testWidgets('iOS cancel returns false', (tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.iOS),
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showAdaptiveConfirmationDialog(
                    context: context,
                    title: 'Discard',
                    message: 'Lose changes?',
                    confirmLabel: 'Discard',
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(result, false);
    });

    testWidgets('Android confirm returns true for destructive action', (
      tester,
    ) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: TargetPlatform.android),
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  result = await showAdaptiveConfirmationDialog(
                    context: context,
                    title: 'Delete task',
                    message: 'Permanent delete?',
                  );
                },
                child: const Text('Show Dialog'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await tester.pumpAndSettle();

      expect(result, true);
    });
  });
}
