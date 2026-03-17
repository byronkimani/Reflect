import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  /// We only use this compile-time variable to decide WHICH file to load.
  /// We do NOT use this for application logic to avoid issues if files are mixed up.
  static const String _flavor = String.fromEnvironment(
    'ENV',
    defaultValue: 'testing',
  );

  static Future<void> init() async {
    // Load the file from the ROOT of the assets bundle
    await dotenv.load(fileName: '.env.$_flavor');
  }

  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://fallback-url.com';
  static String get sentryDsn => dotenv.env['SENTRY_DSN'] ?? '';

  /// The Single Source of Truth for the environment.
  /// This comes directly from the file content (APP_ENV), not the filename.
  static String get envName => dotenv.env['APP_ENV'] ?? 'unknown';
}
