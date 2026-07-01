import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:reflect/core/observability/crash_reporter.dart';

/// Sends crash reports to Firebase Crashlytics in non-debug builds.
class FirebaseCrashReporter implements CrashReporter {
  FirebaseCrashReporter({
    FirebaseCrashlytics? crashlytics,
    @visibleForTesting bool? enabled,
  })  : _crashlytics = crashlytics ?? FirebaseCrashlytics.instance,
        _enabled = enabled ?? !kDebugMode;

  final FirebaseCrashlytics _crashlytics;
  final bool _enabled;

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {
    if (!_enabled) return;
    await _crashlytics.recordFlutterFatalError(details);
  }

  @override
  Future<void> recordError(
    Object error,
    StackTrace stack, {
    bool fatal = false,
  }) async {
    if (!_enabled) return;
    await _crashlytics.recordError(error, stack, fatal: fatal);
  }
}
