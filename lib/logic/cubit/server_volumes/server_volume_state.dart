part of 'server_volume_cubit.dart';

class ApiServerVolumeState extends ServerInstallationDependendState {
  const ApiServerVolumeState(
    this._volumes,
    this.status,
    this.usesBinds,
  );

  const ApiServerVolumeState.initial()
      : this(const [], LoadingStatus.uninitialized, null);

  final List<ServerDiskVolume> _volumes;
  final bool? usesBinds;
  final LoadingStatus status;

  List<ServerDiskVolume> get volumes => _volumes;

  ApiServerVolumeState copyWith({
    final List<ServerDiskVolume>? volumes,
    final LoadingStatus? status,
    final bool? usesBinds,
  }) =>
      ApiServerVolumeState(
        volumes ?? _volumes,
        status ?? this.status,
        usesBinds ?? this.usesBinds,
      );

  @override
  List<Object?> get props => [_volumes, status, usesBinds];
}
