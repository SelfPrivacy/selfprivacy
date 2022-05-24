part of 'recovery_key_cubit.dart';

enum LoadingStatus {
  uninitialized,
  refreshing,
  good,
  error,
}

class RecoveryKeyState extends ServerInstallationDependendState {
  const RecoveryKeyState(this._status, this.loadingStatus);

  const RecoveryKeyState.initial()
      : this(const RecoveryKeyStatus(exists: false, valid: false),
            LoadingStatus.refreshing);

  final RecoveryKeyStatus _status;
  final LoadingStatus loadingStatus;

  bool get exists => _status.exists;
  bool get isValid => _status.valid;
  DateTime? get generatedAt => _status.date;
  DateTime? get expiresAt => _status.date;
  int? get usesLeft => _status.usesLeft;
  @override
  List<Object> get props => [_status, loadingStatus];

  RecoveryKeyState copyWith({
    RecoveryKeyStatus? status,
    LoadingStatus? loadingStatus,
  }) {
    return RecoveryKeyState(
      status ?? _status,
      loadingStatus ?? this.loadingStatus,
    );
  }
}
