import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_state.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

class MockNotificationScheduler extends Mock implements NotificationScheduler {}

class MockStorage extends Mock implements Storage {}

void main() {
  late MockNotificationScheduler mockScheduler;
  late MockStorage storage;

  setUp(() {
    mockScheduler = MockNotificationScheduler();
    storage = MockStorage();
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    when(() => storage.read(any())).thenReturn(null);
    when(() => storage.delete(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});
    HydratedBloc.storage = storage;

    when(() => mockScheduler.cancelMorningPlanning()).thenAnswer((_) async {});
    when(() => mockScheduler.scheduleMorningPlanning()).thenAnswer((_) async {});
    when(() => mockScheduler.cancelEveningReview()).thenAnswer((_) async {});
    when(() => mockScheduler.scheduleEveningReview()).thenAnswer((_) async {});
    when(() => mockScheduler.cancelWeeklyPlanning()).thenAnswer((_) async {});
    when(() => mockScheduler.scheduleWeeklyPlanning()).thenAnswer((_) async {});
    when(() => mockScheduler.cancelMonthlyPlanning()).thenAnswer((_) async {});
    when(() => mockScheduler.scheduleMonthlyPlanning()).thenAnswer((_) async {});
  });

  group('SettingsCubit', () {
    test('initial state is correct', () {
      final cubit = SettingsCubit(mockScheduler);
      expect(cubit.state, const SettingsState());
    });

    test('setThemeMode updates state', () {
      final cubit = SettingsCubit(mockScheduler);
      cubit.setThemeMode(ThemeMode.dark);
      expect(cubit.state.themeMode, ThemeMode.dark);
    });

    test('setMorningPlanningEnabled updates state and syncs', () async {
      final cubit = SettingsCubit(mockScheduler);
      await cubit.setMorningPlanningEnabled(false);
      expect(cubit.state.morningPlanningEnabled, false);
      verify(() => mockScheduler.cancelMorningPlanning()).called(greaterThan(0));
    });

    test('setEveningReviewEnabled updates state and syncs', () async {
      final cubit = SettingsCubit(mockScheduler);
      await cubit.setEveningReviewEnabled(false);
      expect(cubit.state.eveningReviewEnabled, false);
      verify(() => mockScheduler.cancelEveningReview()).called(greaterThan(0));
    });

    test('setWeeklyPlanningEnabled updates state and syncs', () async {
      final cubit = SettingsCubit(mockScheduler);
      await cubit.setWeeklyPlanningEnabled(false);
      expect(cubit.state.weeklyPlanningEnabled, false);
      verify(() => mockScheduler.cancelWeeklyPlanning()).called(greaterThan(0));
    });

    test('setMonthlyPlanningEnabled updates state and syncs', () async {
      final cubit = SettingsCubit(mockScheduler);
      await cubit.setMonthlyPlanningEnabled(false);
      expect(cubit.state.monthlyPlanningEnabled, false);
      verify(() => mockScheduler.cancelMonthlyPlanning()).called(greaterThan(0));
    });
    
    test('fromJson and toJson', () {
      final cubit = SettingsCubit(mockScheduler);
      final json = cubit.toJson(cubit.state);
      expect(json, isNotNull);
      final state = cubit.fromJson(json!);
      expect(state?.themeMode, cubit.state.themeMode);
      expect(state?.morningPlanningEnabled, cubit.state.morningPlanningEnabled);
      expect(cubit.fromJson({}), isNotNull); // Uses defaults or throws inside, wait, handles exception
    });
  });
}
