import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/widgets/reflect_sticky_bottom_bar.dart';

void main() {
  group('ReflectStickyBottomBar', () {
    testWidgets('renders child with default full-screen bottom inset', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ReflectStickyBottomBar(
              child: Text('Save'),
            ),
          ),
        ),
      );

      final safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
      expect(safeArea.bottom, isTrue);
      expect(find.text('Save'), findsOneWidget);
    });

    testWidgets('safeBottom: false disables bottom inset', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ReflectStickyBottomBar(
              safeBottom: false,
              child: Text('Save'),
            ),
          ),
        ),
      );

      final safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
      expect(safeArea.bottom, isFalse);
    });

    testWidgets('applies custom padding', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            bottomNavigationBar: ReflectStickyBottomBar(
              padding: EdgeInsets.all(24),
              child: Text('Save'),
            ),
          ),
        ),
      );

      final paddingWidgets = tester.widgetList<Padding>(
        find.descendant(
          of: find.byType(ReflectStickyBottomBar),
          matching: find.byType(Padding),
        ),
      );
      expect(
        paddingWidgets.any((widget) => widget.padding == const EdgeInsets.all(24)),
        isTrue,
      );
    });
  });

  group('ReflectTabPageSafeArea', () {
    testWidgets('applies top safe area only', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReflectTabPageSafeArea(
              child: Text('Content'),
            ),
          ),
        ),
      );

      final safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
      expect(safeArea.top, isTrue);
      expect(safeArea.bottom, isFalse);
      expect(find.text('Content'), findsOneWidget);
    });
  });
}
