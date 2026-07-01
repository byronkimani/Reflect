import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/observability/app_bloc_observer.dart';
import 'package:reflect/core/observability/crash_reporter.dart';

class MockCrashReporter extends Mock implements CrashReporter {}

class _SampleBloc extends Cubit<int> {
  _SampleBloc() : super(0);
}

void main() {
  setUpAll(() {
    registerFallbackValue(StackTrace.empty);
  });

  late MockCrashReporter crashReporter;
  late AppBlocObserver observer;

  setUp(() {
    crashReporter = MockCrashReporter();
    observer = AppBlocObserver(crashReporter);
    when(() => crashReporter.recordError(any(), any())).thenAnswer((_) async {});
  });

  test('forwards bloc errors to crash reporter', () {
    final bloc = _SampleBloc();
    final error = StateError('boom');
    final stack = StackTrace.current;

    observer.onError(bloc, error, stack);

    verify(() => crashReporter.recordError(error, stack)).called(1);
    bloc.close();
  });

  test('observer is attached to Bloc', () {
    expect(observer, isA<BlocObserver>());
  });
}
