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

class CreateNewRecoveryKey extends RecoveryKeyEvent {
  const CreateNewRecoveryKey({
    this.expirationDate,
    this.numberOfUses,
  });

  final DateTime? expirationDate;
  final int? numberOfUses;

  @override
  List<Object?> get props => [expirationDate, numberOfUses];
}

class ConsumedNewRecoveryKey extends RecoveryKeyEvent {
  const ConsumedNewRecoveryKey();

  @override
  List<Object?> get props => [];
}

class RecoveryKeyStatusRefresh extends RecoveryKeyEvent {
  const RecoveryKeyStatusRefresh();

  @override
  List<Object?> get props => [];
}
