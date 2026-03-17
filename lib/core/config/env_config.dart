import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static const String _flavor = String.fromEnvironment(
    'ENV',
    defaultValue: 'testing',
  );

  static Future<void> init() async {
    await dotenv.load(fileName: '.env.$_flavor');
  }

  static String get baseUrl => 'https://fallback-url.com';

  static String get envName => dotenv.env['APP_ENV'] ?? 'unknown';
}
