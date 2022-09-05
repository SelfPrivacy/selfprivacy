import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/json/backup.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

class ApiResponse<D> {
  ApiResponse({
    required this.statusCode,
    required this.data,
    this.errorMessage,
  });
  final int statusCode;
  final String? errorMessage;
  final D data;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;
}

class ServerApi extends ApiMap {
  ServerApi({
    this.hasLogger = false,
    this.isWithToken = true,
    this.overrideDomain,
    this.customToken,
  });
  @override
  bool hasLogger;
  @override
  bool isWithToken;
  String? overrideDomain;
  String? customToken;

  @override
  BaseOptions get options {
    BaseOptions options = BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );

    if (isWithToken) {
      final ServerDomain? serverDomain = getIt<ApiConfigModel>().serverDomain;
      final String domainName = serverDomain!.domainName;
      final String? apiToken = getIt<ApiConfigModel>().serverDetails?.apiToken;

      options = BaseOptions(
        baseUrl: 'https://api.$domainName',
        connectTimeout: 10000,
        receiveTimeout: 10000,
        headers: {
          'Authorization': 'Bearer $apiToken',
        },
      );
    }

    if (overrideDomain != null) {
      options = BaseOptions(
        baseUrl: 'https://api.$overrideDomain',
        connectTimeout: 10000,
        receiveTimeout: 10000,
        headers: customToken != null
            ? {'Authorization': 'Bearer $customToken'}
            : null,
      );
    }

    return options;
  }

  Future<String?> getApiVersion() async {
    Response response;

    final Dio client = await getClient();
    String? apiVersion;

    try {
      response = await client.get('/api/version');
      apiVersion = response.data['version'];
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
    return apiVersion;
  }

  Future<bool> isHttpServerWorking() async {
    bool res = false;
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.get('/services/status');
      res = response.statusCode == HttpStatus.ok;
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }
    return res;
  }

  Future<ApiResponse<User>> createUser(final User user) async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.post(
        '/users',
        data: {
          'username': user.login,
          'password': user.password,
        },
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.error.toString(),
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: User(
          login: user.login,
          type: UserType.normal,
          password: user.password,
          isFoundOnServer: false,
        ),
      );
    } finally {
      close(client);
    }

    bool isFoundOnServer = false;
    int code = 0;

    final bool isUserCreated = (response.statusCode != null) &&
        (response.statusCode == HttpStatus.created);

    if (isUserCreated) {
      isFoundOnServer = true;
      code = response.statusCode!;
    } else {
      isFoundOnServer = false;
      code = HttpStatus.notAcceptable;
    }

    return ApiResponse(
      statusCode: code,
      data: User(
        login: user.login,
        type: UserType.normal,
        password: user.password,
        isFoundOnServer: isFoundOnServer,
      ),
    );
  }

  Future<ApiResponse<List<String>>> getUsersList({
    final withMainUser = false,
  }) async {
    final List<String> res = [];
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.get(
        '/users',
        queryParameters: withMainUser ? {'withMainUser': 'true'} : null,
      );
      for (final user in response.data) {
        res.add(user.toString());
      }
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: [],
      );
    } catch (e) {
      print(e);
      return ApiResponse(
        errorMessage: e.toString(),
        statusCode: HttpStatus.internalServerError,
        data: [],
      );
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
      statusCode: code,
      data: res,
    );
  }

  Future<ApiResponse<void>> addUserSshKey(
    final User user,
    final String sshKey,
  ) async {
    late Response response;

    final Dio client = await getClient();
    try {
      response = await client.post(
        '/services/ssh/keys/${user.login}',
        data: {
          'public_key': sshKey,
        },
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse<void>(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: null,
      );
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse<void>(
      statusCode: code,
      data: null,
    );
  }

  Future<ApiResponse<void>> addRootSshKey(final String ssh) async {
    late Response response;

    final Dio client = await getClient();
    try {
      response = await client.put(
        '/services/ssh/key/send',
        data: {'public_key': ssh},
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse<void>(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: null,
      );
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse<void>(
      statusCode: code,
      data: null,
    );
  }

  Future<ApiResponse<List<String>>> getUserSshKeys(final User user) async {
    List<String> res;
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.get('/services/ssh/keys/${user.login}');
      res = (response.data as List<dynamic>)
          .map((final e) => e as String)
          .toList();
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse<List<String>>(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: [],
      );
    } catch (e) {
      return ApiResponse<List<String>>(
        errorMessage: e.toString(),
        statusCode: HttpStatus.internalServerError,
        data: [],
      );
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse<List<String>>(
      statusCode: code,
      data: res,
      errorMessage: response.data is List
          ? null
          : response.data?.containsKey('error') ?? false
              ? response.data['error']
              : null,
    );
  }

  Future<ApiResponse<void>> deleteUserSshKey(
    final User user,
    final String sshKey,
  ) async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.delete(
        '/services/ssh/keys/${user.login}',
        data: {'public_key': sshKey},
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse<void>(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: null,
      );
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse<void>(
      statusCode: code,
      data: null,
      errorMessage: response.data?.containsKey('error') ?? false
          ? response.data['error']
          : null,
    );
  }

  Future<bool> deleteUser(final User user) async {
    bool res = false;
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.delete('/users/${user.login}');
      res = response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.notFound;
    } on DioError catch (e) {
      print(e.message);
      res = false;
    } finally {
      close(client);
    }
    return res;
  }

  @override
  String get rootAddress =>
      throw UnimplementedError('not used in with implementation');

  Future<bool> apply() async {
    bool res = false;
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.get('/system/configuration/apply');
      res = response.statusCode == HttpStatus.ok;
    } on DioError catch (e) {
      print(e.message);
      res = false;
    } finally {
      close(client);
    }
    return res;
  }

  Future<void> switchService(
    final ServiceTypes type,
    final bool needToTurnOn,
  ) async {
    final Dio client = await getClient();
    try {
      client.post(
        '/services/${type.url}/${needToTurnOn ? 'enable' : 'disable'}',
      );
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
  }

  Future<Map<ServiceTypes, bool>> servicesPowerCheck() async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.get('/services/status');
    } on DioError catch (e) {
      print(e.message);
      return {};
    } finally {
      close(client);
    }

    return {
      ServiceTypes.bitwarden: response.data['bitwarden'] == 0,
      ServiceTypes.gitea: response.data['gitea'] == 0,
      ServiceTypes.nextcloud: response.data['nextcloud'] == 0,
      ServiceTypes.ocserv: response.data['ocserv'] == 0,
      ServiceTypes.pleroma: response.data['pleroma'] == 0,
    };
  }

  Future<void> uploadBackblazeConfig(final BackblazeBucket bucket) async {
    final Dio client = await getClient();
    try {
      client.put(
        '/services/restic/backblaze/config',
        data: {
          'accountId': bucket.applicationKeyId,
          'accountKey': bucket.applicationKey,
          'bucket': bucket.bucketName,
        },
      );
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
  }

  Future<void> startBackup() async {
    final Dio client = await getClient();
    try {
      client.put('/services/restic/backup/create');
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
  }

  Future<List<Backup>> getBackups() async {
    Response response;
    List<Backup> backups = [];

    final Dio client = await getClient();
    try {
      response = await client.get('/services/restic/backup/list');
      backups =
          response.data.map<Backup>((final e) => Backup.fromJson(e)).toList();
    } on DioError catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }
    return backups;
  }

  Future<BackupStatus> getBackupStatus() async {
    Response response;
    BackupStatus status = BackupStatus(
      status: BackupStatusEnum.error,
      errorMessage: 'Network error',
      progress: 0,
    );

    final Dio client = await getClient();
    try {
      response = await client.get('/services/restic/backup/status');
      status = BackupStatus.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
    return status;
  }

  Future<void> forceBackupListReload() async {
    final Dio client = await getClient();
    try {
      client.get('/services/restic/backup/reload');
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
  }

  Future<void> restoreBackup(final String backupId) async {
    final Dio client = await getClient();
    try {
      client.put(
        '/services/restic/backup/restore',
        data: {'backupId': backupId},
      );
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
  }

  Future<bool> pullConfigurationUpdate() async {
    Response response;
    bool result = false;

    final Dio client = await getClient();
    try {
      response = await client.get('/system/configuration/pull');
      result = (response.statusCode != null)
          ? (response.statusCode == HttpStatus.ok)
          : false;
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
    return result;
  }

  Future<bool> reboot() async {
    Response response;
    bool result = false;

    final Dio client = await getClient();
    try {
      response = await client.get('/system/reboot');
      result = (response.statusCode != null)
          ? (response.statusCode == HttpStatus.ok)
          : false;
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
    return result;
  }

  Future<bool> upgrade() async {
    Response response;
    bool result = false;

    final Dio client = await getClient();
    try {
      response = await client.get('/system/configuration/upgrade');
      result = (response.statusCode != null)
          ? (response.statusCode == HttpStatus.ok)
          : false;
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
    return result;
  }

  Future<AutoUpgradeSettings> getAutoUpgradeSettings() async {
    Response response;
    AutoUpgradeSettings settings = const AutoUpgradeSettings(
      enable: false,
      allowReboot: false,
    );

    final Dio client = await getClient();
    try {
      response = await client.get('/system/configuration/autoUpgrade');
      if (response.data != null) {
        settings = AutoUpgradeSettings.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
    return settings;
  }

  Future<void> updateAutoUpgradeSettings(
    final AutoUpgradeSettings settings,
  ) async {
    final Dio client = await getClient();
    try {
      await client.put(
        '/system/configuration/autoUpgrade',
        data: settings.toJson(),
      );
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
  }

  Future<TimeZoneSettings> getServerTimezone() async {
    // I am not sure how to initialize TimeZoneSettings with default value...
    final Dio client = await getClient();
    final Response response =
        await client.get('/system/configuration/timezone');
    close(client);

    return TimeZoneSettings.fromString(response.data);
  }

  Future<void> updateServerTimezone(final TimeZoneSettings settings) async {
    final Dio client = await getClient();
    try {
      await client.put(
        '/system/configuration/timezone',
        data: settings.toString(),
      );
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
  }

  Future<String?> getDkim() async {
    Response response;
    String? dkim;
    final Dio client = await getClient();
    try {
      response = await client.get('/services/mailserver/dkim');
      final Codec<String, String> base64toString = utf8.fuse(base64);
      dkim = base64toString
          .decode(response.data)
          .split('(')[1]
          .split(')')[0]
          .replaceAll('"', '');
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }

    return dkim;
  }

  Future<ApiResponse<RecoveryKeyStatus?>> getRecoveryTokenStatus() async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.get('/auth/recovery_token');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: const RecoveryKeyStatus(exists: false, valid: false),
      );
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
      statusCode: code,
      data: response.data != null
          ? RecoveryKeyStatus.fromJson(response.data)
          : null,
    );
  }

  Future<ApiResponse<String>> generateRecoveryToken(
    final DateTime? expiration,
    final int? uses,
  ) async {
    Response response;

    final Dio client = await getClient();
    final Map data = {};
    if (expiration != null) {
      data['expiration'] = '${expiration.toIso8601String()}Z';
      print(data['expiration']);
    }
    if (uses != null) {
      data['uses'] = uses;
    }
    try {
      response = await client.post(
        '/auth/recovery_token',
        data: data,
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: '',
      );
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
      statusCode: code,
      data: response.data != null ? response.data['token'] : '',
    );
  }

  Future<ApiResponse<String>> useRecoveryToken(final DeviceToken token) async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.post(
        '/auth/recovery_token/use',
        data: {
          'token': token.token,
          'device': token.device,
        },
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: '',
      );
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
      statusCode: code,
      data: response.data != null ? response.data['token'] : '',
    );
  }

  Future<ApiResponse<String>> authorizeDevice(final DeviceToken token) async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.post(
        '/auth/new_device/authorize',
        data: {
          'token': token.token,
          'device': token.device,
        },
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: '',
      );
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(statusCode: code, data: response.data['token'] ?? '');
  }

  Future<ApiResponse<String>> createDeviceToken() async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.post('/auth/new_device');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: '',
      );
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
      statusCode: code,
      data: response.data != null ? response.data['token'] : '',
    );
  }

  Future<ApiResponse<String>> deleteDeviceToken() async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.delete('/auth/new_device');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: '',
      );
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(statusCode: code, data: response.data ?? '');
  }

  Future<ApiResponse<List<ApiToken>>> getApiTokens() async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.get('/auth/tokens');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: [],
      );
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
      statusCode: code,
      data: (response.data != null)
          ? response.data
              .map<ApiToken>((final e) => ApiToken.fromJson(e))
              .toList()
          : [],
    );
  }

  Future<ApiResponse<String>> refreshCurrentApiToken() async {
    Response response;

    final Dio client = await getClient();
    try {
      response = await client.post('/auth/tokens');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: '',
      );
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
      statusCode: code,
      data: response.data != null ? response.data['token'] : '',
    );
  }

  Future<ApiResponse<void>> deleteApiToken(final String device) async {
    Response response;
    final Dio client = await getClient();
    try {
      response = await client.delete(
        '/auth/tokens',
        data: {
          'token_name': device,
        },
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
        errorMessage: e.message,
        statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
        data: null,
      );
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;
    return ApiResponse(statusCode: code, data: null);
  }
}

extension UrlServerExt on ServiceTypes {
  String get url {
    switch (this) {
      // case ServiceTypes.mail:
      //   return ''; // cannot be switch off
      // case ServiceTypes.messenger:
      //   return ''; // external service
      // case ServiceTypes.video:
      // return ''; // jitsi meet not working
      case ServiceTypes.bitwarden:
        return 'bitwarden';
      case ServiceTypes.nextcloud:
        return 'nextcloud';
      case ServiceTypes.pleroma:
        return 'pleroma';
      case ServiceTypes.gitea:
        return 'gitea';
      case ServiceTypes.ocserv:
        return 'ocserv';
      default:
        throw Exception('wrong state');
    }
  }
}
