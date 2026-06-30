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
    dao = db.analyticsDao;
  });

  tearDown(() async {
    await db.close();
  });

  group('AnalyticsDao', () {
    test('calculateStreaks returns correct active and best streak', () async {
      // Seed daily reviews
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      // Streak of 3 (today, yesterday, day before)
      await db.into(db.dailyReviews).insert(
        DailyReviewsCompanion.insert(
          id: const Value('1'),
          reviewDate: today.millisecondsSinceEpoch,
          dayRating: 5,
          createdAt: now.millisecondsSinceEpoch,
          gratitude1: 'a',
          gratitude2: 'b',
          gratitude3: 'c',
        ),
      );
      await db.into(db.dailyReviews).insert(
        DailyReviewsCompanion.insert(
          id: const Value('2'),
          reviewDate: today.subtract(const Duration(days: 1)).millisecondsSinceEpoch,
          dayRating: 4,
          createdAt: now.millisecondsSinceEpoch,
          gratitude1: 'a',
          gratitude2: 'b',
          gratitude3: 'c',
        ),
      );
      await db.into(db.dailyReviews).insert(
        DailyReviewsCompanion.insert(
          id: const Value('3'),
          reviewDate: today.subtract(const Duration(days: 2)).millisecondsSinceEpoch,
          dayRating: 3,
          createdAt: now.millisecondsSinceEpoch,
          gratitude1: 'a',
          gratitude2: 'b',
          gratitude3: 'c',
        ),
      );
      
      // Older streak of 5
      final olderDate = today.subtract(const Duration(days: 10));
      for (int i = 0; i < 5; i++) {
        await db.into(db.dailyReviews).insert(
          DailyReviewsCompanion.insert(
            id: Value('old_$i'),
            reviewDate: olderDate.subtract(Duration(days: i)).millisecondsSinceEpoch,
            dayRating: 4,
            createdAt: now.millisecondsSinceEpoch,
            gratitude1: 'a',
            gratitude2: 'b',
            gratitude3: 'c',
          ),
        );
      }

      final streaks = await dao.calculateStreaks();
      
      expect(streaks.currentStreak, 3);
      expect(streaks.bestStreak, 5);
    });

    test('getDailyCompletionRates calculates correct rates', () async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      // 2 completed tasks and 1 pending task today => 2/3 = 66.6% completion rate
      await db.into(db.tasks).insert(
        TasksCompanion.insert(
          id: const Value('t1'),
          title: 'T1',
          status: const Value('completed'),
          priority: 'P4',
          createdAt: now.millisecondsSinceEpoch,
          updatedAt: now.millisecondsSinceEpoch,
          dueDateLocalDayStart: Value(today.millisecondsSinceEpoch),
        ),
      );
      await db.into(db.tasks).insert(
        TasksCompanion.insert(
          id: const Value('t2'),
          title: 'T2',
          status: const Value('completed'),
          priority: 'P4',
          createdAt: now.millisecondsSinceEpoch,
          updatedAt: now.millisecondsSinceEpoch,
          dueDateLocalDayStart: Value(today.millisecondsSinceEpoch),
        ),
      );
      await db.into(db.tasks).insert(
        TasksCompanion.insert(
          id: const Value('t3'),
          title: 'T3',
          status: const Value('pending'),
          priority: 'P4',
          createdAt: now.millisecondsSinceEpoch,
          updatedAt: now.millisecondsSinceEpoch,
          dueDateLocalDayStart: Value(today.millisecondsSinceEpoch),
        ),
      );

      final rates = await dao.getDailyCompletionRates(
        today.subtract(const Duration(days: 1)),
        today.add(const Duration(days: 1)),
      );

      expect(rates.length, 1);
      expect(rates.first.date, today);
      expect(rates.first.completionRate, closeTo(0.666, 0.01));
    });

    test('getPriorityBreakdown groups by priority', () async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      await db.into(db.tasks).insert(
        TasksCompanion.insert(
          id: const Value('t1'),
          title: 'T1',
          status: const Value('completed'),
          priority: 'P1',
          createdAt: now.millisecondsSinceEpoch,
          updatedAt: now.millisecondsSinceEpoch,
          dueDateLocalDayStart: Value(today.millisecondsSinceEpoch),
        ),
      );
      await db.into(db.tasks).insert(
        TasksCompanion.insert(
          id: const Value('t2'),
          title: 'T2',
          status: const Value('completed'),
          priority: 'P1',
          createdAt: now.millisecondsSinceEpoch,
          updatedAt: now.millisecondsSinceEpoch,
          dueDateLocalDayStart: Value(today.millisecondsSinceEpoch),
        ),
      );
      await db.into(db.tasks).insert(
        TasksCompanion.insert(
          id: const Value('t3'),
          title: 'T3',
          status: const Value('completed'),
          priority: 'P2',
          createdAt: now.millisecondsSinceEpoch,
          updatedAt: now.millisecondsSinceEpoch,
          dueDateLocalDayStart: Value(today.millisecondsSinceEpoch),
        ),
      );

      final breakdown = await dao.getPriorityBreakdown(
        today.subtract(const Duration(days: 1)),
        today.add(const Duration(days: 1)),
      );

      expect(breakdown.length, 2);
      
      final p1 = breakdown.firstWhere((e) => e.label == 'P1');
      expect(p1.count, 2);
      expect(p1.hexColor, '#F44336'); // Red

      final p2 = breakdown.firstWhere((e) => e.label == 'P2');
      expect(p2.count, 1);
      expect(p2.hexColor, '#FF9800'); // Orange
    });

    test('getDayRatingTrend returns ordered day ratings', () async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      
      await db.into(db.dailyReviews).insert(
        DailyReviewsCompanion.insert(
          id: const Value('1'),
          reviewDate: today.millisecondsSinceEpoch,
          dayRating: 4,
          createdAt: now.millisecondsSinceEpoch,
          gratitude1: 'a',
          gratitude2: 'b',
          gratitude3: 'c',
        ),
      );
      await db.into(db.dailyReviews).insert(
        DailyReviewsCompanion.insert(
          id: const Value('2'),
          reviewDate: today.subtract(const Duration(days: 1)).millisecondsSinceEpoch,
          dayRating: 3,
          createdAt: now.millisecondsSinceEpoch,
          gratitude1: 'a',
          gratitude2: 'b',
          gratitude3: 'c',
        ),
      );
      await db.into(db.dailyReviews).insert(
        DailyReviewsCompanion.insert(
          id: const Value('3'),
          reviewDate: today.subtract(const Duration(days: 2)).millisecondsSinceEpoch,
          dayRating: 5,
          createdAt: now.millisecondsSinceEpoch,
          gratitude1: 'a',
          gratitude2: 'b',
          gratitude3: 'c',
        ),
      );

      final trend = await dao.getDayRatingTrend(
        today.subtract(const Duration(days: 5)),
        today.add(const Duration(days: 1)),
      );

      expect(trend.length, 3);
      expect(trend[0].rating, 5); // 2 days ago
      expect(trend[1].rating, 3); // 1 day ago
      expect(trend[2].rating, 4); // today
    });
  });
}
