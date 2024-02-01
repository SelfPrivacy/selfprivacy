part of 'provider_volume_cubit.dart';

class ProviderVolumeState extends ServerInstallationDependendState {
  const ProviderVolumeState(this._volumes, this.status, this.isResizing);

  const ProviderVolumeState.initial()
      : this(const [], LoadingStatus.uninitialized, false);
  final List<ServerProviderVolume> _volumes;
  final LoadingStatus status;
  final bool isResizing;

  List<ServerProviderVolume> get volumes => _volumes;

  ProviderVolumeState copyWith({
    final List<ServerProviderVolume>? volumes,
    final LoadingStatus? status,
    final bool? isResizing,
  }) =>
      ProviderVolumeState(
        volumes ?? _volumes,
        status ?? this.status,
        isResizing ?? this.isResizing,
      );

  @override
  List<Object?> get props => [_volumes, status, isResizing];
}
