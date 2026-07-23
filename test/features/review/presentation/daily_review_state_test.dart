import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/features/review/presentation/daily_review_state.dart';

void main() {
  group('DailyReviewState.canSubmit', () {
    test('is false when dayRating is zero', () {
      const state = DailyReviewState(wentWell: 'Good');
      expect(state.canSubmit, isFalse);
    });

    test('is false when reflection fields are empty', () {
      const state = DailyReviewState(dayRating: 4);
      expect(state.canSubmit, isFalse);
    });

    test('is true with rating and wentWell', () {
      const state = DailyReviewState(
        dayRating: 3,
        wentWell: 'Productive',
        gratitudeFieldCount: 0,
      );
      expect(state.canSubmit, isTrue);
    });

    test('is true with rating and couldBeBetter only', () {
      const state = DailyReviewState(
        dayRating: 2,
        couldBeBetter: 'Less scrolling',
        gratitudeFieldCount: 0,
      );
      expect(state.canSubmit, isTrue);
    });

    test('requires gratitude1 when one field is visible', () {
      const missing = DailyReviewState(
        dayRating: 5,
        wentWell: 'Fine',
        gratitudeFieldCount: 1,
      );
      const filled = DailyReviewState(
        dayRating: 5,
        wentWell: 'Fine',
        gratitudeFieldCount: 1,
        gratitude1: 'Family',
      );
      expect(missing.canSubmit, isFalse);
      expect(filled.canSubmit, isTrue);
    });

    test('allows empty gratitude2 when two fields are visible', () {
      const state = DailyReviewState(
        dayRating: 5,
        wentWell: 'Fine',
        gratitudeFieldCount: 2,
        gratitude1: 'A',
      );
      expect(state.canSubmit, isTrue);
    });

    test('allows empty gratitude3 when three fields are visible', () {
      const state = DailyReviewState(
        dayRating: 5,
        wentWell: 'Fine',
        gratitudeFieldCount: 3,
        gratitude1: 'A',
        gratitude2: 'B',
      );
      expect(state.canSubmit, isTrue);
    });

    test('allows submit with three gratitude entries when third is filled', () {
      const state = DailyReviewState(
        dayRating: 5,
        wentWell: 'Fine',
        gratitudeFieldCount: 3,
        gratitude1: 'A',
        gratitude2: 'B',
        gratitude3: 'C',
      );
      expect(state.canSubmit, isTrue);
    });
  });

  group('DailyReviewState.showTaskChip', () {
    test('is false when no tasks today', () {
      const state = DailyReviewState();
      expect(state.showTaskChip, isFalse);
    });

    test('is true when tasks exist today', () {
      const state = DailyReviewState(tasksTotalToday: 3);
      expect(state.showTaskChip, isTrue);
    });
  });
}
