import 'package:json_annotation/json_annotation.dart';

part 'server_disk_volume.g.dart';

@JsonSerializable()
class ServerDiskVolume {
  factory ServerDiskVolume.fromJson(final Map<String, dynamic> json) =>
      _$ServerDiskVolumeFromJson(json);
  ServerDiskVolume({
    required this.freeSpace,
    required this.name,
    required this.root,
    required this.totalSpace,
    required this.usedSpace,
  });

  final String freeSpace;
  final String name;
  final bool root;
  final String totalSpace;
  final String usedSpace;
}
