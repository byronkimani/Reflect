import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/expandable_section_row.dart';

void main() {
  testWidgets('ExpandableSectionRow shows title and expand icon when collapsed',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: ExpandableSectionRow(
            title: 'Repeats',
            icon: Icons.repeat,
            expanded: false,
            onTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Repeats'), findsOneWidget);
    expect(find.byIcon(Icons.expand_more), findsOneWidget);
  });

  testWidgets('ExpandableSectionRow shows child when expanded', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: ExpandableSectionRow(
            title: 'Repeats',
            icon: Icons.repeat,
            expanded: true,
            onTap: () {},
            child: const Text('Weekly options'),
          ),
        ),
      ),
    );

    expect(find.text('Weekly options'), findsOneWidget);
    expect(find.byIcon(Icons.expand_less), findsOneWidget);
  });

  testWidgets('ExpandableSectionRow onTap fires', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: ExpandableSectionRow(
            title: 'Repeats',
            icon: Icons.repeat,
            expanded: false,
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Repeats'));
    expect(tapped, isTrue);
  });
}
