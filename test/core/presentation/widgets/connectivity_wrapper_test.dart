import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:reflect/core/network/presentation/connectivity_bloc.dart';
import 'package:reflect/core/network/presentation/connectivity_event.dart';
import 'package:reflect/core/network/presentation/connectivity_state.dart';
import 'package:reflect/core/presentation/connectivity_wrapper.dart';

class MockConnectivityBloc extends MockBloc<ConnectivityEvent, ConnectivityState> implements ConnectivityBloc {}

void main() {
  late MockConnectivityBloc mockConnectivityBloc;

  setUp(() {
    mockConnectivityBloc = MockConnectivityBloc();
  });

  Widget buildSubject() {
    return MaterialApp(
      home: BlocProvider<ConnectivityBloc>.value(
        value: mockConnectivityBloc,
        child: const ConnectivityWrapper(
          child: Scaffold(
            body: Center(child: Text('App Content')),
          ),
        ),
      ),
    );
  }

  testWidgets('shows offline banner when disconnected', (tester) async {
    when(() => mockConnectivityBloc.state).thenReturn(const ConnectivityState.disconnected());
    await tester.pumpWidget(buildSubject());

    expect(find.text('Offline - Changes saved locally'), findsOneWidget);
    expect(find.text('App Content'), findsOneWidget);
  });

  testWidgets('does not show offline banner when connected', (tester) async {
    when(() => mockConnectivityBloc.state).thenReturn(const ConnectivityState.connected());
    await tester.pumpWidget(buildSubject());

    final animatedPositioned = tester.widget<AnimatedPositioned>(find.byType(AnimatedPositioned));
    expect(animatedPositioned.top, -50); // hidden
    expect(find.text('App Content'), findsOneWidget);
  });
}
