import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/widgets/reflect_icon_button.dart';

void main() {
  testWidgets('ReflectIconButton shows icon and handles tap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReflectIconButton(
            icon: Icons.filter_list,
            tooltip: 'Filter',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.filter_list), findsOneWidget);
    await tester.tap(find.byType(ReflectIconButton));
    expect(tapped, isTrue);
  });
}
