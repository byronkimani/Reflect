import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Product analytics gated by user opt-in (Settings) and non-debug builds.
abstract class AppAnalyticsService {
  void setCollectionEnabled(bool enabled);

  Future<void> logTaskCreated();

  Future<void> logDailyReviewSubmitted();

  Future<void> logPlanningCompleted();
}

/// No-ops all analytics calls (tests and disabled environments).
class NoOpAppAnalyticsService implements AppAnalyticsService {
  const NoOpAppAnalyticsService();

  @override
  void setCollectionEnabled(bool enabled) {}

  @override
  Future<void> logTaskCreated() async {}

  @override
  Future<void> logDailyReviewSubmitted() async {}

  @override
  Future<void> logPlanningCompleted() async {}
}

class FirebaseAppAnalyticsService implements AppAnalyticsService {
  FirebaseAppAnalyticsService({
    FirebaseAnalytics? analytics,
    @visibleForTesting bool? reportingEnabled,
  })  : _analytics = analytics ?? FirebaseAnalytics.instance, // coverage:ignore-line
        _reportingEnabled = reportingEnabled ?? !kDebugMode;

  final FirebaseAnalytics _analytics;
  final bool _reportingEnabled;
  bool _collectionEnabled = false;

  @override
  void setCollectionEnabled(bool enabled) {
    _collectionEnabled = enabled;
    if (!_reportingEnabled) return;
    _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  Future<void> _logEvent(String name) async {
    if (!_reportingEnabled || !_collectionEnabled) return;
    await _analytics.logEvent(name: name);
  }

  @override
  Future<void> logTaskCreated() => _logEvent('task_created');

  @override
  Future<void> logDailyReviewSubmitted() => _logEvent('daily_review_submitted');

  @override
  Future<void> logPlanningCompleted() => _logEvent('planning_completed');
}
