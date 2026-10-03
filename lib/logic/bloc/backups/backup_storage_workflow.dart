import 'package:selfprivacy/logic/connection/repositories/backups_repository.dart';
import 'package:selfprivacy/logic/connection/sync/operation_execution.dart';
import 'package:selfprivacy/logic/connection/sync/operation_queue.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider.dart';

enum BackupStorageFailure implements Exception {
  missingEncryptionKey,
  createStorage,
  createApplicationKey,
}

class BackupStorageWorkflow {
  BackupStorageWorkflow({
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

  Future<BackblazeBucket> prepare() async {
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
