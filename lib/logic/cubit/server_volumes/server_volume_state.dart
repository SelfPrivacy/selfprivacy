part of 'server_volume_cubit.dart';

class ApiServerVolumeState extends ServerInstallationDependendState {
  const ApiServerVolumeState(this._volumes, this.status);

  const ApiServerVolumeState.initial()
      : this(const [], LoadingStatus.uninitialized);
  final List<ServerDiskVolume> _volumes;
  final LoadingStatus status;

  List<ServerDiskVolume> get volumes => _volumes;

  ApiServerVolumeState copyWith({
    final List<ServerDiskVolume>? volumes,
    final LoadingStatus? status,
  }) =>
      ApiServerVolumeState(
        volumes ?? _volumes,
        status ?? this.status,
      );

  @override
  List<Object?> get props => [_volumes];
}
