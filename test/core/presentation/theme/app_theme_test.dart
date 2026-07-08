import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

void main() {
  group('AppTheme', () {
    test('light theme uses sage-teal seed color', () {
      final theme = AppTheme.lightTheme;
      expect(theme.colorScheme.primary, ReflectColors.accentPrimary);
      expect(theme.scaffoldBackgroundColor, ReflectColors.pageBackground);
    });

    test('dark theme uses dark surfaces and accent primary', () {
      final theme = AppTheme.darkTheme;
      expect(theme.colorScheme.brightness, Brightness.dark);
      expect(theme.colorScheme.primary, ReflectColors.accentPrimary);
      expect(theme.colorScheme.surface, const Color(0xFF1C1C1E));
      expect(theme.scaffoldBackgroundColor, const Color(0xFF121214));
    });

    test('dark theme filled button uses accent primary', () {
      final theme = AppTheme.darkTheme;
      expect(
        theme.filledButtonTheme.style?.backgroundColor?.resolve({}),
        ReflectColors.accentPrimary,
      );
    });

    test('dark theme navigation bar styles selected and unselected states', () {
      final theme = AppTheme.darkTheme;
      final navTheme = theme.navigationBarTheme;

      final selectedLabel = navTheme.labelTextStyle?.resolve({WidgetState.selected});
      final unselectedLabel =
          navTheme.labelTextStyle?.resolve(<WidgetState>{});

      expect(selectedLabel?.fontWeight, FontWeight.w600);
      expect(unselectedLabel?.fontWeight, FontWeight.w500);
      expect(selectedLabel?.color, ReflectColors.accentPrimary);
      expect(unselectedLabel?.color, ReflectColors.textSecondary);

      final selectedIcon =
          navTheme.iconTheme?.resolve({WidgetState.selected});
      final unselectedIcon = navTheme.iconTheme?.resolve(<WidgetState>{});

      expect(selectedIcon?.color, ReflectColors.accentPrimary);
      expect(unselectedIcon?.color, ReflectColors.textSecondary);
    });
  });
}
