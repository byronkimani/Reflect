import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/observability/crash_reporter.dart';
import 'package:reflect/core/observability/firebase_crash_reporter.dart';

class MockFirebaseCrashlytics extends Mock implements FirebaseCrashlytics {}

void main() {
  setUpAll(() {
    registerFallbackValue(
      FlutterErrorDetails(exception: Exception('fallback')),
    );
  });

  late MockFirebaseCrashlytics mockCrashlytics;

  setUp(() {
    mockCrashlytics = MockFirebaseCrashlytics();
    when(
      () => mockCrashlytics.recordError(
        any(),
        any(),
        fatal: any(named: 'fatal'),
      ),
    ).thenAnswer((_) async {});
    when(() => mockCrashlytics.recordFlutterFatalError(any()))
        .thenAnswer((_) async {});
  });

  test('NoOpCrashReporter implements CrashReporter', () {
    expect(const NoOpCrashReporter(), isA<CrashReporter>());
  });

  test('NoOpCrashReporter accepts fatal and non-fatal errors', () async {
    const reporter = NoOpCrashReporter();

    await reporter.recordError(Exception('non-fatal'), StackTrace.current);
    await reporter.recordError(
      Exception('fatal'),
      StackTrace.current,
      fatal: true,
    );
    await reporter.recordFlutterError(
      FlutterErrorDetails(exception: Exception('flutter')),
    );
  });

  test('skips crashlytics when reporter is disabled', () async {
    final reporter = FirebaseCrashReporter(
      crashlytics: mockCrashlytics,
      enabled: false,
    );

    await reporter.recordError(Exception('x'), StackTrace.current);
    await reporter.recordFlutterError(
      FlutterErrorDetails(exception: Exception('x')),
    );

    verifyNever(() => mockCrashlytics.recordError(any(), any(), fatal: any(named: 'fatal')));
    verifyNever(() => mockCrashlytics.recordFlutterFatalError(any()));
  });

  test('records errors when enabled', () async {
    final reporter = FirebaseCrashReporter(
      crashlytics: mockCrashlytics,
      enabled: true,
    );
    final error = Exception('fail');
    final stack = StackTrace.current;

    await reporter.recordError(error, stack, fatal: true);

    verify(
      () => mockCrashlytics.recordError(error, stack, fatal: true),
    ).called(1);
  });

  test('records flutter errors when enabled', () async {
    final reporter = FirebaseCrashReporter(
      crashlytics: mockCrashlytics,
      enabled: true,
    );
    final details = FlutterErrorDetails(exception: Exception('widget fail'));

    await reporter.recordFlutterError(details);

    verify(() => mockCrashlytics.recordFlutterFatalError(details)).called(1);
  });
}
