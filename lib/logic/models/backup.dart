import 'package:json_annotation/json_annotation.dart';

part 'backup.g.dart';

@JsonSerializable()
class Backup {
  Backup({required this.time, required this.id});

  // Time of the backup
  final DateTime time;
  @JsonKey(name: 'short_id')
  final String id;

  factory Backup.fromJson(Map<String, dynamic> json) => _$BackupFromJson(json);
}

enum BackupStatusEnum {
  @JsonValue('NO_KEY')
  noKey,
  @JsonValue('NOT_INITIALIZED')
  notInitialized,
  @JsonValue('INITIALIZED')
  initialized,
  @JsonValue('BACKING_UP')
  backingUp,
  @JsonValue('RESTORING')
  restoring,
  @JsonValue('ERROR')
  error,
  @JsonValue('INITIALIZING')
  initializing,
}

@JsonSerializable()
class BackupStatus {
  BackupStatus(
      {required this.status,
      required this.progress,
      required this.errorMessage});

  final BackupStatusEnum status;
  final double progress;
  @JsonKey(name: 'error_message')
  final String errorMessage;

  factory BackupStatus.fromJson(Map<String, dynamic> json) =>
      _$BackupStatusFromJson(json);
}
