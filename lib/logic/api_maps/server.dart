import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
import 'package:selfprivacy/logic/models/backblaze_bucket.dart';
import 'package:selfprivacy/logic/models/backup.dart';
import 'package:selfprivacy/logic/models/user.dart';

import 'api_map.dart';

class ServerApi extends ApiMap {
  bool hasLoger;
  bool isWithToken;

  ServerApi({this.hasLoger = false, this.isWithToken = true});

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

  Future<bool> createUser(User user) async {
    bool res;
    Response response;

    var client = await getClient();
    // POST request with JSON body containing username and password
    try {
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
      res = response.statusCode == HttpStatus.created;
    } catch (e) {
      print(e);
      res = false;
    }

    close(client);
    return res;
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
      res = response.statusCode == HttpStatus.ok;
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
    client.close();
  }

  Future<void> sendSsh(String ssh) async {
    var client = await getClient();
    client.put(
      '/services/ssh/key/send',
      data: {"public_key": ssh},
    );
    client.close();
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
    client.close();
  }

  Future<void> startBackup() async {
    var client = await getClient();
    client.put('/services/restic/backup/create');
    client.close();
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
    client.close();
  }

  Future<void> restoreBackup(String backupId) async {
    var client = await getClient();
    client.put('/services/restic/backup/restore', data: {'backupId': backupId});
    client.close();
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
    client.close();
    return response.statusCode == HttpStatus.ok;
  }

  Future<bool> upgrade() async {
    var client = await getClient();
    Response response = await client.get('/system/configuration/upgrade');
    client.close();
    return response.statusCode == HttpStatus.ok;
  }

  Future<String> getDkim() async {
    var client = await getClient();
    Response response = await client.get('/services/mailserver/dkim');
    client.close();

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
      //   return ''; // cannot be swithch off
      // case ServiceTypes.messenger:
      //   return ''; // external service
      // case ServiceTypes.video:
      // return ''; // jeetsu meet not working
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
