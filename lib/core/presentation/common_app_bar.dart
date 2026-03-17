import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBack;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
    this.onBack,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Check if we are on iOS/macOS to determine the platform style
    final isIos = !kIsWeb && (Platform.isIOS || Platform.isMacOS);

    if (isIos) {
      return _buildCupertinoBar(context);
    }
    return _buildMaterialBar(context);
  }

  /// Native iOS Navigation Bar
  Widget _buildCupertinoBar(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoNavigationBar(
      middle: Text(
        title,
        style: TextStyle(
          color: foregroundColor ?? theme.textTheme.titleLarge?.color,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: backgroundColor,
      // On iOS, 'actions' are usually placed in the trailing slot.
      // We wrap them in a Row if there are multiple.
      trailing: actions != null && actions!.isNotEmpty
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: actions!,
            )
          : null,
      // Custom leading logic for iOS
      leading: showBackButton
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              child: Icon(
                CupertinoIcons.back,
                color: foregroundColor ?? theme.primaryColor,
              ),
            )
          : null,
      // Remove border if needed to match elevation: 0
      border: null,
    );
  }

  /// Standard Material App Bar
  Widget _buildMaterialBar(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          color: foregroundColor ?? theme.appBarTheme.foregroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor ?? theme.appBarTheme.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 2,
      actions: actions != null ? [...actions!, const SizedBox(width: 8)] : null,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: foregroundColor ?? theme.appBarTheme.foregroundColor,
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
            )
          : null,
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
