import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/presentation/theme/app_theme.dart';
import 'package:reflect/core/presentation/widgets/mood_rating_row.dart';

void main() {
  testWidgets('MoodRatingRow calls onRatingChanged', (tester) async {
    int? selected;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: MoodRatingRow(
            selectedRating: 0,
            onRatingChanged: (r) => selected = r,
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.sentiment_satisfied_outlined));
    expect(selected, 4);
  });

  testWidgets('MoodRatingRow shows Rough and Great labels', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: MoodRatingRow(
            selectedRating: 3,
            onRatingChanged: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Rough'), findsOneWidget);
    expect(find.text('Great'), findsOneWidget);
  });
}
