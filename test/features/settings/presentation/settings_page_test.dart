import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/settings/presentation/pages/settings_page.dart';

class MockNotificationScheduler extends Mock implements NotificationScheduler {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockNotificationScheduler scheduler;

  setUpAll(() async {
    final dir = Directory.systemTemp.createTempSync('reflect_settings_test');
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(dir.path),
    );
  });

  setUp(() {
    scheduler = MockNotificationScheduler();
    when(() => scheduler.cancelMorningPlanning()).thenAnswer((_) async {});
    when(() => scheduler.scheduleMorningPlanning()).thenAnswer((_) async {});
    when(() => scheduler.cancelEveningReview()).thenAnswer((_) async {});
    when(() => scheduler.scheduleEveningReview()).thenAnswer((_) async {});
    when(() => scheduler.cancelWeeklyPlanning()).thenAnswer((_) async {});
    when(() => scheduler.scheduleWeeklyPlanning()).thenAnswer((_) async {});
    when(() => scheduler.cancelMonthlyPlanning()).thenAnswer((_) async {});
    when(() => scheduler.scheduleMonthlyPlanning()).thenAnswer((_) async {});
  });

  testWidgets('Settings page shows theme and notification sections', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SettingsCubit>(
          create: (_) => SettingsCubit(scheduler),
          child: const SettingsPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Appearance'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Morning planning'), findsOneWidget);
    expect(find.text('Evening review'), findsOneWidget);
  });
}
