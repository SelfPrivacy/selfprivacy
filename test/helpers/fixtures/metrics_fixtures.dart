import 'package:selfprivacy/logic/models/metrics.dart';

ServerMetrics aServerMetrics() {
  final start = DateTime.utc(2026, 1, 1);
  final series = List.generate(
    24,
    (final index) => TimeSeriesData(
      start.millisecondsSinceEpoch ~/ 1000 + index * 300,
      20 + index.toDouble(),
    ),
  );
  return ServerMetrics(
    stepsInSecond: 300,
    cpu: series,
    bandwidthIn: series,
    bandwidthOut: series,
    start: start,
    end: start.add(const Duration(hours: 2)),
  );
}
