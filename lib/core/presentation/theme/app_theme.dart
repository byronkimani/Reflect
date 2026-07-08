import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

class AppTheme {
  static const _fontFamily = 'Inter';

  static ColorScheme _lightColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: ReflectColors.accentPrimary,
      onPrimary: Colors.white,
      primaryContainer: ReflectColors.accentSoft,
      onPrimaryContainer: ReflectColors.accentPrimary,
      secondary: ReflectColors.accentPrimary,
      onSecondary: Colors.white,
      secondaryContainer: ReflectColors.accentSoft,
      onSecondaryContainer: ReflectColors.textPrimary,
      tertiary: ReflectColors.priorityP3,
      onTertiary: Colors.white,
      error: ReflectColors.overdue,
      onError: Colors.white,
      surface: ReflectColors.cardSurface,
      onSurface: ReflectColors.textPrimary,
      onSurfaceVariant: ReflectColors.textSecondary,
      outline: ReflectColors.textSecondary,
      outlineVariant: ReflectColors.inputSurface,
      shadow: Colors.black26,
      scrim: Colors.black54,
      inverseSurface: ReflectColors.textPrimary,
      onInverseSurface: ReflectColors.cardSurface,
      inversePrimary: ReflectColors.accentSoft,
      surfaceTint: ReflectColors.accentPrimary,
      surfaceContainerHighest: ReflectColors.inputSurface,
      surfaceContainerHigh: ReflectColors.inputSurface,
      surfaceContainer: ReflectColors.cardSurface,
      surfaceContainerLow: ReflectColors.pageBackground,
      surfaceContainerLowest: ReflectColors.pageBackground,
    );
  }

  static ColorScheme _darkColorScheme() {
    const darkSurface = Color(0xFF1C1C1E);
    const darkCard = Color(0xFF2C2C2E);
    return ColorScheme(
      brightness: Brightness.dark,
      primary: ReflectColors.accentPrimary,
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFF3D4F50),
      onPrimaryContainer: ReflectColors.accentSoft,
      secondary: ReflectColors.accentPrimary,
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFF3D4F50),
      onSecondaryContainer: ReflectColors.accentSoft,
      tertiary: ReflectColors.priorityP3,
      onTertiary: Colors.white,
      error: ReflectColors.overdue,
      onError: Colors.white,
      surface: darkSurface,
      onSurface: Colors.white,
      onSurfaceVariant: const Color(0xFFAEAEB2),
      outline: const Color(0xFF8E8E93),
      outlineVariant: darkCard,
      shadow: Colors.black,
      scrim: Colors.black87,
      inverseSurface: Colors.white,
      onInverseSurface: darkSurface,
      inversePrimary: ReflectColors.accentPrimary,
      surfaceTint: ReflectColors.accentPrimary,
      surfaceContainerHighest: darkCard,
      surfaceContainerHigh: darkCard,
      surfaceContainer: darkCard,
      surfaceContainerLow: darkSurface,
      surfaceContainerLowest: const Color(0xFF121214),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base, ColorScheme colorScheme) {
    final inter = base.apply(fontFamily: _fontFamily);
    return inter.copyWith(
      displayLarge: inter.displayLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      displayMedium: inter.displayMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      displaySmall: inter.displaySmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      headlineLarge: inter.headlineLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      headlineMedium: inter.headlineMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      headlineSmall: inter.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
    );
  }

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final baseTextTheme = colorScheme.brightness == Brightness.light
        ? ThemeData.light().textTheme
        : ThemeData.dark().textTheme;
    final textTheme = _buildTextTheme(baseTextTheme, colorScheme);
    final scaffoldBg = colorScheme.brightness == Brightness.light
        ? ReflectColors.pageBackground
        : colorScheme.surfaceContainerLowest;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,
      fontFamily: _fontFamily,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scaffoldBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontFamily: _fontFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: ReflectColors.accentSoft,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontFamily: _fontFamily,
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected
                ? ReflectColors.accentPrimary
                : ReflectColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected
                ? ReflectColors.accentPrimary
                : ReflectColors.textSecondary,
            size: 24,
          );
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ReflectColors.inputSurface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: ReflectColors.accentPrimary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ReflectColors.accentPrimary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ReflectSpacing.cardRadius),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ReflectColors.accentPrimary,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(ReflectSpacing.fabRadius)),
        ),
      ),
      cardTheme: CardThemeData(
        color: ReflectColors.cardSurface,
        elevation: 1,
        shadowColor: Colors.black.withValues(alpha: 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ReflectSpacing.cardRadius),
        ),
      ),
    );
  }

  static ThemeData get lightTheme => _buildTheme(_lightColorScheme());

  static ThemeData get darkTheme => _buildTheme(_darkColorScheme());
}
