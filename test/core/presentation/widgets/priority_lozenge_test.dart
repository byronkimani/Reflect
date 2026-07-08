import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/widgets/priority_lozenge.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  testWidgets('PriorityLozenge shows P1 label', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PriorityLozenge(priority: TaskPriority.p1),
        ),
      ),
    );

    expect(find.text('P1'), findsOneWidget);
  });

  testWidgets('PriorityLozenge selected state shows accent border', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PriorityLozenge(
            priority: TaskPriority.p2,
            isSelected: true,
          ),
        ),
      ),
    );

    expect(find.text('P2'), findsOneWidget);
  });
}
