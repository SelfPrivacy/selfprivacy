import 'dart:convert';

import 'package:hive_ce/hive.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/schema.graphql.dart';

part 'backups_credential.g.dart';

// TODO(inex): Make a constant type.
@HiveType(typeId: 4)
class BackupsCredential {
  BackupsCredential({
    required this.keyId,
    required this.applicationKey,
    required this.provider,
  });

  @HiveField(0)
  final String keyId;

  @HiveField(1)
  final String applicationKey;

  @HiveField(2, defaultValue: BackupsProviderType.backblaze)
  final BackupsProviderType provider;

  String get encodedApiKey => encodedBackblazeKey(keyId, applicationKey);

  @override
  String toString() => '$keyId: $encodedApiKey';
}

String encodedBackblazeKey(final String? keyId, final String? applicationKey) {
  final String apiKey = '$keyId:$applicationKey';
  final String encodedApiKey = base64.encode(utf8.encode(apiKey));
  return encodedApiKey;
}

@HiveType(typeId: 103)
enum BackupsProviderType {
  @HiveField(0)
  none,
  @HiveField(1)
  memory,
  @HiveField(2)
  file,
  @HiveField(3)
  backblaze;

  factory BackupsProviderType.fromGraphQL(final Enum$BackupProvider provider) =>
      switch (provider) {
        Enum$BackupProvider.NONE => none,
        Enum$BackupProvider.MEMORY => memory,
        Enum$BackupProvider.FILE => file,
        Enum$BackupProvider.BACKBLAZE => backblaze,
        Enum$BackupProvider.$unknown => none,
      };

  Enum$BackupProvider toGraphQL() => switch (this) {
    none => Enum$BackupProvider.NONE,
    memory => Enum$BackupProvider.MEMORY,
    file => Enum$BackupProvider.FILE,
    backblaze => Enum$BackupProvider.BACKBLAZE,
  };
}
