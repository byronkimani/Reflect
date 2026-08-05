import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/theme/reflect_colors.dart';

class AppTheme {
  static const _fontFamily = 'Inter';

  static TextTheme _buildTextTheme(TextTheme base, ColorScheme colorScheme) {
    final themed = base.apply(
      fontFamily: _fontFamily,
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    );

    return themed.copyWith(
      displayLarge: themed.displayLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
      ),
      displayMedium: themed.displayMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.4,
      ),
      displaySmall: themed.displaySmall?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      headlineLarge: themed.headlineLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        fontSize: 34,
        height: 1.0,
      ),
      headlineMedium: themed.headlineMedium?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.25,
      ),
      headlineSmall: themed.headlineSmall?.copyWith(
        fontWeight: FontWeight.w600,
      ),
      titleLarge: themed.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: themed.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      labelSmall: themed.labelSmall?.copyWith(
        letterSpacing: 1.5,
        fontWeight: FontWeight.w600,
        fontSize: 11,
      ),
    );
  }

  static ColorScheme _lightColorScheme() {
    return ColorScheme(
      brightness: Brightness.light,
      primary: ReflectColors.ink,
      onPrimary: ReflectColors.paper,
      primaryContainer: ReflectColors.paperSoft,
      onPrimaryContainer: ReflectColors.ink,
      secondary: ReflectColors.ink,
      onSecondary: ReflectColors.paper,
      secondaryContainer: ReflectColors.paperSoft,
      onSecondaryContainer: ReflectColors.ink,
      tertiary: ReflectColors.priorityP3,
      onTertiary: ReflectColors.paper,
      error: ReflectColors.overdue,
      onError: ReflectColors.paper,
      surface: ReflectColors.paper,
      onSurface: ReflectColors.ink,
      onSurfaceVariant: ReflectColors.textSecondary,
      outline: ReflectColors.hairline,
      outlineVariant: ReflectColors.paperSoft,
      shadow: Colors.transparent,
      scrim: Colors.black54,
      inverseSurface: ReflectColors.ink,
      onInverseSurface: ReflectColors.paper,
      inversePrimary: ReflectColors.paperSoft,
      surfaceTint: Colors.transparent,
      surfaceContainerHighest: ReflectColors.paperSoft,
      surfaceContainerHigh: ReflectColors.paperSoft,
      surfaceContainer: ReflectColors.paper,
      surfaceContainerLow: ReflectColors.paper,
      surfaceContainerLowest: ReflectColors.paper,
    );
  }

  static ColorScheme _darkColorScheme() {
    const darkSurface = Color(0xFF1C1C1E);
    const darkCard = Color(0xFF2C2C2E);
    return ColorScheme(
      brightness: Brightness.dark,
      primary: ReflectColors.ink,
      onPrimary: ReflectColors.paper,
      primaryContainer: darkCard,
      onPrimaryContainer: ReflectColors.paper,
      secondary: ReflectColors.ink,
      onSecondary: ReflectColors.paper,
      secondaryContainer: darkCard,
      onSecondaryContainer: ReflectColors.paper,
      tertiary: ReflectColors.priorityP3,
      onTertiary: ReflectColors.paper,
      error: ReflectColors.overdue,
      onError: ReflectColors.paper,
      surface: darkSurface,
      onSurface: Colors.white,
      onSurfaceVariant: const Color(0xFFAEAEB2),
      outline: const Color(0xFF8E8E93),
      outlineVariant: darkCard,
      shadow: Colors.transparent,
      scrim: Colors.black87,
      inverseSurface: Colors.white,
      onInverseSurface: darkSurface,
      inversePrimary: ReflectColors.ink,
      surfaceTint: Colors.transparent,
      surfaceContainerHighest: darkCard,
      surfaceContainerHigh: darkCard,
      surfaceContainer: darkCard,
      surfaceContainerLow: darkSurface,
      surfaceContainerLowest: const Color(0xFF121214),
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
      dividerTheme: const DividerThemeData(
        color: ReflectColors.hairline,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: scaffoldBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: ReflectColors.paperSoft,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            fontSize: 10,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            letterSpacing: 0.8,
            color: selected
                ? ReflectColors.ink
                : ReflectColors.textSecondary,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected
                ? ReflectColors.ink
                : ReflectColors.textSecondary,
            size: 22,
          );
        }),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
        alignLabelWithHint: true,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: ReflectColors.hairline),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ReflectColors.hairline),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ReflectColors.ink, width: 2),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ReflectColors.ink,
          foregroundColor: ReflectColors.paper,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ReflectSpacing.cardRadius),
          ),
          textStyle: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ReflectColors.ink,
        foregroundColor: ReflectColors.paper,
        elevation: 0,
        shape: CircleBorder(),
      ),
      cardTheme: CardThemeData(
        color: ReflectColors.paper,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ReflectSpacing.cardRadius),
          side: const BorderSide(color: ReflectColors.hairline),
        ),
      ),
    );
  }

  static ThemeData get lightTheme => _buildTheme(_lightColorScheme());

  static ThemeData get darkTheme => _buildTheme(_darkColorScheme());
}
