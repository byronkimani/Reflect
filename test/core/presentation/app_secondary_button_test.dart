import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/app_secondary_button.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';

void main() {
  testWidgets('AppSecondaryButton shows text and handles tap', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: AppSecondaryButton(
            text: 'Cancel',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Cancel'));
    expect(pressed, isTrue);
  });

  testWidgets('AppSecondaryButton shows loading indicator', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: AppSecondaryButton(
            text: 'Cancel',
            onPressed: null,
            isLoading: true,
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('AppSecondaryButton renders outlined style on iOS theme', (
    tester,
  ) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme.copyWith(platform: TargetPlatform.iOS),
        home: Scaffold(
          body: AppSecondaryButton(
            text: 'Cancel',
            icon: Icons.close,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.byType(CupertinoButton), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    expect(pressed, isTrue);
  });

  testWidgets('AppSecondaryButton is disabled while loading', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme.copyWith(platform: TargetPlatform.android),
        home: Scaffold(
          body: AppSecondaryButton(
            text: 'Cancel',
            isLoading: true,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(OutlinedButton), warnIfMissed: false);
    expect(pressed, isFalse);
  });
}
