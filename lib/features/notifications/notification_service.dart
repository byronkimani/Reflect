import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:reflect/core/router/app_router.dart';
import 'package:reflect/core/router/notification_routes.dart';
import 'package:go_router/go_router.dart';

/// Invoked when a notification payload should navigate to a route.
typedef NotificationRouteHandler = void Function(String route);

/// Platform target used by [NotificationService.requestPermissions].
enum NotificationPlatformTarget { ios, android, other }

/// A wrapper service for flutter_local_notifications.
/// Handles initialization, permissions, and notification tap callbacks.
class NotificationService {
  NotificationService({
    FlutterLocalNotificationsPlugin? notificationsPlugin,
    this._onNotificationRoute,
    this._platformTarget,
  }) : notificationsPlugin =
           notificationsPlugin ?? FlutterLocalNotificationsPlugin();

  final FlutterLocalNotificationsPlugin notificationsPlugin;
  final NotificationRouteHandler? _onNotificationRoute;
  final NotificationPlatformTarget? _platformTarget;

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
      onDidReceiveNotificationResponse: handleNotificationResponse,
    );
  }

  /// Handles notification tap events and performs navigation.
  @visibleForTesting
  void handleNotificationResponse(NotificationResponse response) {
    final route = NotificationRoutes.normalize(response.payload);
    if (route == null) {
      return;
    }

    final routeHandler = _onNotificationRoute;
    if (routeHandler != null) {
      routeHandler(route);
      return;
    }

    final context = rootNavigatorKey.currentContext;
    if (context != null) {
      context.push(route);
    }
  }

  NotificationPlatformTarget get platformTarget =>
      _platformTarget ?? _detectPlatform();

  static NotificationPlatformTarget _detectPlatform() => resolvePlatform(
        isWeb: kIsWeb,
        isIOS: Platform.isIOS,
        isMacOS: Platform.isMacOS,
        isAndroid: Platform.isAndroid,
      );

  @visibleForTesting
  static NotificationPlatformTarget resolvePlatform({
    required bool isWeb,
    required bool isIOS,
    required bool isMacOS,
    required bool isAndroid,
  }) {
    if (isWeb) {
      return NotificationPlatformTarget.other;
    }
    if (isIOS || isMacOS) {
      return NotificationPlatformTarget.ios;
    }
    if (isAndroid) {
      return NotificationPlatformTarget.android;
    }
    return NotificationPlatformTarget.other;
  }

  /// Requests permissions for Android 13+ and iOS.
  Future<void> requestPermissions() async {
    switch (platformTarget) {
      case NotificationPlatformTarget.ios:
        await notificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      case NotificationPlatformTarget.android:
        final androidImplementation = notificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

        await androidImplementation?.requestNotificationsPermission();
        await androidImplementation?.requestExactAlarmsPermission();
      case NotificationPlatformTarget.other:
        break;
    }
  }
}
