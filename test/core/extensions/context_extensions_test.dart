import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/extensions/context_extensions.dart';
import 'package:reflect/l10n/app_localizations.dart';

void main() {
  testWidgets('l10n returns AppLocalizations from context', (tester) async {
    late AppLocalizations? captured;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            captured = context.l10n;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(captured, isNotNull);
    expect(captured, isA<AppLocalizations>());
  });
}
