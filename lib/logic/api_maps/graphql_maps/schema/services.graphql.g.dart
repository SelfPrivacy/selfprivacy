// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services.graphql.dart';

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

Query$AllServices _$Query$AllServicesFromJson(Map<String, dynamic> json) =>
    Query$AllServices(
      services: Query$AllServices$services.fromJson(
          json['services'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$AllServicesToJson(Query$AllServices instance) =>
    <String, dynamic>{
      'services': instance.services.toJson(),
      '__typename': instance.$__typename,
    };

Query$AllServices$services _$Query$AllServices$servicesFromJson(
        Map<String, dynamic> json) =>
    Query$AllServices$services(
      allServices: (json['allServices'] as List<dynamic>)
          .map((e) => Query$AllServices$services$allServices.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Query$AllServices$servicesToJson(
        Query$AllServices$services instance) =>
    <String, dynamic>{
      'allServices': instance.allServices.map((e) => e.toJson()).toList(),
      '__typename': instance.$__typename,
    };

Query$AllServices$services$allServices
    _$Query$AllServices$services$allServicesFromJson(
            Map<String, dynamic> json) =>
        Query$AllServices$services$allServices(
          description: json['description'] as String,
          displayName: json['displayName'] as String,
          dnsRecords: (json['dnsRecords'] as List<dynamic>?)
              ?.map((e) =>
                  Query$AllServices$services$allServices$dnsRecords.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
          id: json['id'] as String,
          isEnabled: json['isEnabled'] as bool,
          isMovable: json['isMovable'] as bool,
          isRequired: json['isRequired'] as bool,
          status: $enumDecode(_$Enum$ServiceStatusEnumEnumMap, json['status'],
              unknownValue: Enum$ServiceStatusEnum.$unknown),
          storageUsage:
              Query$AllServices$services$allServices$storageUsage.fromJson(
                  json['storageUsage'] as Map<String, dynamic>),
          svgIcon: json['svgIcon'] as String,
          url: json['url'] as String?,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$AllServices$services$allServicesToJson(
        Query$AllServices$services$allServices instance) =>
    <String, dynamic>{
      'description': instance.description,
      'displayName': instance.displayName,
      'dnsRecords': instance.dnsRecords?.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'isEnabled': instance.isEnabled,
      'isMovable': instance.isMovable,
      'isRequired': instance.isRequired,
      'status': _$Enum$ServiceStatusEnumEnumMap[instance.status],
      'storageUsage': instance.storageUsage.toJson(),
      'svgIcon': instance.svgIcon,
      'url': instance.url,
      '__typename': instance.$__typename,
    };

const _$Enum$ServiceStatusEnumEnumMap = {
  Enum$ServiceStatusEnum.ACTIVATING: 'ACTIVATING',
  Enum$ServiceStatusEnum.ACTIVE: 'ACTIVE',
  Enum$ServiceStatusEnum.DEACTIVATING: 'DEACTIVATING',
  Enum$ServiceStatusEnum.FAILED: 'FAILED',
  Enum$ServiceStatusEnum.INACTIVE: 'INACTIVE',
  Enum$ServiceStatusEnum.OFF: 'OFF',
  Enum$ServiceStatusEnum.RELOADING: 'RELOADING',
  Enum$ServiceStatusEnum.$unknown: r'$unknown',
};

Query$AllServices$services$allServices$dnsRecords
    _$Query$AllServices$services$allServices$dnsRecordsFromJson(
            Map<String, dynamic> json) =>
        Query$AllServices$services$allServices$dnsRecords(
          content: json['content'] as String,
          name: json['name'] as String,
          priority: json['priority'] as int?,
          recordType: json['recordType'] as String,
          ttl: json['ttl'] as int,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Query$AllServices$services$allServices$dnsRecordsToJson(
        Query$AllServices$services$allServices$dnsRecords instance) =>
    <String, dynamic>{
      'content': instance.content,
      'name': instance.name,
      'priority': instance.priority,
      'recordType': instance.recordType,
      'ttl': instance.ttl,
      '__typename': instance.$__typename,
    };

Query$AllServices$services$allServices$storageUsage
    _$Query$AllServices$services$allServices$storageUsageFromJson(
            Map<String, dynamic> json) =>
        Query$AllServices$services$allServices$storageUsage(
          title: json['title'] as String,
          usedSpace: json['usedSpace'] as String,
          volume: json['volume'] == null
              ? null
              : Query$AllServices$services$allServices$storageUsage$volume
                  .fromJson(json['volume'] as Map<String, dynamic>),
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic>
    _$Query$AllServices$services$allServices$storageUsageToJson(
            Query$AllServices$services$allServices$storageUsage instance) =>
        <String, dynamic>{
          'title': instance.title,
          'usedSpace': instance.usedSpace,
          'volume': instance.volume?.toJson(),
          '__typename': instance.$__typename,
        };

Query$AllServices$services$allServices$storageUsage$volume
    _$Query$AllServices$services$allServices$storageUsage$volumeFromJson(
            Map<String, dynamic> json) =>
        Query$AllServices$services$allServices$storageUsage$volume(
          name: json['name'] as String,
          $__typename: json['__typename'] as String,
        );

Map<String,
    dynamic> _$Query$AllServices$services$allServices$storageUsage$volumeToJson(
        Query$AllServices$services$allServices$storageUsage$volume instance) =>
    <String, dynamic>{
      'name': instance.name,
      '__typename': instance.$__typename,
    };

Variables$Mutation$EnableService _$Variables$Mutation$EnableServiceFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$EnableService(
      serviceId: json['serviceId'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$EnableServiceToJson(
        Variables$Mutation$EnableService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
    };

Mutation$EnableService _$Mutation$EnableServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$EnableService(
      enableService: Mutation$EnableService$enableService.fromJson(
          json['enableService'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$EnableServiceToJson(
        Mutation$EnableService instance) =>
    <String, dynamic>{
      'enableService': instance.enableService.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$EnableService$enableService
    _$Mutation$EnableService$enableServiceFromJson(Map<String, dynamic> json) =>
        Mutation$EnableService$enableService(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$EnableService$enableServiceToJson(
        Mutation$EnableService$enableService instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$DisableService _$Variables$Mutation$DisableServiceFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$DisableService(
      serviceId: json['serviceId'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$DisableServiceToJson(
        Variables$Mutation$DisableService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
    };

Mutation$DisableService _$Mutation$DisableServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$DisableService(
      disableService: Mutation$DisableService$disableService.fromJson(
          json['disableService'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$DisableServiceToJson(
        Mutation$DisableService instance) =>
    <String, dynamic>{
      'disableService': instance.disableService.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$DisableService$disableService
    _$Mutation$DisableService$disableServiceFromJson(
            Map<String, dynamic> json) =>
        Mutation$DisableService$disableService(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$DisableService$disableServiceToJson(
        Mutation$DisableService$disableService instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$StopService _$Variables$Mutation$StopServiceFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$StopService(
      serviceId: json['serviceId'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$StopServiceToJson(
        Variables$Mutation$StopService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
    };

Mutation$StopService _$Mutation$StopServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$StopService(
      stopService: Mutation$StopService$stopService.fromJson(
          json['stopService'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$StopServiceToJson(
        Mutation$StopService instance) =>
    <String, dynamic>{
      'stopService': instance.stopService.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$StopService$stopService _$Mutation$StopService$stopServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$StopService$stopService(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$StopService$stopServiceToJson(
        Mutation$StopService$stopService instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$StartService _$Variables$Mutation$StartServiceFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$StartService(
      serviceId: json['serviceId'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$StartServiceToJson(
        Variables$Mutation$StartService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
    };

Mutation$StartService _$Mutation$StartServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$StartService(
      startService: Mutation$StartService$startService.fromJson(
          json['startService'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$StartServiceToJson(
        Mutation$StartService instance) =>
    <String, dynamic>{
      'startService': instance.startService.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$StartService$startService _$Mutation$StartService$startServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$StartService$startService(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$StartService$startServiceToJson(
        Mutation$StartService$startService instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$RestartService _$Variables$Mutation$RestartServiceFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$RestartService(
      serviceId: json['serviceId'] as String,
    );

Map<String, dynamic> _$Variables$Mutation$RestartServiceToJson(
        Variables$Mutation$RestartService instance) =>
    <String, dynamic>{
      'serviceId': instance.serviceId,
    };

Mutation$RestartService _$Mutation$RestartServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$RestartService(
      restartService: Mutation$RestartService$restartService.fromJson(
          json['restartService'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$RestartServiceToJson(
        Mutation$RestartService instance) =>
    <String, dynamic>{
      'restartService': instance.restartService.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$RestartService$restartService
    _$Mutation$RestartService$restartServiceFromJson(
            Map<String, dynamic> json) =>
        Mutation$RestartService$restartService(
          code: json['code'] as int,
          message: json['message'] as String,
          success: json['success'] as bool,
          $__typename: json['__typename'] as String,
        );

Map<String, dynamic> _$Mutation$RestartService$restartServiceToJson(
        Mutation$RestartService$restartService instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
    };

Variables$Mutation$MoveService _$Variables$Mutation$MoveServiceFromJson(
        Map<String, dynamic> json) =>
    Variables$Mutation$MoveService(
      input: Input$MoveServiceInput.fromJson(
          json['input'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Variables$Mutation$MoveServiceToJson(
        Variables$Mutation$MoveService instance) =>
    <String, dynamic>{
      'input': instance.input.toJson(),
    };

Mutation$MoveService _$Mutation$MoveServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$MoveService(
      moveService: Mutation$MoveService$moveService.fromJson(
          json['moveService'] as Map<String, dynamic>),
      $__typename: json['__typename'] as String,
    );

Map<String, dynamic> _$Mutation$MoveServiceToJson(
        Mutation$MoveService instance) =>
    <String, dynamic>{
      'moveService': instance.moveService.toJson(),
      '__typename': instance.$__typename,
    };

Mutation$MoveService$moveService _$Mutation$MoveService$moveServiceFromJson(
        Map<String, dynamic> json) =>
    Mutation$MoveService$moveService(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      $__typename: json['__typename'] as String,
      job: json['job'] == null
          ? null
          : Mutation$MoveService$moveService$job.fromJson(
              json['job'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Mutation$MoveService$moveServiceToJson(
        Mutation$MoveService$moveService instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      '__typename': instance.$__typename,
      'job': instance.job?.toJson(),
    };

Mutation$MoveService$moveService$job
    _$Mutation$MoveService$moveService$jobFromJson(Map<String, dynamic> json) =>
        Mutation$MoveService$moveService$job(
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

Map<String, dynamic> _$Mutation$MoveService$moveService$jobToJson(
        Mutation$MoveService$moveService$job instance) =>
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
