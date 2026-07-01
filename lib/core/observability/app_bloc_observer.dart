import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reflect/core/observability/crash_reporter.dart';

/// Forwards uncaught BLoC/Cubit errors to [CrashReporter].
class AppBlocObserver extends BlocObserver {
  AppBlocObserver(this._crashReporter);

  final CrashReporter _crashReporter;

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    _crashReporter.recordError(error, stackTrace);
  }
}
