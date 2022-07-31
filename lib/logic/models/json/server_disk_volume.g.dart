// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_disk_volume.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServerDiskVolume _$ServerDiskVolumeFromJson(Map<String, dynamic> json) =>
    ServerDiskVolume(
      freeSpace: json['freeSpace'] as String,
      model: json['model'] as String?,
      name: json['name'] as String,
      root: json['root'] as bool,
      serial: json['serial'] as String?,
      totalSpace: json['totalSpace'] as String,
      type: json['type'] as String,
      usedSpace: json['usedSpace'] as String,
    );

Map<String, dynamic> _$ServerDiskVolumeToJson(ServerDiskVolume instance) =>
    <String, dynamic>{
      'freeSpace': instance.freeSpace,
      'model': instance.model,
      'name': instance.name,
      'root': instance.root,
      'serial': instance.serial,
      'totalSpace': instance.totalSpace,
      'type': instance.type,
      'usedSpace': instance.usedSpace,
    };
