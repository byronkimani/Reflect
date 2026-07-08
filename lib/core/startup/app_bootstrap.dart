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

Future<void> _defaultSqlCipherWorkaround() async {
  // sqlcipher_flutter_libs 0.7+eol is a no-op stub; no Android workaround needed.
}

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

  await (applySqlCipherWorkaround ?? _defaultSqlCipherWorkaround)();

  await (initEnv ?? EnvConfig.init)();

  await (initFirebase ??
      // coverage:ignore-start
      () async {
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        }
      // coverage:ignore-end
      })();

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
