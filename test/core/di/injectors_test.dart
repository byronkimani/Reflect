import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:reflect/core/di/injectors.dart';
import 'package:reflect/core/network/auth_session_notifier.dart';
import 'package:reflect/core/network/dio_client.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/core/observability/crash_reporter.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/core/storage/database/database_key_service.dart';
import 'package:reflect/core/storage/token_storage.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/features/notifications/notification_scheduler.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:reflect/features/planning/presentation/planning_cubit.dart';
import 'package:reflect/features/review/domain/repositories/review_repository.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/domain/services/recurrence_engine.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/main.dart';

import '../../helpers/fake_path_provider.dart';

class MockDatabaseKeyService extends Mock implements DatabaseKeyService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late MockDatabaseKeyService mockKeyService;
  PathProviderPlatform? previousPathProvider;

  setUp(() async {
    getIt.reset();
    dotenv.loadFromString(envString: 'APP_ENV=testing');
    tempDir = Directory.systemTemp.createTempSync('injectors_test');
    previousPathProvider = PathProviderPlatform.instance;
    PathProviderPlatform.instance = FakePathProvider.using(tempDir);
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory('${tempDir.path}/hydrated'),
    );

    mockKeyService = MockDatabaseKeyService();
    when(() => mockKeyService.hasCompletedEncryptionMigration())
        .thenAnswer((_) async => true);
    when(() => mockKeyService.getOrCreateKey()).thenAnswer((_) async => 'dGVzdA==');
  });

  tearDown(() {
    PathProviderPlatform.instance = previousPathProvider!;
    getIt.reset();
    dotenv.clean();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  test('setupDependencies default database factories instantiate', () {
    setupDependencies();

    getIt<DatabaseKeyService>();
    final db = getIt<AppDatabase>();
    addTearDown(() async => db.close());
  });

  test('setupDependencies registers and resolves core services and blocs', () async {
    setupDependencies();
    getIt.unregister<AppAnalyticsService>();
    getIt.registerLazySingleton<AppAnalyticsService>(
      () => const NoOpAppAnalyticsService(),
    );

    getIt.unregister<DatabaseKeyService>();
    getIt.unregister<AppDatabase>();
    getIt.registerLazySingleton<DatabaseKeyService>(() => mockKeyService);
    getIt.registerLazySingleton<AppDatabase>(() => AppDatabase(mockKeyService));

    getIt<FlutterSecureStorage>();
    getIt<TokenStorage>();
    getIt<AuthSessionNotifier>();
    getIt<NetworkInfo>();
    getIt<DioClient>();

    final db = getIt<AppDatabase>();
    addTearDown(() async => db.close());

    getIt<RecurrenceEngine>();
    getIt<ITaskRepository>();
    getIt<IReviewRepository>();
    getIt<IGoalRepository>();
    getIt<NotificationService>();
    getIt<NotificationScheduler>();
    getIt<CrashReporter>();
    getIt<AppAnalyticsService>();

    final connectivity = getIt<ConnectivityBloc>();
    addTearDown(connectivity.close);

    final taskList = getIt<TaskListBloc>();
    addTearDown(taskList.close);

    final planning = getIt<PlanningCubit>();
    addTearDown(planning.close);

    final review = getIt<DailyReviewCubit>();
    addTearDown(review.close);

    final goals = getIt<GoalsCubit>();
    addTearDown(goals.close);

    getIt<TaskSelectionCubit>();

    final settings = getIt<SettingsCubit>();
    addTearDown(settings.close);

    expect(getIt.isRegistered<AppDatabase>(), isTrue);
    expect(getIt.isRegistered<ITaskRepository>(), isTrue);
    expect(getIt.isRegistered<IReviewRepository>(), isTrue);
    expect(getIt.isRegistered<IGoalRepository>(), isTrue);
    expect(getIt.isRegistered<NotificationService>(), isTrue);
    expect(getIt.isRegistered<NotificationScheduler>(), isTrue);
    expect(getIt.isRegistered<CrashReporter>(), isTrue);
    expect(getIt.isRegistered<AppAnalyticsService>(), isTrue);
    expect(getIt.isRegistered<ConnectivityBloc>(), isTrue);
    expect(getIt.isRegistered<TaskListBloc>(), isTrue);
    expect(getIt.isRegistered<PlanningCubit>(), isTrue);
    expect(getIt.isRegistered<DailyReviewCubit>(), isTrue);
    expect(getIt.isRegistered<GoalsCubit>(), isTrue);
    expect(getIt.isRegistered<TaskSelectionCubit>(), isTrue);
    expect(getIt.isRegistered<SettingsCubit>(), isTrue);
  });
}
