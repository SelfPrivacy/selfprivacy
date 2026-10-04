part of 'volumes_bloc.dart';

sealed class VolumesEvent extends Equatable {
  const VolumesEvent();
}

class _VolumesObserved extends VolumesEvent {
  const _VolumesObserved(this.observation);
  final CachedValue<List<ServerDiskVolume>>? observation;
  @override
  List<Object?> get props => [observation];
}

class _LoadProviderVolumes extends VolumesEvent {
  const _LoadProviderVolumes();
  @override
  List<Object> get props => [];
}

class VolumeResize extends VolumesEvent {
  const VolumeResize(this.volume, this.newSize);

  final DiskVolume volume;
  final DiskSize newSize;
  @override
  List<Object?> get props => [volume, newSize];
}
