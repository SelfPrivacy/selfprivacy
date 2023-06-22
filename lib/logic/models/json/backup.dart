import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';

part 'backup.g.dart';

@JsonSerializable()
class Backup {
  factory Backup.fromJson(final Map<String, dynamic> json) =>
      _$BackupFromJson(json);
  Backup.fromGraphQL(
    final Query$AllBackupSnapshots$backup$allSnapshots snapshot,
  ) : this(
          id: snapshot.id,
          time: snapshot.createdAt,
          serviceId: snapshot.service.id,
          fallbackServiceName: snapshot.service.displayName,
        );

  Backup({
    required this.time,
    required this.id,
    required this.serviceId,
    required this.fallbackServiceName,
  });

  // Time of the backup
  final DateTime time;
  @JsonKey(name: 'short_id')
  final String id;
  final String serviceId;
  final String fallbackServiceName;
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
  factory BackupStatus.fromJson(final Map<String, dynamic> json) =>
      _$BackupStatusFromJson(json);
  BackupStatus({
    required this.status,
    required this.progress,
    required this.errorMessage,
  });

  final BackupStatusEnum status;
  final double progress;
  @JsonKey(name: 'error_message')
  final String? errorMessage;
}
