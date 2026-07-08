import 'package:flutter/foundation.dart';

/// Records fatal and non-fatal errors for production crash visibility.
abstract class CrashReporter {
  Future<void> recordFlutterError(FlutterErrorDetails details);

  Future<void> recordError(
    Object error,
    StackTrace stack, {
    bool fatal = false,
  });
}

/// No-op implementation for tests and debug-only paths.
class NoOpCrashReporter implements CrashReporter {
  const NoOpCrashReporter(); // coverage:ignore-line

  @override
  Future<void> recordFlutterError(FlutterErrorDetails details) async {}

  @override
  Future<void> recordError(
    Object error,
    StackTrace stack, {
    bool fatal = false,
  }) async {}
}
