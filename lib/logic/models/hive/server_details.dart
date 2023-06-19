import 'package:hive/hive.dart';
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
    this.startTime,
  });

  @HiveField(0)
  final String ip4;

  @HiveField(1)
  final int id;

  @HiveField(3)
  final DateTime? createTime;

  @HiveField(2)
  final DateTime? startTime;

  @HiveField(4)
  final ServerVolume volume;

  @HiveField(5)
  final String apiToken;

  @HiveField(6, defaultValue: ServerProviderType.hetzner)
  final ServerProviderType provider;

  ServerHostingDetails copyWith({final DateTime? startTime}) =>
      ServerHostingDetails(
        startTime: startTime ?? this.startTime,
        createTime: createTime,
        id: id,
        ip4: ip4,
        volume: volume,
        apiToken: apiToken,
        provider: provider,
      );

  @override
  String toString() => id.toString();
}

@HiveType(typeId: 5)
class ServerVolume {
  ServerVolume({
    required this.id,
    required this.name,
    required this.sizeByte,
    required this.serverId,
    required this.linuxDevice,
    this.uuid,
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
      default:
        return unknown;
    }
  }

  String get displayName {
    switch (this) {
      case ServerProviderType.hetzner:
        return 'Hetzner Cloud';
      case ServerProviderType.digitalOcean:
        return 'Digital Ocean';
      default:
        return 'Unknown';
    }
  }
}
