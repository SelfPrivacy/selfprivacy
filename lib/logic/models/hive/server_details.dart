import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';

part 'server_details.g.dart';

@HiveType(typeId: 2)
class ServerHostingDetails {
  ServerHostingDetails({
    required this.ip4,
    required this.id,
    required this.createTime,
    required this.volume,
    required this.apiToken,
    required this.provider,
    this.serverLocation,
    this.serverType,
    this.startTime,
  });

  @HiveField(0)
  final String ip4;

  @HiveField(1)
  final int id;

  // TODO(inex): Check if it is still needed
  @HiveField(2)
  final DateTime? startTime;

  @HiveField(3)
  final DateTime? createTime;

  // TODO(inex): Check if it is still needed
  @HiveField(4)
  final ServerProviderVolume volume;

  @HiveField(5)
  final String apiToken;

  @HiveField(6, defaultValue: ServerProviderType.hetzner)
  final ServerProviderType provider;

  @HiveField(7)
  final String? serverLocation;

  @HiveField(8)
  final String? serverType;

  ServerHostingDetails copyWith({
    final DateTime? startTime,
    final String? serverLocation,
    final String? serverType,
    final String? apiToken,
  }) => ServerHostingDetails(
    startTime: startTime ?? this.startTime,
    serverLocation: serverLocation ?? this.serverLocation,
    serverType: serverType ?? this.serverType,
    apiToken: apiToken ?? this.apiToken,
    createTime: createTime,
    id: id,
    ip4: ip4,
    volume: volume,
    provider: provider,
  );

  @override
  String toString() => id.toString();
}

@HiveType(typeId: 5)
class ServerProviderVolume {
  ServerProviderVolume({
    required this.id,
    required this.name,
    required this.sizeByte,
    required this.serverId,
    required this.linuxDevice,
    this.uuid,
    this.location,
  });

  @HiveField(1)
  int id;
  @HiveField(2)
  String name;
  @HiveField(3, defaultValue: 10737418240) // 10 Gb
  int sizeByte;
  @HiveField(4, defaultValue: null)
  int? serverId;
  @HiveField(5, defaultValue: null)
  String? linuxDevice;
  @HiveField(6, defaultValue: null)
  String? uuid;
  @HiveField(7, defaultValue: null)
  String? location;
}

@HiveType(typeId: 101)
enum ServerProviderType {
  @HiveField(0)
  unknown,
  @HiveField(1)
  hetzner,
  @HiveField(2)
  digitalOcean;

  factory ServerProviderType.fromGraphQL(final Enum$ServerProvider provider) {
    switch (provider) {
      case Enum$ServerProvider.HETZNER:
        return hetzner;
      case Enum$ServerProvider.DIGITALOCEAN:
        return digitalOcean;
      case Enum$ServerProvider.OTHER:
      case Enum$ServerProvider.$unknown:
        return unknown;
    }
  }

  String get displayName => switch (this) {
    digitalOcean => 'Digital Ocean',
    hetzner => 'Hetzner Cloud',
    unknown => 'Unknown',
  };

  String get supportArticle => switch (this) {
    digitalOcean => 'how_digital_ocean',
    hetzner => 'how_hetzner',
    unknown => '',
  };
}

extension ServerProviderTypeIsSpecified on ServerProviderType? {
  bool get isSpecified => this != null && this != ServerProviderType.unknown;
}
