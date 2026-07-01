import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/router/notification_routes.dart';

void main() {
  group('NotificationRoutes', () {
    test('normalize allows exact planning route', () {
      expect(NotificationRoutes.normalize('/today/planning'), '/today/planning');
    });

    test('normalize maps legacy task route to today task route', () {
      expect(
        NotificationRoutes.normalize('/task/abc-123'),
        '/today/task/abc-123',
      );
    });

    test('normalize rejects traversal payloads', () {
      expect(NotificationRoutes.normalize('../../../evil'), isNull);
    });

    test('normalize rejects unknown routes', () {
      expect(NotificationRoutes.normalize('/admin'), isNull);
    });

    test('normalize allows backlog task route', () {
      expect(
        NotificationRoutes.normalize('/backlog/task/task-1'),
        '/backlog/task/task-1',
      );
    });

    test('isAllowed returns true for normalized routes', () {
      expect(NotificationRoutes.isAllowed('/today/planning'), isTrue);
    });

    test('isAllowed returns false for rejected routes', () {
      expect(NotificationRoutes.isAllowed('/admin'), isFalse);
    });
  });
}
