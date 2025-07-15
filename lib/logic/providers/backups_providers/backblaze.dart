import 'package:selfprivacy/logic/api_maps/rest_maps/backblaze.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/logic/providers/backups_providers/backups_provider.dart';

class ApiAdapter {
  ApiAdapter({final String? token, final String? tokenId})
    : _api = BackblazeApi(
        isWithToken: true,
        token: token ?? '',
        tokenId: tokenId ?? '',
      );

  BackblazeApi api({final bool getInitialized = true}) =>
      getInitialized ? _api : BackblazeApi(isWithToken: false);

  final BackblazeApi _api;
}

class BackblazeBackupsProvider extends BackupsProvider {
  BackblazeBackupsProvider() : _adapter = ApiAdapter();
  BackblazeBackupsProvider.load({final String? token, final String? tokenId})
    : _adapter = ApiAdapter(token: token, tokenId: tokenId);

  final ApiAdapter _adapter;

  @override
  bool get isAuthorized => _adapter.api().isWithToken;

  @override
  BackupsProviderType get type => BackupsProviderType.backblaze;

  @override
  String get howToRegister => 'how_backblaze';

  @override
  Future<GenericResult<bool>> tryInitApiByToken(final String token) async {
    final api = _adapter.api(getInitialized: false);
    final result = await api.isApiTokenValid(token);
    if (!result.data || !result.success) {
      return result;
    }
    return result;
  }

  @override
  Future<GenericResult<String>> createStorage(final String desiredName) async {
    final api = _adapter.api();
    final result = await api.createBucket(desiredName);
    return result;
  }

  @override
  Future<GenericResult<BackupsApplicationKey?>> createApplicationKey(
    final String storageId,
  ) async {
    final api = _adapter.api();
    final result = await api.createKey(storageId);
    if (!result.success) {
      return GenericResult(success: false, data: null, message: result.message);
    }
    return GenericResult(
      success: result.success,
      data: BackupsApplicationKey(
        applicationKeyId: result.data.applicationKeyId,
        applicationKey: result.data.applicationKey,
      ),
    );
  }

  @override
  Future<GenericResult<BackblazeBucket?>> getStorage(
    final BackupsCredential credentials,
    final BackupConfiguration configuration,
  ) async {
    final api = _adapter.api();
    final result = await api.fetchBucket(credentials, configuration);
    return result;
  }
}
