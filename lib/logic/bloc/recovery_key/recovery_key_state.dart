part of 'recovery_key_bloc.dart';

sealed class RecoveryKeyState extends Equatable {
  const RecoveryKeyState({final RecoveryKeyStatus? keyStatus})
    : _status =
          keyStatus ?? const RecoveryKeyStatus(exists: false, valid: false);

  final RecoveryKeyStatus _status;

  bool get exists => _status.exists;
  bool get isValid => _status.valid;
  DateTime? get generatedAt => _status.date;
  DateTime? get expiresAt => _status.expiration;
  int? get usesLeft => _status.usesLeft;
  bool get isInvalidBecauseExpired =>
      _status.expiration?.isBefore(DateTime.now()) ?? false;
  bool get isInvalidBecauseUsed => _status.usesLeft == 0;

  @override
  List<Object> get props => [_status];
}

class RecoveryKeyInitial extends RecoveryKeyState {
  const RecoveryKeyInitial();
}

class RecoveryKeyRefreshing extends RecoveryKeyState {
  const RecoveryKeyRefreshing({super.keyStatus});
}

class RecoveryKeyLoaded extends RecoveryKeyState {
  const RecoveryKeyLoaded({required super.keyStatus});
}

class RecoveryKeyError extends RecoveryKeyState {
  const RecoveryKeyError({super.keyStatus});
}
