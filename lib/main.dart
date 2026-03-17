import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:reflect/core/di/injectors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reflect/app.dart';
import 'package:reflect/core/config/env_config.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:get_it/get_it.dart';

// Dependency Injection Setup
final getIt = GetIt.instance;

void main() async {
  // 1. Binding init
  WidgetsFlutterBinding.ensureInitialized();

  await EnvConfig.init();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );

  // 3. Set up dependency injection
  setupDependencies();

  // 4. Initialize Sentry & Run App
  await SentryFlutter.init((options) {
    options.dsn = 'YOUR_SENTRY_DSN_HERE';
    options.tracesSampleRate = 1.0; // Capture 100% of transactions for testing
    options.environment = EnvConfig.envName;
  }, appRunner: () => runApp(const MyApp()));
}
