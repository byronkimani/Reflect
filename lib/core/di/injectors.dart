import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:reflect/core/config/env_config.dart';
import 'package:reflect/core/network/dio_client.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/storage/token_storage.dart';
import 'package:reflect/features/post/data/post_repository.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/gcal/domain/repositories/gcal_repository.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/planning/presentation/planning_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
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

  // 5. Posts
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepository(getIt<DioClient>()),
  );

  // 6. Repositories (Placeholders)
  // Note: These would usually be implemented in the data layer
  // and injected here as their implementations.
  // Using sl.registerFactory for BLoCs to ensure fresh instances if needed,
  // but usually global blocs are singletons.
  
  // getIt.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(getIt<AppDatabase>()));
  // getIt.registerLazySingleton<GCalRepository>(() => GCalRepositoryImpl(getIt<AppDatabase>()));
  // getIt.registerLazySingleton<ReviewRepository>(() => ReviewRepositoryImpl(getIt<AppDatabase>()));

  // 7. BLoCs / Cubits
  getIt.registerFactory<ConnectivityBloc>(() => ConnectivityBloc(getIt<NetworkInfo>()));
  getIt.registerFactory<GCalSyncCubit>(() => GCalSyncCubit(getIt<GCalRepository>()));
  getIt.registerFactory<TaskListBloc>(() => TaskListBloc(getIt<TaskRepository>()));
  getIt.registerFactory<PlanningCubit>(() => PlanningCubit(getIt<TaskRepository>()));
  getIt.registerFactory<DailyReviewCubit>(() => DailyReviewCubit(getIt<ReviewRepository>()));
}
