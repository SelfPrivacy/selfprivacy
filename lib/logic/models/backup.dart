import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';

class Backup {
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

class BackupConfiguration {
  BackupConfiguration.fromGraphQL(
    final Query$BackupConfiguration$backup$configuration configuration,
  ) : this(
          // Provided by API as int of minutes
          autobackupPeriod: configuration.autobackupPeriod != null
              ? Duration(minutes: configuration.autobackupPeriod!)
              : null,
          encryptionKey: configuration.encryptionKey,
          isInitialized: configuration.isInitialized,
          locationId: configuration.locationId,
          locationName: configuration.locationName,
          provider: BackupsProviderType.fromGraphQL(configuration.provider),
        );

  BackupConfiguration({
    required this.autobackupPeriod,
    required this.encryptionKey,
    required this.isInitialized,
    required this.locationId,
    required this.locationName,
    required this.provider,
  });

  final Duration? autobackupPeriod;
  final String encryptionKey;
  final bool isInitialized;
  final String? locationId;
  final String? locationName;
  final BackupsProviderType provider;
}

enum BackupRestoreStrategy {
  inplace,
  downloadVerifyOverwrite,
  unknown;

  factory BackupRestoreStrategy.fromGraphQL(
    final Enum$RestoreStrategy strategy,
  ) =>
      switch (strategy) {
        Enum$RestoreStrategy.INPLACE => inplace,
        Enum$RestoreStrategy.DOWNLOAD_VERIFY_OVERWRITE =>
          downloadVerifyOverwrite,
        Enum$RestoreStrategy.$unknown => unknown,
      };

  Enum$RestoreStrategy get toGraphQL => switch (this) {
        inplace => Enum$RestoreStrategy.INPLACE,
        downloadVerifyOverwrite =>
          Enum$RestoreStrategy.DOWNLOAD_VERIFY_OVERWRITE,
        unknown => Enum$RestoreStrategy.$unknown,
      };
}
