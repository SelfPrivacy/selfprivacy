import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
export 'package:selfprivacy/logic/api_maps/generic_result.dart';

class BackupsApplicationKey {
  BackupsApplicationKey({
    required this.applicationKeyId,
    required this.applicationKey,
  });

  final String applicationKeyId;
  final String applicationKey;
}

abstract class BackupsProvider {
  /// Returns an assigned enum value, respectively to which
  /// provider implements [BackupsProvider] interface.
  BackupsProviderType get type;

  bool get isAuthorized;

  /// Returns a full url to a guide on how to setup
  /// backups provider
  String get howToRegister;

  /// Tries to access an account linked to the provided token.
  ///
  /// To generate a token for your account follow instructions of your
  /// backups provider respectfully.
  Future<GenericResult<bool>> tryInitApiByToken(final String token);

  /// Creates a storage for backups (for example, a bucket)
  /// and returns a storage ID to access it.
  Future<GenericResult<String>> createStorage(final String desiredName);

  /// Creates the credentials to access the backups storage
  /// from the server
  Future<GenericResult<BackupsApplicationKey?>> createApplicationKey(
    final String storageId,
  );

  /// Get the backups storage
  Future<GenericResult<BackblazeBucket?>> getStorage(
    final BackupsCredential credentials,
    final BackupConfiguration configuration,
  );
}
