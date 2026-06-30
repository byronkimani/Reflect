import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/errors/failure.dart';

void main() {
  test('ServerFailure props contains errorMessage and statusCode', () {
    const failure = ServerFailure(errorMessage: 'test error', statusCode: 500);
    expect(failure.props, ['test error', 500]);
  });

  test('CacheFailure props contains errorMessage', () {
    const failure = CacheFailure(errorMessage: 'cache error');
    expect(failure.props, ['cache error', null]);
  });

  test('NetworkFailure props contains errorMessage', () {
    const failure = NetworkFailure(errorMessage: 'network error');
    expect(failure.props, ['network error', null]);
  });
}
