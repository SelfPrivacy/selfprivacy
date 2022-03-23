import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';
import 'package:selfprivacy/logic/models/user.dart';

import 'api_map.dart';

class ApiResponse<D> {
  final int statusCode;
  final String? errorMessage;
  final D data;

  get isSuccess => statusCode >= 200 && statusCode < 300;

  ApiResponse({
    required this.statusCode,
    this.errorMessage,
    required this.data,
  });
}

class ServerApi extends ApiMap {
  bool hasLogger;
  bool isWithToken;

  ServerApi({this.hasLogger = false, this.isWithToken = true});

  BaseOptions get options {
    var options = BaseOptions();

    if (isWithToken) {
      var cloudFlareDomain = getIt<ApiConfigModel>().cloudFlareDomain;
      var domainName = cloudFlareDomain!.domainName;
      var apiToken = getIt<ApiConfigModel>().hetznerServer?.apiToken;

      options = BaseOptions(baseUrl: 'https://api.$domainName', headers: {
        'Authorization': 'Bearer $apiToken',
      });
    }

    return options;
  }

  Future<bool> isHttpServerWorking() async {
    bool res;
    Response response;

    var client = await getClient();
    try {
      response = await client.get('/services/status');
      res = response.statusCode == HttpStatus.ok;
    } catch (e) {
      res = false;
    }
    close(client);
    return res;
  }

  Future<ApiResponse<User>> createUser(User user) async {
    Response response;

    var client = await getClient();
    // POST request with JSON body containing username and password

    response = await client.post(
      '/users',
      data: {
        'username': user.login,
        'password': user.password,
      },
      options: Options(
        contentType: 'application/json',
      ),
    );

    close(client);

    if (response.statusCode == HttpStatus.created) {
      return ApiResponse(
        statusCode: response.statusCode ?? HttpStatus.internalServerError,
        data: User(
          login: user.login,
          password: user.password,
          isFoundOnServer: true,
        ),
      );
    } else {
      return ApiResponse(
        statusCode: response.statusCode ?? HttpStatus.internalServerError,
        data: User(
          login: user.login,
          password: user.password,
          isFoundOnServer: false,
          note: response.data['message'] ?? null,
        ),
        errorMessage: response.data?.containsKey('error') ?? false
            ? response.data['error']
            : null,
      );
    }
  }

  Future<ApiResponse<List<String>>> getUsersList() async {
    List<String> res = [];
    Response response;

    var client = await getClient();
    response = await client.get('/users');
    try {
      for (var user in response.data) {
        res.add(user.toString());
      }
    } catch (e) {
      print(e);
      res = [];
    }

    close(client);
    return ApiResponse<List<String>>(
      statusCode: response.statusCode ?? HttpStatus.internalServerError,
      data: res,
    );
  }

  Future<ApiResponse<void>> addUserSshKey(User user, String sshKey) async {
    Response response;

    var client = await getClient();
    response = await client.post(
      '/services/ssh/keys/${user.login}',
      data: {
        'public_key': sshKey,
      },
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

  Future<ApiResponse<void>> addRootSshKey(String ssh) async {
    Response response;

    var client = await getClient();
    response = await client.put(
      '/services/ssh/key/send',
      data: {"public_key": ssh},
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
    response = await client.get('/services/ssh/keys/${user.login}');
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
    response = await client.delete('/services/ssh/keys/${user.login}',
        data: {"public_key": sshKey});
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
        ),
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
    client.post('/services/${type.url}/${needToTurnOn ? 'enable' : 'disable'}');
    close(client);
  }

  Future<Map<ServiceTypes, bool>> servicesPowerCheck() async {
    var client = await getClient();
    Response response = await client.get('/services/status');

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
    );
    close(client);
  }

  Future<void> startBackup() async {
    var client = await getClient();
    client.put('/services/restic/backup/create');
    close(client);
  }

  Future<List<Backup>> getBackups() async {
    Response response;

    var client = await getClient();
    try {
      response = await client.get(
        '/services/restic/backup/list',
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
    client.get('/services/restic/backup/reload');
    close(client);
  }

  Future<void> restoreBackup(String backupId) async {
    var client = await getClient();
    client.put('/services/restic/backup/restore', data: {'backupId': backupId});
    close(client);
  }

  Future<bool> pullConfigurationUpdate() async {
    var client = await getClient();
    Response response = await client.get('/system/configuration/pull');
    close(client);
    return response.statusCode == HttpStatus.ok;
  }

  Future<bool> reboot() async {
    var client = await getClient();
    Response response = await client.get('/system/reboot');
    close(client);
    return response.statusCode == HttpStatus.ok;
  }

  Future<bool> upgrade() async {
    var client = await getClient();
    Response response = await client.get('/system/configuration/upgrade');
    close(client);
    return response.statusCode == HttpStatus.ok;
  }

  Future<AutoUpgradeSettings> getAutoUpgradeSettings() async {
    var client = await getClient();
    Response response = await client.get('/system/configuration/autoUpgrade');
    close(client);
    return AutoUpgradeSettings.fromJson(response.data);
  }

  Future<void> updateAutoUpgradeSettings(AutoUpgradeSettings settings) async {
    var client = await getClient();
    await client.put(
      '/system/configuration/autoUpgrade',
      data: settings.toJson(),
    );
    close(client);
  }

  Future<TimeZoneSettings> getServerTimezone() async {
    var client = await getClient();
    Response response = await client.get('/system/configuration/timezone');
    close(client);

    return TimeZoneSettings.fromString(response.data);
  }

  Future<void> updateServerTimezone(TimeZoneSettings settings) async {
    var client = await getClient();
    await client.put(
      '/system/configuration/timezone',
      data: settings.toJson(),
    );
    close(client);
  }

  Future<String> getDkim() async {
    var client = await getClient();
    Response response = await client.get('/services/mailserver/dkim');
    close(client);

    // if got 404 raise exception
    if (response.statusCode == HttpStatus.notFound) {
      throw Exception('No DKIM key found');
    }

    final base64toString = utf8.fuse(base64);

    return base64toString
        .decode(response.data)
        .split('(')[1]
        .split(')')[0]
        .replaceAll('"', '');
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
