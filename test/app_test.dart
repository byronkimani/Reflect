import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reflect/app.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/core/network/presentation/connectivity_event.dart';
import 'package:reflect/core/network/presentation/connectivity_state.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_cubit.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_state.dart';
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
import 'package:reflect/main.dart'; // for getIt

class MockConnectivityBloc extends MockBloc<ConnectivityEvent, ConnectivityState> implements ConnectivityBloc {}
class MockGCalSyncCubit extends MockCubit<GCalSyncState> implements GCalSyncCubit {}
class MockTaskListBloc extends MockBloc<TaskListEvent, TaskListState> implements TaskListBloc {}
class MockPlanningCubit extends MockCubit<PlanningState> implements PlanningCubit {}
class MockDailyReviewCubit extends MockCubit<DailyReviewState> implements DailyReviewCubit {}
class MockTaskSelectionCubit extends MockCubit<TaskSelectionState> implements TaskSelectionCubit {}
class MockSettingsCubit extends MockCubit<SettingsState> implements SettingsCubit {}

void main() {
  late MockConnectivityBloc mockConnectivityBloc;
  late MockGCalSyncCubit mockGCalSyncCubit;
  late MockTaskListBloc mockTaskListBloc;
  late MockPlanningCubit mockPlanningCubit;
  late MockDailyReviewCubit mockDailyReviewCubit;
  late MockTaskSelectionCubit mockTaskSelectionCubit;
  late MockSettingsCubit mockSettingsCubit;

  setUp(() {
    getIt.reset();
    
    mockConnectivityBloc = MockConnectivityBloc();
    mockGCalSyncCubit = MockGCalSyncCubit();
    mockTaskListBloc = MockTaskListBloc();
    mockPlanningCubit = MockPlanningCubit();
    mockDailyReviewCubit = MockDailyReviewCubit();
    mockTaskSelectionCubit = MockTaskSelectionCubit();
    mockSettingsCubit = MockSettingsCubit();

    when(() => mockConnectivityBloc.state).thenReturn(const ConnectivityState.connected());
    when(() => mockGCalSyncCubit.state).thenReturn(const GCalSyncState());
    when(() => mockTaskListBloc.state).thenReturn(const TaskListState.loaded(pending: [], completed: [], overdue: []));
    when(() => mockPlanningCubit.state).thenReturn(const PlanningState());
    when(() => mockDailyReviewCubit.state).thenReturn(const DailyReviewState());
    when(() => mockTaskSelectionCubit.state).thenReturn(const TaskSelectionState());
    when(() => mockSettingsCubit.state).thenReturn(const SettingsState());

    when(() => mockGCalSyncCubit.processQueue()).thenAnswer((_) async {});

    getIt.registerSingleton<ConnectivityBloc>(mockConnectivityBloc);
    getIt.registerSingleton<GCalSyncCubit>(mockGCalSyncCubit);
    getIt.registerSingleton<TaskListBloc>(mockTaskListBloc);
    getIt.registerSingleton<PlanningCubit>(mockPlanningCubit);
    getIt.registerSingleton<DailyReviewCubit>(mockDailyReviewCubit);
    getIt.registerSingleton<TaskSelectionCubit>(mockTaskSelectionCubit);
    getIt.registerSingleton<SettingsCubit>(mockSettingsCubit);
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('ReflectApp builds without crashing', (tester) async {
    await tester.pumpWidget(const ReflectApp());
    await tester.pump();
    
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
