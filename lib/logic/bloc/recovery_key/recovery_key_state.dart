part of 'recovery_key_bloc.dart';

sealed class RecoveryKeyState extends Equatable {
  RecoveryKeyState({required final RecoveryKeyStatus? keyStatus})
    : _hashCode = keyStatus.hashCode;

  final int _hashCode;

  RecoveryKeyStatus get _status =>
      getIt<ApiConnectionRepository>().apiData.recoveryKeyStatus.data ??
      const RecoveryKeyStatus(exists: false, valid: false);

  bool get exists => _status.exists;
  bool get isValid => _status.valid;
  DateTime? get generatedAt => _status.date;
  DateTime? get expiresAt => _status.expiration;
  int? get usesLeft => _status.usesLeft;

  bool get isInvalidBecauseExpired =>
      _status.expiration != null &&
      _status.expiration!.isBefore(DateTime.now());

  bool get isInvalidBecauseUsed =>
      _status.usesLeft != null && _status.usesLeft == 0;
}

class RecoveryKeyInitial extends RecoveryKeyState {
  RecoveryKeyInitial()
    : super(keyStatus: const RecoveryKeyStatus(exists: false, valid: false));

  @override
  List<Object> get props => [_hashCode];
}

class RecoveryKeyRefreshing extends RecoveryKeyState {
  RecoveryKeyRefreshing({required super.keyStatus});

  @override
  List<Object> get props => [_hashCode];
}

class RecoveryKeyLoaded extends RecoveryKeyState {
  RecoveryKeyLoaded({required super.keyStatus});

  @override
  List<Object> get props => [_hashCode];
}

class RecoveryKeyError extends RecoveryKeyState {
  RecoveryKeyError()
    : super(keyStatus: const RecoveryKeyStatus(exists: false, valid: false));

  @override
  List<Object> get props => [_hashCode];
}
