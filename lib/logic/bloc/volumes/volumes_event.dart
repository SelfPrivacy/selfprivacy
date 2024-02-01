part of 'volumes_bloc.dart';

abstract class VolumesEvent extends Equatable {
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
  const VolumesServerStateChanged(
    this.volumes,
  );

  final List<ServerDiskVolume> volumes;

  @override
  List<Object> get props => [volumes];
}
