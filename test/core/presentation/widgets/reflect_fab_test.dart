import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/reflect_fab.dart';

void main() {
  testWidgets('ReflectFab triggers onPressed', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          floatingActionButton: ReflectFab(
            heroTag: 'fab-test',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(FloatingActionButton));
    expect(pressed, isTrue);
  });
}
