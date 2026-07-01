import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/config/production_env_validator.dart';

void main() {
  const validEnv = {
    'APP_ENV': 'production',
    'API_BASE_URL': 'https://api.example.com',
    'FIREBASE_MESSAGING_SENDER_ID': '123456789',
    'FIREBASE_PROJECT_ID': 'reflect-prod',
    'FIREBASE_ANDROID_API_KEY': 'android-key',
    'FIREBASE_ANDROID_APP_ID': '1:123:android:abc',
    'FIREBASE_IOS_API_KEY': 'ios-key',
    'FIREBASE_IOS_APP_ID': '1:123:ios:abc',
  };

  group('ProductionEnvValidator', () {
    test('validate passes when all required keys are set', () {
      expect(
        () => ProductionEnvValidator.validate(validEnv),
        returnsNormally,
      );
    });

    test('validate throws when APP_ENV is missing', () {
      final env = Map<String, String?>.from(validEnv)..remove('APP_ENV');

      expect(
        () => ProductionEnvValidator.validate(env),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('APP_ENV is required'),
          ),
        ),
      );
    });

    test('validate throws when API_BASE_URL is missing', () {
      final env = Map<String, String?>.from(validEnv)..remove('API_BASE_URL');

      expect(
        () => ProductionEnvValidator.validate(env),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('API_BASE_URL is required'),
          ),
        ),
      );
    });

    test('validate throws when APP_ENV is not production', () {
      final env = Map<String, String?>.from(validEnv)
        ..['APP_ENV'] = 'testing';

      expect(
        () => ProductionEnvValidator.validate(env),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('APP_ENV must be "production"'),
          ),
        ),
      );
    });

    test('validate throws when Firebase key uses placeholder', () {
      final env = Map<String, String?>.from(validEnv)
        ..['FIREBASE_ANDROID_API_KEY'] = ProductionEnvValidator.placeholderValue;

      expect(
        () => ProductionEnvValidator.validate(env),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('must not use placeholder'),
          ),
        ),
      );
    });

    test('validate aggregates multiple errors', () {
      final env = <String, String?>{
        'APP_ENV': 'testing',
        'API_BASE_URL': ProductionEnvValidator.placeholderValue,
      };

      expect(
        () => ProductionEnvValidator.validate(env),
        throwsA(
          isA<StateError>().having(
            (e) => e.message.split('\n').length,
            'error count',
            greaterThan(1),
          ),
        ),
      );
    });
  });
}
