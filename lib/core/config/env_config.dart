import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:reflect/core/config/production_env_validator.dart';

class EnvConfig {
  static const String _flavor = String.fromEnvironment(
    'ENV',
    defaultValue: 'testing',
  );

  static const String _activeEnvAsset = 'env/active.env';

  static Future<void> init() async {
    await dotenv.load(fileName: _activeEnvAsset);
    validateProductionIfNeeded(isProduction: isProduction);
  }

  /// Validates env when [isProduction] is true. Exposed for unit tests.
  @visibleForTesting
  static void validateProductionIfNeeded({
    required bool isProduction,
    Map<String, String?>? env,
    String source = _activeEnvAsset,
  }) {
    if (!isProduction) return;
    ProductionEnvValidator.validate(
      env ?? (dotenv.isInitialized ? dotenv.env : const {}),
      source: source,
    );
  }

  static bool get isProduction => _flavor == 'production';

  static String resolveBaseUrl(
    Map<String, String?> env, {
    required bool isProduction,
    String source = _activeEnvAsset,
  }) {
    final fromEnv = env['API_BASE_URL'];
    if (fromEnv != null && fromEnv.isNotEmpty) {
      return fromEnv;
    }
    if (isProduction) {
      throw StateError(
        'API_BASE_URL is required in production but was not set in $source',
      );
    }
    return 'https://jsonplaceholder.typicode.com';
  }

  static String get baseUrl {
    if (!dotenv.isInitialized) {
      return resolveBaseUrl(const {}, isProduction: isProduction);
    }
    return resolveBaseUrl(dotenv.env, isProduction: isProduction);
  }

  static String get envName =>
      dotenv.isInitialized ? dotenv.env['APP_ENV'] ?? 'unknown' : 'unknown';
}
