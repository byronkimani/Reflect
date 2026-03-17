import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:reflect/core/di/injectors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/app.dart';
import 'package:reflect/core/config/env_config.dart';
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

  // 4. Initialize Notifications
  final notificationService = getIt<NotificationService>();
  await notificationService.init();
  await notificationService.requestPermissions();
  
  // 5. Schedule initial heartbeats
  final notificationScheduler = getIt<NotificationScheduler>();
  await notificationScheduler.scheduleAllHeartbeats();

  runApp(const ReflectApp());
}
