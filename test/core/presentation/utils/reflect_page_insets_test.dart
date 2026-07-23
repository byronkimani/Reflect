import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/utils/reflect_page_insets.dart';

void main() {
  testWidgets('reflectTabHeaderPadding includes status bar inset', (
    tester,
  ) async {
    late EdgeInsets padding;

    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(padding: EdgeInsets.only(top: 44)),
          child: Builder(
            builder: (context) {
              padding = reflectTabHeaderPadding(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );

    expect(padding.top, 60);
    expect(padding.left, 16);
    expect(padding.right, 16);
  });

  test('kReflectTabBarScrollClearance is positive', () {
    expect(kReflectTabBarScrollClearance, greaterThan(0));
  });
}
