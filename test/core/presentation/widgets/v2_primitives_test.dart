import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/priority_dot.dart';
import 'package:reflect/core/presentation/widgets/reflect_hairline.dart';
import 'package:reflect/core/presentation/widgets/reflect_page_header.dart';
import 'package:reflect/core/presentation/widgets/reflect_segmented_control.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';

Widget wrap(Widget child) => MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: child),
    );

void main() {
  group('ReflectPageHeader', () {
    testWidgets('shows eyebrow and title', (tester) async {
      await tester.pumpWidget(
        wrap(
          const ReflectPageHeader(
            eyebrow: 'Good morning',
            title: 'Tuesday, Jul 7',
          ),
        ),
      );

      expect(find.text('GOOD MORNING'), findsOneWidget);
      expect(find.text('Tuesday, Jul 7'), findsOneWidget);
    });

    testWidgets('shows trailing actions when provided', (tester) async {
      await tester.pumpWidget(
        wrap(
          const ReflectPageHeader(
            title: 'Backlog',
            trailing: Icon(Icons.tune),
          ),
        ),
      );

      expect(find.byIcon(Icons.tune), findsOneWidget);
    });
  });

  group('PriorityDot', () {
    testWidgets('shows dot without label by default', (tester) async {
      await tester.pumpWidget(
        wrap(const PriorityDot(priority: TaskPriority.p1)),
      );

      expect(find.text('P1'), findsNothing);
    });

    testWidgets('shows label when showLabel is true', (tester) async {
      await tester.pumpWidget(
        wrap(const PriorityDot(priority: TaskPriority.p2, showLabel: true)),
      );

      expect(find.text('P2'), findsOneWidget);
    });
  });

  group('ReflectHairline', () {
    testWidgets('renders divider widget', (tester) async {
      await tester.pumpWidget(wrap(const ReflectHairline()));

      expect(find.byType(ReflectHairline), findsOneWidget);
    });
  });

  group('ReflectSegmentedControl', () {
    testWidgets('priority factory calls onChanged', (tester) async {
      TaskPriority? selected;
      await tester.pumpWidget(
        wrap(
          ReflectSegmentedControl.priority(
            selected: TaskPriority.p3,
            onChanged: (p) => selected = p,
          ),
        ),
      );

      await tester.tap(find.text('P1'));
      expect(selected, TaskPriority.p1);
    });

    testWidgets('priority factory shows all four segments', (tester) async {
      await tester.pumpWidget(
        wrap(
          ReflectSegmentedControl.priority(
            selected: TaskPriority.p4,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.text('P1'), findsOneWidget);
      expect(find.text('P4'), findsOneWidget);
    });
  });
}
