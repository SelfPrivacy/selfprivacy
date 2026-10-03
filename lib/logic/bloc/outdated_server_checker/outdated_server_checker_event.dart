part of 'outdated_server_checker_bloc.dart';

sealed class OutdatedServerCheckerEvent extends Equatable {
  const OutdatedServerCheckerEvent();
}

class _ServerApiVersionObserved extends OutdatedServerCheckerEvent {
  const _ServerApiVersionObserved(this.observation);

  final ConnectionObservation<CachedValue<Version>> observation;

  @override
  List<Object> get props => [observation];
}
