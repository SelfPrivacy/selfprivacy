import 'package:hive/hive.dart';

part 'server_details.g.dart';

@HiveType(typeId: 2)
class HetznerServerDetails {
  HetznerServerDetails({
    required this.ip4,
    required this.id,
    required this.createTime,
    this.startTime,
  });

  @HiveField(0)
  final String? ip4;

  @HiveField(1)
  final int? id;

  @HiveField(3)
  final DateTime? createTime;

  @HiveField(2)
  final DateTime? startTime;

  HetznerServerDetails copyWith({DateTime? startTime}) {
    return HetznerServerDetails(
      startTime: startTime ?? this.startTime,
      createTime: createTime,
      id: id,
      ip4: ip4,
    );
  }

  String toString() => id.toString();
}
