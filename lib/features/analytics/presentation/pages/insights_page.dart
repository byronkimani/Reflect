import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:reflect/features/analytics/domain/entities/analytics_models.dart';
import 'package:reflect/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:reflect/main.dart';

class InsightsPage extends StatelessWidget {
  const InsightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<AnalyticsBloc>()
            ..add(const AnalyticsEvent.load(DateRange.last7Days)),
      child: Scaffold(
        body: BlocBuilder<AnalyticsBloc, AnalyticsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text(message)),
              loaded:
                  (
                    range,
                    completion,
                    streaks,
                    tagBreakdown,
                    priorityBreakdown,
                    ratingTrend,
                  ) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 120,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(
                              'Insights',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            centerTitle: false,
                          ),
                          actions: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: SegmentedButton<DateRange>(
                                segments: const [
                                  ButtonSegment(
                                    value: DateRange.last7Days,
                                    label: Text('7D'),
                                  ),
                                  ButtonSegment(
                                    value: DateRange.last30Days,
                                    label: Text('30D'),
                                  ),
                                  ButtonSegment(
                                    value: DateRange.last90Days,
                                    label: Text('90D'),
                                  ),
                                ],
                                selected: {range},
                                onSelectionChanged: (value) {
                                  context.read<AnalyticsBloc>().add(
                                    AnalyticsEvent.load(value.first),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                            _StreakCard(streaks: streaks),
                            _SectionHeader(title: 'Activity'),
                            _CompletionChart(data: completion),
                            _RatingTrendChart(data: ratingTrend),
                            _SectionHeader(title: 'Breakdown'),
                            _PriorityChart(data: priorityBreakdown),
                            _TagChart(data: tagBreakdown),
                            const SizedBox(height: 32),
                          ]),
                        ),
                      ],
                    );
                  },
            );
          },
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final StreakData streaks;
  const _StreakCard({required this.streaks});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 0,
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _StreakItem(
              label: 'Current Streak',
              value: streaks.currentStreak,
              icon: Icons.local_fire_department,
              color: Colors.orange,
            ),
            Container(
              height: 40,
              width: 1,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            _StreakItem(
              label: 'Best Streak',
              value: streaks.bestStreak,
              icon: Icons.workspace_premium,
              color: Colors.amber,
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakItem extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const _StreakItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value.toString(),
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    );
  }
}

class _CompletionChart extends StatelessWidget {
  final List<DailyCompletionPoint> data;
  const _CompletionChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Completion Rate',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 1.0,
                  barGroups: data.asMap().entries.map((entry) {
                    return BarChartGroupData(
                      x: entry.key,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.completionRate,
                          color: Theme.of(context).colorScheme.primary,
                          width: 12,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    );
                  }).toList(),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          if (value % 2 != 0) return const SizedBox();
                          final index = value.toInt();
                          if (index < 0 || index >= data.length) {
                            return const SizedBox();
                          }
                          return Text(
                            DateFormat('MM/dd').format(data[index].date),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingTrendChart extends StatelessWidget {
  final List<DayRatingPoint> data;
  const _RatingTrendChart({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Day Rating Trend',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 150,
              child: LineChart(
                LineChartData(
                  minY: 1,
                  maxY: 5,
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: data.asMap().entries.map((e) {
                        return FlSpot(
                          e.key.toDouble(),
                          e.value.rating.toDouble(),
                        );
                      }).toList(),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.secondary,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(
                          context,
                        ).colorScheme.secondary.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriorityChart extends StatelessWidget {
  final List<BreakdownItem> data;
  const _PriorityChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tasks by Priority',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  sections: data.map((item) {
                    final color = Color(
                      int.parse(item.hexColor.replaceFirst('#', '0xff')),
                    );
                    return PieChartSectionData(
                      value: item.count.toDouble(),
                      title: '${item.label}\n${item.count}',
                      color: color,
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagChart extends StatelessWidget {
  final List<BreakdownItem> data;
  const _TagChart({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) return const SizedBox();
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Top Tags', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 16),
            ...data.take(5).map((item) {
              final color = Color(
                int.parse(item.hexColor.replaceFirst('#', '0xff')),
              );
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(
                        item.label,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value:
                              1.0, // We could normalize this relative to the max count
                          color: color,
                          backgroundColor: color.withValues(alpha: 0.1),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.count.toString(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
