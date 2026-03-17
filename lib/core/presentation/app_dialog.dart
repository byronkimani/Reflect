import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

class AppDialog {
  /// Shows a platform-adaptive dialog.
  ///
  /// [title] and [content] are usually Strings.
  /// [primaryActionText] is the main confirmation button (e.g., "OK", "Delete").
  /// [onPrimaryAction] is the callback for the primary button.
  /// [secondaryActionText] is optional (e.g., "Cancel").
  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required String content,
    String primaryActionText = "OK",
    VoidCallback? onPrimaryAction,
    String? secondaryActionText,
    VoidCallback? onSecondaryAction,
    bool isDestructiveAction = false,
  }) {
    final isIos = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

    if (isIos) {
      return showCupertinoDialog<T>(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            if (secondaryActionText != null)
              CupertinoDialogAction(
                onPressed: () {
                  onSecondaryAction?.call();
                  context.pop();
                },
                child: Text(secondaryActionText),
              ),
            CupertinoDialogAction(
              isDestructiveAction: isDestructiveAction,
              isDefaultAction: true,
              onPressed: () {
                onPrimaryAction?.call();
                context.pop();
              },
              child: Text(primaryActionText),
            ),
          ],
        ),
      );
    }

    return showDialog<T>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          if (secondaryActionText != null)
            TextButton(
              onPressed: () {
                onSecondaryAction?.call();
                context.pop();
              },
              child: Text(secondaryActionText),
            ),
          TextButton(
            onPressed: () {
              onPrimaryAction?.call();
              context.pop();
            },
            style: isDestructiveAction
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  )
                : null,
            child: Text(primaryActionText),
          ),
        ],
      ),
    );
  }
}
