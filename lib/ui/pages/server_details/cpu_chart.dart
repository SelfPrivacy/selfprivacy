import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/text_themes.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hetzner_metrics.dart';
import 'package:intl/intl.dart';

class CpuChart extends StatelessWidget {
  CpuChart(this.data, this.period, this.start);

  final List<TimeSeriesData> data;
  final Period period;
  final DateTime start;

  List<FlSpot> getSpots() {
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
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          LineChartBarData(
            spots: getSpots(),
            isCurved: true,
            barWidth: 1,
            colors: [
              Colors.red,
            ],
            dotData: FlDotData(
              show: false,
            ),
          ),
        ],
        minY: 0,
        maxY: 100,
        minX: data.length - 200,
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
              interval: 20,
              rotateAngle: 90.0,
              showTitles: true,
              getTextStyles: (value) => const TextStyle(
                    fontSize: 10,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
              getTitles: (value) {
                return bottomTitle(value.toInt());
              }),
          leftTitles: SideTitles(
            getTextStyles: (value) => progressTextStyleLight.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? BrandColors.gray4
                  : null,
            ),
            margin: 15,
            interval: 25,
            showTitles: true,
          ),
        ),
        gridData: FlGridData(show: true),
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
    print(value);
    if (value < 0) {
      return false;
    } else if (value == 0) {
      return true;
    }
    var _value = value - minValue;
    var v = _value / 20;
    return v - v.floor() == 0;
  }

  String bottomTitle(int value) {
    final hhmm = DateFormat('HH:mm');
    var day = DateFormat('MMMd');
    String res;

    if (value <= 0) {
      return '';
    }
    var time = data[value].time;
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
