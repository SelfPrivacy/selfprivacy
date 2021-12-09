// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Backup _$BackupFromJson(Map<String, dynamic> json) {
  return Backup(
    time: DateTime.parse(json['time'] as String),
    id: json['short_id'] as String,
  );
}

BackupStatus _$BackupStatusFromJson(Map<String, dynamic> json) {
  return BackupStatus(
    status: _$enumDecode(_$BackupStatusEnumEnumMap, json['status']),
    progress: (json['progress'] as num).toDouble(),
    errorMessage: json['error_message'] as String?,
  );
}

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$BackupStatusEnumEnumMap = {
  BackupStatusEnum.noKey: 'NO_KEY',
  BackupStatusEnum.notInitialized: 'NOT_INITIALIZED',
  BackupStatusEnum.initialized: 'INITIALIZED',
  BackupStatusEnum.backingUp: 'BACKING_UP',
  BackupStatusEnum.restoring: 'RESTORING',
  BackupStatusEnum.error: 'ERROR',
  BackupStatusEnum.initializing: 'INITIALIZING',
};
