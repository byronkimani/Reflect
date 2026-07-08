import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/reflect_pill.dart';

Widget wrap(Widget child) => MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  testWidgets('ReflectPill shows label', (tester) async {
    await tester.pumpWidget(wrap(const ReflectPill(label: 'Today')));
    expect(find.text('Today'), findsOneWidget);
  });

  testWidgets('ReflectPill onTap fires when tapped', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      wrap(ReflectPill(label: 'Today', onTap: () => tapped = true)),
    );
    await tester.tap(find.text('Today'));
    expect(tapped, isTrue);
  });

  testWidgets('ReflectPill onClear fires when clear icon tapped', (tester) async {
    var cleared = false;
    await tester.pumpWidget(
      wrap(ReflectPill(label: 'Mar 18', onClear: () => cleared = true)),
    );
    await tester.tap(find.byIcon(Icons.close));
    expect(cleared, isTrue);
  });

  testWidgets('ReflectPill shows trailing icon when provided', (tester) async {
    await tester.pumpWidget(
      wrap(
        const ReflectPill(
          label: 'Pick date',
          trailingIcon: Icons.calendar_today_outlined,
        ),
      ),
    );

    expect(find.byIcon(Icons.calendar_today_outlined), findsOneWidget);
  });
}
