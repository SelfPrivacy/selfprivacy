import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/ui/pages/server_details/charts/bottom_title.dart';

class DiskChart extends StatelessWidget {
  const DiskChart({
    required this.diskData,
    required this.period,
    required this.start,
    super.key,
  });

  final Map<String, List<TimeSeriesData>> diskData;
  final Period period;
  final DateTime start;

  List<FlSpot> getSpots(final List<TimeSeriesData> data) {
    var i = 0;
    final List<FlSpot> res = [];

    for (final d in data) {
      res.add(FlSpot(i.toDouble(), d.value));
      i++;
    }

    return res;
  }

  @override
  Widget build(final BuildContext context) {
    final anyDiskId = diskData.keys.toList()[0];
    final diskDataMax = [
      ...diskData.values.map<List<double>>(
        (final timeData) => timeData.map((final e) => e.value).toList(),
      ),
    ].expand((final x) => x).reduce(max);
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (final LineBarSpot _) =>
                Theme.of(context).colorScheme.surface,
            tooltipPadding: const EdgeInsets.all(8),
            getTooltipItems: (final List<LineBarSpot> touchedBarSpots) {
              final List<LineTooltipItem> res = [];

              bool timeShown = false;
              for (final spot in touchedBarSpots) {
                final value = spot.y;
                final date = diskData[anyDiskId]![spot.x.toInt()].time;

                res.add(
                  LineTooltipItem(
                    '${timeShown ? '' : DateFormat('HH:mm dd.MM.yyyy').format(date)} ${diskData.keys.toList()[spot.barIndex]} ${value.toInt()}%',
                    TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );

                timeShown = true;
              }

              return res;
            },
          ),
        ),
        lineBarsData: diskData.values
            .toList()
            .map<LineChartBarData>(
              (final timeData) => LineChartBarData(
                spots: getSpots(timeData),
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
            )
            .toList(),
        minY: 0,
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
                    diskData[anyDiskId]!,
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
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 50,
              getTitlesWidget: (final value, final titleMeta) => Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  '${value.toInt()}%',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              interval: diskDataMax * 2 / 6.5,
              showTitles: true,
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          verticalInterval: 40,
          horizontalInterval: diskDataMax * 2 / 6.5,
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
  }

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

    final diff = value - minValue;
    final finalValue = diff / 20;
    return finalValue - finalValue.floor() == 0;
  }
}
