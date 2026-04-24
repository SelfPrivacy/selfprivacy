import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';

class Backup {
  Backup({
    required this.time,
    required this.id,
    required this.serviceId,
    required this.fallbackServiceName,
    required this.reason,
  });

  Backup.fromGraphQL(
    final Query$AllBackupSnapshots$backup$allSnapshots snapshot,
  ) : this(
        id: snapshot.id,
        time: snapshot.createdAt,
        serviceId: snapshot.service.id,
        fallbackServiceName: snapshot.service.displayName,
        reason: snapshot.reason,
      );

  // Time of the backup
  final DateTime time;
  @JsonKey(name: 'short_id')
  final String id;
  final String serviceId;
  final String fallbackServiceName;
  final Enum$BackupReason reason;
}

extension BackupReasonExtension on Enum$BackupReason {
  String get displayName => switch (this) {
    Enum$BackupReason.AUTO => 'backup.snapshot_reasons.auto',
    Enum$BackupReason.EXPLICIT => 'backup.snapshot_reasons.explicit',
    Enum$BackupReason.PRE_RESTORE => 'backup.snapshot_reasons.pre_restore',
    Enum$BackupReason.$unknown => 'backup.snapshot_reasons.unknown',
  };
}

class BackupConfiguration extends Equatable {
  const BackupConfiguration({
    required this.autobackupPeriod,
    required this.encryptionKey,
    required this.isInitialized,
    required this.locationId,
    required this.locationName,
    required this.provider,
    required this.autobackupQuotas,
  });

  BackupConfiguration.fromGraphQL(
    final Query$BackupConfiguration$backup$configuration configuration,
  ) : this(
        // Provided by API as int of minutes
        autobackupPeriod:
            configuration.autobackupPeriod != null
                ? Duration(minutes: configuration.autobackupPeriod!)
                : null,
        encryptionKey: configuration.encryptionKey,
        isInitialized: configuration.isInitialized,
        locationId: configuration.locationId,
        locationName: configuration.locationName,
        provider: BackupsProviderType.fromGraphQL(configuration.provider),
        autobackupQuotas: AutobackupQuotas.fromGraphQL(
          configuration.autobackupQuotas,
        ),
      );

  final Duration? autobackupPeriod;
  final String encryptionKey;
  final bool isInitialized;
  final String? locationId;
  final String? locationName;
  final BackupsProviderType provider;
  final AutobackupQuotas autobackupQuotas;

  @override
  List<Object?> get props => [
    autobackupPeriod,
    encryptionKey,
    isInitialized,
    locationId,
    locationName,
    provider,
    autobackupQuotas,
  ];

  BackupConfiguration copyWith({
    final Duration? autobackupPeriod,
    final String? encryptionKey,
    final bool? isInitialized,
    final String? locationId,
    final String? locationName,
    final BackupsProviderType? provider,
    final AutobackupQuotas? autobackupQuotas,
  }) => BackupConfiguration(
    autobackupPeriod: autobackupPeriod ?? this.autobackupPeriod,
    encryptionKey: encryptionKey ?? this.encryptionKey,
    isInitialized: isInitialized ?? this.isInitialized,
    locationId: locationId ?? this.locationId,
    locationName: locationName ?? this.locationName,
    provider: provider ?? this.provider,
    autobackupQuotas: autobackupQuotas ?? this.autobackupQuotas,
  );
}

class AutobackupQuotas extends Equatable {
  const AutobackupQuotas({
    required this.last,
    required this.daily,
    required this.weekly,
    required this.monthly,
    required this.yearly,
  });
  AutobackupQuotas.fromGraphQL(
    final Query$BackupConfiguration$backup$configuration$autobackupQuotas
    autobackupQuotas,
  ) : this(
        last: autobackupQuotas.last,
        daily: autobackupQuotas.daily,
        weekly: autobackupQuotas.weekly,
        monthly: autobackupQuotas.monthly,
        yearly: autobackupQuotas.yearly,
      );

  final int last;
  final int daily;
  final int weekly;
  final int monthly;
  final int yearly;

  AutobackupQuotas copyWith({
    final int? last,
    final int? daily,
    final int? weekly,
    final int? monthly,
    final int? yearly,
  }) => AutobackupQuotas(
    last: last ?? this.last,
    daily: daily ?? this.daily,
    weekly: weekly ?? this.weekly,
    monthly: monthly ?? this.monthly,
    yearly: yearly ?? this.yearly,
  );

  @override
  List<Object?> get props => [last, daily, weekly, monthly, yearly];
}

enum BackupRestoreStrategy {
  inplace,
  downloadVerifyOverwrite,
  unknown;

  factory BackupRestoreStrategy.fromGraphQL(
    final Enum$RestoreStrategy strategy,
  ) => switch (strategy) {
    Enum$RestoreStrategy.INPLACE => inplace,
    Enum$RestoreStrategy.DOWNLOAD_VERIFY_OVERWRITE => downloadVerifyOverwrite,
    Enum$RestoreStrategy.$unknown => unknown,
  };

  Enum$RestoreStrategy get toGraphQL => switch (this) {
    inplace => Enum$RestoreStrategy.INPLACE,
    downloadVerifyOverwrite => Enum$RestoreStrategy.DOWNLOAD_VERIFY_OVERWRITE,
    unknown => Enum$RestoreStrategy.$unknown,
  };
}
