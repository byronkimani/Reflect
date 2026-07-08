import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/app_error_widget.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';

void main() {
  testWidgets('AppErrorWidget shows message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: AppErrorWidget(message: 'Something went wrong'),
        ),
      ),
    );

    expect(find.text('Oops!'), findsOneWidget);
    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('AppErrorWidget retry button calls onRetry', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: AppErrorWidget(
            message: 'Error',
            onRetry: () => retried = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Try Again'));
    expect(retried, isTrue);
  });
}
