part of 'volumes_cubit.dart';

class ApiVolumesState extends ServerInstallationDependendState {
  const ApiVolumesState(this._volumes, this.status);

  const ApiVolumesState.initial() : this(const [], LoadingStatus.uninitialized);
  final List<ServerVolume> _volumes;
  final LoadingStatus status;

  List<ServerVolume> get volumes => _volumes;

  ApiVolumesState copyWith({
    final List<ServerVolume>? volumes,
    final LoadingStatus? status,
  }) =>
      ApiVolumesState(
        volumes ?? _volumes,
        status ?? this.status,
      );

  @override
  List<Object?> get props => [_volumes];
}
