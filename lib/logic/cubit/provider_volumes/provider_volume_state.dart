part of 'provider_volume_cubit.dart';

class ApiProviderVolumeState extends ServerInstallationDependendState {
  const ApiProviderVolumeState(this._volumes, this.status, this.isResizing);

  const ApiProviderVolumeState.initial()
      : this(const [], LoadingStatus.uninitialized, false);
  final List<ServerProviderVolume> _volumes;
  final LoadingStatus status;
  final bool isResizing;

  List<ServerProviderVolume> get volumes => _volumes;

  ApiProviderVolumeState copyWith({
    final List<ServerProviderVolume>? volumes,
    final LoadingStatus? status,
    final bool? isResizing,
  }) =>
      ApiProviderVolumeState(
        volumes ?? _volumes,
        status ?? this.status,
        isResizing ?? this.isResizing,
      );

  @override
  List<Object?> get props => [_volumes, status, isResizing];
}
