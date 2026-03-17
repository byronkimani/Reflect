// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get postsTitle => 'Latest Posts';

  @override
  String get postDetailsTitle => 'Post Details';

  @override
  String get loginWelcome => 'Welcome Back';

  @override
  String get loginGoogle => 'Sign in with Google';

  @override
  String get loginApple => 'Sign in with Apple';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get retry => 'Try Again';
}
