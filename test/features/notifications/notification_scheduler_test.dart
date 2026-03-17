import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late NotificationScheduler scheduler;
  late MockFlutterLocalNotificationsPlugin mockPlugin;
  late MockNotificationService mockService;

  setUpAll(() {
    tz.initializeTimeZones();
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(tz.TZDateTime.now(tz.local));
    registerFallbackValue(AndroidScheduleMode.exactAllowWhileIdle);
    registerFallbackValue(DateTimeComponents.time);
  });

  setUp(() {
    mockPlugin = MockFlutterLocalNotificationsPlugin();
    mockService = MockNotificationService();
    
    when(() => mockService.notificationsPlugin).thenReturn(mockPlugin);
    
    scheduler = NotificationScheduler(mockService);

    when(() => mockPlugin.zonedSchedule(
          id: any(named: 'id'),
          title: any(named: 'title'),
          body: any(named: 'body'),
          scheduledDate: any(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          payload: any(named: 'payload'),
          matchDateTimeComponents: any(named: 'matchDateTimeComponents'),
        )).thenAnswer((_) async => {});
  });

  group('NotificationScheduler', () {
    test('scheduleMorningPlanning calls zonedSchedule with correct ID and payload', () async {
      await scheduler.scheduleMorningPlanning();

      verify(() => mockPlugin.zonedSchedule(
            id: 1001,
            title: any(named: 'title'),
            body: any(named: 'body'),
            scheduledDate: any(named: 'scheduledDate'),
            notificationDetails: any(named: 'notificationDetails'),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            payload: '/today/planning',
            matchDateTimeComponents: DateTimeComponents.time,
          )).called(1);
    });

    test('scheduleMonthlyPlanning schedules 12 instances', () async {
      await scheduler.scheduleMonthlyPlanning();

      // Verify 12 calls with sequential IDs starting from 1100
      for (int i = 0; i < 12; i++) {
        verify(() => mockPlugin.zonedSchedule(
              id: 1100 + i,
              title: any(named: 'title'),
              body: any(named: 'body'),
              scheduledDate: any(named: 'scheduledDate'),
              notificationDetails: any(named: 'notificationDetails'),
              androidScheduleMode: any(named: 'androidScheduleMode'),
              payload: '/monthly/plan',
            )).called(1);
      }
    });

    test('cancelNotification triggers plugin cancel', () async {
      when(() => mockPlugin.cancel(id: any(named: 'id'))).thenAnswer((_) async => {});
      
      await scheduler.cancelNotification(1002);

      verify(() => mockPlugin.cancel(id: 1002)).called(1);
    });
  });
}
