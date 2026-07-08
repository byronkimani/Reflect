import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/reflect_soft_field.dart';

void main() {
  testWidgets('ReflectSoftField shows label and hint', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: ReflectSoftField(
            labelText: 'Notes',
            hintText: 'Add details...',
          ),
        ),
      ),
    );

    expect(find.text('Notes'), findsOneWidget);
    expect(find.text('Add details...'), findsOneWidget);
  });

  testWidgets('ReflectSoftField onChanged fires on input', (tester) async {
    String? value;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: ReflectSoftField(
            onChanged: (v) => value = v,
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextFormField), 'Hello');
    expect(value, 'Hello');
  });
}
