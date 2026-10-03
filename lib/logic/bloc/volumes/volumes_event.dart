part of 'volumes_bloc.dart';

sealed class VolumesEvent extends Equatable {
  const VolumesEvent();
}

class _VolumesObserved extends VolumesEvent {
  const _VolumesObserved(this.observation);
  final ConnectionObservation<CachedValue<List<ServerDiskVolume>>> observation;
  @override
  List<Object?> get props => [observation];
}

class _LoadProviderVolumes extends VolumesEvent {
  const _LoadProviderVolumes(this.origin);
  final ServerStateOrigin origin;
  @override
  List<Object> get props => [origin];
}

class _ResizeVolume extends VolumesEvent {
  const _ResizeVolume(this.event, this.origin);
  final VolumeResize event;
  final ServerStateOrigin? origin;
  @override
  List<Object?> get props => [event, origin];
}

class VolumeResize extends VolumesEvent {
  const VolumeResize(this.volume, this.newSize);
  final DiskVolume volume;
  final DiskSize newSize;
  @override
  List<Object> get props => [volume, newSize];
}
