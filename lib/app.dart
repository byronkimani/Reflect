import 'package:reflect/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/core/network/network_info.dart';
import 'package:reflect/core/presentation/connectivity_wrapper.dart';
import 'package:reflect/core/router/app_router.dart';
import 'package:reflect/core/theme/app_theme.dart';
import 'package:reflect/features/network/data/connectivity_bloc.dart';
import 'package:reflect/features/post/data/post_bloc.dart';
import 'package:reflect/features/post/data/post_repository.dart';
import 'package:reflect/main.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // network info
        BlocProvider(
          create: (context) =>
              ConnectivityBloc(getIt<NetworkInfo>())
                ..add(const ConnectivityEvent.started()),
        ),

        // posts
        BlocProvider(
          create: (context) =>
              PostBloc(getIt<PostRepository>())..add(const PostEvent.started()),
        ),
      ],
      // We wrap MaterialApp with a Builder or use a widget to access the AuthBloc
      // so we can pass it to the Router for redirection logic
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            title: 'App shell',
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            routerConfig: createAppRouter(), // No AuthBloc needed
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
