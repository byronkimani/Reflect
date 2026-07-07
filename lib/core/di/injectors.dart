import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:reflect/core/config/env_config.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/core/observability/crash_reporter.dart';
import 'package:reflect/core/observability/firebase_crash_reporter.dart';
import 'package:reflect/core/network/auth_session_notifier.dart';
import 'package:reflect/core/network/dio_client.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/core/storage/database/database_key_service.dart';
import 'package:reflect/core/storage/secure_storage_factory.dart';
import 'package:reflect/core/storage/token_storage.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/features/planning/presentation/planning_cubit.dart';
import 'package:reflect/features/review/data/repositories/review_repository_impl.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/tasks/data/repositories/task_repository_impl.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';

import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/goals/data/repositories/goal_repository_impl.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/main.dart';

void setupDependencies() {
  const secureStorage = SecureStorageFactory.instance;

  getIt.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(secureStorage));
  getIt.registerLazySingleton<DatabaseKeyService>(
    () => DatabaseKeyService(secureStorage),
  );
  getIt.registerLazySingleton<AuthSessionNotifier>(() => AuthSessionNotifier());

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnection()),
  );

  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      baseUrl: EnvConfig.baseUrl,
      tokenStorage: getIt<TokenStorage>(),
      sessionNotifier: getIt<AuthSessionNotifier>(),
    ),
  );

  getIt.registerLazySingleton<AppDatabase>(
    () => AppDatabase(getIt<DatabaseKeyService>()),
  );

  getIt.registerLazySingleton<RecurrenceEngine>(() => RecurrenceEngineImpl());

  getIt.registerLazySingleton<ITaskRepository>(
    () => TaskRepositoryImpl(
      getIt<AppDatabase>(),
      getIt<RecurrenceEngine>(),
      getIt<NotificationScheduler>(),
    ),
  );
  getIt.registerLazySingleton<IReviewRepository>(
    () => ReviewRepositoryImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<IGoalRepository>(
    () => GoalRepositoryImpl(getIt<AppDatabase>()),
  );

  getIt.registerFactory<ConnectivityBloc>(
    () => ConnectivityBloc(getIt<NetworkInfo>()),
  );
  getIt.registerFactory<TaskListBloc>(
    () => TaskListBloc(getIt<ITaskRepository>()),
  );
  getIt.registerFactory<PlanningCubit>(
    () => PlanningCubit(
      getIt<ITaskRepository>(),
      getIt<AppAnalyticsService>(),
    ),
  );
  getIt.registerFactory<DailyReviewCubit>(
    () => DailyReviewCubit(
      getIt<IReviewRepository>(),
      getIt<AppAnalyticsService>(),
    ),
  );

  getIt.registerFactory<GoalsCubit>(
    () => GoalsCubit(getIt<IGoalRepository>()),
  );
  getIt.registerFactory<TaskSelectionCubit>(
    () => TaskSelectionCubit(),
  );

  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerLazySingleton<NotificationScheduler>(
    () => NotificationScheduler(getIt<NotificationService>()),
  );
  getIt.registerLazySingleton<CrashReporter>(() => FirebaseCrashReporter());
  getIt.registerLazySingleton<AppAnalyticsService>(
    () => FirebaseAppAnalyticsService(),
  );

  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(
      getIt<NotificationScheduler>(),
      getIt<AppAnalyticsService>(),
    ),
  );
}
