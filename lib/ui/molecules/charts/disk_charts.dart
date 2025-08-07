import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/ui/molecules/charts/generic_chart.dart';

class DiskChart extends GenericLineChart {
  DiskChart({
    required this.diskData,
    required super.period,
    required super.start,
    super.key,
  }) : super(data: diskData.map((final e) => e.diskData).toList());

  final List<DiskGraphData> diskData;

  @override
  String screenReaderDescription(final BuildContext context) {
    final buffer =
        StringBuffer()..write(
          'resource_chart.disk_chart_screen_reader_explanation.beginning'.tr(
            namedArgs: {'period': 'resource_chart.${period.name}'.tr()},
          ),
        );

    for (final disk in diskData) {
      final lastData = disk.diskData.last;
      final lastValue = lastData.value;

      final firstData = disk.diskData.first;
      final firstValue = firstData.value;

      buffer.write(
        'resource_chart.disk_chart_screen_reader_explanation.disk'.tr(
          namedArgs: {
            'disk': disk.volume.displayName,
            'beginningValue': firstValue.toStringAsFixed(1),
            'endValue': lastValue.toStringAsFixed(1),
          },
        ),
      );
    }
    return buffer.toString();
  }

  @override
  LineTooltipItem generateTooltipItem({
    required final bool timeShown,
    required final DateTime date,
    required final double value,
    required final LineBarSpot spot,
    required final BuildContext context,
  }) => LineTooltipItem(
    '${timeShown ? '' : DateFormat('HH:mm dd.MM.yyyy').format(date)} ${diskData[spot.barIndex].volume.displayName} ${value.toInt()}%',
    TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    ),
  );
}
