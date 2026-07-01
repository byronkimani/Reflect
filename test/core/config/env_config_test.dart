import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:reflect/core/config/env_config.dart';

void main() {
  tearDown(() {
    dotenv.clean();
  });

  test('EnvConfig baseUrl returns testing default when API_BASE_URL missing', () {
    dotenv.loadFromString(envString: 'APP_ENV=testing');

    expect(EnvConfig.baseUrl, 'https://jsonplaceholder.typicode.com');
  });

  test('EnvConfig baseUrl reads API_BASE_URL from dotenv', () {
    dotenv.loadFromString(
      envString: 'APP_ENV=testing\nAPI_BASE_URL=https://api.example.com',
    );

    expect(EnvConfig.baseUrl, 'https://api.example.com');
  });

  test('EnvConfig resolveBaseUrl throws in production when API_BASE_URL missing', () {
    expect(
      () => EnvConfig.resolveBaseUrl(const {}, isProduction: true),
      throwsA(isA<StateError>()),
    );
  });

  test('EnvConfig resolveBaseUrl returns placeholder API in non-production', () {
    expect(
      EnvConfig.resolveBaseUrl(const {}, isProduction: false),
      'https://jsonplaceholder.typicode.com',
    );
  });

  test('EnvConfig envName returns unknown when dotenv is not loaded', () {
    expect(EnvConfig.envName, 'unknown');
  });

  test('EnvConfig envName returns APP_ENV when dotenv is initialized', () {
    dotenv.loadFromString(envString: 'APP_ENV=testing');

    expect(EnvConfig.envName, 'testing');
  });

  test('EnvConfig init loads active env file', () async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await EnvConfig.init();

    expect(dotenv.isInitialized, isTrue);
    expect(EnvConfig.baseUrl, isNotEmpty);
  });

  test('EnvConfig validateProductionIfNeeded throws for invalid production env', () {
    dotenv.loadFromString(envString: 'APP_ENV=testing');

    expect(
      () => EnvConfig.validateProductionIfNeeded(isProduction: true),
      throwsA(isA<StateError>()),
    );
  });
}
