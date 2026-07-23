import 'package:flutter/material.dart';
import 'package:reflect/core/presentation/app_scaffold.dart';

/// Whether [context] sits inside the main tab shell (not a full-screen push).
bool isInTabShell(BuildContext context) {
  return context.findAncestorWidgetOfExactType<ScaffoldWithNavBar>() != null;
}

/// Extra bottom padding so scrollable tab content clears the tab bar and FAB.
const double kReflectTabBarScrollClearance = 100;

/// Header padding for tab pages that render a custom title row (no [AppBar]).
EdgeInsets reflectTabHeaderPadding(BuildContext context) {
  final top = MediaQuery.paddingOf(context).top;
  return EdgeInsets.fromLTRB(16, top + 16, 16, 8);
}

/// Scroll padding for tab pages so the last item is not hidden behind chrome.
EdgeInsets reflectTabScrollPadding(BuildContext context) {
  return EdgeInsets.only(bottom: kReflectTabBarScrollClearance);
}
