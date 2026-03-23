import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:reflect/core/config/env_config.dart';
import 'package:reflect/core/network/dio_client.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/storage/token_storage.dart';
import 'package:reflect/features/post/data/post_repository.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/gcal/data/repositories/gcal_repository_impl.dart';
import 'package:reflect/features/gcal/data/sources/gcal_api_service.dart';
import 'package:reflect/features/gcal/domain/repositories/gcal_repository.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_cubit.dart';
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
import 'package:reflect/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/goals/data/repositories/goal_repository_impl.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/main.dart';

void setupDependencies() {
  // 1. Secure Storage & Token Storage
  const secureStorage = FlutterSecureStorage();
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(secureStorage));

  // 2. Network Info
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(InternetConnection()),
  );

  // 3. Dio Client (Injects TokenStorage)
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      baseUrl: EnvConfig.baseUrl,
      tokenStorage: getIt<TokenStorage>(),
    ),
  );

  // 4. Database
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // 5. Posts
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepository(getIt<DioClient>()),
  );

  // 6. Services & Enginges
  getIt.registerLazySingleton<GCalApiService>(() => GCalApiServiceImpl());
  getIt.registerLazySingleton<RecurrenceEngine>(() => RecurrenceEngineImpl());

  // 7. Repositories
  getIt.registerLazySingleton<ITaskRepository>(
    () => TaskRepositoryImpl(
      getIt<AppDatabase>(),
      getIt<NetworkInfo>(),
      getIt<GCalApiService>(),
      getIt<RecurrenceEngine>(),
      getIt<NotificationScheduler>(),
    ),
  );
  getIt.registerLazySingleton<IGCalRepository>(
    () => GCalRepositoryImpl(getIt<AppDatabase>(), getIt<GCalApiService>()),
  );
  getIt.registerLazySingleton<IReviewRepository>(
    () => ReviewRepositoryImpl(getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<IGoalRepository>(
    () => GoalRepositoryImpl(getIt<AppDatabase>()),
  );

  // 8. BLoCs / Cubits
  getIt.registerFactory<ConnectivityBloc>(
    () => ConnectivityBloc(getIt<NetworkInfo>()),
  );
  getIt.registerFactory<GCalSyncCubit>(
    () => GCalSyncCubit(getIt<IGCalRepository>()),
  );
  getIt.registerFactory<TaskListBloc>(
    () => TaskListBloc(getIt<ITaskRepository>()),
  );
  getIt.registerFactory<PlanningCubit>(
    () => PlanningCubit(getIt<ITaskRepository>()),
  );
  getIt.registerFactory<DailyReviewCubit>(
    () => DailyReviewCubit(getIt<IReviewRepository>()),
  );
  getIt.registerFactory<AnalyticsBloc>(
    () => AnalyticsBloc(getIt<AppDatabase>().analyticsDao),
  );
  getIt.registerFactory<GoalsCubit>(
    () => GoalsCubit(getIt<IGoalRepository>()),
  );
  getIt.registerFactory<TaskSelectionCubit>(
    () => TaskSelectionCubit(),
  );

  // 9. Notifications
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerLazySingleton<NotificationScheduler>(
    () => NotificationScheduler(getIt<NotificationService>()),
  );
  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(getIt<NotificationScheduler>()),
  );
}
