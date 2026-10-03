part of 'server_detailed_info_cubit.dart';

abstract class ServerDetailsState extends Equatable {
  ServerDetailsState({
    required final List<ServerMetadataEntity> metadata,
    this.continuity,
  }) : metadata = List.unmodifiable(metadata);

  final List<ServerMetadataEntity> metadata;
  final Object? continuity;

  @override
  List<Object?> get props => [metadata, continuity];

  ServerDetailsState copyWith({final List<ServerMetadataEntity>? metadata});
}

class ServerDetailsInitial extends ServerDetailsState {
  ServerDetailsInitial({super.metadata = const [], super.continuity});

  @override
  ServerDetailsInitial copyWith({final List<ServerMetadataEntity>? metadata}) =>
      ServerDetailsInitial(
        metadata: metadata ?? this.metadata,
        continuity: continuity,
      );
}

class ServerDetailsLoading extends ServerDetailsState {
  ServerDetailsLoading({super.metadata = const [], super.continuity});

  @override
  ServerDetailsLoading copyWith({final List<ServerMetadataEntity>? metadata}) =>
      ServerDetailsLoading(
        metadata: metadata ?? this.metadata,
        continuity: continuity,
      );
}

class ServerDetailsNotReady extends ServerDetailsState {
  ServerDetailsNotReady({super.metadata = const [], super.continuity});

  @override
  ServerDetailsNotReady copyWith({
    final List<ServerMetadataEntity>? metadata,
  }) => ServerDetailsNotReady(
    metadata: metadata ?? this.metadata,
    continuity: continuity,
  );
}

class ServerDetailsUnavailable extends ServerDetailsState {
  ServerDetailsUnavailable({
    required this.isUnsupported,
    super.metadata = const [],
    super.continuity,
  });

  final bool isUnsupported;

  @override
  List<Object?> get props => [isUnsupported, metadata, continuity];

  @override
  ServerDetailsUnavailable copyWith({
    final List<ServerMetadataEntity>? metadata,
  }) => ServerDetailsUnavailable(
    isUnsupported: isUnsupported,
    metadata: metadata ?? this.metadata,
    continuity: continuity,
  );
}

class Loaded extends ServerDetailsState {
  Loaded({
    required super.metadata,
    required this.serverTimezone,
    required this.autoUpgradeSettings,
    required this.sshSettings,
    super.continuity,
  });
  final TimeZoneSettings serverTimezone;
  final AutoUpgradeSettings autoUpgradeSettings;
  final SshSettings sshSettings;

  @override
  List<Object?> get props => [
    continuity,
    metadata,
    serverTimezone,
    autoUpgradeSettings,
    sshSettings,
  ];

  @override
  Loaded copyWith({
    final List<ServerMetadataEntity>? metadata,
    final TimeZoneSettings? serverTimezone,
    final AutoUpgradeSettings? autoUpgradeSettings,
    final SshSettings? sshSettings,
  }) => Loaded(
    metadata: metadata ?? this.metadata,
    continuity: continuity,
    serverTimezone: serverTimezone ?? this.serverTimezone,
    autoUpgradeSettings: autoUpgradeSettings ?? this.autoUpgradeSettings,
    sshSettings: sshSettings ?? this.sshSettings,
  );
}
