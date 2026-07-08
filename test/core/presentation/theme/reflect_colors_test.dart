import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

void main() {
  group('ReflectColors', () {
    test('accent tokens match design system hex values', () {
      expect(ReflectColors.accentPrimary, const Color(0xFF7A9E9F));
      expect(ReflectColors.accentSoft, const Color(0xFFE8F0F0));
      expect(ReflectColors.pageBackground, const Color(0xFFFAFAF8));
      expect(ReflectColors.overdue, const Color(0xFFC45C5C));
    });

    test('priorityColor returns P1–P4 colors by index', () {
      expect(ReflectColors.priorityColor(0), ReflectColors.priorityP1);
      expect(ReflectColors.priorityColor(1), ReflectColors.priorityP2);
      expect(ReflectColors.priorityColor(2), ReflectColors.priorityP3);
      expect(ReflectColors.priorityColor(3), ReflectColors.priorityP4);
      expect(ReflectColors.priorityColor(99), ReflectColors.priorityP4);
    });

    test('priorityWash applies alpha to priority color', () {
      final wash = ReflectColors.priorityWash(ReflectColors.priorityP1);
      expect(wash.a, closeTo(0.12, 0.01));
    });
  });

  group('ReflectSpacing', () {
    test('spacing scale is monotonically increasing', () {
      expect(ReflectSpacing.xs, lessThan(ReflectSpacing.sm));
      expect(ReflectSpacing.sm, lessThan(ReflectSpacing.md));
      expect(ReflectSpacing.md, lessThan(ReflectSpacing.lg));
      expect(ReflectSpacing.lg, lessThan(ReflectSpacing.xl));
    });
  });
}
