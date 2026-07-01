import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/observability/analytics_service.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  group('FirebaseAppAnalyticsService', () {
    late MockFirebaseAnalytics mockAnalytics;

    setUp(() {
      mockAnalytics = MockFirebaseAnalytics();
      when(
        () => mockAnalytics.setAnalyticsCollectionEnabled(any()),
      ).thenAnswer((_) async {});
      when(() => mockAnalytics.logEvent(name: any(named: 'name')))
          .thenAnswer((_) async {});
    });

    test('does not log events when collection is disabled', () async {
      final service = FirebaseAppAnalyticsService(
        analytics: mockAnalytics,
        reportingEnabled: true,
      );

      await service.logTaskCreated();
      verifyNever(() => mockAnalytics.logEvent(name: any(named: 'name')));
    });

    test('logs task_created when collection is enabled', () async {
      final service = FirebaseAppAnalyticsService(
        analytics: mockAnalytics,
        reportingEnabled: true,
      );
      service.setCollectionEnabled(true);

      await service.logTaskCreated();
      verify(() => mockAnalytics.logEvent(name: 'task_created')).called(1);
    });

    test('does not log when reporting is disabled', () async {
      final service = FirebaseAppAnalyticsService(
        analytics: mockAnalytics,
        reportingEnabled: false,
      );
      service.setCollectionEnabled(true);

      await service.logDailyReviewSubmitted();
      verifyNever(() => mockAnalytics.logEvent(name: any(named: 'name')));
      verifyNever(() => mockAnalytics.setAnalyticsCollectionEnabled(any()));
    });
  });

  group('NoOpAppAnalyticsService', () {
    test('accepts calls without throwing', () async {
      const service = NoOpAppAnalyticsService();
      service.setCollectionEnabled(true);
      await service.logPlanningCompleted();
    });
  });
}
