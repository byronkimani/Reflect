import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:reflect/core/network/network_info.dart';

class MockInternetConnection extends Mock implements InternetConnection {}

void main() {
  late MockInternetConnection mockInternetConnection;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockInternetConnection = MockInternetConnection();
    networkInfo = NetworkInfoImpl(mockInternetConnection);
  });

  test('isConnected returns true when hasInternetAccess is true', () async {
    when(() => mockInternetConnection.hasInternetAccess).thenAnswer((_) async => true);
    final result = await networkInfo.isConnected;
    expect(result, true);
  });

  test('isConnected returns false when hasInternetAccess is false', () async {
    when(() => mockInternetConnection.hasInternetAccess).thenAnswer((_) async => false);
    final result = await networkInfo.isConnected;
    expect(result, false);
  });

  test('onStatusChange returns stream from internet connection checker', () {
    final stream = Stream<InternetStatus>.fromIterable([InternetStatus.connected]);
    when(() => mockInternetConnection.onStatusChange).thenAnswer((_) => stream);
    final result = networkInfo.onStatusChange;
    expect(result, stream);
  });
}
