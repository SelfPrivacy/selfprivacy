part of 'server_detailed_info_cubit.dart';

abstract class ServerDetailsState extends Equatable {
  ServerDetailsState({required final List<ServerMetadataEntity> metadata})
    : metadata = List.unmodifiable(metadata);

  final List<ServerMetadataEntity> metadata;

  @override
  List<Object?> get props => [metadata];

  ServerDetailsState copyWith({final List<ServerMetadataEntity>? metadata});
}

class ServerDetailsInitial extends ServerDetailsState {
  ServerDetailsInitial({super.metadata = const []});

  @override
  ServerDetailsInitial copyWith({final List<ServerMetadataEntity>? metadata}) =>
      ServerDetailsInitial(metadata: metadata ?? this.metadata);
}

class ServerDetailsLoading extends ServerDetailsState {
  ServerDetailsLoading({super.metadata = const []});

  @override
  ServerDetailsLoading copyWith({final List<ServerMetadataEntity>? metadata}) =>
      ServerDetailsLoading(metadata: metadata ?? this.metadata);
}

class ServerDetailsNotReady extends ServerDetailsState {
  ServerDetailsNotReady({super.metadata = const []});

  @override
  ServerDetailsNotReady copyWith({
    final List<ServerMetadataEntity>? metadata,
  }) => ServerDetailsNotReady(metadata: metadata ?? this.metadata);
}

class ServerDetailsUnavailable extends ServerDetailsState {
  ServerDetailsUnavailable({
    required this.isUnsupported,
    super.metadata = const [],
  });

  final bool isUnsupported;

  @override
  List<Object?> get props => [isUnsupported, metadata];

  @override
  ServerDetailsUnavailable copyWith({
    final List<ServerMetadataEntity>? metadata,
  }) => ServerDetailsUnavailable(
    isUnsupported: isUnsupported,
    metadata: metadata ?? this.metadata,
  );
}

class Loaded extends ServerDetailsState {
  Loaded({
    required super.metadata,
    required this.serverTimezone,
    required this.autoUpgradeSettings,
    required this.sshSettings,
  });
  final TimeZoneSettings serverTimezone;
  final AutoUpgradeSettings autoUpgradeSettings;
  final SshSettings sshSettings;

  @override
  List<Object?> get props => [
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
    serverTimezone: serverTimezone ?? this.serverTimezone,
    autoUpgradeSettings: autoUpgradeSettings ?? this.autoUpgradeSettings,
    sshSettings: sshSettings ?? this.sshSettings,
  );
}
