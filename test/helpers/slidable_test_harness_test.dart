import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'slidable_test_harness.dart';

void main() {
  testWidgets('performEndAction opens pane and invokes delete callback', (
    tester,
  ) async {
    var deleted = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SlidableAutoCloseBehavior(
            child: Slidable(
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) => deleted = true,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete_outline,
                  ),
                ],
              ),
              child: const ListTile(title: Text('Swipe me')),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(SlidableAction), findsNothing);

    await SlidableTestHarness.performEndAction(
      tester,
      descendant: find.text('Swipe me'),
      icon: Icons.delete_outline,
    );

    expect(deleted, isTrue);
  });

  testWidgets('openEndPane exposes action without tapping', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Slidable(
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_outline,
                ),
              ],
            ),
            child: const ListTile(title: Text('Item')),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await SlidableTestHarness.openEndPane(
      tester,
      descendant: find.text('Item'),
    );

    expect(find.byType(SlidableAction), findsOneWidget);
  });
}
