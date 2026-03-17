import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/gcal/domain/repositories/gcal_repository.dart';

import 'g_cal_sync_state.dart';

class GCalSyncCubit extends Cubit<GCalSyncState> {
  final IGCalRepository _gcalRepository;
  StreamSubscription? _queueSubscription;

  GCalSyncCubit(this._gcalRepository) : super(const GCalSyncState()) {
    _monitorQueue();
  }

  void _monitorQueue() {
    _queueSubscription?.cancel();
    _queueSubscription = _gcalRepository.watchQueueDepth().listen((depth) {
      emit(state.copyWith(queueDepth: depth));
    });
  }

  Future<void> signIn() async {
    emit(state.copyWith(isSyncing: true, lastError: null));
    final result = await _gcalRepository.signIn();
    result.fold(
      (failure) => emit(state.copyWith(isSyncing: false, lastError: failure.errorMessage)),
      (_) => emit(state.copyWith(isSignedIn: true, isSyncing: false)),
    );
  }

  Future<void> signOut() async {
    emit(state.copyWith(isSyncing: true, lastError: null));
    final result = await _gcalRepository.signOut();
    result.fold(
      (failure) => emit(state.copyWith(isSyncing: false, lastError: failure.errorMessage)),
      (_) => emit(state.copyWith(isSignedIn: false, isSyncing: false)),
    );
  }

  Future<void> processQueue() async {
    if (state.isSyncing) return;
    
    emit(state.copyWith(isSyncing: true, lastError: null));
    final result = await _gcalRepository.processQueue();
    result.fold(
      (failure) => emit(state.copyWith(isSyncing: false, lastError: failure.errorMessage)),
      (_) => emit(state.copyWith(isSyncing: false)),
    );
  }

  @override
  Future<void> close() {
    _queueSubscription?.cancel();
    return super.close();
  }
}
