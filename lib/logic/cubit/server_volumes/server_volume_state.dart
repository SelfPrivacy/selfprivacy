part of 'server_volume_cubit.dart';

class ApiServerVolumeState extends ServerInstallationDependendState {
  const ApiServerVolumeState(
    this._volumes,
    this.status,
    this.usesBinds,
    this._diskStatus,
  );

  ApiServerVolumeState.initial()
      : this(const [], LoadingStatus.uninitialized, null, DiskStatus());

  final List<ServerDiskVolume> _volumes;
  final DiskStatus _diskStatus;
  final bool? usesBinds;
  final LoadingStatus status;

  List<DiskVolume> get volumes => _diskStatus.diskVolumes;
  DiskStatus get diskStatus => _diskStatus;

  DiskVolume getVolume(final String volumeName) => volumes.firstWhere(
        (final volume) => volume.name == volumeName,
        orElse: () => DiskVolume(),
      );

  ApiServerVolumeState copyWith({
    final List<ServerDiskVolume>? volumes,
    final LoadingStatus? status,
    final bool? usesBinds,
    final DiskStatus? diskStatus,
  }) =>
      ApiServerVolumeState(
        volumes ?? _volumes,
        status ?? this.status,
        usesBinds ?? this.usesBinds,
        diskStatus ?? _diskStatus,
      );

  @override
  List<Object?> get props => [_volumes, status, usesBinds];
}
