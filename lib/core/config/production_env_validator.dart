/// Validates production environment variables before the app starts.
class ProductionEnvValidator {
  ProductionEnvValidator._();

  static const placeholderValue = 'replace_me';

  /// Keys required for production mobile builds (Android + iOS Firebase).
  static const requiredKeys = [
    'APP_ENV',
    'API_BASE_URL',
    'FIREBASE_MESSAGING_SENDER_ID',
    'FIREBASE_PROJECT_ID',
    'FIREBASE_ANDROID_API_KEY',
    'FIREBASE_ANDROID_APP_ID',
    'FIREBASE_IOS_API_KEY',
    'FIREBASE_IOS_APP_ID',
  ];

  /// Validates [env] for production. Throws [StateError] when invalid.
  static void validate(Map<String, String?> env, {String source = 'env/active.env'}) {
    final errors = <String>[];

    final appEnv = env['APP_ENV'];
    if (appEnv == null || appEnv.isEmpty) {
      errors.add('APP_ENV is required in production');
    } else if (appEnv != 'production') {
      errors.add(
        'APP_ENV must be "production" in production builds (found "$appEnv")',
      );
    }

    for (final key in requiredKeys) {
      if (key == 'APP_ENV') continue;

      final value = env[key];
      if (value == null || value.isEmpty) {
        errors.add('$key is required in production but was not set in $source');
      } else if (value == placeholderValue) {
        errors.add(
          '$key must not use placeholder "$placeholderValue" in production',
        );
      }
    }

    if (errors.isNotEmpty) {
      throw StateError(errors.join('\n'));
    }
  }
}
