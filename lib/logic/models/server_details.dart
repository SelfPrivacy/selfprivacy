import 'package:hive/hive.dart';

part 'server_details.g.dart';

@HiveType(typeId: 2)
class ServerHostingDetails {
  ServerHostingDetails({
    required this.ip4,
    required this.id,
    required this.createTime,
    required this.dataBase,
    required this.apiToken,
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
  final ServerVolume dataBase;

  @HiveField(5)
  final String apiToken;

  ServerHostingDetails copyWith({DateTime? startTime}) {
    return ServerHostingDetails(
      startTime: startTime ?? this.startTime,
      createTime: createTime,
      id: id,
      ip4: ip4,
      dataBase: dataBase,
      apiToken: apiToken,
    );
  }

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
