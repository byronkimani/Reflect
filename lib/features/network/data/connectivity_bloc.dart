import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../../../core/network/network_info.dart';

part 'connectivity_bloc.freezed.dart';

// --- EVENTS ---
@freezed
abstract class ConnectivityEvent with _$ConnectivityEvent {
  const factory ConnectivityEvent.started() = _Started;
  const factory ConnectivityEvent.statusChanged(InternetStatus status) =
      _StatusChanged;
}

// --- STATES ---
@freezed
abstract class ConnectivityState with _$ConnectivityState {
  const factory ConnectivityState.initial() = _Initial;
  const factory ConnectivityState.connected() = _Connected;
  const factory ConnectivityState.disconnected() = _Disconnected;
}

// --- BLOC ---
class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final NetworkInfo _networkInfo;
  StreamSubscription<InternetStatus>? _subscription;

  ConnectivityBloc(this._networkInfo)
    : super(const ConnectivityState.initial()) {
    on<_Started>(_onStarted);
    on<_StatusChanged>(_onStatusChanged);
  }

  Future<void> _onStarted(
    _Started event,
    Emitter<ConnectivityState> emit,
  ) async {
    // Check initial status
    final isConnected = await _networkInfo.isConnected;
    if (!isConnected) {
      emit(const ConnectivityState.disconnected());
    } else {
      emit(const ConnectivityState.connected());
    }

    // Listen for future changes
    _subscription = _networkInfo.onStatusChange.listen((status) {
      add(ConnectivityEvent.statusChanged(status));
    });
  }

  void _onStatusChanged(_StatusChanged event, Emitter<ConnectivityState> emit) {
    if (event.status == InternetStatus.disconnected) {
      emit(const ConnectivityState.disconnected());
    } else {
      emit(const ConnectivityState.connected());
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
