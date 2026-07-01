import 'package:flutter/material.dart';

class SettingsState {
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.morningPlanningEnabled = true,
    this.eveningReviewEnabled = true,
    this.weeklyPlanningEnabled = true,
    this.monthlyPlanningEnabled = true,
    this.analyticsEnabled = false,
  });

  final ThemeMode themeMode;
  final bool morningPlanningEnabled;
  final bool eveningReviewEnabled;
  final bool weeklyPlanningEnabled;
  final bool monthlyPlanningEnabled;
  final bool analyticsEnabled;

  SettingsState copyWith({
    ThemeMode? themeMode,
    bool? morningPlanningEnabled,
    bool? eveningReviewEnabled,
    bool? weeklyPlanningEnabled,
    bool? monthlyPlanningEnabled,
    bool? analyticsEnabled,
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
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'themeMode': themeMode.name,
        'morningPlanningEnabled': morningPlanningEnabled,
        'eveningReviewEnabled': eveningReviewEnabled,
        'weeklyPlanningEnabled': weeklyPlanningEnabled,
        'monthlyPlanningEnabled': monthlyPlanningEnabled,
        'analyticsEnabled': analyticsEnabled,
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
      analyticsEnabled: json['analyticsEnabled'] as bool? ?? false,
    );
  }
}

/// Avoids rebuilding Settings UI when unrelated cubit internals change.
bool settingsStateShouldRebuild(SettingsState previous, SettingsState current) {
  return previous.themeMode != current.themeMode ||
      previous.morningPlanningEnabled != current.morningPlanningEnabled ||
      previous.eveningReviewEnabled != current.eveningReviewEnabled ||
      previous.weeklyPlanningEnabled != current.weeklyPlanningEnabled ||
      previous.monthlyPlanningEnabled != current.monthlyPlanningEnabled ||
      previous.analyticsEnabled != current.analyticsEnabled;
}
