import 'package:drift/drift.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/core/storage/database/tables/task_tables.dart';
import 'package:reflect/core/storage/database/tables/review_tables.dart';
import 'package:reflect/features/analytics/domain/entities/analytics_models.dart';

part 'analytics_dao.g.dart';

@DriftAccessor(tables: [Tasks, Tags, TaskTags, DailyReviews])
class AnalyticsDao extends DatabaseAccessor<AppDatabase>
    with _$AnalyticsDaoMixin {
  AnalyticsDao(super.db);

  /// Inclusive range of local calendar days: `[firstDayStartMs, lastDayStartMs]`.
  (int, int) _localInclusiveDayRangeMs(DateTime startDate, DateTime endDate) {
    final start = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    ).millisecondsSinceEpoch;
    final lastDayStart = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    ).millisecondsSinceEpoch;
    return (start, lastDayStart);
  }

  /// Calculates daily completion rates (completed / total) for tasks within a date range.
  Future<List<DailyCompletionPoint>> getDailyCompletionRates(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final (start, lastDayStart) = _localInclusiveDayRangeMs(startDate, endDate);

    final query = customSelect(
      '''
      SELECT 
        due_date_local_day_start as day_start,
        CAST(SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) AS REAL) / COUNT(*) as rate
      FROM tasks
      WHERE due_date_local_day_start IS NOT NULL
        AND due_date_local_day_start >= ? AND due_date_local_day_start <= ?
      GROUP BY due_date_local_day_start
      ORDER BY day_start ASC
      ''',
      readsFrom: {tasks},
      variables: [Variable.withInt(start), Variable.withInt(lastDayStart)],
    );

    final rows = await query.get();
    return rows.map((row) {
      return DailyCompletionPoint(
        date: DateTime.fromMillisecondsSinceEpoch(row.read<int>('day_start')),
        completionRate: row.read<double>('rate'),
      );
    }).toList();
  }

  /// Calculates current and all-time best streaks for daily reviews.
  Future<StreakData> calculateStreaks() async {
    final reviews =
        await (select(dailyReviews)..orderBy([
              (t) => OrderingTerm(
                expression: t.reviewDate,
                mode: OrderingMode.desc,
              ),
            ]))
            .get();

    if (reviews.isEmpty) {
      return const StreakData(currentStreak: 0, bestStreak: 0);
    }

    int currentStreak = 0;
    int bestStreak = 0;
    int tempStreak = 0;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    final yesterday = today - 86400000;

    // Check if current streak is still active (today or yesterday)
    final latestReviewDate = reviews.first.reviewDate;
    if (latestReviewDate < yesterday) {
      currentStreak = 0;
    } else {
      // Calculate active streak
      DateTime previousDate = DateTime.fromMillisecondsSinceEpoch(
        reviews.first.reviewDate,
      );
      currentStreak = 1;
      for (int i = 1; i < reviews.length; i++) {
        final currentDate = DateTime.fromMillisecondsSinceEpoch(
          reviews[i].reviewDate,
        );
        if (previousDate.difference(currentDate).inDays == 1) {
          currentStreak++;
          previousDate = currentDate;
        } else {
          break;
        }
      }
    }

    // Calculate all-time best streak
    if (reviews.isNotEmpty) {
      tempStreak = 1;
      bestStreak = 1;
      DateTime prev = DateTime.fromMillisecondsSinceEpoch(
        reviews.first.reviewDate,
      );
      for (int i = 1; i < reviews.length; i++) {
        final curr = DateTime.fromMillisecondsSinceEpoch(reviews[i].reviewDate);
        if (prev.difference(curr).inDays == 1) {
          tempStreak++;
        } else {
          tempStreak = 1;
        }
        if (tempStreak > bestStreak) bestStreak = tempStreak;
        prev = curr;
      }
    }

    return StreakData(currentStreak: currentStreak, bestStreak: bestStreak);
  }

  /// Gets breakdown of completed tasks by tag.
  Future<List<BreakdownItem>> getTagBreakdown(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final (start, lastDayStart) = _localInclusiveDayRangeMs(startDate, endDate);
    final query = customSelect(
      '''
      SELECT t.name, t.colour, COUNT(*) as count
      FROM tasks tk
      JOIN task_tags tt ON tk.id = tt.task_id
      JOIN tags t ON tt.tag_id = t.id
      WHERE tk.status = 'completed'
        AND tk.due_date_local_day_start IS NOT NULL
        AND tk.due_date_local_day_start >= ? AND tk.due_date_local_day_start <= ?
      GROUP BY t.id
      ORDER BY count DESC
      ''',
      readsFrom: {tasks, taskTags, tags},
      variables: [
        Variable.withInt(start),
        Variable.withInt(lastDayStart),
      ],
    );

    final rows = await query.get();
    return rows.map((row) {
      return BreakdownItem(
        label: row.read<String>('name'),
        count: row.read<int>('count'),
        hexColor: row.read<String>('colour'),
      );
    }).toList();
  }

  /// Gets breakdown of completed tasks by priority.
  Future<List<BreakdownItem>> getPriorityBreakdown(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final (start, lastDayStart) = _localInclusiveDayRangeMs(startDate, endDate);
    final query = customSelect(
      '''
      SELECT priority, COUNT(*) as count
      FROM tasks
      WHERE status = 'completed'
        AND due_date_local_day_start IS NOT NULL
        AND due_date_local_day_start >= ? AND due_date_local_day_start <= ?
      GROUP BY priority
      ORDER BY priority ASC
      ''',
      readsFrom: {tasks},
      variables: [
        Variable.withInt(start),
        Variable.withInt(lastDayStart),
      ],
    );

    final rows = await query.get();
    return rows.map((row) {
      final p = row.read<String>('priority').toUpperCase();
      String color = '#9E9E9E'; // Default Grey
      if (p == 'P1') color = '#F44336'; // Red
      if (p == 'P2') color = '#FF9800'; // Orange
      if (p == 'P3') color = '#2196F3'; // Blue
      if (p == 'P4') color = '#4CAF50'; // Green

      return BreakdownItem(
        label: p,
        count: row.read<int>('count'),
        hexColor: color,
      );
    }).toList();
  }

  /// Gets the trend of daily ratings from reviews.
  Future<List<DayRatingPoint>> getDayRatingTrend(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final query = select(dailyReviews)
      ..where(
        (t) => t.reviewDate.isBetweenValues(
          startDate.millisecondsSinceEpoch,
          endDate.millisecondsSinceEpoch,
        ),
      )
      ..orderBy([
        (t) => OrderingTerm(expression: t.reviewDate, mode: OrderingMode.asc),
      ]);

    final rows = await query.get();
    return rows.map((row) {
      return DayRatingPoint(
        date: DateTime.fromMillisecondsSinceEpoch(row.reviewDate),
        rating: row.dayRating,
      );
    }).toList();
  }
}
