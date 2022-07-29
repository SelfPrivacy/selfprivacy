// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_server_disk_volumes.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Query$GetServerDiskVolumesQuery _$Query$GetServerDiskVolumesQueryFromJson(
        Map<String, dynamic> json) =>
    Query$GetServerDiskVolumesQuery(
      storage: Query$GetServerDiskVolumesQuery$storage.fromJson(
          json['storage'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetServerDiskVolumesQueryToJson(
        Query$GetServerDiskVolumesQuery instance) =>
    <String, dynamic>{
      'storage': instance.storage.toJson(),
      '__typename': instance.$__typename,
    };

Query$GetServerDiskVolumesQuery$storage
    _$Query$GetServerDiskVolumesQuery$storageFromJson(
            Map<String, dynamic> json) =>
        Query$GetServerDiskVolumesQuery$storage(
          volumes: (json['volumes'] as List<dynamic>)
              .map((e) =>
                  Query$GetServerDiskVolumesQuery$storage$volumes.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$GetServerDiskVolumesQuery$storageToJson(
        Query$GetServerDiskVolumesQuery$storage instance) =>
    <String, dynamic>{
      'volumes': instance.volumes.map((e) => e.toJson()).toList(),
      '__typename': instance.$__typename,
    };

Query$GetServerDiskVolumesQuery$storage$volumes
    _$Query$GetServerDiskVolumesQuery$storage$volumesFromJson(
            Map<String, dynamic> json) =>
        Query$GetServerDiskVolumesQuery$storage$volumes(
          freeSpace: json['freeSpace'] as String,
          name: json['name'] as String,
          root: json['root'] as bool,
          totalSpace: json['totalSpace'] as String,
          usedSpace: json['usedSpace'] as String,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$GetServerDiskVolumesQuery$storage$volumesToJson(
        Query$GetServerDiskVolumesQuery$storage$volumes instance) =>
    <String, dynamic>{
      'freeSpace': instance.freeSpace,
      'name': instance.name,
      'root': instance.root,
      'totalSpace': instance.totalSpace,
      'usedSpace': instance.usedSpace,
      '__typename': instance.$__typename,
    };
