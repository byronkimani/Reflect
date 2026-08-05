import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/presentation/app_scaffold.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_bloc.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_event.dart';
import 'package:reflect/features/tasks/presentation/blocs/task_list/task_list_state.dart';

class FakeStatefulNavigationShell extends StatefulWidget
    implements StatefulNavigationShell {
  final int mockCurrentIndex;
  final void Function(int, {bool initialLocation}) mockGoBranch;

  const FakeStatefulNavigationShell({
    super.key,
    this.mockCurrentIndex = 0,
    required this.mockGoBranch,
  });

  @override
  State<FakeStatefulNavigationShell> createState() =>
      _FakeStatefulNavigationShellState();

  @override
  int get currentIndex => mockCurrentIndex;

  @override
  void goBranch(int index, {bool initialLocation = false}) {
    mockGoBranch(index, initialLocation: initialLocation);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeStatefulNavigationShellState
    extends State<FakeStatefulNavigationShell> {
  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

class MockTaskListBloc extends Mock implements TaskListBloc {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockTaskListBloc mockTaskListBloc;
  int calledIndex = -1;
  bool calledInitialLocation = false;

  setUpAll(() {
    registerFallbackValue(const TaskListEvent.loadBacklog());
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    calledIndex = -1;
    calledInitialLocation = false;
    mockTaskListBloc = MockTaskListBloc();

    when(() => mockTaskListBloc.state)
        .thenReturn(const TaskListState.initial());
    when(() => mockTaskListBloc.stream)
        .thenAnswer((_) => Stream.value(const TaskListState.initial()));
    when(() => mockTaskListBloc.close())
        .thenAnswer((_) async => Future<void>.value());
  });

  Widget buildWidget({int currentIndex = 0}) {
    return MaterialApp(
      home: BlocProvider<TaskListBloc>.value(
        value: mockTaskListBloc,
        child: ScaffoldWithNavBar(
          navigationShell: FakeStatefulNavigationShell(
            mockCurrentIndex: currentIndex,
            mockGoBranch: (index, {bool initialLocation = false}) {
              calledIndex = index;
              calledInitialLocation = initialLocation;
            },
          ),
        ),
      ),
    );
  }

  group('ScaffoldWithNavBar', () {
    testWidgets('renders all navigation destinations', (tester) async {
      await tester.pumpWidget(buildWidget());

      expect(find.text('TODAY'), findsOneWidget);
      expect(find.text('BACKLOG'), findsOneWidget);
      expect(find.text('GOALS'), findsOneWidget);
      expect(find.text('REFLECT'), findsOneWidget);
      expect(find.text('MORE'), findsOneWidget);
    });

    testWidgets('tapping Today when already selected does not reload TaskListBloc',
        (tester) async {
      await tester.pumpWidget(buildWidget());

      await tester.tap(find.text('TODAY'));
      await tester.pumpAndSettle();

      verifyNever(() => mockTaskListBloc.add(any()));
      expect(calledIndex, 0);
      expect(calledInitialLocation, true);
    });

    testWidgets('tapping Today from another tab reloads TaskListBloc', (tester) async {
      await tester.pumpWidget(buildWidget(currentIndex: 1));

      await tester.tap(find.text('TODAY'));
      await tester.pumpAndSettle();

      verify(() => mockTaskListBloc.add(any(that: isA<LoadTasksForDate>())))
          .called(1);
      expect(calledIndex, 0);
      expect(calledInitialLocation, false);
    });

    testWidgets('tapping Backlog destination calls TaskListBloc and goBranch',
        (tester) async {
      await tester.pumpWidget(buildWidget());

      await tester.tap(find.text('BACKLOG'));
      await tester.pumpAndSettle();

      verify(() => mockTaskListBloc.add(const TaskListEvent.loadBacklog()))
          .called(1);
      expect(calledIndex, 1);
      expect(calledInitialLocation, false);
    });

    testWidgets('tapping Goals destination calls goBranch', (tester) async {
      await tester.pumpWidget(buildWidget());

      await tester.tap(find.text('GOALS'));
      await tester.pumpAndSettle();

      expect(calledIndex, 2);
      expect(calledInitialLocation, false);
    });
  });
}
