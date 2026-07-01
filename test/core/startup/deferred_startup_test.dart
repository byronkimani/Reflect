import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/startup/deferred_startup.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_cubit.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';

class MockNotificationService extends Mock implements NotificationService {}

class MockSettingsCubit extends Mock implements SettingsCubit {}

class MockGCalSyncCubit extends Mock implements GCalSyncCubit {}

void main() {
  late MockNotificationService mockNotifications;
  late MockSettingsCubit mockSettings;
  late MockGCalSyncCubit mockGCal;

  setUp(() {
    mockNotifications = MockNotificationService();
    mockSettings = MockSettingsCubit();
    mockGCal = MockGCalSyncCubit();

    when(() => mockNotifications.init()).thenAnswer((_) async {});
    when(() => mockNotifications.requestPermissions()).thenAnswer((_) async => true);
    when(() => mockSettings.scheduleStartupSync()).thenAnswer((_) async {});
    when(() => mockGCal.processQueue()).thenAnswer((_) async {});
  });

  test('runDeferredStartup initializes notifications and sync', () async {
    await runDeferredStartup(
      notifications: mockNotifications,
      settings: mockSettings,
      gcalSync: mockGCal,
    );

    verify(() => mockNotifications.init()).called(1);
    verify(() => mockNotifications.requestPermissions()).called(1);
    verify(() => mockSettings.scheduleStartupSync()).called(1);
    verify(() => mockGCal.processQueue()).called(1);
  });
}
