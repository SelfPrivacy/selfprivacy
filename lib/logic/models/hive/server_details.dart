import 'package:hive/hive.dart';

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

  @HiveField(6, defaultValue: ServerProvider.hetzner)
  final ServerProvider provider;

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
  });

  @HiveField(1)
  int id;
  @HiveField(2)
  String name;
}

@HiveType(typeId: 101)
enum ServerProvider {
  @HiveField(0)
  unknown,
  @HiveField(1)
  hetzner,
}
