import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflect/core/storage/database/app_database.dart';
import 'package:reflect/features/analytics/data/daos/analytics_dao.dart';

void main() {
  late AppDatabase db;
  late AnalyticsDao dao;

  setUp(() {
    db = AppDatabase.forTesting(DatabaseConnection(NativeDatabase.memory()));
    dao = AnalyticsDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('AnalyticsDao', () {
    test('getDailyCompletionRates returns correct math', () async {
      final now = DateTime.now();
      final todayStart = DateTime(
        now.year,
        now.month,
        now.day,
      ).millisecondsSinceEpoch;

      // Insert 2 completed, 1 pending for today
      await db
          .into(db.tasks)
          .insert(
            TasksCompanion.insert(
              title: 'Task 1',
              priority: 'p1',
              status: const Value('completed'),
              dueDate: Value(todayStart),
              dueDateLocalDayStart: Value(todayStart),
              dueDateUtcMs: Value(todayStart),
              createdAt: 0,
              updatedAt: 0,
            ),
          );
      await db
          .into(db.tasks)
          .insert(
            TasksCompanion.insert(
              title: 'Task 2',
              priority: 'p2',
              status: const Value('completed'),
              dueDate: Value(todayStart),
              dueDateLocalDayStart: Value(todayStart),
              dueDateUtcMs: Value(todayStart),
              createdAt: 0,
              updatedAt: 0,
            ),
          );
      await db
          .into(db.tasks)
          .insert(
            TasksCompanion.insert(
              title: 'Task 3',
              priority: 'p3',
              status: const Value('pending'),
              dueDate: Value(todayStart),
              dueDateLocalDayStart: Value(todayStart),
              dueDateUtcMs: Value(todayStart),
              createdAt: 0,
              updatedAt: 0,
            ),
          );

      final start = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(const Duration(days: 1));
      final end = DateTime(
        now.year,
        now.month,
        now.day,
      ).add(const Duration(days: 1));

      final results = await dao.getDailyCompletionRates(start, end);

      expect(results.length, 1);
      expect(results.first.completionRate, closeTo(0.66, 0.01));
    });

    test(
      'calculateStreaks correctly calculates current and best streaks',
      () async {
        final now = DateTime.now();
        final today = DateTime(now.year, now.month, now.day);

        // Insert reviews for 3 consecutive days (concluding yesterday)
        for (int i = 1; i <= 3; i++) {
          await db
              .into(db.dailyReviews)
              .insert(
                DailyReviewsCompanion.insert(
                  reviewDate: today
                      .subtract(Duration(days: i))
                      .millisecondsSinceEpoch,
                  dayRating: 5,
                  gratitude1: '',
                  gratitude2: '',
                  gratitude3: '',
                  createdAt: 0,
                ),
              );
        }

        // Skip 1 day (4 days ago)

        // Insert 1 review (5 days ago)
        await db
            .into(db.dailyReviews)
            .insert(
              DailyReviewsCompanion.insert(
                reviewDate: today
                    .subtract(const Duration(days: 5))
                    .millisecondsSinceEpoch,
                dayRating: 4,
                gratitude1: '',
                gratitude2: '',
                gratitude3: '',
                createdAt: 0,
              ),
            );

        final streak = await dao.calculateStreaks();

        expect(streak.currentStreak, 3);
        expect(streak.bestStreak, 3);
      },
    );

    test('getPriorityBreakdown returns correct counts', () async {
      final now = DateTime.now();
      final todayStart = DateTime(
        now.year,
        now.month,
        now.day,
      ).millisecondsSinceEpoch;

      await db
          .into(db.tasks)
          .insert(
            TasksCompanion.insert(
              title: 'P1 Task',
              priority: 'p1',
              status: const Value('completed'),
              dueDate: Value(todayStart),
              dueDateLocalDayStart: Value(todayStart),
              dueDateUtcMs: Value(todayStart),
              createdAt: 0,
              updatedAt: 0,
            ),
          );
      await db
          .into(db.tasks)
          .insert(
            TasksCompanion.insert(
              title: 'Another P1 Task',
              priority: 'p1',
              status: const Value('completed'),
              dueDate: Value(todayStart),
              dueDateLocalDayStart: Value(todayStart),
              dueDateUtcMs: Value(todayStart),
              createdAt: 0,
              updatedAt: 0,
            ),
          );

      final breakdown = await dao.getPriorityBreakdown(
        DateTime.now().subtract(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 1)),
      );

      final p1Item = breakdown.firstWhere((element) => element.label == 'P1');
      expect(p1Item.count, 2);
    });
  });
}
