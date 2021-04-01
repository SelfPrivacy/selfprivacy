import 'package:hive/hive.dart';

part 'server_details.g.dart';

@HiveType(typeId: 2)
class HetznerServerDetails {
  HetznerServerDetails({
    required this.ip4,
    required this.id,
    required this.createTime,
    required this.dataBase,
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
  final HetznerDataBase dataBase;

  HetznerServerDetails copyWith({DateTime? startTime}) {
    return HetznerServerDetails(
      startTime: startTime ?? this.startTime,
      createTime: createTime,
      id: id,
      ip4: ip4,
      dataBase: dataBase,
    );
  }

  String toString() => id.toString();
}

@HiveType(typeId: 5)
class HetznerDataBase {
  HetznerDataBase({
    required this.id,
    required this.name,
  });

  @HiveField(1)
  int id;
  @HiveField(2)
  String name;
}
