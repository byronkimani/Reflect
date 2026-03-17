import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'app_loading_indicator.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;

  const AppButton({
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

    if (isIos) {
      return SizedBox(
        width: width ?? double.infinity,
        child: CupertinoButton.filled(
          onPressed: isLoading ? null : onPressed,
          disabledColor: CupertinoColors.quaternarySystemFill,
          child: _buildContent(isIos: true),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _buildContent(isIos: false),
      ),
    );
  }

  Widget _buildContent({required bool isIos}) {
    if (isLoading) {
      return const AppLoadingIndicator(color: Colors.white, radius: 10);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[Icon(icon, size: 20), const SizedBox(width: 8)],
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            // Ensure text is readable on iOS primary button
            color: isIos ? Colors.white : null,
          ),
        ),
      ],
    );
  }
}
