// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_disk_volume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerDiskVolume _$ServerDiskVolumeFromJson(Map<String, dynamic> json) =>
    ServerDiskVolume(
      freeSpace: json['freeSpace'] as String,
      name: json['name'] as String,
      root: json['root'] as bool,
      totalSpace: json['totalSpace'] as String,
      usedSpace: json['usedSpace'] as String,
    );

Map<String, dynamic> _$ServerDiskVolumeToJson(ServerDiskVolume instance) =>
    <String, dynamic>{
      'freeSpace': instance.freeSpace,
      'name': instance.name,
      'root': instance.root,
      'totalSpace': instance.totalSpace,
      'usedSpace': instance.usedSpace,
    };
