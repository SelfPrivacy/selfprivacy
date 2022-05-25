import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hetzner_metrics.dart';
import 'package:intl/intl.dart';

class NetworkChart extends StatelessWidget {
  const NetworkChart({
    Key? key,
    required this.listData,
    required this.period,
    required this.start,
  }) : super(key: key);

  final List<List<TimeSeriesData>> listData;
  final Period period;
  final DateTime start;

  List<FlSpot> getSpots(data) {
    var i = 0;
    List<FlSpot> res = [];

    for (var d in data) {
      res.add(FlSpot(i.toDouble(), d.value));
      i++;
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                ...listData[0].map((e) => e.value),
                ...listData[1].map((e) => e.value)
              ].reduce(max) *
              1.2,
          minX: listData[0].length - 200,
          titlesData: FlTitlesData(
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 20,
                reservedSize: 50,
                getTitlesWidget: (value, titleMeta) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(bottomTitle(value.toInt()),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  );
                },
                showTitles: true,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                reservedSize: 50,
                getTitlesWidget: (value, titleMeta) {
                  return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text(
                        value.toInt().toString(),
                        style: progressTextStyleLight.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? BrandColors.gray4
                              : null,
                        ),
                      ));
                },
                interval: [
                      ...listData[0].map((e) => e.value),
                      ...listData[1].map((e) => e.value)
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
  }

  bool checkToShowTitle(
    double minValue,
    double maxValue,
    SideTitles sideTitles,
    double appliedInterval,
    double value,
  ) {
    if (value < 0) {
      return false;
    } else if (value == 0) {
      return true;
    }
    var diff = value - minValue;
    var finalValue = diff / 20;
    return finalValue - finalValue.floor() == 0;
  }

  String bottomTitle(int value) {
    final hhmm = DateFormat('HH:mm');
    var day = DateFormat('MMMd');
    String res;

    if (value <= 0) {
      return '';
    }
    var time = listData[0][value].time;
    switch (period) {
      case Period.hour:
      case Period.day:
        res = hhmm.format(time);
        break;
      case Period.month:
        res = day.format(time);
    }

    return res;
  }
}
