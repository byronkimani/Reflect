import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:reflect/core/network/network_info.dart';

import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo _networkInfo;
  StreamSubscription? _subscription;

  ConnectivityBloc(this._networkInfo) : super(const ConnectivityState.initial()) {
    on<MonitorConnectivityStarted>(_onMonitorStarted);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  Future<void> _onMonitorStarted(
    MonitorConnectivityStarted event,
    Emitter<ConnectivityState> emit,
  ) async {
    final isConnected = await _networkInfo.isConnected;
    add(ConnectivityEvent.connectivityChanged(isConnected));

    await _subscription?.cancel();
    _subscription = _networkInfo.onStatusChange.listen((status) {
      add(ConnectivityEvent.connectivityChanged(status == InternetStatus.connected));
    });
  }

  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    if (event.isConnected) {
      emit(const ConnectivityState.connected());
    } else {
      emit(const ConnectivityState.disconnected());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
