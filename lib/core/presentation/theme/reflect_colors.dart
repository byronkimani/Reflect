import 'package:flutter/material.dart';

/// Design tokens for Reflect — Paper & Ink palette.
/// Source of truth: this file and [AppTheme].
abstract final class ReflectColors {
  // v2 Paper & Ink
  static const paper = Color(0xFFF5F3EE);
  static const paperSoft = Color(0xFFEDE9E2);
  static const ink = Color(0xFF0D0D0D);
  static const hairline = Color(0xFFE0DBD3);

  // Semantic aliases (backward compatible names)
  static const pageBackground = paper;
  static const cardSurface = paper;
  static const inputSurface = paperSoft;
  static const textPrimary = ink;
  static const textSecondary = Color(0xFF6B6B6B);

  /// Primary actions, FAB, active emphasis — ink in v2.
  static const accentPrimary = ink;
  static const accentSoft = paperSoft;

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

  /// v2 max control radius.
  static const double cardRadius = 8;
  static const double pillRadius = 20;
  static const double fabRadius = 28;
}
