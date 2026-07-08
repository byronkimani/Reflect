import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:reflect/core/observability/app_bloc_observer.dart';
import 'package:reflect/core/observability/crash_reporter.dart';
import 'package:reflect/core/startup/app_bootstrap.dart';

import '../../helpers/fake_path_provider.dart';

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
  PathProviderPlatform? previousPathProvider;
  FlutterExceptionHandler? previousFlutterHandler;
  ErrorCallback? previousPlatformHandler;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('reflect_bootstrap_test');
    previousPathProvider = PathProviderPlatform.instance;
    PathProviderPlatform.instance = FakePathProvider.using(tempDir);
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
    PathProviderPlatform.instance = previousPathProvider!;
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

  test('uses default sqlcipher workaround when override is omitted', () async {
    await bootstrapReflectApp(
      crashReporter: crashReporter,
      initEnv: () async {},
      initFirebase: () async {},
      buildHydratedStorage: () async => HydratedStorage.build(
        storageDirectory: HydratedStorageDirectory(tempDir.path),
      ),
      setupDi: () {},
    );

    expect(Bloc.observer, isA<BlocObserver>());
  });

  test('uses default hydrated storage when builder omitted', () async {
    await bootstrapReflectApp(
      crashReporter: crashReporter,
      initEnv: () async {},
      initFirebase: () async {},
      setupDi: () {},
    );

    expect(HydratedBloc.storage, isNotNull);
  });
}
