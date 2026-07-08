import 'package:flutter/material.dart';

/// Design tokens for the 2026 Reflect UI refresh.
/// See docs/design/design-system.md
abstract final class ReflectColors {
  static const accentPrimary = Color(0xFF7A9E9F);
  static const accentSoft = Color(0xFFE8F0F0);
  static const pageBackground = Color(0xFFFAFAF8);
  static const cardSurface = Color(0xFFFFFFFF);
  static const inputSurface = Color(0xFFF5F5F3);
  static const textPrimary = Color(0xFF1A1A1A);
  static const textSecondary = Color(0xFF8A8A8A);
  static const overdue = Color(0xFFC45C5C);

  static const priorityP1 = Color(0xFFC45C5C);
  static const priorityP2 = Color(0xFFC49A6C);
  static const priorityP3 = Color(0xFF7A8FA8);
  static const priorityP4 = Color(0xFF9A9A9A);

  static Color priorityWash(Color priority) =>
      priority.withValues(alpha: 0.12);

  static Color priorityColor(int index) => switch (index) {
        0 => priorityP1,
        1 => priorityP2,
        2 => priorityP3,
        _ => priorityP4,
      };
}

abstract final class ReflectSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;

  static const double cardRadius = 16;
  static const double pillRadius = 20;
  static const double fabRadius = 16;
}
