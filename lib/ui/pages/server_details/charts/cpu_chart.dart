import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/ui/pages/server_details/charts/bottom_title.dart';

class CpuChart extends StatelessWidget {
  const CpuChart({
    required this.data,
    required this.period,
    required this.start,
    super.key,
  });

  final List<TimeSeriesData> data;
  final Period period;
  final DateTime start;

  List<FlSpot> getSpots() {
    var i = 0;
    final List<FlSpot> res = [];

    for (final d in data) {
      res.add(FlSpot(i.toDouble(), d.value));
      i++;
    }

    return res;
  }

  @override
  Widget build(final BuildContext context) => LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (final LineBarSpot _) =>
                  Theme.of(context).colorScheme.surface,
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipItems: (final List<LineBarSpot> touchedBarSpots) {
                final List<LineTooltipItem> res = [];

                for (final spot in touchedBarSpots) {
                  final value = spot.y;
                  final date = data[spot.x.toInt()].time;

                  res.add(
                    LineTooltipItem(
                      '${value.toStringAsFixed(2)}% at ${DateFormat('HH:mm dd.MM.yyyy').format(date)}',
                      TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return res;
              },
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: getSpots(),
              isCurved: false,
              barWidth: 2,
              color: Theme.of(context).colorScheme.primary,
              dotData: const FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    Theme.of(context).colorScheme.primary.withOpacity(0.0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
          minY: 0,
          // Maximal value of data by 100 step
          maxY: 100,
          minX: 0,
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 40,
                reservedSize: 30,
                getTitlesWidget: (final value, final titleMeta) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    bottomTitle(
                      value.toInt(),
                      data,
                      period,
                    ),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ),
                showTitles: true,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 25,
            verticalInterval: 40,
            getDrawingHorizontalLine: (final value) => FlLine(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (final value) => FlLine(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
              strokeWidth: 1,
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 1,
              ),
              left: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 1,
              ),
              right: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 1,
              ),
              top: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 1,
              ),
            ),
          ),
        ),
      );

  bool checkToShowTitle(
    final double minValue,
    final double maxValue,
    final SideTitles sideTitles,
    final double appliedInterval,
    final double value,
  ) {
    if (value < 0) {
      return false;
    } else if (value == 0) {
      return true;
    }

    final localValue = value - minValue;
    final v = localValue / 20;
    return v - v.floor() == 0;
  }
}
