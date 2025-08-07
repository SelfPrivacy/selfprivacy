// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/backups_credential.dart';
import 'package:selfprivacy/utils/app_logger.dart';

export 'package:selfprivacy/logic/api_maps/generic_result.dart';

class BackblazeApiAuth {
  BackblazeApiAuth({required this.authorizationToken, required this.apiUrl});

  final String authorizationToken;
  final String apiUrl;
}

class BackblazeApplicationKey {
  BackblazeApplicationKey({
    required this.applicationKeyId,
    required this.applicationKey,
  });

  final String applicationKeyId;
  final String applicationKey;
}

class BackblazeApi extends RestApiMap {
  BackblazeApi({
    this.token = '',
    this.tokenId = '',
    this.hasLogger = false,
    this.isWithToken = true,
  }) : assert(
         !isWithToken || token.isNotEmpty && tokenId.isNotEmpty,
         'Backblaze API requires token and tokenId to be set when isWithToken is true.',
       );

  @override
  bool hasLogger;
  @override
  bool isWithToken;

  final String token;
  final String tokenId;

  static final logger = const AppLogger(name: 'backblaze_api_map').log;

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(
      baseUrl: rootAddress,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    if (isWithToken) {
      final encodedApiKey = encodedBackblazeKey(tokenId, token);
      options.headers = {'Authorization': 'Basic $encodedApiKey'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }

    return options;
  }

  @override
  String rootAddress = 'https://api.backblazeb2.com/b2api/v2/';

  String apiPrefix = '/b2api/v2';

  Future<BackblazeApiAuth> getAuthorizationToken() async {
    final Dio client = await getClient();
    if (token.isEmpty || tokenId.isEmpty) {
      throw Exception('Backblaze credential is null');
    }
    final String encodedApiKey = encodedBackblazeKey(tokenId, token);
    final Response response = await client.get(
      'b2_authorize_account',
      options: Options(headers: {'Authorization': 'Basic $encodedApiKey'}),
    );
    if (response.statusCode != 200) {
      throw Exception('code: ${response.statusCode}');
    }
    return BackblazeApiAuth(
      authorizationToken: response.data['authorizationToken'],
      apiUrl: response.data['apiUrl'],
    );
  }

  Future<GenericResult<bool>> isApiTokenValid(
    final String encodedApiKey,
  ) async {
    final Dio client = await getClient();
    bool isTokenValid = false;
    try {
      final Response response = await client.get(
        'b2_authorize_account',
        options: Options(
          followRedirects: false,
          validateStatus:
              (final status) =>
                  status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Basic $encodedApiKey'},
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        isTokenValid = response.data['allowed']['capabilities'].contains(
          'listBuckets',
        );
      } else if (response.statusCode == HttpStatus.unauthorized) {
        isTokenValid = false;
      } else {
        throw Exception('code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      logger('Error in Backblaze API token validation: ${e.message}', error: e);
      return GenericResult(data: false, success: false, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(data: isTokenValid, success: true);
  }

  // Create bucket
  Future<GenericResult<String>> createBucket(final String bucketName) async {
    final BackblazeApiAuth auth = await getAuthorizationToken();
    final Dio client = await getClient();
    client.options.baseUrl = auth.apiUrl;
    final Response response = await client.post(
      '$apiPrefix/b2_create_bucket',
      data: {
        'accountId': tokenId,
        'bucketName': bucketName,
        'bucketType': 'allPrivate',
        'lifecycleRules': [
          {
            'daysFromHidingToDeleting': 30,
            'daysFromUploadingToHiding': null,
            'fileNamePrefix': '',
          },
        ],
      },
      options: Options(headers: {'Authorization': auth.authorizationToken}),
    );
    close(client);
    if (response.statusCode == HttpStatus.ok) {
      return GenericResult(data: response.data['bucketId'], success: true);
    } else {
      return GenericResult(
        data: '',
        success: false,
        message: 'code: ${response.statusCode}, ${response.data}',
      );
    }
  }

  // Create a limited capability key with access to the given bucket
  Future<GenericResult<BackblazeApplicationKey>> createKey(
    final String bucketId,
  ) async {
    final BackblazeApiAuth auth = await getAuthorizationToken();
    final Dio client = await getClient();
    client.options.baseUrl = auth.apiUrl;
    final Response response = await client.post(
      '$apiPrefix/b2_create_key',
      data: {
        'accountId': getIt<ResourcesModel>().backblazeCredential!.keyId,
        'bucketId': bucketId,
        'capabilities': ['listBuckets', 'listFiles', 'readFiles', 'writeFiles'],
        'keyName': 'selfprivacy-restricted-server-key',
      },
      options: Options(headers: {'Authorization': auth.authorizationToken}),
    );
    close(client);
    if (response.statusCode == HttpStatus.ok) {
      return GenericResult(
        success: true,
        data: BackblazeApplicationKey(
          applicationKeyId: response.data['applicationKeyId'],
          applicationKey: response.data['applicationKey'],
        ),
      );
    } else {
      return GenericResult(
        success: false,
        data: BackblazeApplicationKey(applicationKeyId: '', applicationKey: ''),
        message: 'code: ${response.statusCode}, ${response.data}',
      );
    }
  }

  Future<GenericResult<BackblazeBucket?>> fetchBucket(
    final BackupsCredential credentials,
    final BackupConfiguration configuration,
  ) async {
    BackblazeBucket? bucket;
    final BackblazeApiAuth auth = await getAuthorizationToken();
    final Dio client = await getClient();
    client.options.baseUrl = auth.apiUrl;
    final Response response = await client.get(
      '$apiPrefix/b2_list_buckets',
      queryParameters: {
        'accountId': getIt<ResourcesModel>().backblazeCredential!.keyId,
      },
      options: Options(headers: {'Authorization': auth.authorizationToken}),
    );
    close(client);
    if (response.statusCode == HttpStatus.ok) {
      for (final rawBucket in response.data['buckets']) {
        if (rawBucket['bucketId'] == configuration.locationId) {
          bucket = BackblazeBucket(
            bucketId: rawBucket['bucketId'],
            bucketName: rawBucket['bucketName'],
            encryptionKey: configuration.encryptionKey,
            applicationKeyId: '',
            applicationKey: '',
          );
        }
      }
      return GenericResult(success: bucket != null, data: bucket);
    } else {
      return GenericResult(
        success: false,
        data: null,
        message: 'code: ${response.statusCode}, ${response.data}',
      );
    }
  }
}
