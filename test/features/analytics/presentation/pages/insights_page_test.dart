import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflect/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:reflect/features/analytics/presentation/pages/insights_page.dart';
import 'package:reflect/features/analytics/domain/entities/analytics_models.dart';
import 'package:reflect/main.dart';

class MockAnalyticsBloc extends MockBloc<AnalyticsEvent, AnalyticsState> implements AnalyticsBloc {}

void main() {
  late MockAnalyticsBloc mockBloc;

  setUpAll(() {
    registerFallbackValue(const AnalyticsEvent.load(DateRange.last7Days));
  });

  setUp(() async {
    mockBloc = MockAnalyticsBloc();
    await getIt.reset();
    getIt.registerFactory<AnalyticsBloc>(() => mockBloc);
  });

  tearDown(() {
    getIt.reset();
  });

  Widget buildPage() {
    return MaterialApp(
      home: const InsightsPage(),
      theme: ThemeData.light(),
    );
  }

  testWidgets('InsightsPage shows loading indicator when initial state', (tester) async {
    when(() => mockBloc.state).thenReturn(const AnalyticsState.initial());
    
    await tester.pumpWidget(buildPage());
    
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('InsightsPage shows loading indicator when loading state', (tester) async {
    when(() => mockBloc.state).thenReturn(const AnalyticsState.loading());
    
    await tester.pumpWidget(buildPage());
    
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('InsightsPage shows error message when error state', (tester) async {
    when(() => mockBloc.state).thenReturn(const AnalyticsState.error('Failed to load insights'));
    
    await tester.pumpWidget(buildPage());
    
    expect(find.text('Failed to load insights'), findsOneWidget);
  });

  testWidgets('InsightsPage shows insights when loaded state', (tester) async {
    final streaks = StreakData(currentStreak: 2, bestStreak: 5);
    final completion = [
      DailyCompletionPoint(date: DateTime.now(), completionRate: 0.66),
    ];
    final tagBreakdown = [
      BreakdownItem(label: 'Work', count: 10, hexColor: '#ff0000'),
    ];
    final priorityBreakdown = [
      BreakdownItem(label: 'High', count: 5, hexColor: '#00ff00'),
    ];
    final ratingTrend = [
      DayRatingPoint(date: DateTime.now(), rating: 4),
    ];

    when(() => mockBloc.state).thenReturn(AnalyticsState.loaded(
      activeRange: DateRange.last7Days,
      dailyCompletion: completion,
      streaks: streaks,
      tagBreakdown: tagBreakdown,
      priorityBreakdown: priorityBreakdown,
      ratingTrend: ratingTrend,
    ));
    
    await tester.pumpWidget(buildPage());
    
    expect(find.text('Insights'), findsOneWidget);
    expect(find.text('Current Streak'), findsOneWidget);
    expect(find.text('Best Streak'), findsOneWidget);
    expect(find.text('2'), findsWidgets);
    expect(find.text('5'), findsWidgets);
    
    expect(find.text('Activity'), findsOneWidget);
    expect(find.text('Daily Completion Rate'), findsOneWidget);
    
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
    await tester.pumpAndSettle();
    
    expect(find.text('Day Rating Trend'), findsOneWidget);
    expect(find.text('Breakdown'), findsOneWidget);
  });
  
  testWidgets('InsightsPage segmented button changes range', (tester) async {
    final streaks = StreakData(currentStreak: 2, bestStreak: 5);
    
    when(() => mockBloc.state).thenReturn(AnalyticsState.loaded(
      activeRange: DateRange.last7Days,
      dailyCompletion: [],
      streaks: streaks,
      tagBreakdown: [],
      priorityBreakdown: [],
      ratingTrend: [],
    ));
    
    await tester.pumpWidget(buildPage());
    
    await tester.tap(find.text('30D'));
    await tester.pump();
    
    verify(() => mockBloc.add(const AnalyticsEvent.load(DateRange.last30Days))).called(1);
  });
}
