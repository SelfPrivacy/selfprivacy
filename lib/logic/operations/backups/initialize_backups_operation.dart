import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';
import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/models/initialize_repository_input.dart';
import 'package:selfprivacy/logic/operations/operation_execution.dart';
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider.dart';

enum BackupStorageFailure implements Exception {
  missingEncryptionKey,
  createStorage,
  createApplicationKey,
}

class InitializeBackupsOperation {
  InitializeBackupsOperation({
    required this.repository,
    required this.provider,
    required this.bucketName,
    required this.existingBucket,
    required this.saveBucket,
  });

  final BackupsRepository repository;
  final BackupsProvider provider;
  final String bucketName;
  final BackblazeBucket? existingBucket;
  final Future<void> Function(BackblazeBucket) saveBucket;

  void _requireAttached() {
    if (!repository.commands.isAttached) {
      throw const OperationNotSent();
    }
  }

  Future<ServerMutationResult<BackupConfiguration>> run() async {
    final bucket = await _prepare();
    _requireAttached();
    OperationExecution.current?.recordStep(
      const OperationStep(
        id: 'configure',
        titleKey: 'operations.kind.manageBackups',
        status: OperationStatus.running,
      ),
    );
    final result = await repository.initializeRepository(
      InitializeRepositoryInput(
        provider: BackupsProviderType.backblaze,
        locationId: bucket.bucketId,
        locationName: bucket.bucketName,
        login: bucket.applicationKeyId,
        password: bucket.applicationKey,
      ),
    );
    OperationExecution.current?.recordStep(
      OperationStep.fromMutation(
        id: 'configure',
        titleKey: 'operations.kind.manageBackups',
        result: result,
      ),
    );
    return result;
  }

  Future<BackblazeBucket> _prepare() async {
    _requireAttached();
    final encryptionKey = repository.configValue.data?.encryptionKey;
    if (encryptionKey == null || encryptionKey.isEmpty) {
      OperationExecution.current?.recordCompletion(succeeded: false);
      throw BackupStorageFailure.missingEncryptionKey;
    }
    if (existingBucket case final bucket?) {
      return bucket;
    }
    final storage = await provider.createStorage(bucketName);
    final created = storage.success && storage.data.isNotEmpty;
    OperationExecution.current?.recordCompletion(succeeded: created);
    _requireAttached();
    if (!created) {
      throw BackupStorageFailure.createStorage;
    }
    final key = await provider.createApplicationKey(storage.data);
    final credential = key.data;
    final usable =
        key.success &&
        credential != null &&
        credential.applicationKey.isNotEmpty &&
        credential.applicationKeyId.isNotEmpty;
    OperationExecution.current?.recordCompletion(succeeded: usable);
    _requireAttached();
    if (!usable) {
      throw BackupStorageFailure.createApplicationKey;
    }
    final bucket = BackblazeBucket(
      bucketId: storage.data,
      bucketName: bucketName,
      applicationKey: credential.applicationKey,
      applicationKeyId: credential.applicationKeyId,
      encryptionKey: encryptionKey,
    );
    await saveBucket(bucket);
    _requireAttached();
    return bucket;
  }
}
