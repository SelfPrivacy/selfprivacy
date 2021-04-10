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
