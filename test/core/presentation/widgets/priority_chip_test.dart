import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/priority_chip.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

void main() {
  testWidgets('PriorityChip delegates to PriorityLozenge', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: PriorityChip(priority: TaskPriority.p1),
        ),
      ),
    );

    expect(find.text('P1'), findsOneWidget);
  });

  test('labelFor and colorFor delegate to PriorityLozenge', () {
    expect(PriorityChip.labelFor(TaskPriority.p2), 'High');
    expect(PriorityChip.colorFor(TaskPriority.p1), isA<Color>());
  });
}
