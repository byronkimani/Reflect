import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_it/get_it.dart';
import 'package:reflect/app.dart';
import 'package:reflect/core/observability/firebase_crash_reporter.dart';
import 'package:reflect/core/startup/app_bootstrap.dart';

// Dependency Injection Setup
final getIt = GetIt.instance;

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final crashReporter = FirebaseCrashReporter();
  await bootstrapReflectApp(crashReporter: crashReporter);
  runApp(const ReflectApp());
}
