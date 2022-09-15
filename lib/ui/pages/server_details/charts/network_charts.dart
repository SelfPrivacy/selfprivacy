import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hetzner_metrics.dart';
import 'package:selfprivacy/ui/pages/server_details/charts/bottom_title.dart';

class NetworkChart extends StatelessWidget {
  const NetworkChart({
    required this.listData,
    required this.period,
    required this.start,
    final super.key,
  });

  final List<List<TimeSeriesData>> listData;
  final Period period;
  final DateTime start;

  List<FlSpot> getSpots(final data) {
    var i = 0;
    final List<FlSpot> res = [];

    for (final d in data) {
      res.add(FlSpot(i.toDouble(), d.value));
      i++;
    }

    return res;
  }

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots: getSpots(listData[0]),
                isCurved: true,
                barWidth: 1,
                color: Colors.red,
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: getSpots(listData[1]),
                isCurved: true,
                barWidth: 1,
                color: Colors.green,
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            minY: 0,
            maxY: [
                  ...listData[0].map((final e) => e.value),
                  ...listData[1].map((final e) => e.value)
                ].reduce(max) *
                1.2,
            minX: listData[0].length - 200,
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  interval: 20,
                  reservedSize: 50,
                  getTitlesWidget: (final value, final titleMeta) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        bottomTitle(
                          value.toInt(),
                          listData[0],
                          period,
                        ),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  showTitles: true,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 50,
                  getTitlesWidget: (final value, final titleMeta) => Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Text(
                      value.toInt().toString(),
                      style: progressTextStyleLight.copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? BrandColors.gray4
                            : null,
                      ),
                    ),
                  ),
                  interval: [
                        ...listData[0].map((final e) => e.value),
                        ...listData[1].map((final e) => e.value)
                      ].reduce(max) *
                      2 /
                      10,
                  showTitles: false,
                ),
              ),
            ),
            gridData: FlGridData(show: true),
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

    final diff = value - minValue;
    final finalValue = diff / 20;
    return finalValue - finalValue.floor() == 0;
  }
}
