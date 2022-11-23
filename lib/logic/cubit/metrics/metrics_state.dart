part of 'metrics_cubit.dart';

abstract class MetricsState extends Equatable {
  const MetricsState();

  abstract final Period period;
}

class MetricsLoading extends MetricsState {
  const MetricsLoading(this.period);
  @override
  final Period period;

  @override
  List<Object?> get props => [period];
}

class MetricsLoaded extends MetricsState {
  const MetricsLoaded({
    required this.period,
    required this.metrics,
  });

  @override
  final Period period;

  final ServerMetrics metrics;

  @override
  List<Object?> get props => [period, metrics];
}
