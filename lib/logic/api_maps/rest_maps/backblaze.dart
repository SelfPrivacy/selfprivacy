import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/api_generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_credential.dart';

export 'package:selfprivacy/logic/api_maps/api_generic_result.dart';

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

class BackblazeApi extends ApiMap {
  BackblazeApi({this.hasLogger = false, this.isWithToken = true});

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(baseUrl: rootAddress);
    if (isWithToken) {
      final BackblazeCredential? backblazeCredential =
          getIt<ApiConfigModel>().backblazeCredential;
      final String token = backblazeCredential!.applicationKey;
      options.headers = {'Authorization': 'Basic $token'};
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
    final BackblazeCredential? backblazeCredential =
        getIt<ApiConfigModel>().backblazeCredential;
    if (backblazeCredential == null) {
      throw Exception('Backblaze credential is null');
    }
    final String encodedApiKey = encodedBackblazeKey(
      backblazeCredential.keyId,
      backblazeCredential.applicationKey,
    );
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

  Future<APIGenericResult<bool>> isApiTokenValid(
    final String encodedApiKey,
  ) async {
    final Dio client = await getClient();
    bool isTokenValid = false;
    try {
      final Response response = await client.get(
        'b2_authorize_account',
        options: Options(
          followRedirects: false,
          validateStatus: (final status) =>
              status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Basic $encodedApiKey'},
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        if (response.data['allowed']['capabilities'].contains('listBuckets')) {
          isTokenValid = true;
        }
        isTokenValid = false;
      } else if (response.statusCode == HttpStatus.unauthorized) {
        isTokenValid = false;
      } else {
        throw Exception('code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print(e);
      return APIGenericResult(
        data: false,
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(
      data: isTokenValid,
      success: true,
    );
  }

  // Create bucket
  Future<String> createBucket(final String bucketName) async {
    final BackblazeApiAuth auth = await getAuthorizationToken();
    final BackblazeCredential? backblazeCredential =
        getIt<ApiConfigModel>().backblazeCredential;
    final Dio client = await getClient();
    client.options.baseUrl = auth.apiUrl;
    final Response response = await client.post(
      '$apiPrefix/b2_create_bucket',
      data: {
        'accountId': backblazeCredential!.keyId,
        'bucketName': bucketName,
        'bucketType': 'allPrivate',
        'lifecycleRules': [
          {
            'daysFromHidingToDeleting': 30,
            'daysFromUploadingToHiding': null,
            'fileNamePrefix': ''
          }
        ],
      },
      options: Options(
        headers: {'Authorization': auth.authorizationToken},
      ),
    );
    close(client);
    if (response.statusCode == HttpStatus.ok) {
      return response.data['bucketId'];
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

  // Create a limited capability key with access to the given bucket
  Future<BackblazeApplicationKey> createKey(final String bucketId) async {
    final BackblazeApiAuth auth = await getAuthorizationToken();
    final Dio client = await getClient();
    client.options.baseUrl = auth.apiUrl;
    final Response response = await client.post(
      '$apiPrefix/b2_create_key',
      data: {
        'accountId': getIt<ApiConfigModel>().backblazeCredential!.keyId,
        'bucketId': bucketId,
        'capabilities': ['listBuckets', 'listFiles', 'readFiles', 'writeFiles'],
        'keyName': 'selfprivacy-restricted-server-key',
      },
      options: Options(
        headers: {'Authorization': auth.authorizationToken},
      ),
    );
    close(client);
    if (response.statusCode == HttpStatus.ok) {
      return BackblazeApplicationKey(
        applicationKeyId: response.data['applicationKeyId'],
        applicationKey: response.data['applicationKey'],
      );
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

  @override
  bool hasLogger;

  @override
  bool isWithToken;
}
