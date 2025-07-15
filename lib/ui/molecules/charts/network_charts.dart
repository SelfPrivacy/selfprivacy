import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/ui/molecules/charts/generic_chart.dart';

class NetworkChart extends GenericLineChart {
  const NetworkChart({
    required super.data,
    required super.period,
    required super.start,
    super.key,
  });

  @override
  bool get showRightTitle => true;

  @override
  String screenReaderDescription(final BuildContext context) {
    final lastDataIn = data[0].last;
    final lastDataOut = data[1].last;
    final lastValueIn = lastDataIn.value;
    final lastValueOut = lastDataOut.value;

    final averageUsageIn =
        data[0].map((final e) => e.value).reduce((final a, final b) => a + b) /
        data[0].length;
    final averageUsageOut =
        data[1].map((final e) => e.value).reduce((final a, final b) => a + b) /
        data[1].length;

    final maxUsageIn = data[0]
        .map((final e) => e.value)
        .reduce((final a, final b) => a > b ? a : b);
    final maxUsageOut = data[1]
        .map((final e) => e.value)
        .reduce((final a, final b) => a > b ? a : b);

    final maxUsageTimeIn =
        data[0].firstWhere((final e) => e.value == maxUsageIn).time;
    final maxUsageTimeOut =
        data[1].firstWhere((final e) => e.value == maxUsageOut).time;

    final label = 'resource_chart.network_chart_screen_reader_explanation'.tr(
      namedArgs: {
        'period': 'resource_chart.${period.name}'.tr(),
        'lastValueIn': DiskSize(byte: lastValueIn.toInt()).toString(),
        'lastValueOut': DiskSize(byte: lastValueOut.toInt()).toString(),
        'averageUsageIn': DiskSize(byte: averageUsageIn.toInt()).toString(),
        'averageUsageOut': DiskSize(byte: averageUsageOut.toInt()).toString(),
        'maxUsageIn': DiskSize(byte: maxUsageIn.toInt()).toString(),
        'maxUsageOut': DiskSize(byte: maxUsageOut.toInt()).toString(),
        'maxUsageTimeIn': DateFormat(
          'HH:mm dd MMMM',
          context.locale.languageCode,
        ).format(maxUsageTimeIn),
        'maxUsageTimeOut': DateFormat(
          'HH:mm dd MMMM',
          context.locale.languageCode,
        ).format(maxUsageTimeOut),
      },
    );

    return label;
  }

  @override
  double getMaxY() =>
      [
        ...data[0].map((final e) => e.value),
        ...data[1].map((final e) => e.value),
      ].reduce(max) *
      1.2;

  @override
  LineTooltipItem generateTooltipItem({
    required final bool timeShown,
    required final DateTime date,
    required final double value,
    required final LineBarSpot spot,
    required final BuildContext context,
  }) => LineTooltipItem(
    '${timeShown ? '' : DateFormat('HH:mm dd.MM.yyyy').format(date)} ${spot.barIndex == 0 ? 'resource_chart.in'.tr() : 'resource_chart.out'.tr()} ${DiskSize(byte: value.toInt())}',
    TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    ),
  );

  @override
  String getRightTitle(final double value) =>
      DiskSize(byte: value.toInt()).toString();
}
