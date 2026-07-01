import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:reflect/features/tasks/domain/entities/task.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MockFlutterLocalNotificationsPlugin extends Mock
    implements FlutterLocalNotificationsPlugin {}

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MockFlutterLocalNotificationsPlugin mockPlugin;
  late MockNotificationService mockService;
  late NotificationScheduler scheduler;

  setUpAll(() {
    tz.initializeTimeZones();
    registerFallbackValue(tz.TZDateTime.now(tz.local));
    registerFallbackValue(const NotificationDetails());
    registerFallbackValue(AndroidScheduleMode.exactAllowWhileIdle);
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
        )).thenAnswer((_) async {});

    when(() => mockPlugin.cancel(id: any(named: 'id')))
        .thenAnswer((_) async {});
  });

  test('scheduleAllHeartbeats schedules all planning notifications', () async {
    await scheduler.scheduleAllHeartbeats();
    verify(() => mockPlugin.zonedSchedule(
          id: 1001,
          title: any(named: 'title'),
          body: any(named: 'body'),
          scheduledDate: any(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          payload: any(named: 'payload'),
          matchDateTimeComponents: any(named: 'matchDateTimeComponents'),
        )).called(1);
    verify(() => mockPlugin.zonedSchedule(
          id: 1002,
          title: any(named: 'title'),
          body: any(named: 'body'),
          scheduledDate: any(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          payload: any(named: 'payload'),
          matchDateTimeComponents: any(named: 'matchDateTimeComponents'),
        )).called(1);
    verify(() => mockPlugin.zonedSchedule(
          id: 1003,
          title: any(named: 'title'),
          body: any(named: 'body'),
          scheduledDate: any(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          payload: any(named: 'payload'),
          matchDateTimeComponents: any(named: 'matchDateTimeComponents'),
        )).called(1);
    verify(() => mockPlugin.zonedSchedule(
          id: any(named: 'id'),
          title: any(named: 'title'),
          body: any(named: 'body'),
          scheduledDate: any(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          payload: any(named: 'payload'),
          matchDateTimeComponents: any(named: 'matchDateTimeComponents'),
        )).called(12);
  });

  test('cancel commands cancel correct ids', () async {
    await scheduler.cancelMorningPlanning();
    verify(() => mockPlugin.cancel(id: 1001)).called(1);
    await scheduler.cancelEveningReview();
    verify(() => mockPlugin.cancel(id: 1002)).called(1);
    await scheduler.cancelWeeklyPlanning();
    verify(() => mockPlugin.cancel(id: 1003)).called(1);
    await scheduler.cancelMonthlyPlanning();
    verify(() => mockPlugin.cancel(id: any(named: 'id'))).called(12);
  });

  test('scheduleTaskReminder schedules if due time exists', () async {
    final task = Task(
      id: 'task_1',
      title: 'Do this',
      status: TaskStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      dueDate: DateTime.now().add(const Duration(days: 1)),
      dueTime: '10:00',
      hasEnabledReminder: true,
    );
    await scheduler.scheduleTaskReminder(task);
    verify(() => mockPlugin.zonedSchedule(
          id: any(named: 'id'),
          title: 'Task due',
          body: 'Do this',
          scheduledDate: any(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          payload: '/today/task/task_1',
        )).called(1);
  });

  test('scheduleTaskReminder ignores if no due date', () async {
    final task = Task(
      id: 'task_1',
      title: 'Do this',
      status: TaskStatus.pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      hasEnabledReminder: true,
    );
    await scheduler.scheduleTaskReminder(task);
    verifyNever(() => mockPlugin.zonedSchedule(
          id: any(named: 'id'),
          title: any(named: 'title'),
          body: any(named: 'body'),
          scheduledDate: any(named: 'scheduledDate'),
          notificationDetails: any(named: 'notificationDetails'),
          androidScheduleMode: any(named: 'androidScheduleMode'),
          payload: any(named: 'payload'),
        ));
  });

  test('cancelTaskReminder cancels correct id', () async {
    await scheduler.cancelTaskReminder('task_1');
    verify(() => mockPlugin.cancel(id: NotificationScheduler.taskReminderNotificationId('task_1'))).called(1);
  });

  test('cancelNotification cancels by id via plugin', () async {
    await scheduler.cancelNotification(42);
    verify(() => mockPlugin.cancel(id: 42)).called(1);
  });
}
