import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/cubit/metrics/metrics_cubit.dart';
import 'package:selfprivacy/logic/models/metrics.dart';

import 'constants.dart';

List<TimeSeriesData> demoSeries({
  final double scale = 1,
  final bool flat = false,
}) => List.generate(
  13,
  (final i) => TimeSeriesData(
    referenceTime.millisecondsSinceEpoch ~/ 1000 + i * 300,
    (flat ? 0 : 20 + (i * 13 % 65)) * scale,
  ),
);
MetricsLoaded demoMetrics({
  final bool legacy = false,
  final bool flat = false,
}) => MetricsLoaded(
  period: Period.hour,
  source: legacy ? MetricsDataSource.legacy : MetricsDataSource.server,
  metrics: ServerMetrics(
    stepsInSecond: 300,
    cpu: demoSeries(flat: flat),
    bandwidthIn: demoSeries(scale: 1024, flat: flat),
    bandwidthOut: demoSeries(scale: 512, flat: flat),
    start: referenceTime,
    end: referenceTime.add(const Duration(hours: 1)),
  ),
  diskMetrics: legacy
      ? null
      : DiskMetrics(
          stepsInSecond: 300,
          diskMetrics: {'sda1': demoSeries(flat: flat)},
          start: referenceTime,
          end: referenceTime.add(const Duration(hours: 1)),
        ),
  memoryMetrics: legacy
      ? null
      : MemoryMetrics(
          stepsInSecond: 300,
          overallMetrics: demoSeries(flat: flat),
          swapMetrics: demoSeries(flat: flat),
          averageMetricsByService: const {},
          maxMetricsByService: const {},
          start: referenceTime,
          end: referenceTime.add(const Duration(hours: 1)),
        ),
);
