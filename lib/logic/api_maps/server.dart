import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/common_enum/common_enum.dart';
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

      options = BaseOptions(baseUrl: 'https://api.$domainName');
    }

    return options;
  }

  Future<bool> isHttpServerWorking() async {
    bool res;
    Response response;

    var client = await getClient();
    try {
      response = await client.get('/serviceStatus');
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
    try {
      response = await client.post(
        '/createUser',
        options: Options(
          headers: {
            "X-User": user.login,
            "X-Password":
                '\$6\$${user.hashPassword.salt}\$${user.hashPassword.hash}',
          },
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
        '/apply',
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
