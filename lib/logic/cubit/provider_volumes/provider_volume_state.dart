part of 'provider_volume_cubit.dart';

class ApiProviderVolumeState extends ServerInstallationDependendState {
  const ApiProviderVolumeState(this._volumes, this.status);

  const ApiProviderVolumeState.initial()
      : this(const [], LoadingStatus.uninitialized);
  final List<ServerVolume> _volumes;
  final LoadingStatus status;

  List<ServerVolume> get volumes => _volumes;

  ApiProviderVolumeState copyWith({
    final List<ServerVolume>? volumes,
    final LoadingStatus? status,
  }) =>
      ApiProviderVolumeState(
        volumes ?? _volumes,
        status ?? this.status,
      );

  @override
  List<Object?> get props => [_volumes];
}
