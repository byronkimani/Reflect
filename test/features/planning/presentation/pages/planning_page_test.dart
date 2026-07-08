import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/planning/presentation/pages/planning_page.dart';

void main() {
  testWidgets('PlanningPage shows Morning Planning title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: PlanningPage()),
    );

    expect(find.text('Morning Planning'), findsNWidgets(2));
  });
}
