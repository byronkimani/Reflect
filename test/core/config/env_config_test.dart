import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/config/env_config.dart';

void main() {
  test('EnvConfig baseUrl returns fallback-url.com', () {
    expect(EnvConfig.baseUrl, 'https://fallback-url.com');
  });

  test('EnvConfig envName returns unknown when dotenv is not loaded', () {
    expect(EnvConfig.envName, 'unknown');
  });
}
