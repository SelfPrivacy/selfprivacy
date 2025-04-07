import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/ui/molecules/charts/generic_chart.dart';

class MemoryChart extends GenericLineChart {
  const MemoryChart({
    required super.data,
    required super.period,
    required super.start,
    this.isSwap = false,
    super.key,
  });

  final bool isSwap;

  @override
  String screenReaderDescription(final BuildContext context) {
    final lastData = data.first.last;
    final lastValue = lastData.value;

    final averageUsage = data.first
            .map((final e) => e.value)
            .reduce((final a, final b) => a + b) /
        data.length;
    final maxUsage = data.first
        .map((final e) => e.value)
        .reduce((final a, final b) => a > b ? a : b);
    final maxUsageTime =
        data.first.firstWhere((final e) => e.value == maxUsage).time;

    final labelKey = isSwap
        ? 'resource_chart.swap_chart_screen_reader_explanation'
        : 'resource_chart.memory_chart_screen_reader_explanation';

    final label = labelKey.tr(
      namedArgs: {
        'period': 'resource_chart.${period.name}'.tr(),
        'lastValue': lastValue.toStringAsFixed(1),
        'averageUsage': averageUsage.toStringAsFixed(1),
        'maxUsage': maxUsage.toStringAsFixed(1),
        'maxUsageTime': DateFormat('HH:mm dd MMMM', context.locale.languageCode)
            .format(maxUsageTime),
      },
    );

    return label;
  }
}
