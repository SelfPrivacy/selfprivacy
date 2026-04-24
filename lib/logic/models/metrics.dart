import 'package:flutter/services.dart' show Color;
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/monitoring.graphql.dart';
import 'package:selfprivacy/logic/models/disk_status.dart';

class TimeSeriesData {
  TimeSeriesData(this.secondsSinceEpoch, this.value);

  final int secondsSinceEpoch;
  DateTime get time =>
      DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  final double value;
}

class DiskGraphData {
  DiskGraphData({
    required this.volume,
    required this.color,
    required this.diskData,
    required this.originalId,
  });

  final DiskVolume volume;
  final Color color;
  final List<TimeSeriesData> diskData;
  final String originalId;
}

class ServerMetrics {
  ServerMetrics({
    required this.stepsInSecond,
    required this.cpu,
    required this.bandwidthIn,
    required this.bandwidthOut,
    required this.start,
    required this.end,
  });

  ServerMetrics.fromGraphQL({
    required final Query$GetOverallCpuAndNetworkMetrics$monitoring data,
    required final int stepsInSecond,
    required final DateTime start,
    required final DateTime end,
  }) : this(
         stepsInSecond: stepsInSecond,
         cpu:
             (data.cpuUsage.overallUsage as Fragment$MonitoringValues).values
                 .map(
                   (final metric) => TimeSeriesData(
                     // Convert DateTime to seconds since epoch
                     metric.timestamp.millisecondsSinceEpoch ~/ 1000,
                     // Parse string as a float
                     double.parse(metric.value),
                   ),
                 )
                 .toList(),
         bandwidthIn:
             (data.networkUsage.overallUsage as Fragment$MonitoringMetrics)
                 .metrics
                 .firstWhere((final element) => element.metricId == 'receive')
                 .values
                 .map(
                   (final metric) => TimeSeriesData(
                     metric.timestamp.millisecondsSinceEpoch ~/ 1000,
                     double.parse(metric.value),
                   ),
                 )
                 .toList(),
         bandwidthOut:
             (data.networkUsage.overallUsage as Fragment$MonitoringMetrics)
                 .metrics
                 .firstWhere((final element) => element.metricId == 'transmit')
                 .values
                 .map(
                   (final metric) => TimeSeriesData(
                     metric.timestamp.millisecondsSinceEpoch ~/ 1000,
                     double.parse(metric.value),
                   ),
                 )
                 .toList(),
         start: start,
         end: end,
       );

  final num stepsInSecond;
  final List<TimeSeriesData> cpu;
  final List<TimeSeriesData> bandwidthIn;
  final List<TimeSeriesData> bandwidthOut;

  final DateTime start;
  final DateTime end;
}

class MemoryMetrics {
  MemoryMetrics({
    required this.stepsInSecond,
    required this.overallMetrics,
    required this.swapMetrics,
    required this.averageMetricsByService,
    required this.maxMetricsByService,
    required this.start,
    required this.end,
  });

  MemoryMetrics.fromGraphQL({
    required final Query$GetMemoryMetrics$monitoring data,
    required final int stepsInSecond,
    required final DateTime start,
    required final DateTime end,
  }) : this(
         stepsInSecond: stepsInSecond,
         overallMetrics:
             (data.memoryUsage.overallUsage as Fragment$MonitoringValues).values
                 .map(
                   (final metric) => TimeSeriesData(
                     metric.timestamp.millisecondsSinceEpoch ~/ 1000,
                     double.parse(metric.value),
                   ),
                 )
                 .toList(),
         swapMetrics:
             (data.memoryUsage.swapUsageOverall as Fragment$MonitoringValues)
                 .values
                 .map(
                   (final metric) => TimeSeriesData(
                     metric.timestamp.millisecondsSinceEpoch ~/ 1000,
                     double.parse(metric.value),
                   ),
                 )
                 .toList(),
         averageMetricsByService: Map.fromEntries(
           (data.memoryUsage.averageUsageByService
                   as Fragment$MonitoringMetrics)
               .metrics
               .map(
                 (final metric) => MapEntry(
                   metric.metricId,
                   double.parse(metric.values.first.value),
                 ),
               ),
         ),
         maxMetricsByService: Map.fromEntries(
           (data.memoryUsage.maxUsageByService as Fragment$MonitoringMetrics)
               .metrics
               .map(
                 (final metric) => MapEntry(
                   metric.metricId,
                   double.parse(metric.values.first.value),
                 ),
               ),
         ),
         start: start,
         end: end,
       );

  final num stepsInSecond;
  final List<TimeSeriesData> overallMetrics;
  final List<TimeSeriesData> swapMetrics;
  final Map<String, double> averageMetricsByService;
  final Map<String, double> maxMetricsByService;

  final DateTime start;
  final DateTime end;
}

class DiskMetrics {
  DiskMetrics({
    required this.stepsInSecond,
    required this.diskMetrics,
    required this.start,
    required this.end,
  });

  DiskMetrics.fromGraphQL({
    required final Query$GetDiskMetrics$monitoring data,
    required final int stepsInSecond,
    required final DateTime start,
    required final DateTime end,
  }) : this(
         stepsInSecond: stepsInSecond,
         diskMetrics: Map.fromEntries(
           (data.diskUsage.overallUsage as Fragment$MonitoringMetrics).metrics
               .map(
                 (final metric) => MapEntry(
                   metric.metricId,
                   metric.values
                       .map(
                         (final value) => TimeSeriesData(
                           value.timestamp.millisecondsSinceEpoch ~/ 1000,
                           double.parse(value.value),
                         ),
                       )
                       .toList(),
                 ),
               ),
         ),
         start: start,
         end: end,
       );

  final num stepsInSecond;
  final Map<String, List<TimeSeriesData>> diskMetrics;

  final DateTime start;
  final DateTime end;
}
