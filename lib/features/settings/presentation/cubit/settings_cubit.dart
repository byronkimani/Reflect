import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';

import 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit(this._scheduler, this._analytics) : super(const SettingsState());

  final NotificationScheduler _scheduler;
  final AppAnalyticsService _analytics;

  /// Schedules heartbeat notifications after first frame (deferred startup).
  Future<void> scheduleStartupSync() async {
    _analytics.setCollectionEnabled(state.analyticsEnabled);
    await _syncHeartbeatNotifications();
  }

  void setThemeMode(ThemeMode mode) => emit(state.copyWith(themeMode: mode));

  Future<void> setAnalyticsEnabled(bool enabled) async {
    emit(state.copyWith(analyticsEnabled: enabled));
    _analytics.setCollectionEnabled(enabled);
  }

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
    await Future.wait([
      _syncMorningPlanning(s.morningPlanningEnabled),
      _syncEveningReview(s.eveningReviewEnabled),
      _syncWeeklyPlanning(s.weeklyPlanningEnabled),
      _syncMonthlyPlanning(s.monthlyPlanningEnabled),
    ]);
  }

  Future<void> _syncMorningPlanning(bool enabled) async {
    await _scheduler.cancelMorningPlanning();
    if (enabled) await _scheduler.scheduleMorningPlanning();
  }

  Future<void> _syncEveningReview(bool enabled) async {
    await _scheduler.cancelEveningReview();
    if (enabled) await _scheduler.scheduleEveningReview();
  }

  Future<void> _syncWeeklyPlanning(bool enabled) async {
    await _scheduler.cancelWeeklyPlanning();
    if (enabled) await _scheduler.scheduleWeeklyPlanning();
  }

  Future<void> _syncMonthlyPlanning(bool enabled) async {
    await _scheduler.cancelMonthlyPlanning();
    if (enabled) await _scheduler.scheduleMonthlyPlanning();
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
