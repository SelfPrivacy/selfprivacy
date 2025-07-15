part of 'volumes_bloc.dart';

sealed class VolumesEvent extends Equatable {
  const VolumesEvent();
}

class VolumesServerLoaded extends VolumesEvent {
  const VolumesServerLoaded();

  @override
  List<Object> get props => [];
}

class VolumesServerReset extends VolumesEvent {
  const VolumesServerReset();

  @override
  List<Object> get props => [];
}

class VolumesServerStateChanged extends VolumesEvent {
  const VolumesServerStateChanged(this.volumes);

  final List<ServerDiskVolume> volumes;

  @override
  List<Object> get props => [volumes];
}

class VolumeResize extends VolumesEvent {
  const VolumeResize(this.volume, this.newSize);

  final DiskVolume volume;
  final DiskSize newSize;

  @override
  List<Object> get props => [volume, newSize];
}
