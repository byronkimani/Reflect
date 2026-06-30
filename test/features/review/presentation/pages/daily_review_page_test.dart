import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/review/presentation/daily_review_cubit.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';
import 'package:reflect/features/review/presentation/pages/daily_review_page.dart';
import 'package:bloc_test/bloc_test.dart';

class MockDailyReviewCubit extends MockBloc<void, DailyReviewState> implements DailyReviewCubit {}

void main() {
  late MockDailyReviewCubit mockCubit;

  setUp(() {
    mockCubit = MockDailyReviewCubit();
  });

  Widget buildPage() {
    return MaterialApp(
      home: BlocProvider<DailyReviewCubit>.value(
        value: mockCubit,
        child: const DailyReviewPage(),
      ),
    );
  }

  testWidgets('DailyReviewPage shows all initial fields', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState());
    
    await tester.pumpWidget(buildPage());
    
    expect(find.text('Daily Review'), findsOneWidget);
    expect(find.text('How was your day?'), findsOneWidget);
    expect(find.text('What went well?'), findsOneWidget);
    expect(find.text('What could be better?'), findsOneWidget);
    expect(find.text('Gratitude (3 mandatory)'), findsOneWidget);
    
    expect(find.byType(SegmentedButton<int>), findsOneWidget);
    expect(find.text('1. I am grateful for...'), findsOneWidget);
    expect(find.text('2. I am grateful for...'), findsOneWidget);
    expect(find.text('3. I am grateful for...'), findsOneWidget);
  });

  testWidgets('DailyReviewPage interactions call cubit methods', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState());
    
    await tester.pumpWidget(buildPage());
    
    await tester.enterText(
      find.widgetWithText(TextField, 'Reflect on your wins...'), 
      'Good day',
    );
    verify(() => mockCubit.wentWellChanged('Good day')).called(1);
    
    await tester.enterText(
      find.widgetWithText(TextField, 'Potential improvements?'), 
      'Could be better',
    );
    verify(() => mockCubit.couldBeBetterChanged('Could be better')).called(1);
    
    await tester.enterText(
      find.widgetWithText(TextField, '1. I am grateful for...'), 
      'Food',
    );
    verify(() => mockCubit.gratitudeChanged(0, 'Food')).called(1);
  });

  testWidgets('DailyReviewPage Save Review button calls submitReview when enabled', (tester) async {
    when(() => mockCubit.state).thenReturn(const DailyReviewState(
      dayRating: 3,
      gratitude1: 'g1',
      gratitude2: 'g2',
      gratitude3: 'g3',
    ));
    when(() => mockCubit.submitReview()).thenAnswer((_) async {});
    
    await tester.pumpWidget(buildPage());
    
    final saveButton = find.widgetWithText(FilledButton, 'Save Review');
    expect(saveButton, findsOneWidget);
    
    await tester.ensureVisible(saveButton);
    await tester.tap(saveButton);
    await tester.pump();
    
    verify(() => mockCubit.submitReview()).called(1);
  });

  testWidgets('DailyReviewPage Save Review button is disabled when not submittable', (tester) async {
    // Missing gratitude3
    when(() => mockCubit.state).thenReturn(const DailyReviewState(
      gratitude1: 'g1',
      gratitude2: 'g2',
      gratitude3: '',
    ));
    
    await tester.pumpWidget(buildPage());
    
    final saveButtonFinder = find.byWidgetPredicate(
      (widget) => widget is FilledButton && widget.onPressed == null
    );
    expect(saveButtonFinder, findsOneWidget);
  });
}
