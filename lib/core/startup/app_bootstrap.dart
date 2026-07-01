import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reflect/core/config/env_config.dart';
import 'package:reflect/core/di/injectors.dart';
import 'package:reflect/core/observability/app_bloc_observer.dart';
import 'package:reflect/core/observability/crash_reporter.dart';
import 'package:reflect/firebase_options.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';

/// Initializes Firebase, storage, DI, and global error handlers.
Future<void> bootstrapReflectApp({
  required CrashReporter crashReporter,
  Future<void> Function()? applySqlCipherWorkaround,
  Future<void> Function()? initEnv,
  Future<void> Function()? initFirebase,
  Future<HydratedStorage> Function()? buildHydratedStorage,
  void Function()? setupDi,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await (applySqlCipherWorkaround ??
      applyWorkaroundToOpenSqlCipherOnOldAndroidVersions)();

  await (initEnv ?? EnvConfig.init)();

  await (initFirebase ??
      () => Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ))();

  HydratedBloc.storage = await (buildHydratedStorage ??
      () async => HydratedStorage.build(
            storageDirectory: HydratedStorageDirectory(
              (await getApplicationSupportDirectory()).path,
            ),
          ))();

  (setupDi ?? setupDependencies)();

  _installGlobalErrorHandlers(crashReporter);
  Bloc.observer = AppBlocObserver(crashReporter);
}

void _installGlobalErrorHandlers(CrashReporter crashReporter) {
  final previousFlutterHandler = FlutterError.onError;

  FlutterError.onError = (details) {
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
    previousFlutterHandler?.call(details);
    crashReporter.recordFlutterError(details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    crashReporter.recordError(error, stack, fatal: true);
    return true;
  };
}
