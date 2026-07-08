import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/reflect_progress_bar.dart';

void main() {
  testWidgets('ReflectProgressBar shows label', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: ReflectProgressBar(progress: 0.5, label: '2/4'),
        ),
      ),
    );

    expect(find.text('2/4'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('ReflectProgressBar clamps progress above 1', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: ReflectProgressBar(progress: 2.0),
        ),
      ),
    );

    final indicator = tester.widget<LinearProgressIndicator>(
      find.byType(LinearProgressIndicator),
    );
    expect(indicator.value, 1.0);
  });
}
