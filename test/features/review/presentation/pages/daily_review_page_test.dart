import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/core/presentation/widgets/mood_rating_row.dart';
import 'package:reflect/core/presentation/widgets/reflect_primary_button.dart';
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
    when(() => mockCubit.initializeForToday()).thenAnswer((_) async {});
  });

  Widget buildPage() {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: '/review',
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
    verify(() => mockCubit.initializeForToday()).called(1);
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
      find.widgetWithText(TextField, 'I am grateful for…'),
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
}
