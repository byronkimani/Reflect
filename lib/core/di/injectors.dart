import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:reflect/core/config/env_config.dart';
import 'package:reflect/core/network/dio_client.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/storage/token_storage.dart';
import 'package:reflect/features/post/data/post_repository.dart';
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
}
