part of 'recovery_key_bloc.dart';

sealed class RecoveryKeyEvent extends Equatable {
  const RecoveryKeyEvent();
}

class _RecoveryKeyObserved extends RecoveryKeyEvent {
  const _RecoveryKeyObserved(this.observation);

  final ConnectionObservation<CachedValue<RecoveryKeyStatus>> observation;

  @override
  List<Object?> get props => [observation];
}

class RecoveryKeyStatusRefresh extends RecoveryKeyEvent {
  const RecoveryKeyStatusRefresh();

  @override
  List<Object?> get props => [];
}

class _BoundRecoveryRefresh extends RecoveryKeyEvent {
  const _BoundRecoveryRefresh(this.origin);
  final ServerStateOrigin? origin;

  @override
  List<Object?> get props => [origin];
}
