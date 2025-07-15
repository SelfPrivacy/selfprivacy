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

enum MetricsDataSource { server, legacy }

class MetricsLoaded extends MetricsState {
  const MetricsLoaded({
    required this.period,
    required this.metrics,
    required this.source,
    this.memoryMetrics,
    this.diskMetrics,
  });

  @override
  final Period period;

  final ServerMetrics metrics;
  final MemoryMetrics? memoryMetrics;
  final DiskMetrics? diskMetrics;
  final MetricsDataSource source;

  @override
  List<Object?> get props => [
    period,
    metrics,
    memoryMetrics,
    diskMetrics,
    source,
  ];
}

class MetricsUnsupported extends MetricsState {
  const MetricsUnsupported(this.period);
  @override
  final Period period;

  @override
  List<Object?> get props => [period];
}
