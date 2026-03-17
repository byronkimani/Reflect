import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/features/gcal/domain/repositories/gcal_repository.dart';

import 'g_cal_sync_state.dart';

class GCalSyncCubit extends Cubit<GCalSyncState> {
  final GCalRepository _gcalRepository;
  StreamSubscription<int>? _queueSubscription;

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
    try {
      emit(state.copyWith(isSyncing: true, lastError: null));
      await _gcalRepository.signIn();
      emit(state.copyWith(isSignedIn: true, isSyncing: false));
    } catch (e) {
      emit(state.copyWith(isSyncing: false, lastError: e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(state.copyWith(isSyncing: true, lastError: null));
      await _gcalRepository.signOut();
      emit(state.copyWith(isSignedIn: false, isSyncing: false));
    } catch (e) {
      emit(state.copyWith(isSyncing: false, lastError: e.toString()));
    }
  }

  Future<void> processQueue() async {
    if (state.isSyncing) return;
    
    try {
      emit(state.copyWith(isSyncing: true, lastError: null));
      await _gcalRepository.processQueue();
      emit(state.copyWith(isSyncing: false));
    } catch (e) {
      emit(state.copyWith(isSyncing: false, lastError: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _queueSubscription?.cancel();
    return super.close();
  }
}
