import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:reflect/features/notifications/notification_service.dart';

/// Handles the business logic for scheduling specific app notifications.
class NotificationScheduler {
  final NotificationService _notificationService;

  NotificationScheduler(this._notificationService);

  FlutterLocalNotificationsPlugin get _plugin =>
      _notificationService.notificationsPlugin;

  /// Schedules all recurring heartbeat notifications for the application.
  Future<void> scheduleAllHeartbeats() async {
    await scheduleMorningPlanning();
    await scheduleEveningReview();
    await scheduleWeeklyPlanning();
    await scheduleMonthlyPlanning();
  }

  /// Schedules daily morning planning at 8:00 AM.
  /// ID: 1001
  Future<void> scheduleMorningPlanning() async {
    await _plugin.zonedSchedule(
      id: 1001,
      title: 'Time to plan your day 🗓️',
      body: 'Open Reflect to set yourself up for a great day.',
      scheduledDate: _nextInstanceOfTime(8, 0),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'planning_channel',
          'Planning Notifications',
          channelDescription: 'Daily morning planning reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '/today/planning',
    );
  }

  /// Schedules daily evening review at 9:00 PM.
  /// ID: 1002
  /// [skipToday] can be used to explicitly schedule for tomorrow (e.g., after completion).
  Future<void> scheduleEveningReview({bool skipToday = false}) async {
    await _plugin.zonedSchedule(
      id: 1002,
      title: 'Daily Reflection 🌙',
      body: 'Take a moment to review your day.',
      scheduledDate: _nextInstanceOfTime(21, 0, skipToday: skipToday),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'review_channel',
          'Review Notifications',
          channelDescription: 'Daily evening review reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: '/today/review',
    );
  }

  /// Schedules weekly planning on Sunday at 6:00 PM.
  /// ID: 1003
  Future<void> scheduleWeeklyPlanning() async {
    await _plugin.zonedSchedule(
      id: 1003,
      title: 'Weekly Review & Plan 🧭',
      body: 'Set your direction for the week ahead.',
      scheduledDate: _nextInstanceOfDayOfWeekAndTime(DateTime.sunday, 18, 0),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'weekly_channel',
          'Weekly Notifications',
          channelDescription: 'Weekly planning reminders',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      payload: '/weekly/plan',
    );
  }

  /// Schedules monthly planning on the 1st of each month at 9:00 AM.
  /// Explicitly schedules the next 12 instances as day-of-month isn't built-in.
  /// Base ID: 1100
  Future<void> scheduleMonthlyPlanning() async {
    const int idBase = 1100;
    final now = tz.TZDateTime.now(tz.local);

    for (int i = 0; i < 12; i++) {
      // Calculate 1st of month for current month + i
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month + i,
        1,
        9,
      );

      // If the calculated date is in the past, move to next month
      if (scheduledDate.isBefore(now)) {
        scheduledDate = tz.TZDateTime(
          tz.local,
          now.year,
          now.month + i + 1,
          1,
          9,
        );
      }

      await _plugin.zonedSchedule(
        id: idBase + i,
        title: 'New Month, New Focus 🎯',
        body: 'Set your goals for the new month.',
        scheduledDate: scheduledDate,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'monthly_channel',
            'Monthly Notifications',
            channelDescription: 'Monthly planning reminders',
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: '/monthly/plan',
      );
    }
  }

  /// Cancels a specific notification by ID.
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id: id);
  }

  /// Helper to get the next instance of a specific time.
  tz.TZDateTime _nextInstanceOfTime(
    int hour,
    int minute, {
    bool skipToday = false,
  }) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now) || skipToday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  /// Helper to get the next instance of a specific day of week and time.
  tz.TZDateTime _nextInstanceOfDayOfWeekAndTime(
    int dayOfWeek,
    int hour,
    int minute,
  ) {
    tz.TZDateTime scheduledDate = _nextInstanceOfTime(hour, minute);
    while (scheduledDate.weekday != dayOfWeek) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
