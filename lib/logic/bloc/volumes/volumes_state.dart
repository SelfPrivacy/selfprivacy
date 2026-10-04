part of 'volumes_bloc.dart';

sealed class VolumesState extends Equatable {
  VolumesState({
    required this.diskStatus,
    required final serverVolumesHashCode,
    this.origin,
    final List<ServerProviderVolume> providerVolumes = const [],
  }) : providerVolumes = List.unmodifiable(providerVolumes),
       _serverVolumesHashCode = serverVolumesHashCode;

  final DiskStatus diskStatus;
  final ServerStateOrigin? origin;
  final List<ServerProviderVolume> providerVolumes;
  List<DiskVolume> get volumes => diskStatus.diskVolumes;
  final int? _serverVolumesHashCode;

  DiskVolume getVolume(final String volumeName) => volumes.firstWhere(
    (final volume) => volume.name == volumeName,
    orElse: DiskVolume.new,
  );

  String? get location => volumes
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
  List<Object?> get props => [origin, providerVolumes, _serverVolumesHashCode];

  @override
  VolumesInitial copyWith({
    required final int? serverVolumesHashCode,
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) => VolumesInitial();
}

class VolumesUnavailable extends VolumesState {
  VolumesUnavailable({
    required this.isUnsupported,
    super.origin,
    super.providerVolumes,
  }) : super(diskStatus: DiskStatus(), serverVolumesHashCode: null);

  final bool isUnsupported;

  @override
  List<Object?> get props => [origin, isUnsupported, providerVolumes];

  @override
  VolumesUnavailable copyWith({
    required final int? serverVolumesHashCode,
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) => VolumesUnavailable(
    origin: origin,
    isUnsupported: isUnsupported,
    providerVolumes: providerVolumes ?? this.providerVolumes,
  );
}

class VolumesLoading extends VolumesState {
  VolumesLoading({
    super.origin,
    super.serverVolumesHashCode,
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) : super(
         diskStatus: diskStatus ?? DiskStatus(),
         providerVolumes: providerVolumes ?? const [],
       );

  @override
  List<Object?> get props => [origin, providerVolumes, _serverVolumesHashCode];

  @override
  VolumesLoading copyWith({
    required final int? serverVolumesHashCode,
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
  }) => VolumesLoading(
    origin: origin,
    diskStatus: diskStatus ?? this.diskStatus,
    providerVolumes: providerVolumes ?? this.providerVolumes,
    serverVolumesHashCode: serverVolumesHashCode ?? _serverVolumesHashCode!,
  );
}

class VolumesLoaded extends VolumesState {
  VolumesLoaded({
    required super.serverVolumesHashCode,
    required super.diskStatus,
    super.origin,
    final List<ServerProviderVolume>? providerVolumes,
  }) : super(providerVolumes: providerVolumes ?? const []);

  @override
  List<Object?> get props => [origin, providerVolumes, _serverVolumesHashCode];

  @override
  VolumesLoaded copyWith({
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
    final int? serverVolumesHashCode,
  }) => VolumesLoaded(
    origin: origin,
    diskStatus: diskStatus ?? this.diskStatus,
    providerVolumes: providerVolumes ?? this.providerVolumes,
    serverVolumesHashCode: serverVolumesHashCode ?? _serverVolumesHashCode!,
  );
}

class VolumesResizing extends VolumesState {
  VolumesResizing({
    required super.serverVolumesHashCode,
    required super.diskStatus,
    super.origin,
    final List<ServerProviderVolume>? providerVolumes,
  }) : super(providerVolumes: providerVolumes ?? const []);

  @override
  List<Object?> get props => [origin, providerVolumes, _serverVolumesHashCode];

  @override
  VolumesResizing copyWith({
    final DiskStatus? diskStatus,
    final List<ServerProviderVolume>? providerVolumes,
    final int? serverVolumesHashCode,
  }) => VolumesResizing(
    origin: origin,
    diskStatus: diskStatus ?? this.diskStatus,
    providerVolumes: providerVolumes ?? this.providerVolumes,
    serverVolumesHashCode: serverVolumesHashCode ?? _serverVolumesHashCode!,
  );
}
