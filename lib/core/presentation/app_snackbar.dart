import 'package:flutter/material.dart';

class AppSnackbar {
  static void show(
    BuildContext context,
    String message, {
    bool isError = false,
    Duration duration = const Duration(seconds: 4),
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isError ? colorScheme.onError : colorScheme.onPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: isError ? colorScheme.error : colorScheme.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          margin: const EdgeInsets.all(16),
          duration: duration,
          action: SnackBarAction(
            label: 'DISMISS',
            textColor: isError ? colorScheme.onError : colorScheme.onPrimary,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
  }

  /// Helper for success messages
  static void showSuccess(BuildContext context, String message) {
    show(context, message, isError: false);
  }

  /// Helper for error messages
  static void showError(
    BuildContext context,
    String message, {
    Duration? duration,
  }) {
    show(context, message, isError: true);
  }
}
