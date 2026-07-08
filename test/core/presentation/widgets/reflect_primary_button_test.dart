import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/reflect_primary_button.dart';

void main() {
  testWidgets('ReflectPrimaryButton shows label and handles tap', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: ReflectPrimaryButton(
            label: 'Save',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Save'), findsOneWidget);
    await tester.tap(find.text('Save'));
    expect(pressed, isTrue);
  });

  testWidgets('ReflectPrimaryButton is disabled when loading', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: ReflectPrimaryButton(
            label: 'Save',
            isLoading: true,
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(FilledButton));
    expect(pressed, isFalse);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
