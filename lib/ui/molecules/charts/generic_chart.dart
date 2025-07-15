import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/theming/harmonized_basic_colors.dart';

abstract class GenericLineChart extends StatelessWidget {
  const GenericLineChart({
    required this.data,
    required this.period,
    required this.start,
    super.key,
  });

  final List<List<TimeSeriesData>> data;
  final Period period;
  final DateTime start;

  bool get showRightTitle => false;

  static List<FlSpot> getSpots(final List<TimeSeriesData> data) {
    var i = 0;
    final List<FlSpot> res = [];

    for (final d in data) {
      res.add(FlSpot(i.toDouble(), d.value));
      i++;
    }

    return res;
  }

  static bool checkToShowTitle(
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

  /// Now needs explicit override
  String screenReaderDescription(final BuildContext context);

  LineTooltipItem generateTooltipItem({
    required final bool timeShown,
    required final DateTime date,
    required final double value,
    required final LineBarSpot spot,
    required final BuildContext context,
  }) => LineTooltipItem(
    '${value.toStringAsFixed(2)}% at ${DateFormat('HH:mm dd.MM.yyyy').format(date)}',
    TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    ),
  );

  double getMaxY() => 100;

  String getRightTitle(final double value) => '';

  String bottomTitle(
    final int value,
    final List<TimeSeriesData> data,
    final Period period,
  ) {
    final hhmm = DateFormat('HH:mm');
    final day = DateFormat('MMMd');
    String res;

    if (value <= 0 || value >= data.length) {
      return '';
    }

    final time = data[value].time;
    switch (period) {
      case Period.hour:
      case Period.day:
        res = hhmm.format(time);
      case Period.month:
        res = day.format(time);
    }

    return res;
  }

  @override
  Widget build(final BuildContext context) {
    final colors = getGraphColors(context, data.length);
    return Semantics(
      label: screenReaderDescription(context),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor:
                  (final LineBarSpot _) =>
                      Theme.of(context).colorScheme.surface,
              tooltipPadding: const EdgeInsets.all(8),
              getTooltipItems: (final List<LineBarSpot> touchedBarSpots) {
                final List<LineTooltipItem> tooltipItems = [];
                bool timeShown = false;

                for (final spot in touchedBarSpots) {
                  final value = spot.y;
                  final date = data.first[spot.x.toInt()].time;

                  tooltipItems.add(
                    generateTooltipItem(
                      timeShown: timeShown,
                      date: date,
                      value: value,
                      spot: spot,
                      context: context,
                    ),
                  );

                  timeShown = true;
                }

                return tooltipItems;
              },
            ),
          ),
          lineBarsData:
              data
                  .map<LineChartBarData>(
                    (final List<TimeSeriesData> dataSeries) => LineChartBarData(
                      spots: getSpots(dataSeries),
                      isCurved: false,
                      barWidth: 2,
                      color: colors[data.indexOf(dataSeries)],
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            colors[data.indexOf(dataSeries)].withAlpha(127),
                            colors[data.indexOf(dataSeries)].withAlpha(0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  )
                  .toList(),
          minY: 0,
          maxY: getMaxY(),
          minX: 0,
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 40,
                reservedSize: 30,
                getTitlesWidget:
                    (final value, final titleMeta) => Padding(
                      padding: const EdgeInsets.all(8),
                      child: ExcludeSemantics(
                        child: Text(
                          bottomTitle(value.toInt(), data.first, period),
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                showTitles: true,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles:
                showRightTitle
                    ? AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 50,
                        getTitlesWidget:
                            (final value, final titleMeta) => Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: ExcludeSemantics(
                                child: Text(
                                  getRightTitle(value),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.labelSmall?.copyWith(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                        interval: getMaxY() * 2 / 6.5,
                        showTitles: true,
                      ),
                    )
                    : const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            verticalInterval: 40,
            horizontalInterval: getMaxY() == 100 ? 25 : getMaxY() * 2 / 6.5,
            getDrawingHorizontalLine:
                (final value) => FlLine(
                  color: Theme.of(context).colorScheme.outline.withAlpha(76),
                  strokeWidth: 1,
                ),
            getDrawingVerticalLine:
                (final value) => FlLine(
                  color: Theme.of(context).colorScheme.outline.withAlpha(76),
                  strokeWidth: 1,
                ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline.withAlpha(76),
                width: 1,
              ),
              left: BorderSide(
                color: Theme.of(context).colorScheme.outline.withAlpha(76),
                width: 1,
              ),
              right: BorderSide(
                color: Theme.of(context).colorScheme.outline.withAlpha(76),
                width: 1,
              ),
              top: BorderSide(
                color: Theme.of(context).colorScheme.outline.withAlpha(76),
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
