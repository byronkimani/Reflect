import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Pumps a [child] inside a minimal [MaterialApp] scaffold for page tests.
Future<void> pumpMaterialPage(
  WidgetTester tester,
  Widget child, {
  ThemeData? theme,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: theme,
      home: Scaffold(body: child),
    ),
  );
  await tester.pump();
}
