import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/more/presentation/pages/more_options_page.dart';

void main() {
  testWidgets('More options page shows title and menu rows', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MoreOptionsPage()),
    );

    expect(find.text('More options'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance & notifications'), findsOneWidget);
    expect(find.text('Analytics'), findsOneWidget);
    expect(find.text('Insights and trends'), findsOneWidget);
  });
}
