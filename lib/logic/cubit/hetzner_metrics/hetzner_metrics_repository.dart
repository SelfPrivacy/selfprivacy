import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hetzner_metrics.dart';

import 'package:selfprivacy/logic/cubit/hetzner_metrics/hetzner_metrics_cubit.dart';

class MetricsLoadException implements Exception {
  MetricsLoadException(this.message);
  final String message;
}

class HetznerMetricsRepository {
  Future<HetznerMetricsLoaded> getMetrics(final Period period) async {
    final DateTime end = DateTime.now();
    DateTime start;

    switch (period) {
      case Period.hour:
        start = end.subtract(const Duration(hours: 1));
        break;
      case Period.day:
        start = end.subtract(const Duration(days: 1));
        break;
      case Period.month:
        start = end.subtract(const Duration(days: 15));
        break;
    }

    final HetznerApi api = HetznerApi(hasLogger: false);

    final List<Map<String, dynamic>> results = await Future.wait([
      api.getMetrics(start, end, 'cpu'),
      api.getMetrics(start, end, 'network'),
    ]);

    final cpuMetricsData = results[0]['metrics'];
    final networkMetricsData = results[1]['metrics'];

    if (cpuMetricsData == null || networkMetricsData == null) {
      throw MetricsLoadException('Metrics data is null');
    }

    return HetznerMetricsLoaded(
      period: period,
      start: start,
      end: end,
      stepInSeconds: cpuMetricsData['step'],
      cpu: timeSeriesSerializer(cpuMetricsData, 'cpu'),
      ppsIn: timeSeriesSerializer(networkMetricsData, 'network.0.pps.in'),
      ppsOut: timeSeriesSerializer(networkMetricsData, 'network.0.pps.out'),
      bandwidthIn:
          timeSeriesSerializer(networkMetricsData, 'network.0.bandwidth.in'),
      bandwidthOut: timeSeriesSerializer(
        networkMetricsData,
        'network.0.bandwidth.out',
      ),
    );
  }
}

List<TimeSeriesData> timeSeriesSerializer(
  final Map<String, dynamic> json,
  final String type,
) {
  final List list = json['time_series'][type]['values'];
  return list
      .map((final el) => TimeSeriesData(el[0], double.parse(el[1])))
      .toList();
}
