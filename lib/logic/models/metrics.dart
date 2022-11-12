class TimeSeriesData {
  TimeSeriesData(
    this.secondsSinceEpoch,
    this.value,
  );

  final int secondsSinceEpoch;
  DateTime get time =>
      DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  final double value;
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

  final num stepsInSecond;
  final List<TimeSeriesData> cpu;
  final List<TimeSeriesData> bandwidthIn;
  final List<TimeSeriesData> bandwidthOut;

  final DateTime start;
  final DateTime end;
}
