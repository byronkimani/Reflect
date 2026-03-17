import 'package:reflect/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  /// Allows you to use `context.l10n.someString`
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  //  /// Convenience method to start a showcase flow
  // void startShowcase(List<GlobalKey> keys) {
  //   ShowCaseWidget.of(this).startShowCase(keys);
  // }
}
