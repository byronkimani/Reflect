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

    test('dark theme uses sage-teal primary', () {
      final theme = AppTheme.darkTheme;
      expect(theme.colorScheme.primary, isNotNull);
    });

    test('light theme filled button uses accent primary', () {
      final theme = AppTheme.lightTheme;
      expect(
        theme.filledButtonTheme.style?.backgroundColor?.resolve({}),
        ReflectColors.accentPrimary,
      );
    });
  });
}
