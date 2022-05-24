import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hetzner_metrics.dart';

import 'hetzner_metrics_cubit.dart';

class HetznerMetricsRepository {
  Future<HetznerMetricsLoaded> getMetrics(Period period) async {
    var end = DateTime.now();
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

    var api = HetznerApi(hasLogger: true);

    var results = await Future.wait([
      api.getMetrics(start, end, 'cpu'),
      api.getMetrics(start, end, 'network'),
    ]);

    var cpuMetricsData = results[0]['metrics'];
    var networkMetricsData = results[1]['metrics'];

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
    Map<String, dynamic> json, String type) {
  List list = json['time_series'][type]['values'];
  return list.map((el) => TimeSeriesData(el[0], double.parse(el[1]))).toList();
}
