# Notifications — Reflect

Reflect uses `flutter_local_notifications` and the `timezone` package to schedule "heartbeat" reminders and task alerts locally on the device, ensuring privacy and offline functionality.

## Core Components

The implementation is located in `lib/features/notifications/`.

### 1. `NotificationService`
Handles the low-level platform channels, plugin initialization, and OS-level permission requests for Android and iOS.

### 2. `NotificationScheduler`
Contains the business logic for scheduling specific alerts (e.g., scheduling a daily heartbeat at 9:00 AM). It interacts with `NotificationService` to actually place the notification in the OS queue.

## Initialization

Initialization happens early in `main.dart`:

```dart
final notificationService = getIt<NotificationService>();
await notificationService.init();
await notificationService.requestPermissions();
```

## Scheduling

Notifications are scheduled based on user preferences in `SettingsCubit`. When a user toggles "Heartbeat Reminders", the `SettingsCubit` calls the `NotificationScheduler`.

```dart
Future<void> scheduleHeartbeat(TimeOfDay time) async {
  // Convert time to TZDateTime and schedule...
}
```

## Permissions

- **Android 13+**: Requires the `POST_NOTIFICATIONS` runtime permission.
- **iOS**: Requires standard notification permissions via APNs.

## Open Items

- Currently, tapping a notification opens the app to the default route. Deep linking into specific screens based on notification payload is planned but not fully implemented.
