import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/core/network/presentation/connectivity_event.dart';
import 'package:reflect/core/presentation/connectivity_wrapper.dart';
import 'package:reflect/core/router/app_router.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/features/gcal/presentation/g_cal_sync_cubit.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/planning/presentation/planning_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/l10n/app_localizations.dart';
import 'package:reflect/main.dart';

class ReflectApp extends StatelessWidget {
  const ReflectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityBloc>(
          create: (_) => getIt<ConnectivityBloc>()..add(const ConnectivityEvent.monitorStarted()),
        ),
        BlocProvider<GCalSyncCubit>(
          create: (_) => getIt<GCalSyncCubit>()..processQueue(),
        ),
        BlocProvider<TaskListBloc>(
          create: (_) => getIt<TaskListBloc>()..add(TaskListEvent.loadTasksForDate(DateTime.now())),
        ),
        BlocProvider<PlanningCubit>(
          create: (_) => getIt<PlanningCubit>(),
        ),
        BlocProvider<DailyReviewCubit>(
          create: (_) => getIt<DailyReviewCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'Reflect',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: createAppRouter(),
            builder: (context, child) {
              return ConnectivityWrapper(
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
