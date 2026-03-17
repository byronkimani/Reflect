import 'package:freezed_annotation/freezed_annotation.dart';

part 'connectivity_event.freezed.dart';

@freezed
class ConnectivityEvent with _$ConnectivityEvent {
  const factory ConnectivityEvent.monitorStarted() = MonitorConnectivityStarted;
  const factory ConnectivityEvent.connectivityChanged(bool isConnected) = ConnectivityChanged;
}
