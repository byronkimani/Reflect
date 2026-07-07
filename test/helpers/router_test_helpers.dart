import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart' hide Task;
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/core/network/presentation/connectivity_event.dart';
import 'package:reflect/core/network/presentation/connectivity_state.dart';
import 'package:reflect/core/observability/analytics_service.dart';
import 'package:reflect/core/router/app_router.dart';

import 'package:reflect/features/goals/domain/entities/goal.dart';
import 'package:reflect/features/goals/domain/entities/goal_category.dart';
import 'package:reflect/features/goals/domain/repositories/goal_repository.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_cubit.dart';
import 'package:reflect/features/goals/presentation/cubit/goals_state.dart';
import 'package:reflect/features/planning/presentation/planning_cubit.dart';
import 'package:reflect/features/planning/presentation/planning_state.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_state.dart';
import 'package:reflect/features/tasks/domain/repositories/task_repository.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';
import 'package:reflect/main.dart';

class MockConnectivityBloc extends MockBloc<ConnectivityEvent, ConnectivityState>
    implements ConnectivityBloc {}



class MockTaskListBloc extends MockBloc<TaskListEvent, TaskListState>
    implements TaskListBloc {}

class MockPlanningCubit extends MockCubit<PlanningState>
    implements PlanningCubit {}

class MockDailyReviewCubit extends MockCubit<DailyReviewState>
    implements DailyReviewCubit {}

class MockTaskSelectionCubit extends MockCubit<TaskSelectionState>
    implements TaskSelectionCubit {}

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

class MockGoalsCubit extends MockCubit<GoalsState> implements GoalsCubit {}



class MockITaskRepository extends Mock implements ITaskRepository {}

class MockIGoalRepository extends Mock implements IGoalRepository {}

/// Registers the minimum GetIt + bloc mocks required to pump [createAppRouter].
class RouterTestHarness {
  RouterTestHarness._();

  late MockConnectivityBloc connectivityBloc;

  late MockTaskListBloc taskListBloc;
  late MockPlanningCubit planningCubit;
  late MockDailyReviewCubit dailyReviewCubit;
  late MockTaskSelectionCubit taskSelectionCubit;
  late MockSettingsCubit settingsCubit;
  late MockGoalsCubit goalsCubit;

  late MockITaskRepository taskRepository;
  late MockIGoalRepository goalRepository;

  late GoRouter router;

  static Future<RouterTestHarness> create() async {
    final harness = RouterTestHarness._();
    await harness._setUp();
    return harness;
  }

  Future<void> _setUp() async {
    await getIt.reset();

    connectivityBloc = MockConnectivityBloc();

    taskListBloc = MockTaskListBloc();
    planningCubit = MockPlanningCubit();
    dailyReviewCubit = MockDailyReviewCubit();
    taskSelectionCubit = MockTaskSelectionCubit();
    settingsCubit = MockSettingsCubit();
    goalsCubit = MockGoalsCubit();

    taskRepository = MockITaskRepository();
    goalRepository = MockIGoalRepository();

    when(() => connectivityBloc.state)
        .thenReturn(const ConnectivityState.connected());

    when(() => taskListBloc.state).thenReturn(
      const TaskListState.loaded(rawTasks: [], pending: [], completed: [], overdue: []),
    );
    when(() => planningCubit.state).thenReturn(const PlanningState());
    when(() => dailyReviewCubit.state).thenReturn(const DailyReviewState());
    when(() => taskSelectionCubit.state)
        .thenReturn(const TaskSelectionState());
    when(() => settingsCubit.state).thenReturn(const SettingsState());
    when(() => goalsCubit.state).thenReturn(const GoalsState());
    when(() => goalsCubit.stream)
        .thenAnswer((_) => Stream.value(const GoalsState()));

    when(() => goalRepository.watchAllGoals()).thenAnswer(
      (_) => Stream.value(const Right(<Goal>[])),
    );
    when(() => goalRepository.watchCategories()).thenAnswer(
      (_) => Stream.value(const Right(<GoalCategory>[])),
    );

    getIt.registerSingleton<ITaskRepository>(taskRepository);
    getIt.registerSingleton<IGoalRepository>(goalRepository);
    getIt.registerSingleton<GoalsCubit>(goalsCubit);
    getIt.registerSingleton<AppAnalyticsService>(const NoOpAppAnalyticsService());


    router = createAppRouter();
  }

  Future<void> dispose() async {
    await getIt.reset();
  }

  Widget buildApp() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>.value(value: connectivityBloc),

        BlocProvider<TaskListBloc>.value(value: taskListBloc),
        BlocProvider<PlanningCubit>.value(value: planningCubit),
        BlocProvider<DailyReviewCubit>.value(value: dailyReviewCubit),
        BlocProvider<TaskSelectionCubit>.value(value: taskSelectionCubit),
        BlocProvider<SettingsCubit>.value(value: settingsCubit),
      ],
      child: MaterialApp.router(routerConfig: router),
    );
  }
}
