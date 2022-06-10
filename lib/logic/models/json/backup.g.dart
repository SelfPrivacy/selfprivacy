// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Backup _$BackupFromJson(Map<String, dynamic> json) => Backup(
      time: DateTime.parse(json['time'] as String),
      id: json['short_id'] as String,
    );

BackupStatus _$BackupStatusFromJson(Map<String, dynamic> json) => BackupStatus(
      status: $enumDecode(_$BackupStatusEnumEnumMap, json['status']),
      progress: (json['progress'] as num).toDouble(),
      errorMessage: json['error_message'] as String?,
    );

const _$BackupStatusEnumEnumMap = {
  BackupStatusEnum.noKey: 'NO_KEY',
  BackupStatusEnum.notInitialized: 'NOT_INITIALIZED',
  BackupStatusEnum.initialized: 'INITIALIZED',
  BackupStatusEnum.backingUp: 'BACKING_UP',
  BackupStatusEnum.restoring: 'RESTORING',
  BackupStatusEnum.error: 'ERROR',
  BackupStatusEnum.initializing: 'INITIALIZING',
};
