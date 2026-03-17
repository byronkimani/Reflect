import 'package:freezed_annotation/freezed_annotation.dart';

part 'g_cal_sync_state.freezed.dart';

@freezed
abstract class GCalSyncState with _$GCalSyncState {
  const factory GCalSyncState({
    @Default(false) bool isSignedIn,
    @Default(false) bool isSyncing,
    @Default(0) int queueDepth,
    String? lastError,
  }) = _GCalSyncState;
}
