import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/disk_volumes.graphql.dart';

part 'server_disk_volume.g.dart';

@JsonSerializable()
class ServerDiskVolume extends Equatable {
  const ServerDiskVolume({
    required this.freeSpace,
    required this.model,
    required this.name,
    required this.root,
    required this.serial,
    required this.totalSpace,
    required this.type,
    required this.usedSpace,
  });

  factory ServerDiskVolume.fromJson(final Map<String, dynamic> json) =>
      _$ServerDiskVolumeFromJson(json);

  factory ServerDiskVolume.fromGraphQL(
    final Query$GetServerDiskVolumes$storage$volumes serverDiskVolume,
  ) => ServerDiskVolume(
    freeSpace: serverDiskVolume.freeSpace,
    model: serverDiskVolume.model,
    name: serverDiskVolume.name,
    root: serverDiskVolume.root,
    serial: serverDiskVolume.serial,
    totalSpace: serverDiskVolume.totalSpace,
    type: serverDiskVolume.type,
    usedSpace: serverDiskVolume.usedSpace,
  );

  final String freeSpace;
  final String? model;
  final String name;
  final bool root;
  final String? serial;
  final String totalSpace;
  final String type;
  final String usedSpace;

  @override
  List<Object?> get props => [
    freeSpace,
    model,
    name,
    root,
    serial,
    totalSpace,
    type,
    usedSpace,
  ];
}
