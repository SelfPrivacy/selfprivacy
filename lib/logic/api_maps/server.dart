import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/api_token.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/recovery_token_status.dart';
import 'package:selfprivacy/logic/models/device_token.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';
import 'package:selfprivacy/logic/models/user.dart';

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
  bool hasLogger;
  bool isWithToken;
  String? overrideDomain;

  ServerApi(
      {this.hasLogger = false, this.isWithToken = true, this.overrideDomain});

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
      options = BaseOptions(baseUrl: 'https://api.$overrideDomain');
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
    var client = await getClient();

    Response response;

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
    int statusCode = 0;

    final bool isUserCreated = (response.statusCode != null) &&
        (response.statusCode == HttpStatus.created);

    if (isUserCreated) {
      isFoundOnServer = true;
      statusCode = response.statusCode!;
    } else {
      isFoundOnServer = false;
      statusCode = HttpStatus.notAcceptable;
    }

    return ApiResponse(
      statusCode: statusCode,
      data: User(
        login: user.login,
        password: user.password,
        isFoundOnServer: isFoundOnServer,
      ),
    );
  }

  Future<ApiResponse<List<String>>> getUsersList() async {
    List<String> res = [];
    Response response;
    String? message;
    int code = 0;

    var client = await getClient();
    try {
      response = await client.get('/users');
      for (var user in response.data) {
        res.add(user.toString());
      }
    } on DioError catch (e) {
      print(e.message);
      message = e.message;
      code = e.response?.statusCode ?? HttpStatus.internalServerError;
      res = [];
    } catch (e) {
      print(e);
      message = e.toString();
      code = HttpStatus.internalServerError;
      res = [];
    } finally {
      close(client);
    }

    return ApiResponse(
      errorMessage: message,
      statusCode: code,
      data: res,
    );
  }

  Future<ApiResponse<void>> addUserSshKey(User user, String sshKey) async {
    Response response;

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
      return ApiResponse(
          data: null,
          errorMessage: e.message,
          statusCode: e.response?.statusCode ?? HttpStatus.internalServerError);
    } finally {
      close(client);
    }

    return ApiResponse<void>(
      statusCode: response.statusCode ?? HttpStatus.internalServerError,
      data: null,
      errorMessage: response.data?.containsKey('error') ?? false
          ? response.data['error']
          : null,
    );
  }

  Future<ApiResponse<void>> addRootSshKey(String ssh) async {
    Response response;

    var client = await getClient();
    response = await client.put(
      '/services/ssh/key/send',
      data: {"public_key": ssh},
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);

    return ApiResponse<void>(
      statusCode: response.statusCode ?? HttpStatus.internalServerError,
      data: null,
      errorMessage: response.data?.containsKey('error') ?? false
          ? response.data['error']
          : null,
    );
  }

  Future<ApiResponse<List<String>>> getUserSshKeys(User user) async {
    List<String> res;
    Response response;

    var client = await getClient();
    response = await client.get(
      '/services/ssh/keys/${user.login}',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    try {
      res = (response.data as List<dynamic>).map((e) => e as String).toList();
    } catch (e) {
      print(e);
      res = [];
    }

    close(client);
    return ApiResponse<List<String>>(
      statusCode: response.statusCode ?? HttpStatus.internalServerError,
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
    response = await client.delete(
      '/services/ssh/keys/${user.login}',
      data: {"public_key": sshKey},
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);

    return ApiResponse<void>(
      statusCode: response.statusCode ?? HttpStatus.internalServerError,
      data: null,
      errorMessage: response.data?.containsKey('error') ?? false
          ? response.data['error']
          : null,
    );
  }

  Future<bool> deleteUser(User user) async {
    bool res;
    Response response;

    var client = await getClient();
    try {
      response = await client.delete(
        '/users/${user.login}',
        options: Options(
            contentType: 'application/json',
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return (status != null) &&
                  (status < HttpStatus.internalServerError);
            }),
      );
      res = response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.notFound;
    } catch (e) {
      print(e);
      res = false;
    }

    close(client);
    return res;
  }

  String get rootAddress =>
      throw UnimplementedError('not used in with implementation');

  Future<bool> apply() async {
    bool res;
    Response response;

    var client = await getClient();
    try {
      response = await client.get(
        '/system/configuration/apply',
        options: Options(
            contentType: 'application/json',
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return (status != null) &&
                  (status < HttpStatus.internalServerError);
            }),
      );

      res = response.statusCode == HttpStatus.ok;
    } catch (e) {
      print(e);
      res = false;
    }

    close(client);
    return res;
  }

  Future<void> switchService(ServiceTypes type, bool needToTurnOn) async {
    var client = await getClient();
    client.post(
      '/services/${type.url}/${needToTurnOn ? 'enable' : 'disable'}',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
  }

  Future<Map<ServiceTypes, bool>> servicesPowerCheck() async {
    var client = await getClient();
    Response response = await client.get(
      '/services/status',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );

    close(client);
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
    client.put(
      '/services/restic/backblaze/config',
      data: {
        'accountId': bucket.applicationKeyId,
        'accountKey': bucket.applicationKey,
        'bucket': bucket.bucketName,
      },
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
  }

  Future<void> startBackup() async {
    var client = await getClient();
    client.put(
      '/services/restic/backup/create',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
  }

  Future<List<Backup>> getBackups() async {
    Response response;

    var client = await getClient();
    try {
      response = await client.get(
        '/services/restic/backup/list',
        options: Options(
            contentType: 'application/json',
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return (status != null) &&
                  (status < HttpStatus.internalServerError);
            }),
      );
      return response.data.map<Backup>((e) => Backup.fromJson(e)).toList();
    } catch (e) {
      print(e);
    }
    close(client);
    return <Backup>[];
  }

  Future<BackupStatus> getBackupStatus() async {
    Response response;

    var client = await getClient();
    try {
      response = await client.get(
        '/services/restic/backup/status',
        options: Options(
            contentType: 'application/json',
            receiveDataWhenStatusError: true,
            followRedirects: false,
            validateStatus: (status) {
              return (status != null) &&
                  (status < HttpStatus.internalServerError);
            }),
      );
      return BackupStatus.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    close(client);

    return BackupStatus(
      status: BackupStatusEnum.error,
      errorMessage: 'Network error',
      progress: 0,
    );
  }

  Future<void> forceBackupListReload() async {
    var client = await getClient();
    client.get(
      '/services/restic/backup/reload',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
  }

  Future<void> restoreBackup(String backupId) async {
    var client = await getClient();
    client.put(
      '/services/restic/backup/restore',
      data: {'backupId': backupId},
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
  }

  Future<bool> pullConfigurationUpdate() async {
    var client = await getClient();
    Response response = await client.get(
      '/system/configuration/pull',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
    return response.statusCode == HttpStatus.ok;
  }

  Future<bool> reboot() async {
    var client = await getClient();
    Response response = await client.get(
      '/system/reboot',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
    return response.statusCode == HttpStatus.ok;
  }

  Future<bool> upgrade() async {
    var client = await getClient();
    Response response = await client.get(
      '/system/configuration/upgrade',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
    return response.statusCode == HttpStatus.ok;
  }

  Future<AutoUpgradeSettings> getAutoUpgradeSettings() async {
    var client = await getClient();
    Response response = await client.get(
      '/system/configuration/autoUpgrade',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
    return AutoUpgradeSettings.fromJson(response.data);
  }

  Future<void> updateAutoUpgradeSettings(AutoUpgradeSettings settings) async {
    var client = await getClient();
    await client.put(
      '/system/configuration/autoUpgrade',
      data: settings.toJson(),
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
  }

  Future<TimeZoneSettings> getServerTimezone() async {
    var client = await getClient();
    Response response = await client.get(
      '/system/configuration/timezone',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);

    return TimeZoneSettings.fromString(response.data);
  }

  Future<void> updateServerTimezone(TimeZoneSettings settings) async {
    var client = await getClient();
    await client.put(
      '/system/configuration/timezone',
      data: settings.toJson(),
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);
  }

  Future<String?> getDkim() async {
    var client = await getClient();
    Response response = await client.get(
      '/services/mailserver/dkim',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    close(client);

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
    var client = await getClient();
    Response response = await client.get(
      '/auth/recovery_token',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(
          statusCode: response.statusCode!,
          data: response.data != null
              ? response.data.fromJson(response.data)
              : null);
    }

    return ApiResponse(
        statusCode: HttpStatus.internalServerError,
        data: RecoveryTokenStatus(exists: false, valid: false));
  }

  Future<ApiResponse<String>> generateRecoveryToken(
      DateTime expiration, int uses) async {
    var client = await getClient();
    Response response = await client.post(
      '/auth/recovery_token',
      data: {
        'expiration': expiration.toIso8601String(),
        'uses': uses,
      },
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(
          statusCode: response.statusCode!,
          data: response.data != null ? response.data["token"] : '');
    }

    return ApiResponse(statusCode: HttpStatus.internalServerError, data: '');
  }

  Future<ApiResponse<String>> useRecoveryToken(DeviceToken token) async {
    var client = await getClient();
    Response response = await client.post(
      '/auth/recovery_token/use',
      data: {
        'token': token.token,
        'device': token.device,
      },
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(
          statusCode: response.statusCode!,
          data: response.data != null ? response.data["token"] : '');
    }

    return ApiResponse(statusCode: HttpStatus.internalServerError, data: '');
  }

  Future<ApiResponse<String>> authorizeDevice(DeviceToken token) async {
    var client = await getClient();
    Response response = await client.post(
      '/auth/new_device/authorize',
      data: {
        'token': token.token,
        'device': token.device,
      },
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(
          statusCode: response.statusCode!,
          data: response.data != null ? response.data : '');
    }

    return ApiResponse(statusCode: HttpStatus.internalServerError, data: '');
  }

  Future<ApiResponse<String>> createDeviceToken() async {
    var client = await getClient();
    Response response = await client.post(
      '/auth/new_device',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(
          statusCode: response.statusCode!,
          data: response.data != null ? response.data["token"] : '');
    }

    return ApiResponse(statusCode: HttpStatus.internalServerError, data: '');
  }

  Future<ApiResponse<String>> deleteDeviceToken() async {
    var client = await getClient();
    Response response = await client.delete(
      '/auth/new_device',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(
          statusCode: response.statusCode!,
          data: response.data != null ? response.data : '');
    }

    return ApiResponse(statusCode: HttpStatus.internalServerError, data: '');
  }

  Future<ApiResponse<List<ApiToken>>> getApiTokens() async {
    var client = await getClient();
    Response response = await client.get(
      '/auth/tokens',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(
          statusCode: response.statusCode!,
          data: (response.data != null)
              ? response.data
                  .map<ApiToken>((e) => ApiToken.fromJson(e))
                  .toList()
              : []);
    }

    return ApiResponse(statusCode: HttpStatus.internalServerError, data: []);
  }

  Future<ApiResponse<String>> refreshCurrentApiToken() async {
    var client = await getClient();
    Response response = await client.post(
      '/auth/tokens',
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(
          statusCode: response.statusCode!,
          data: (response.data != null) ? response.data["token"] : '');
    }

    return ApiResponse(statusCode: HttpStatus.internalServerError, data: '');
  }

  Future<ApiResponse<void>> deleteApiToken(String device) async {
    var client = await getClient();
    Response response = await client.delete(
      '/auth/tokens',
      data: {
        'device': device,
      },
      options: Options(
          contentType: 'application/json',
          receiveDataWhenStatusError: true,
          followRedirects: false,
          validateStatus: (status) {
            return (status != null) &&
                (status < HttpStatus.internalServerError);
          }),
    );
    client.close();

    if (response.statusCode != null) {
      return ApiResponse(statusCode: response.statusCode!, data: null);
    }

    return ApiResponse(statusCode: HttpStatus.internalServerError, data: null);
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
