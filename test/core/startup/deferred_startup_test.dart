import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/startup/deferred_startup.dart';

import 'package:reflect/features/notifications/notification_service.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';

class MockNotificationService extends Mock implements NotificationService {}

class MockSettingsCubit extends Mock implements SettingsCubit {}



void main() {
  late MockNotificationService mockNotifications;
  late MockSettingsCubit mockSettings;


  setUp(() {
    mockNotifications = MockNotificationService();
    mockSettings = MockSettingsCubit();


    when(() => mockNotifications.init()).thenAnswer((_) async {});
    when(() => mockNotifications.requestPermissions()).thenAnswer((_) async => true);
    when(() => mockSettings.scheduleStartupSync()).thenAnswer((_) async {});

  });

  test('runDeferredStartup initializes notifications and sync', () async {
    await runDeferredStartup(
      notifications: mockNotifications,
      settings: mockSettings,
    );

    verify(() => mockNotifications.init()).called(1);
    verify(() => mockNotifications.requestPermissions()).called(1);
    verify(() => mockSettings.scheduleStartupSync()).called(1);

  });
}
