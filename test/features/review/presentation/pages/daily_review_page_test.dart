import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/presentation/widgets/mood_rating_row.dart';
import 'package:reflect/core/presentation/widgets/reflect_primary_button.dart';
import 'package:reflect/core/presentation/widgets/reflect_sticky_bottom_bar.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';
import 'package:reflect/features/review/presentation/pages/daily_review_page.dart';
import 'package:bloc_test/bloc_test.dart';

class MockDailyReviewCubit extends MockBloc<void, DailyReviewState>
    implements DailyReviewCubit {}

void main() {
  late MockDailyReviewCubit mockCubit;

  setUp(() {
    mockCubit = MockDailyReviewCubit();
    when(() => mockCubit.startWatchingTodayTasks()).thenReturn(null);
    when(() => mockCubit.removeGratitudeField(any())).thenReturn(null);
  });

  Widget buildPage({String initialLocation = '/review'}) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: initialLocation,
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: Text('Home')),
            routes: [
              GoRoute(
                path: 'review',
                builder: (_, _) => BlocProvider<DailyReviewCubit>.value(
                  value: mockCubit,
                  child: const DailyReviewPage(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  testWidgets('DailyReviewPage shows card-based layout', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState());

    await tester.pumpWidget(buildPage());
    await tester.pump();

    expect(find.text('Daily Review'), findsOneWidget);
    expect(find.text('How was your day?'), findsOneWidget);
    expect(find.text('Wins & Growth'), findsOneWidget);
    expect(find.text('Gratitude'), findsOneWidget);
    expect(find.text('Share up to 3 things'), findsOneWidget);
    expect(find.byType(MoodRatingRow), findsOneWidget);
    expect(find.text('Add another'), findsOneWidget);
    verify(() => mockCubit.startWatchingTodayTasks()).called(1);
  });

  testWidgets('DailyReviewPage interactions call cubit methods', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState());

    await tester.pumpWidget(buildPage());
    await tester.pump();

    await tester.enterText(
      find.widgetWithText(TextField, 'A win from today…'),
      'Good day',
    );
    verify(() => mockCubit.wentWellChanged('Good day')).called(1);

    await tester.enterText(
      find.widgetWithText(TextField, 'One thing to improve…'),
      'Could be better',
    );
    verify(() => mockCubit.couldBeBetterChanged('Could be better')).called(1);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'I am grateful for…'),
      'Food',
    );
    verify(() => mockCubit.gratitudeChanged(0, 'Food')).called(1);
  });

  testWidgets('DailyReviewPage Save Review button calls submitReview when enabled',
      (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState(
      dayRating: 3,
      wentWell: 'win',
      gratitude1: 'g1',
    ));
    when(() => mockCubit.submitReview()).thenAnswer((_) async {});

    await tester.pumpWidget(buildPage());

    final saveButton = find.widgetWithText(ReflectPrimaryButton, 'Save Review');
    expect(saveButton, findsOneWidget);

    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pump();

    verify(() => mockCubit.submitReview()).called(1);
  });

  testWidgets(
    'Save Review stays enabled with empty added gratitude field',
    (tester) async {
      when(() => mockCubit.state).thenReturn(const DailyReviewState(
        dayRating: 3,
        wentWell: 'win',
        gratitude1: 'sunshine',
        gratitudeFieldCount: 2,
      ));

      await tester.pumpWidget(buildPage());

      final button = tester.widget<ReflectPrimaryButton>(
        find.byType(ReflectPrimaryButton),
      );
      expect(button.onPressed, isNotNull);
    },
  );

  testWidgets('DailyReviewPage Save Review button is disabled when not submittable',
      (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState(
      dayRating: 3,
      gratitude1: '',
    ));

    await tester.pumpWidget(buildPage());

    final button = tester.widget<ReflectPrimaryButton>(
      find.byType(ReflectPrimaryButton),
    );
    expect(button.onPressed, isNull);
  });

  testWidgets('selecting mood icon calls ratingChanged', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState());
    whenListen(
      mockCubit,
      Stream.value(const DailyReviewState()),
      initialState: const DailyReviewState(),
    );

    await tester.pumpWidget(buildPage());
    await tester.pump();

    await tester.tap(find.byIcon(Icons.sentiment_satisfied_outlined));
    await tester.pump();

    verify(() => mockCubit.ratingChanged(4)).called(1);
  });

  testWidgets('shows task chip when tasks exist', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState(
      tasksCompletedToday: 4,
      tasksTotalToday: 6,
    ));

    await tester.pumpWidget(buildPage());

    expect(find.text('4 of 6 tasks done today'), findsOneWidget);
  });

  testWidgets('Add another gratitude field calls cubit', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState());
    when(() => mockCubit.stream)
        .thenAnswer((_) => Stream.value(const DailyReviewState()));
    when(() => mockCubit.addGratitudeField()).thenReturn(null);

    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -300));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add another'));
    await tester.pump();

    verify(() => mockCubit.addGratitudeField()).called(1);
  });

  testWidgets('remove gratitude button calls cubit', (tester) async {
    whenListen(
      mockCubit,
      Stream.value(
        const DailyReviewState(
          gratitudeFieldCount: 2,
          gratitude1: 'A',
          gratitude2: 'B',
        ),
      ),
      initialState: const DailyReviewState(
        gratitudeFieldCount: 2,
        gratitude1: 'A',
        gratitude2: 'B',
      ),
    );

    await tester.pumpWidget(buildPage());
    await tester.pumpAndSettle();

    final removeButton = find.byTooltip('Remove');
    await tester.ensureVisible(removeButton);
    await tester.tap(removeButton, warnIfMissed: false);
    await tester.pump();

    verify(() => mockCubit.removeGratitudeField(1)).called(1);
  });

  testWidgets('gratitude field displays initial value from state', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState(
      gratitude1: 'sunshine',
    ));

    await tester.pumpWidget(buildPage());
    await tester.pump();

    expect(find.text('sunshine'), findsOneWidget);
  });

  testWidgets('shows loading state on Save Review button', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState(
      dayRating: 4,
      wentWell: 'win',
      gratitude1: 'thanks',
      isSubmitting: true,
    ));

    await tester.pumpWidget(buildPage());

    final button = tester.widget<ReflectPrimaryButton>(
      find.byType(ReflectPrimaryButton),
    );
    expect(button.isLoading, isTrue);
    expect(button.onPressed, isNull);
  });

  testWidgets('success state shows snackbar on tab root without popping', (
    tester,
  ) async {
    whenListen(
      mockCubit,
      Stream.fromIterable([
        const DailyReviewState(
          dayRating: 4,
          wentWell: 'win',
          gratitude1: 'thanks',
        ),
        const DailyReviewState(
          dayRating: 4,
          wentWell: 'win',
          gratitude1: 'thanks',
          isSuccess: true,
        ),
      ]),
      initialState: const DailyReviewState(),
    );

    await tester.pumpWidget(buildPage());
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Daily Review saved!'), findsOneWidget);
    expect(find.text('Daily Review'), findsOneWidget);
  });

  testWidgets('success state shows snackbar and pops pushed route', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, _) => Scaffold(
            body: TextButton(
              onPressed: () => context.push('/review'),
              child: const Text('Open review'),
            ),
          ),
        ),
        GoRoute(
          path: '/review',
          builder: (_, _) => BlocProvider<DailyReviewCubit>.value(
            value: mockCubit,
            child: const DailyReviewPage(),
          ),
        ),
      ],
    );

    whenListen(
      mockCubit,
      Stream.fromIterable([
        const DailyReviewState(
          dayRating: 4,
          wentWell: 'win',
          gratitude1: 'thanks',
        ),
        const DailyReviewState(
          dayRating: 4,
          wentWell: 'win',
          gratitude1: 'thanks',
          isSuccess: true,
        ),
      ]),
      initialState: const DailyReviewState(),
    );

    await tester.pumpWidget(MaterialApp.router(routerConfig: router));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open review'));
    await tester.pumpAndSettle();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Daily Review saved!'), findsOneWidget);
    expect(find.text('Open review'), findsOneWidget);
  });

  testWidgets('error state shows error snackbar', (tester) async {
    whenListen(
      mockCubit,
      Stream.fromIterable([
        const DailyReviewState(dayRating: 3),
        const DailyReviewState(dayRating: 3, error: 'Save failed'),
      ]),
      initialState: const DailyReviewState(),
    );

    await tester.pumpWidget(buildPage());
    await tester.pump();
    await tester.pump();

    expect(find.text('Save failed'), findsOneWidget);
  });

  testWidgets('save review button uses sticky bottom bar', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState());

    await tester.pumpWidget(buildPage());
    await tester.pump();

    expect(find.byType(ReflectStickyBottomBar), findsOneWidget);
    expect(find.text('Save Review'), findsOneWidget);
  });
}
