import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reflect/app.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/core/network/presentation/connectivity_event.dart';
import 'package:reflect/core/network/presentation/connectivity_state.dart';

import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_selection/task_selection_state.dart';
import 'package:reflect/features/planning/presentation/planning_cubit.dart';
import 'package:reflect/features/planning/presentation/planning_state.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:reflect/features/settings/presentation/cubit/settings_state.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';
import 'package:reflect/features/notifications/notification_service.dart';
import 'package:reflect/main.dart'; // for getIt

class MockConnectivityBloc extends MockBloc<ConnectivityEvent, ConnectivityState> implements ConnectivityBloc {}

class MockTaskListBloc extends MockBloc<TaskListEvent, TaskListState> implements TaskListBloc {}
class MockPlanningCubit extends MockCubit<PlanningState> implements PlanningCubit {}
class MockDailyReviewCubit extends MockCubit<DailyReviewState> implements DailyReviewCubit {}
class MockTaskSelectionCubit extends MockCubit<TaskSelectionState> implements TaskSelectionCubit {}
class MockSettingsCubit extends MockCubit<SettingsState> implements SettingsCubit {}
class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late MockConnectivityBloc mockConnectivityBloc;

  late MockTaskListBloc mockTaskListBloc;
  late MockPlanningCubit mockPlanningCubit;
  late MockDailyReviewCubit mockDailyReviewCubit;
  late MockTaskSelectionCubit mockTaskSelectionCubit;
  late MockSettingsCubit mockSettingsCubit;
  late MockNotificationService mockNotificationService;

  setUp(() {
    getIt.reset();
    
    mockConnectivityBloc = MockConnectivityBloc();

    mockTaskListBloc = MockTaskListBloc();
    mockPlanningCubit = MockPlanningCubit();
    mockDailyReviewCubit = MockDailyReviewCubit();
    mockTaskSelectionCubit = MockTaskSelectionCubit();
    mockSettingsCubit = MockSettingsCubit();
    mockNotificationService = MockNotificationService();

    when(() => mockConnectivityBloc.state).thenReturn(const ConnectivityState.connected());

    when(() => mockTaskListBloc.state).thenReturn(const TaskListState.loaded(rawTasks: [], pending: [], completed: [], overdue: []));
    when(() => mockPlanningCubit.state).thenReturn(const PlanningState());
    when(() => mockDailyReviewCubit.state).thenReturn(const DailyReviewState());
    when(() => mockDailyReviewCubit.startWatchingTodayTasks()).thenReturn(null);
    when(() => mockTaskSelectionCubit.state).thenReturn(const TaskSelectionState());
    when(() => mockSettingsCubit.state).thenReturn(const SettingsState());


    when(() => mockSettingsCubit.scheduleStartupSync()).thenAnswer((_) async {});
    when(() => mockNotificationService.init()).thenAnswer((_) async {});
    when(() => mockNotificationService.requestPermissions()).thenAnswer((_) async => true);
    when(() => mockConnectivityBloc.stream).thenAnswer((_) => const Stream.empty());

    when(() => mockTaskListBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockPlanningCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockDailyReviewCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockTaskSelectionCubit.stream).thenAnswer((_) => const Stream.empty());
    when(() => mockSettingsCubit.stream).thenAnswer((_) => const Stream.empty());

    getIt.registerSingleton<ConnectivityBloc>(mockConnectivityBloc);

    getIt.registerSingleton<TaskListBloc>(mockTaskListBloc);
    getIt.registerSingleton<PlanningCubit>(mockPlanningCubit);
    getIt.registerSingleton<DailyReviewCubit>(mockDailyReviewCubit);
    getIt.registerSingleton<TaskSelectionCubit>(mockTaskSelectionCubit);
    getIt.registerSingleton<SettingsCubit>(mockSettingsCubit);
    getIt.registerSingleton<NotificationService>(mockNotificationService);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('ReflectApp builds without crashing', (tester) async {
    await tester.pumpWidget(const ReflectApp());
    await tester.pump();
    
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('ReflectApp resolves DailyReviewCubit from GetIt', (tester) async {
    await tester.pumpWidget(const ReflectApp());
    await tester.pump();

    final context = tester.element(find.byType(MaterialApp));
    expect(context.read<DailyReviewCubit>(), same(mockDailyReviewCubit));
  });

  testWidgets('ReflectApp rebuilds when theme mode changes', (tester) async {
    whenListen(
      mockSettingsCubit,
      Stream.fromIterable([
        const SettingsState(themeMode: ThemeMode.light),
        const SettingsState(themeMode: ThemeMode.dark),
      ]),
      initialState: const SettingsState(themeMode: ThemeMode.light),
    );

    await tester.pumpWidget(const ReflectApp());
    await tester.pump();
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
