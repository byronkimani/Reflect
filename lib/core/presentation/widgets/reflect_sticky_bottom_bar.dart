import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/utils/reflect_page_insets.dart';

/// Sticky primary-action bar for [Scaffold.bottomNavigationBar].
///
/// Applies bottom [SafeArea] on full-screen routes so CTAs clear the home
/// indicator. When embedded in the tab shell, bottom inset is skipped because
/// the tab bar already handles it.
class ReflectStickyBottomBar extends StatelessWidget {
  const ReflectStickyBottomBar({
    super.key,
    required this.child,
    this.padding,
    this.safeBottom,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  /// When null, bottom safe inset is applied only off the tab shell.
  final bool? safeBottom;

  @override
  Widget build(BuildContext context) {
    final applyBottomInset = safeBottom ?? !isInTabShell(context);

    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: applyBottomInset,
      child: Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: child,
      ),
    );
  }
}

/// Top safe-area wrapper for tab-root pages without an [AppBar].
class ReflectTabPageSafeArea extends StatelessWidget {
  const ReflectTabPageSafeArea({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: child,
    );
  }
}
