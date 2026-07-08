import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_state.dart';

void main() {
  const base = SettingsState();

  group('settingsStateShouldRebuild', () {
    test('returns false when state is unchanged', () {
      expect(settingsStateShouldRebuild(base, base), isFalse);
    });

    test('returns true when themeMode changes', () {
      expect(
        settingsStateShouldRebuild(base, base.copyWith(themeMode: ThemeMode.dark)),
        isTrue,
      );
    });

    test('returns true when planning toggles change', () {
      expect(
        settingsStateShouldRebuild(
          base,
          base.copyWith(morningPlanningEnabled: false),
        ),
        isTrue,
      );
      expect(
        settingsStateShouldRebuild(
          base,
          base.copyWith(eveningReviewEnabled: false),
        ),
        isTrue,
      );
      expect(
        settingsStateShouldRebuild(
          base,
          base.copyWith(weeklyPlanningEnabled: false),
        ),
        isTrue,
      );
      expect(
        settingsStateShouldRebuild(
          base,
          base.copyWith(monthlyPlanningEnabled: false),
        ),
        isTrue,
      );
    });

    test('returns true when analyticsEnabled changes', () {
      expect(
        settingsStateShouldRebuild(base, base.copyWith(analyticsEnabled: true)),
        isTrue,
      );
    });
  });

  group('fromJson / toJson', () {
    test('round-trips all fields', () {
      const state = SettingsState(
        themeMode: ThemeMode.dark,
        morningPlanningEnabled: false,
        eveningReviewEnabled: false,
        weeklyPlanningEnabled: false,
        monthlyPlanningEnabled: false,
        analyticsEnabled: true,
      );

      final restored = SettingsState.fromJson(state.toJson());

      expect(restored.themeMode, ThemeMode.dark);
      expect(restored.morningPlanningEnabled, isFalse);
      expect(restored.eveningReviewEnabled, isFalse);
      expect(restored.weeklyPlanningEnabled, isFalse);
      expect(restored.monthlyPlanningEnabled, isFalse);
      expect(restored.analyticsEnabled, isTrue);
    });

    test('fromJson maps light and dark theme modes', () {
      expect(
        SettingsState.fromJson({'themeMode': 'light'}).themeMode,
        ThemeMode.light,
      );
      expect(
        SettingsState.fromJson({'themeMode': 'dark'}).themeMode,
        ThemeMode.dark,
      );
    });

    test('fromJson uses defaults for missing or unknown theme', () {
      final fromEmpty = SettingsState.fromJson({});
      expect(fromEmpty.themeMode, ThemeMode.system);
      expect(fromEmpty.morningPlanningEnabled, isTrue);
      expect(fromEmpty.analyticsEnabled, isFalse);

      final fromUnknown = SettingsState.fromJson({'themeMode': 'sepia'});
      expect(fromUnknown.themeMode, ThemeMode.system);
    });
  });
}
