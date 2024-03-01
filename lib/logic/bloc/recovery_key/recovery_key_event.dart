part of 'recovery_key_bloc.dart';

sealed class RecoveryKeyEvent extends Equatable {
  const RecoveryKeyEvent();
}

class RecoveryKeyStatusChanged extends RecoveryKeyEvent {
  const RecoveryKeyStatusChanged(this.recoveryKeyStatus);

  final RecoveryKeyStatus? recoveryKeyStatus;

  @override
  List<Object?> get props => [recoveryKeyStatus];
}

class RecoveryKeyStatusRefresh extends RecoveryKeyEvent {
  const RecoveryKeyStatusRefresh();

  @override
  List<Object?> get props => [];
}
