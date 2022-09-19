// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'disk_volumes.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fragment$basicMutationReturnFields _$Fragment$basicMutationReturnFieldsFromJson(
        Map<String, dynamic> json) =>
    Fragment$basicMutationReturnFields(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Fragment$basicMutationReturnFieldsToJson(
        Fragment$basicMutationReturnFields instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Query$GetServerDiskVolumes _$Query$GetServerDiskVolumesFromJson(
        Map<String, dynamic> json) =>
    Query$GetServerDiskVolumes(
      storage: Query$GetServerDiskVolumes$storage.fromJson(
          json['storage'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetServerDiskVolumesToJson(
        Query$GetServerDiskVolumes instance) =>
    <String, dynamic>{
      'storage': instance.storage.toJson(),
      '__typename': instance.$__typename,
    };

Query$GetServerDiskVolumes$storage _$Query$GetServerDiskVolumes$storageFromJson(
        Map<String, dynamic> json) =>
    Query$GetServerDiskVolumes$storage(
      volumes: (json['volumes'] as List<dynamic>)
          .map((e) => Query$GetServerDiskVolumes$storage$volumes.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$GetServerDiskVolumes$storageToJson(
        Query$GetServerDiskVolumes$storage instance) =>
    <String, dynamic>{
      'volumes': instance.volumes.map((e) => e.toJson()).toList(),
      '__typename': instance.$__typename,
    };

Query$GetServerDiskVolumes$storage$volumes
    _$Query$GetServerDiskVolumes$storage$volumesFromJson(
            Map<String, dynamic> json) =>
        Query$GetServerDiskVolumes$storage$volumes(
          freeSpace: json['freeSpace'] as String,
          model: json['model'] as String?,
          name: json['name'] as String,
          root: json['root'] as bool,
          serial: json['serial'] as String?,
          totalSpace: json['totalSpace'] as String,
          type: json['type'] as String,
          usages: (json['usages'] as List<dynamic>)
              .map((e) =>
                  Query$GetServerDiskVolumes$storage$volumes$usages.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
          usedSpace: json['usedSpace'] as String,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$GetServerDiskVolumes$storage$volumesToJson(
        Query$GetServerDiskVolumes$storage$volumes instance) =>
    <String, dynamic>{
      'freeSpace': instance.freeSpace,
      'model': instance.model,
      'name': instance.name,
      'root': instance.root,
      'serial': instance.serial,
      'totalSpace': instance.totalSpace,
      'type': instance.type,
      'usages': instance.usages.map((e) => e.toJson()).toList(),
      'usedSpace': instance.usedSpace,
      '__typename': instance.$__typename,
    };

Query$GetServerDiskVolumes$storage$volumes$usages
    _$Query$GetServerDiskVolumes$storage$volumes$usagesFromJson(
            Map<String, dynamic> json) =>
        Query$GetServerDiskVolumes$storage$volumes$usages(
          title: json['title'] as String,
          usedSpace: json['usedSpace'] as String,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$GetServerDiskVolumes$storage$volumes$usagesToJson(
        Query$GetServerDiskVolumes$storage$volumes$usages instance) =>
    <String, dynamic>{
      'title': instance.title,
      'usedSpace': instance.usedSpace,
      '__typename': instance.$__typename,
    };

Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
    _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsageFromJson(
            Map<String, dynamic> json) =>
        Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage(
          title: json['title'] as String,
          usedSpace: json['usedSpace'] as String,
          $__typename: json['__typename'] as String,
          service: json['service'] == null
              ? null
              : Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
                  .fromJson(json['service'] as Map<String, dynamic>),
        );

Map<String, dynamic>
    _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsageToJson(
            Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage
                instance) =>
        <String, dynamic>{
          'title': instance.title,
          'usedSpace': instance.usedSpace,
          '__typename': instance.$__typename,
          'service': instance.service?.toJson(),
        };

Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
    _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$serviceFromJson(
            Map<String, dynamic> json) =>
        Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service(
          id: json['id'] as String,
          isMovable: json['isMovable'] as bool,
          displayName: json['displayName'] as String,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic>
    _$Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$serviceToJson(
            Query$GetServerDiskVolumes$storage$volumes$usages$$ServiceStorageUsage$service
                instance) =>
        <String, dynamic>{
          'id': instance.id,
          'isMovable': instance.isMovable,
          'displayName': instance.displayName,
          '__typename': instance.$__typename,
        };

Variables$Mutation$MountVolume _$Variables$Mutation$MountVolumeFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$MountVolume(
      name: json['name'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$MountVolumeToJson(
        Variables$Mutation$MountVolume instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Mutation$MountVolume _$Mutation$MountVolumeFromJson(
        Map<String, dynamic> json) =>
    Mutation$MountVolume(
      mountVolume: Mutation$MountVolume$mountVolume.fromJson(
          json['mountVolume'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$MountVolumeToJson(
        Mutation$MountVolume instance) =>
    <String, dynamic>{
      'mountVolume': instance.mountVolume.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$MountVolume$mountVolume _$Mutation$MountVolume$mountVolumeFromJson(
        Map<String, dynamic> json) =>
    Mutation$MountVolume$mountVolume(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$MountVolume$mountVolumeToJson(
        Mutation$MountVolume$mountVolume instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$ResizeVolume _$Variables$Mutation$ResizeVolumeFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$ResizeVolume(
      name: json['name'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$ResizeVolumeToJson(
        Variables$Mutation$ResizeVolume instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Mutation$ResizeVolume _$Mutation$ResizeVolumeFromJson(
        Map<String, dynamic> json) =>
    Mutation$ResizeVolume(
      resizeVolume: Mutation$ResizeVolume$resizeVolume.fromJson(
          json['resizeVolume'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$ResizeVolumeToJson(
        Mutation$ResizeVolume instance) =>
    <String, dynamic>{
      'resizeVolume': instance.resizeVolume.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$ResizeVolume$resizeVolume _$Mutation$ResizeVolume$resizeVolumeFromJson(
        Map<String, dynamic> json) =>
    Mutation$ResizeVolume$resizeVolume(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$ResizeVolume$resizeVolumeToJson(
        Mutation$ResizeVolume$resizeVolume instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$UnmountVolume _$Variables$Mutation$UnmountVolumeFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$UnmountVolume(
      name: json['name'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$UnmountVolumeToJson(
        Variables$Mutation$UnmountVolume instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

Mutation$UnmountVolume _$Mutation$UnmountVolumeFromJson(
        Map<String, dynamic> json) =>
    Mutation$UnmountVolume(
      unmountVolume: Mutation$UnmountVolume$unmountVolume.fromJson(
          json['unmountVolume'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$UnmountVolumeToJson(
        Mutation$UnmountVolume instance) =>
    <String, dynamic>{
      'unmountVolume': instance.unmountVolume.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$UnmountVolume$unmountVolume
    _$Mutation$UnmountVolume$unmountVolumeFromJson(Map<String, dynamic> json) =>
        Mutation$UnmountVolume$unmountVolume(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$UnmountVolume$unmountVolumeToJson(
        Mutation$UnmountVolume$unmountVolume instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$MigrateToBinds _$Variables$Mutation$MigrateToBindsFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$MigrateToBinds(
      input: Input$MigrateToBindsInput.fromJson(
          json['input'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Variables$Mutation$MigrateToBindsToJson(
        Variables$Mutation$MigrateToBinds instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

Mutation$MigrateToBinds _$Mutation$MigrateToBindsFromJson(
        Map<String, dynamic> json) =>
    Mutation$MigrateToBinds(
      migrateToBinds: Mutation$MigrateToBinds$migrateToBinds.fromJson(
          json['migrateToBinds'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$MigrateToBindsToJson(
        Mutation$MigrateToBinds instance) =>
    <String, dynamic>{
      'migrateToBinds': instance.migrateToBinds.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$MigrateToBinds$migrateToBinds
    _$Mutation$MigrateToBinds$migrateToBindsFromJson(
            Map<String, dynamic> json) =>
        Mutation$MigrateToBinds$migrateToBinds(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
          job: json['job'] == null
              ? null
              : Mutation$MigrateToBinds$migrateToBinds$job.fromJson(
                  json['job'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$Mutation$MigrateToBinds$migrateToBindsToJson(
        Mutation$MigrateToBinds$migrateToBinds instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
      'job': instance.job?.toJson(),
    };

Mutation$MigrateToBinds$migrateToBinds$job
    _$Mutation$MigrateToBinds$migrateToBinds$jobFromJson(
            Map<String, dynamic> json) =>
        Mutation$MigrateToBinds$migrateToBinds$job(
          createdAt: dateTimeFromJson(json['createdAt']),
          description: json['description'] as String,
          error: json['error'] as String?,
          finishedAt: _nullable$dateTimeFromJson(json['finishedAt']),
          name: json['name'] as String,
          progress: json['progress'] as int?,
          result: json['result'] as String?,
          status: json['status'] as String,
          statusText: json['statusText'] as String?,
          uid: json['uid'] as String,
          updatedAt: dateTimeFromJson(json['updatedAt']),
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$MigrateToBinds$migrateToBinds$jobToJson(
        Mutation$MigrateToBinds$migrateToBinds$job instance) =>
    <String, dynamic>{
      'createdAt': dateTimeToJson(instance.createdAt),
      'description': instance.description,
      'error': instance.error,
      'finishedAt': _nullable$dateTimeToJson(instance.finishedAt),
      'name': instance.name,
      'progress': instance.progress,
      'result': instance.result,
      'status': instance.status,
      'statusText': instance.statusText,
      'uid': instance.uid,
      'updatedAt': dateTimeToJson(instance.updatedAt),
      '__typename': instance.$__typename,
    };
