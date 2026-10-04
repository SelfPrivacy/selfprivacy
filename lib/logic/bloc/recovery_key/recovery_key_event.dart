part of 'recovery_key_bloc.dart';

sealed class RecoveryKeyEvent extends Equatable {
  const RecoveryKeyEvent();
}

class _RecoveryKeyObserved extends RecoveryKeyEvent {
  const _RecoveryKeyObserved(this.observation);

  final CachedValue<RecoveryKeyStatus>? observation;

  @override
  List<Object?> get props => [observation];
}

class RecoveryKeyStatusRefresh extends RecoveryKeyEvent {
  const RecoveryKeyStatusRefresh();

  @override
  List<Object?> get props => [];
}
