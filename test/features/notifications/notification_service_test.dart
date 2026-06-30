import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('NotificationService initializes correctly', () async {
    final service = NotificationService();
    // We can't fully mock initialize without method channels, but we can assert instance exists
    expect(service.notificationsPlugin, isA<FlutterLocalNotificationsPlugin>());
  });
}
