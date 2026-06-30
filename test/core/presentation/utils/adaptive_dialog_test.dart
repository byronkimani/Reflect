import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/utils/adaptive_dialog.dart';

void main() {
  testWidgets('showAdaptiveConfirmationDialog displays and can be cancelled', (tester) async {
    bool? result;

    await tester.pumpWidget(
      MaterialApp(
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

    // Tap to show dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Verify it shows
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.text('Test Message'), findsOneWidget);

    // Tap cancel
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(result, false);
  });

  testWidgets('showAdaptiveConfirmationDialog displays and can be confirmed', (tester) async {
    bool? result;

    await tester.pumpWidget(
      MaterialApp(
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

    // Tap to show dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Tap delete/confirm
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(result, true);
  });
}
