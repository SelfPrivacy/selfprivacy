part of 'volumes_bloc.dart';

sealed class VolumesState extends Equatable {
  const VolumesState({
    required this.diskStatus,
    required final serverVolumesHashCode,
    this.providerVolumes = const [],
  }) : _serverVolumesHashCode = serverVolumesHashCode;

  final DiskStatus diskStatus;
  final List<ServerProviderVolume> providerVolumes;
  List<DiskVolume> get volumes => diskStatus.diskVolumes;
  final int? _serverVolumesHashCode;

  DiskVolume getVolume(final String volumeName) => volumes.firstWhere(
    (final volume) => volume.name == volumeName,
    orElse: DiskVolume.new,
  );

  String? get location =>
      volumes
          .firstWhereOrNull((final volume) => volume.isResizable)
          ?.providerVolume
          ?.location;

  bool get isProviderVolumesLoaded => providerVolumes.isNotEmpty;

  VolumesState copyWith({
    required final int? serverVolumesHashCode,
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  });
}

class VolumesInitial extends VolumesState {
  VolumesInitial()
    : super(diskStatus: DiskStatus(), serverVolumesHashCode: null);

  @override
  List<Object?> get props => [providerVolumes, _serverVolumesHashCode];

  @override
  VolumesInitial copyWith({
    required final int? serverVolumesHashCode,
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) => VolumesInitial();
}

class VolumesLoading extends VolumesState {
  VolumesLoading({
    super.serverVolumesHashCode,
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) : super(
         diskStatus: diskStatus ?? DiskStatus(),
         providerVolumes: providerVolumes ?? const [],
       );

  @override
  List<Object?> get props => [providerVolumes, _serverVolumesHashCode];

  @override
  VolumesLoading copyWith({
    required final int? serverVolumesHashCode,
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) => VolumesLoading(
    diskStatus: diskStatus ?? this.diskStatus,
    providerVolumes: providerVolumes ?? this.providerVolumes,
    serverVolumesHashCode: serverVolumesHashCode ?? _serverVolumesHashCode!,
  );
}

class VolumesLoaded extends VolumesState {
  const VolumesLoaded({
    required super.serverVolumesHashCode,
    required super.diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) : super(providerVolumes: providerVolumes ?? const []);

  @override
  List<Object?> get props => [providerVolumes, _serverVolumesHashCode];

  @override
  VolumesLoaded copyWith({
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
    final int? serverVolumesHashCode,
  }) => VolumesLoaded(
    diskStatus: diskStatus ?? this.diskStatus,
    providerVolumes: providerVolumes ?? this.providerVolumes,
    serverVolumesHashCode: serverVolumesHashCode ?? _serverVolumesHashCode!,
  );
}

class VolumesResizing extends VolumesState {
  const VolumesResizing({
    required super.serverVolumesHashCode,
    required super.diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) : super(providerVolumes: providerVolumes ?? const []);

  @override
  List<Object?> get props => [providerVolumes, _serverVolumesHashCode];

  @override
  VolumesResizing copyWith({
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
    final int? serverVolumesHashCode,
  }) => VolumesResizing(
    diskStatus: diskStatus ?? this.diskStatus,
    providerVolumes: providerVolumes ?? this.providerVolumes,
    serverVolumesHashCode: serverVolumesHashCode ?? _serverVolumesHashCode!,
  );
}
