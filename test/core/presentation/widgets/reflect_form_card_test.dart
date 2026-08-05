import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/reflect_form_card.dart';

void main() {
  testWidgets('ReflectFormCard shows title and child', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: ReflectFormCard(
            title: 'Reflection',
            child: Text('Body content'),
          ),
        ),
      ),
    );

    expect(find.text('REFLECTION'), findsOneWidget);
    expect(find.text('Body content'), findsOneWidget);
  });
}
