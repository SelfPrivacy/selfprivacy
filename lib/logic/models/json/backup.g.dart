// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Backup _$BackupFromJson(Map<String, dynamic> json) => Backup(
      time: DateTime.parse(json['time'] as String),
      id: json['short_id'] as String,
    );

Map<String, dynamic> _$BackupToJson(Backup instance) => <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'short_id': instance.id,
    };

BackupStatus _$BackupStatusFromJson(Map<String, dynamic> json) => BackupStatus(
      status: $enumDecode(_$BackupStatusEnumEnumMap, json['status']),
      progress: (json['progress'] as num).toDouble(),
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$BackupStatusToJson(BackupStatus instance) =>
    <String, dynamic>{
      'status': _$BackupStatusEnumEnumMap[instance.status],
      'progress': instance.progress,
      'error_message': instance.errorMessage,
    };

const _$BackupStatusEnumEnumMap = {
  BackupStatusEnum.noKey: 'NO_KEY',
  BackupStatusEnum.notInitialized: 'NOT_INITIALIZED',
  BackupStatusEnum.initialized: 'INITIALIZED',
  BackupStatusEnum.backingUp: 'BACKING_UP',
  BackupStatusEnum.restoring: 'RESTORING',
  BackupStatusEnum.error: 'ERROR',
  BackupStatusEnum.initializing: 'INITIALIZING',
};
