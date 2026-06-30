import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/core/network/presentation/connectivity_event.dart';
import 'package:reflect/core/network/presentation/connectivity_state.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late ConnectivityBloc bloc;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    bloc = ConnectivityBloc(mockNetworkInfo);
  });

  tearDown(() {
    bloc.close();
  });

  group('ConnectivityBloc', () {
    test('initial state is initial', () {
      expect(bloc.state, const ConnectivityState.initial());
    });

    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits connected when monitor started and isConnected is true',
      build: () {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockNetworkInfo.onStatusChange).thenAnswer((_) => const Stream.empty());
        return bloc;
      },
      act: (b) => b.add(const ConnectivityEvent.monitorStarted()),
      expect: () => [
        const ConnectivityState.connected(),
      ],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits disconnected when monitor started and isConnected is false',
      build: () {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(() => mockNetworkInfo.onStatusChange).thenAnswer((_) => const Stream.empty());
        return bloc;
      },
      act: (b) => b.add(const ConnectivityEvent.monitorStarted()),
      expect: () => [
        const ConnectivityState.disconnected(),
      ],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits updated state on status change stream',
      build: () {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockNetworkInfo.onStatusChange).thenAnswer((_) => Stream.fromIterable([
              InternetStatus.disconnected,
              InternetStatus.connected,
            ]));
        return bloc;
      },
      act: (b) => b.add(const ConnectivityEvent.monitorStarted()),
      expect: () => [
        const ConnectivityState.connected(),
        const ConnectivityState.disconnected(),
        const ConnectivityState.connected(),
      ],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits connected when connectivityChanged(true) is added',
      build: () => bloc,
      act: (b) => b.add(const ConnectivityEvent.connectivityChanged(true)),
      expect: () => [
        const ConnectivityState.connected(),
      ],
    );

    blocTest<ConnectivityBloc, ConnectivityState>(
      'emits disconnected when connectivityChanged(false) is added',
      build: () => bloc,
      act: (b) => b.add(const ConnectivityEvent.connectivityChanged(false)),
      expect: () => [
        const ConnectivityState.disconnected(),
      ],
    );
  });
}
