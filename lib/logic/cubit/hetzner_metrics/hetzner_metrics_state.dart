part of 'hetzner_metrics_cubit.dart';

abstract class HetznerMetricsState extends Equatable {
  const HetznerMetricsState();

  abstract final Period period;
}

class HetznerMetricsLoading extends HetznerMetricsState {
  HetznerMetricsLoading(this.period);
  final Period period;

  @override
  List<Object?> get props => [period];
}

class HetznerMetricsLoaded extends HetznerMetricsState {
  HetznerMetricsLoaded({
    required this.period,
    required this.start,
    required this.end,
    required this.stepInSeconds,
    required this.cpu,
    required this.ppsIn,
    required this.ppsOut,
    required this.bandwidthIn,
    required this.bandwidthOut,
  });

  final Period period;
  final DateTime start;
  final DateTime end;
  final num stepInSeconds;

  final List<TimeSeriesData> cpu;
  final List<TimeSeriesData> ppsIn;
  final List<TimeSeriesData> ppsOut;
  final List<TimeSeriesData> bandwidthIn;
  final List<TimeSeriesData> bandwidthOut;

  @override
  List<Object?> get props => [period, start, end];
}
