// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disk_volumes.graphql.dart';

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
          model: json['model'] as String,
          name: json['name'] as String,
          root: json['root'] as bool,
          serial: json['serial'] as String,
          totalSpace: json['totalSpace'] as String,
          type: json['type'] as String,
          usedSpace: json['usedSpace'] as String,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$GetServerDiskVolumesQuery$storage$volumesToJson(
        Query$GetServerDiskVolumesQuery$storage$volumes instance) =>
    <String, dynamic>{
      'freeSpace': instance.freeSpace,
      'model': instance.model,
      'name': instance.name,
      'root': instance.root,
      'serial': instance.serial,
      'totalSpace': instance.totalSpace,
      'type': instance.type,
      'usedSpace': instance.usedSpace,
      '__typename': instance.$__typename,
    };

Variables$Mutation$MountVolumeMutation
    _$Variables$Mutation$MountVolumeMutationFromJson(
            Map<String, dynamic> json) =>
        Variables$Mutation$MountVolumeMutation(
          name: json['name'] as String,
        );

Map<String, dynamic> _$Variables$Mutation$MountVolumeMutationToJson(
        Variables$Mutation$MountVolumeMutation instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Mutation$MountVolumeMutation _$Mutation$MountVolumeMutationFromJson(
        Map<String, dynamic> json) =>
    Mutation$MountVolumeMutation(
      mountVolume: Mutation$MountVolumeMutation$mountVolume.fromJson(
          json['mountVolume'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$MountVolumeMutationToJson(
        Mutation$MountVolumeMutation instance) =>
    <String, dynamic>{
      'mountVolume': instance.mountVolume.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$MountVolumeMutation$mountVolume
    _$Mutation$MountVolumeMutation$mountVolumeFromJson(
            Map<String, dynamic> json) =>
        Mutation$MountVolumeMutation$mountVolume(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$MountVolumeMutation$mountVolumeToJson(
        Mutation$MountVolumeMutation$mountVolume instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$ResizeVolumeMutation
    _$Variables$Mutation$ResizeVolumeMutationFromJson(
            Map<String, dynamic> json) =>
        Variables$Mutation$ResizeVolumeMutation(
          name: json['name'] as String,
        );

Map<String, dynamic> _$Variables$Mutation$ResizeVolumeMutationToJson(
        Variables$Mutation$ResizeVolumeMutation instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Mutation$ResizeVolumeMutation _$Mutation$ResizeVolumeMutationFromJson(
        Map<String, dynamic> json) =>
    Mutation$ResizeVolumeMutation(
      resizeVolume: Mutation$ResizeVolumeMutation$resizeVolume.fromJson(
          json['resizeVolume'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$ResizeVolumeMutationToJson(
        Mutation$ResizeVolumeMutation instance) =>
    <String, dynamic>{
      'resizeVolume': instance.resizeVolume.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$ResizeVolumeMutation$resizeVolume
    _$Mutation$ResizeVolumeMutation$resizeVolumeFromJson(
            Map<String, dynamic> json) =>
        Mutation$ResizeVolumeMutation$resizeVolume(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$ResizeVolumeMutation$resizeVolumeToJson(
        Mutation$ResizeVolumeMutation$resizeVolume instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$UnmountVolumeMutation
    _$Variables$Mutation$UnmountVolumeMutationFromJson(
            Map<String, dynamic> json) =>
        Variables$Mutation$UnmountVolumeMutation(
          name: json['name'] as String,
        );

Map<String, dynamic> _$Variables$Mutation$UnmountVolumeMutationToJson(
        Variables$Mutation$UnmountVolumeMutation instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Mutation$UnmountVolumeMutation _$Mutation$UnmountVolumeMutationFromJson(
        Map<String, dynamic> json) =>
    Mutation$UnmountVolumeMutation(
      unmountVolume: Mutation$UnmountVolumeMutation$unmountVolume.fromJson(
          json['unmountVolume'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$UnmountVolumeMutationToJson(
        Mutation$UnmountVolumeMutation instance) =>
    <String, dynamic>{
      'unmountVolume': instance.unmountVolume.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$UnmountVolumeMutation$unmountVolume
    _$Mutation$UnmountVolumeMutation$unmountVolumeFromJson(
            Map<String, dynamic> json) =>
        Mutation$UnmountVolumeMutation$unmountVolume(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$UnmountVolumeMutation$unmountVolumeToJson(
        Mutation$UnmountVolumeMutation$unmountVolume instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };
