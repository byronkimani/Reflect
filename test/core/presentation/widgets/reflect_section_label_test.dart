import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/reflect_section_label.dart';

void main() {
  testWidgets('ReflectSectionLabel uppercases title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(body: ReflectSectionLabel(title: 'Today')),
      ),
    );

    expect(find.text('TODAY'), findsOneWidget);
  });
}
