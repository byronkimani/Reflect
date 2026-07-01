import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_state.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class MockNotificationScheduler extends Mock implements NotificationScheduler {}

class MockStorage extends Mock implements Storage {}

class MockAppAnalyticsService extends Mock implements AppAnalyticsService {}

void main() {
  late MockNotificationScheduler mockScheduler;
  late MockAppAnalyticsService mockAnalytics;
  late MockStorage storage;

  setUp(() {
    mockScheduler = MockNotificationScheduler();
    mockAnalytics = MockAppAnalyticsService();
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
    when(() => mockAnalytics.setCollectionEnabled(any())).thenReturn(null);
  });

  SettingsCubit buildCubit() => SettingsCubit(mockScheduler, mockAnalytics);

  group('SettingsCubit', () {
    test('initial state is correct and does not sync on construction', () {
      final cubit = buildCubit();
      expect(cubit.state, const SettingsState());
      verifyNever(() => mockScheduler.cancelMorningPlanning());
    });

    test('scheduleStartupSync syncs heartbeat notifications', () async {
      final cubit = buildCubit();
      await cubit.scheduleStartupSync();
      verify(() => mockScheduler.cancelMorningPlanning()).called(1);
      verify(() => mockScheduler.scheduleMorningPlanning()).called(1);
    });

    test('setThemeMode updates state', () {
      final cubit = buildCubit();
      cubit.setThemeMode(ThemeMode.dark);
      expect(cubit.state.themeMode, ThemeMode.dark);
    });

    test('setMorningPlanningEnabled updates state and syncs', () async {
      final cubit = buildCubit();
      await cubit.setMorningPlanningEnabled(false);
      expect(cubit.state.morningPlanningEnabled, false);
      verify(() => mockScheduler.cancelMorningPlanning()).called(greaterThan(0));
    });

    test('setEveningReviewEnabled updates state and syncs', () async {
      final cubit = buildCubit();
      await cubit.setEveningReviewEnabled(false);
      expect(cubit.state.eveningReviewEnabled, false);
      verify(() => mockScheduler.cancelEveningReview()).called(greaterThan(0));
    });

    test('setWeeklyPlanningEnabled updates state and syncs', () async {
      final cubit = buildCubit();
      await cubit.setWeeklyPlanningEnabled(false);
      expect(cubit.state.weeklyPlanningEnabled, false);
      verify(() => mockScheduler.cancelWeeklyPlanning()).called(greaterThan(0));
    });

    test('setMonthlyPlanningEnabled updates state and syncs', () async {
      final cubit = buildCubit();
      await cubit.setMonthlyPlanningEnabled(false);
      expect(cubit.state.monthlyPlanningEnabled, false);
      verify(() => mockScheduler.cancelMonthlyPlanning()).called(greaterThan(0));
    });
    
    test('setAnalyticsEnabled updates state and syncs collection flag', () async {
      final cubit = buildCubit();
      await cubit.setAnalyticsEnabled(true);
      expect(cubit.state.analyticsEnabled, isTrue);
      verify(() => mockAnalytics.setCollectionEnabled(true)).called(1);
    });

    test('scheduleStartupSync applies analytics opt-in from state', () async {
      final cubit = buildCubit();
      await cubit.setAnalyticsEnabled(true);
      clearInteractions(mockAnalytics);
      await cubit.scheduleStartupSync();
      verify(() => mockAnalytics.setCollectionEnabled(true)).called(1);
    });

    test('fromJson and toJson', () {
      final cubit = buildCubit();
      final json = cubit.toJson(cubit.state);
      expect(json, isNotNull);
      final state = cubit.fromJson(json!);
      expect(state?.themeMode, cubit.state.themeMode);
      expect(state?.morningPlanningEnabled, cubit.state.morningPlanningEnabled);
      expect(cubit.fromJson({}), isNotNull); // Uses defaults or throws inside, wait, handles exception
    });
  });
}
