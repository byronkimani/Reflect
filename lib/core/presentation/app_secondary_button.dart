import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'app_loading_indicator.dart';

class AppSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;

  const AppSecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isIos = !kIsWeb && (Platform.isIOS || Platform.isMacOS);
    final theme = Theme.of(context);

    if (isIos) {
      // iOS doesn't have a native "Outlined Button" concept in the standard kit,
      // but we can simulate it with a CupertinoButton containing a decorated Container
      // or simply use the default CupertinoButton which is text-only (very common for secondary).
      // Here, I'll mimic the "Outlined" look to maintain design consistency across platforms.
      return SizedBox(
        width: width ?? double.infinity,
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: isLoading ? null : onPressed,
          child: Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: theme.primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: _buildContent(context),
          ),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: theme.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: theme.primaryColor,
        ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return AppLoadingIndicator(
        color: Theme.of(context).primaryColor,
        radius: 10,
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
