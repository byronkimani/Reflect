import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/observability/app_bloc_observer.dart';
import 'package:reflect/core/observability/crash_reporter.dart';
import 'package:reflect/core/startup/app_bootstrap.dart';

class MockCrashReporter extends Mock implements CrashReporter {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(
      FlutterErrorDetails(exception: Exception('fallback')),
    );
    registerFallbackValue(StackTrace.empty);
  });

  late MockCrashReporter crashReporter;
  late Directory tempDir;
  FlutterExceptionHandler? previousFlutterHandler;
  ErrorCallback? previousPlatformHandler;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('reflect_bootstrap_test');
    crashReporter = MockCrashReporter();
    when(() => crashReporter.recordFlutterError(any())).thenAnswer((_) async {});
    when(
      () => crashReporter.recordError(
        any(),
        any(),
        fatal: any(named: 'fatal'),
      ),
    ).thenAnswer((_) async {});
    previousFlutterHandler = FlutterError.onError;
    previousPlatformHandler = PlatformDispatcher.instance.onError;
  });

  tearDown(() {
    FlutterError.onError = previousFlutterHandler;
    PlatformDispatcher.instance.onError = previousPlatformHandler ?? (_, _) => false;
    Bloc.observer = AppBlocObserver(crashReporter);
  });

  test('installs global error handlers and bloc observer', () async {
    var envCalled = false;
    var firebaseCalled = false;
    var diCalled = false;

    await bootstrapReflectApp(
      crashReporter: crashReporter,
      applySqlCipherWorkaround: () async {},
      initEnv: () async {
        envCalled = true;
      },
      initFirebase: () async {
        firebaseCalled = true;
      },
      buildHydratedStorage: () async => HydratedStorage.build(
        storageDirectory: HydratedStorageDirectory(tempDir.path),
      ),
      setupDi: () {
        diCalled = true;
      },
    );

    expect(envCalled, isTrue);
    expect(firebaseCalled, isTrue);
    expect(diCalled, isTrue);
    expect(Bloc.observer, isA<BlocObserver>());

    FlutterError.onError!(
      FlutterErrorDetails(exception: Exception('flutter')),
    );
    PlatformDispatcher.instance.onError!(Exception('async'), StackTrace.current);

    verify(() => crashReporter.recordFlutterError(any())).called(1);
    verify(
      () => crashReporter.recordError(
        any(),
        any(),
        fatal: true,
      ),
    ).called(1);
  });
}
