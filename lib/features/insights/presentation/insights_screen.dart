import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/color_utils.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/insights.dart';
import '../../../shared/widgets/async_value_view.dart';
import '../../../shared/widgets/category_visuals.dart';
import '../../../shared/widgets/max_width_body.dart';
import '../../../shared/widgets/section_header.dart';
import '../application/insights_providers.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(insightsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(insightsProvider),
        child: MaxWidthBody(
          child: AsyncValueView<Insights>(
            value: insights,
            onRetry: () => ref.invalidate(insightsProvider),
            data: (data) => LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth > 840;
                final spending = _SpendingCard(insights: data);
                final trend = _TrendCard(insights: data);
                return ListView(
                  padding: const EdgeInsets.all(Spacing.lg),
                  children: [
                    _Header(insights: data),
                    const SizedBox(height: Spacing.lg),
                    if (wide)
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: spending),
                            const SizedBox(width: Spacing.lg),
                            Expanded(child: trend),
                          ],
                        ),
                      )
                    else ...[
                      spending,
                      const SizedBox(height: Spacing.lg),
                      trend,
                    ],
                    const SizedBox(height: Spacing.lg),
                    _BudgetsCard(insights: data),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.insights});
  final Insights insights;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(insights.period, style: TextStyle(color: scheme.onSurfaceVariant)),
        const SizedBox(height: Spacing.xs),
        Text(
          Formatters.money(insights.total, 'USD'),
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        Text(
          'Total spent this period',
          style: TextStyle(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _SpendingCard extends StatelessWidget {
  const _SpendingCard({required this.insights});
  final Insights insights;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'By category'),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 52,
                  sectionsSpace: 2,
                  sections: [
                    for (final c in insights.byCategory)
                      PieChartSectionData(
                        value: c.amount,
                        color: colorFromHex(c.color),
                        title: '',
                        radius: 28,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.lg),
            ...insights.byCategory.map((c) => _LegendRow(spend: c)),
          ],
        ),
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.spend});
  final CategorySpend spend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.xs),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: colorFromHex(spend.color),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: Spacing.sm),
          Expanded(child: Text(categoryLabel(spend.category))),
          Text(
            Formatters.money(spend.amount, 'USD'),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  const _TrendCard({required this.insights});
  final Insights insights;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final trend = insights.trend;
    final maxY = trend.isEmpty
        ? 1.0
        : trend.map((t) => t.amount).reduce((a, b) => a > b ? a : b) * 1.25;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Monthly trend'),
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  maxY: maxY,
                  alignment: BarChartAlignment.spaceAround,
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: scheme.outlineVariant.withValues(alpha: 0.4),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          final i = value.toInt();
                          if (i < 0 || i >= trend.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: Spacing.xs),
                            child: Text(
                              trend[i].month,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    for (var i = 0; i < trend.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: trend[i].amount,
                            width: 16,
                            color: scheme.primary,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(6),
                            ),
                          ),
                        ],
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

class _BudgetsCard extends StatelessWidget {
  const _BudgetsCard({required this.insights});
  final Insights insights;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Budgets'),
            for (final b in insights.budgets) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          categoryLabel(b.category),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '${Formatters.money(b.spent, 'USD')} / ${Formatters.money(b.limit, 'USD')}',
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacing.sm),
                    ClipRRect(
                      borderRadius: Radii.pill,
                      child: LinearProgressIndicator(
                        value: b.limit <= 0
                            ? 0
                            : (b.spent / b.limit).clamp(0.0, 1.0),
                        minHeight: 8,
                        color: b.spent > b.limit
                            ? scheme.error
                            : scheme.primary,
                        backgroundColor: scheme.surfaceContainerHighest,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
