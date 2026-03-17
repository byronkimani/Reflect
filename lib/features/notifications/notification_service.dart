import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:reflect/core/router/app_router.dart';
import 'package:go_router/go_router.dart';

/// A wrapper service for flutter_local_notifications.
/// Handles initialization, permissions, and notification tap callbacks.
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Initializes the notification plugin and the timezone database.
  Future<void> init() async {
    tz.initializeTimeZones();

    // Android-specific settings: using the default app icon
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS/Darwin-specific settings
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    await notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
    );
  }

  /// Handles notification tap events and performs navigation.
  void _handleNotificationResponse(NotificationResponse response) {
    final String? payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        context.push(payload);
      }
    }
  }

  /// Requests permissions for Android 13+ and iOS.
  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await notificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          notificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      // Request normal notification permission
      await androidImplementation?.requestNotificationsPermission();
      // Request permission for exact alarms (required for Android 12+)
      await androidImplementation?.requestExactAlarmsPermission();
    }
  }
}
