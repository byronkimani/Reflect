import 'package:flutter/material.dart';

class SettingsState {
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.morningPlanningEnabled = true,
    this.eveningReviewEnabled = true,
    this.weeklyPlanningEnabled = true,
    this.monthlyPlanningEnabled = true,
  });

  final ThemeMode themeMode;
  final bool morningPlanningEnabled;
  final bool eveningReviewEnabled;
  final bool weeklyPlanningEnabled;
  final bool monthlyPlanningEnabled;

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? morningPlanningEnabled,
    bool? eveningReviewEnabled,
    bool? weeklyPlanningEnabled,
    bool? monthlyPlanningEnabled,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      morningPlanningEnabled:
          morningPlanningEnabled ?? this.morningPlanningEnabled,
      eveningReviewEnabled: eveningReviewEnabled ?? this.eveningReviewEnabled,
      weeklyPlanningEnabled:
          weeklyPlanningEnabled ?? this.weeklyPlanningEnabled,
      monthlyPlanningEnabled:
          monthlyPlanningEnabled ?? this.monthlyPlanningEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode.name,
        'morningPlanningEnabled': morningPlanningEnabled,
        'eveningReviewEnabled': eveningReviewEnabled,
        'weeklyPlanningEnabled': weeklyPlanningEnabled,
        'monthlyPlanningEnabled': monthlyPlanningEnabled,
      };

  factory SettingsState.fromJson(Map<String, dynamic> json) {
    ThemeMode mode = ThemeMode.system;
    final raw = json['themeMode'] as String?;
    if (raw == 'light') mode = ThemeMode.light;
    if (raw == 'dark') mode = ThemeMode.dark;

    return SettingsState(
      themeMode: mode,
      morningPlanningEnabled: json['morningPlanningEnabled'] as bool? ?? true,
      eveningReviewEnabled: json['eveningReviewEnabled'] as bool? ?? true,
      weeklyPlanningEnabled: json['weeklyPlanningEnabled'] as bool? ?? true,
      monthlyPlanningEnabled: json['monthlyPlanningEnabled'] as bool? ?? true,
    );
  }
}
