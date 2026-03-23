import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';

import 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit(this._scheduler) : super(const SettingsState()) {
    _syncHeartbeatNotifications();
  }

  final NotificationScheduler _scheduler;

  void setThemeMode(ThemeMode mode) => emit(state.copyWith(themeMode: mode));

  Future<void> setMorningPlanningEnabled(bool enabled) async {
    emit(state.copyWith(morningPlanningEnabled: enabled));
    await _syncHeartbeatNotifications();
  }

  Future<void> setEveningReviewEnabled(bool enabled) async {
    emit(state.copyWith(eveningReviewEnabled: enabled));
    await _syncHeartbeatNotifications();
  }

  Future<void> setWeeklyPlanningEnabled(bool enabled) async {
    emit(state.copyWith(weeklyPlanningEnabled: enabled));
    await _syncHeartbeatNotifications();
  }

  Future<void> setMonthlyPlanningEnabled(bool enabled) async {
    emit(state.copyWith(monthlyPlanningEnabled: enabled));
    await _syncHeartbeatNotifications();
  }

  Future<void> _syncHeartbeatNotifications() async {
    final s = state;
    if (s.morningPlanningEnabled) {
      await _scheduler.cancelMorningPlanning();
      await _scheduler.scheduleMorningPlanning();
    } else {
      await _scheduler.cancelMorningPlanning();
    }
    if (s.eveningReviewEnabled) {
      await _scheduler.cancelEveningReview();
      await _scheduler.scheduleEveningReview();
    } else {
      await _scheduler.cancelEveningReview();
    }
    if (s.weeklyPlanningEnabled) {
      await _scheduler.cancelWeeklyPlanning();
      await _scheduler.scheduleWeeklyPlanning();
    } else {
      await _scheduler.cancelWeeklyPlanning();
    }
    if (s.monthlyPlanningEnabled) {
      await _scheduler.cancelMonthlyPlanning();
      await _scheduler.scheduleMonthlyPlanning();
    } else {
      await _scheduler.cancelMonthlyPlanning();
    }
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    try {
      return SettingsState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) => state.toJson();
}
