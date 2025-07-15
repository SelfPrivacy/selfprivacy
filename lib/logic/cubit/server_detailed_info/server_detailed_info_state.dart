part of 'server_detailed_info_cubit.dart';

abstract class ServerDetailsState extends ServerInstallationDependendState {
  const ServerDetailsState({required this.metadata});

  final List<ServerMetadataEntity> metadata;

  @override
  List<Object> get props => [metadata];

  ServerDetailsState copyWith({final List<ServerMetadataEntity>? metadata});
}

class ServerDetailsInitial extends ServerDetailsState {
  const ServerDetailsInitial({super.metadata = const []});

  @override
  ServerDetailsInitial copyWith({final List<ServerMetadataEntity>? metadata}) =>
      ServerDetailsInitial(metadata: metadata ?? this.metadata);
}

class ServerDetailsLoading extends ServerDetailsState {
  const ServerDetailsLoading({super.metadata = const []});

  @override
  ServerDetailsLoading copyWith({final List<ServerMetadataEntity>? metadata}) =>
      ServerDetailsLoading(metadata: metadata ?? this.metadata);
}

class ServerDetailsNotReady extends ServerDetailsState {
  const ServerDetailsNotReady({super.metadata = const []});

  @override
  ServerDetailsNotReady copyWith({
    final List<ServerMetadataEntity>? metadata,
  }) => ServerDetailsNotReady(metadata: metadata ?? this.metadata);
}

class Loaded extends ServerDetailsState {
  const Loaded({
    required super.metadata,
    required this.serverTimezone,
    required this.autoUpgradeSettings,
    required this.sshSettings,
  });
  final TimeZoneSettings serverTimezone;
  final AutoUpgradeSettings autoUpgradeSettings;
  final SshSettings sshSettings;

  @override
  List<Object> get props => [
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
