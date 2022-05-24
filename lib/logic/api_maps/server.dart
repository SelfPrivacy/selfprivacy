import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/hive/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/api_token.dart';
import 'package:selfprivacy/logic/models/json/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/json/backup.dart';
import 'package:selfprivacy/logic/models/json/device_token.dart';
import 'package:selfprivacy/logic/models/json/recovery_token_status.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

import 'api_map.dart';

class ApiResponse<D> {
  final int statusCode;
  final String? errorMessage;
  final D data;

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  ApiResponse({
    required this.statusCode,
    this.errorMessage,
    required this.data,
  });
}

class ServerApi extends ApiMap {
  @override
  bool hasLogger;
  @override
  bool isWithToken;
  String? overrideDomain;
  String? customToken;

  ServerApi(
      {this.hasLogger = false,
      this.isWithToken = true,
      this.overrideDomain,
      this.customToken});

  BaseOptions get options {
    var options = BaseOptions();

    if (isWithToken) {
      var cloudFlareDomain = getIt<ApiConfigModel>().serverDomain;
      var domainName = cloudFlareDomain!.domainName;
      var apiToken = getIt<ApiConfigModel>().serverDetails?.apiToken;

      options = BaseOptions(baseUrl: 'https://api.$domainName', headers: {
        'Authorization': 'Bearer $apiToken',
      });
    }

    if (overrideDomain != null) {
      options = BaseOptions(
        baseUrl: 'https://api.$overrideDomain',
        headers: customToken != null
            ? {'Authorization': 'Bearer $customToken'}
            : null,
      );
    }

    return options;
  }

  Future<String?> getApiVersion() async {
    Response response;

    var client = await getClient();
    String? apiVersion = null;

    try {
      response = await client.get('/api/version');
      apiVersion = response.data['version'];
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
      return apiVersion;
    }
  }

  Future<bool> isHttpServerWorking() async {
    bool res = false;
    Response response;

    var client = await getClient();
    try {
      response = await client.get('/services/status');
      res = response.statusCode == HttpStatus.ok;
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
      return res;
    }
  }

  Future<ApiResponse<User>> createUser(User user) async {
    Response response;

    var client = await getClient();
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
        password: user.password,
        isFoundOnServer: isFoundOnServer,
      ),
    );
  }

  Future<ApiResponse<List<String>>> getUsersList({withMainUser = false}) async {
    List<String> res = [];
    Response response;

    var client = await getClient();
    try {
      response = await client.get('/users',
          queryParameters: withMainUser ? {'withMainUser': 'true'} : null);
      for (var user in response.data) {
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

  Future<ApiResponse<void>> addUserSshKey(User user, String sshKey) async {
    late Response response;

    var client = await getClient();
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

  Future<ApiResponse<void>> addRootSshKey(String ssh) async {
    late Response response;

    var client = await getClient();
    try {
      response = await client.put(
        '/services/ssh/key/send',
        data: {"public_key": ssh},
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

  Future<ApiResponse<List<String>>> getUserSshKeys(User user) async {
    List<String> res;
    Response response;

    var client = await getClient();
    try {
      response = await client.get('/services/ssh/keys/${user.login}');
      res = (response.data as List<dynamic>).map((e) => e as String).toList();
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

  Future<ApiResponse<void>> deleteUserSshKey(User user, String sshKey) async {
    Response response;

    var client = await getClient();
    try {
      response = await client.delete(
        '/services/ssh/keys/${user.login}',
        data: {"public_key": sshKey},
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

  Future<bool> deleteUser(User user) async {
    bool res = false;
    Response response;

    var client = await getClient();
    try {
      response = await client.delete('/users/${user.login}');
      res = response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.notFound;
    } on DioError catch (e) {
      print(e.message);
      res = false;
    } finally {
      close(client);
      return res;
    }
  }

  String get rootAddress =>
      throw UnimplementedError('not used in with implementation');

  Future<bool> apply() async {
    bool res = false;
    Response response;

    var client = await getClient();
    try {
      response = await client.get('/system/configuration/apply');
      res = response.statusCode == HttpStatus.ok;
    } on DioError catch (e) {
      print(e.message);
      res = false;
    } finally {
      close(client);
      return res;
    }
  }

  Future<void> switchService(ServiceTypes type, bool needToTurnOn) async {
    var client = await getClient();
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

    var client = await getClient();
    try {
      response = await client.get('/services/status');
    } on DioError catch (e) {
      print(e.message);
      return {};
    } finally {
      close(client);
    }

    return {
      ServiceTypes.passwordManager: response.data['bitwarden'] == 0,
      ServiceTypes.git: response.data['gitea'] == 0,
      ServiceTypes.cloud: response.data['nextcloud'] == 0,
      ServiceTypes.vpn: response.data['ocserv'] == 0,
      ServiceTypes.socialNetwork: response.data['pleroma'] == 0,
    };
  }

  Future<void> uploadBackblazeConfig(BackblazeBucket bucket) async {
    var client = await getClient();
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
    var client = await getClient();
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

    var client = await getClient();
    try {
      response = await client.get('/services/restic/backup/list');
      backups = response.data.map<Backup>((e) => Backup.fromJson(e)).toList();
    } on DioError catch (e) {
      print(e.message);
    } catch (e) {
      print(e);
    } finally {
      close(client);
      return backups;
    }
  }

  Future<BackupStatus> getBackupStatus() async {
    Response response;
    BackupStatus status = BackupStatus(
      status: BackupStatusEnum.error,
      errorMessage: 'Network error',
      progress: 0,
    );

    var client = await getClient();
    try {
      response = await client.get('/services/restic/backup/status');
      status = BackupStatus.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
      return status;
    }
  }

  Future<void> forceBackupListReload() async {
    var client = await getClient();
    try {
      client.get('/services/restic/backup/reload');
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
    }
  }

  Future<void> restoreBackup(String backupId) async {
    var client = await getClient();
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

    var client = await getClient();
    try {
      response = await client.get('/system/configuration/pull');
      result = (response.statusCode != null)
          ? (response.statusCode == HttpStatus.ok)
          : false;
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
      return result;
    }
  }

  Future<bool> reboot() async {
    Response response;
    bool result = false;

    var client = await getClient();
    try {
      response = await client.get('/system/reboot');
      result = (response.statusCode != null)
          ? (response.statusCode == HttpStatus.ok)
          : false;
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
      return result;
    }
  }

  Future<bool> upgrade() async {
    Response response;
    bool result = false;

    var client = await getClient();
    try {
      response = await client.get('/system/configuration/upgrade');
      result = (response.statusCode != null)
          ? (response.statusCode == HttpStatus.ok)
          : false;
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
      return result;
    }
  }

  Future<AutoUpgradeSettings> getAutoUpgradeSettings() async {
    Response response;
    AutoUpgradeSettings settings = AutoUpgradeSettings(
      enable: false,
      allowReboot: false,
    );

    var client = await getClient();
    try {
      response = await client.get('/system/configuration/autoUpgrade');
      if (response.data != null) {
        settings = AutoUpgradeSettings.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    } finally {
      close(client);
      return settings;
    }
  }

  Future<void> updateAutoUpgradeSettings(AutoUpgradeSettings settings) async {
    var client = await getClient();
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
    var client = await getClient();
    Response response = await client.get('/system/configuration/timezone');
    close(client);

    return TimeZoneSettings.fromString(response.data);
  }

  Future<void> updateServerTimezone(TimeZoneSettings settings) async {
    var client = await getClient();
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

    var client = await getClient();
    try {
      response = await client.get('/services/mailserver/dkim');
    } on DioError catch (e) {
      print(e.message);
      return null;
    } finally {
      close(client);
    }

    if (response.statusCode == null) {
      return null;
    }

    if (response.statusCode == HttpStatus.notFound || response.data == null) {
      throw Exception('No DKIM key found');
    }

    if (response.statusCode != HttpStatus.ok) {
      return "";
    }

    final base64toString = utf8.fuse(base64);

    return base64toString
        .decode(response.data)
        .split('(')[1]
        .split(')')[0]
        .replaceAll('"', '');
  }

  Future<ApiResponse<RecoveryTokenStatus>> getRecoveryTokenStatus() async {
    Response response;

    var client = await getClient();
    try {
      response = await client.get('/auth/recovery_token');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
          errorMessage: e.message,
          statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
          data: RecoveryTokenStatus(exists: false, valid: false));
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
        statusCode: code,
        data: response.data != null
            ? response.data.fromJson(response.data)
            : null);
  }

  Future<ApiResponse<String>> generateRecoveryToken(
      DateTime expiration, int uses) async {
    Response response;

    var client = await getClient();
    try {
      response = await client.post(
        '/auth/recovery_token',
        data: {
          'expiration': expiration.toIso8601String(),
          'uses': uses,
        },
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
          errorMessage: e.message,
          statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
          data: "");
    } finally {
      close(client);
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
        statusCode: code,
        data: response.data != null ? response.data["token"] : '');
  }

  Future<ApiResponse<String>> useRecoveryToken(DeviceToken token) async {
    Response response;

    var client = await getClient();
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
          data: "");
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
        statusCode: code,
        data: response.data != null ? response.data["token"] : '');
  }

  Future<ApiResponse<String>> authorizeDevice(DeviceToken token) async {
    Response response;

    var client = await getClient();
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
          data: "");
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
        statusCode: code,
        data: response.data["token"] != null ? response.data["token"] : '');
  }

  Future<ApiResponse<String>> createDeviceToken() async {
    Response response;

    var client = await getClient();
    try {
      response = await client.post('/auth/new_device');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
          errorMessage: e.message,
          statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
          data: "");
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
        statusCode: code,
        data: response.data != null ? response.data["token"] : '');
  }

  Future<ApiResponse<String>> deleteDeviceToken() async {
    Response response;

    var client = await getClient();
    try {
      response = await client.delete('/auth/new_device');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
          errorMessage: e.message,
          statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
          data: "");
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
        statusCode: code, data: response.data != null ? response.data : '');
  }

  Future<ApiResponse<List<ApiToken>>> getApiTokens() async {
    Response response;

    var client = await getClient();
    try {
      response = await client.get('/auth/tokens');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
          errorMessage: e.message,
          statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
          data: []);
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
        statusCode: code,
        data: (response.data != null)
            ? response.data.map<ApiToken>((e) => ApiToken.fromJson(e)).toList()
            : []);
  }

  Future<ApiResponse<String>> refreshCurrentApiToken() async {
    Response response;

    var client = await getClient();
    try {
      response = await client.post('/auth/tokens');
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
          errorMessage: e.message,
          statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
          data: "");
    } finally {
      client.close();
    }

    final int code = response.statusCode ?? HttpStatus.internalServerError;

    return ApiResponse(
        statusCode: code,
        data: response.data != null ? response.data["token"] : '');
  }

  Future<ApiResponse<void>> deleteApiToken(String device) async {
    Response response;
    var client = await getClient();
    try {
      response = await client.delete(
        '/auth/tokens',
        data: {
          'device': device,
        },
      );
    } on DioError catch (e) {
      print(e.message);
      return ApiResponse(
          errorMessage: e.message,
          statusCode: e.response?.statusCode ?? HttpStatus.internalServerError,
          data: null);
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
      case ServiceTypes.passwordManager:
        return 'bitwarden';
      case ServiceTypes.cloud:
        return 'nextcloud';
      case ServiceTypes.socialNetwork:
        return 'pleroma';
      case ServiceTypes.git:
        return 'gitea';
      case ServiceTypes.vpn:
        return 'ocserv';
      default:
        throw Exception('wrong state');
    }
  }
}
