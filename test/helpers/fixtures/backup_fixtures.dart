import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/json/server_job.dart';

import 'credential_fixtures.dart';
import 'json_fixture.dart';

BackupConfiguration aBackupConfiguration() => BackupConfiguration.fromGraphQL(
  Query$BackupConfiguration.fromJson(
    loadJsonFixture('graphql/domain_reads.json')['BackupConfiguration']
        as Map<String, dynamic>,
  ).backup.configuration,
);

ServerJob aBackupJob() {
  final data =
      loadJsonFixture('graphql/mutation_results.json')['StartBackup']
          as Map<String, dynamic>;
  final backup = data['backup'] as Map<String, dynamic>;
  final mutation = backup['startBackup'] as Map<String, dynamic>;
  return ServerJob.fromGraphQL(
    Fragment$basicApiJobsFields.fromJson(
      mutation['job'] as Map<String, dynamic>,
    ),
  );
}

BackblazeBucket aBackblazeBucket() {
  final config = aBackupConfiguration();
  final credential = aBackupsCredential();
  return BackblazeBucket(
    bucketId: config.locationId!,
    bucketName: config.locationName!,
    applicationKeyId: credential.keyId,
    applicationKey: credential.applicationKey,
    encryptionKey: config.encryptionKey,
  );
}
