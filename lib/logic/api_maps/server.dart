import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
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
            "X-Username": user.login,
            "X-Password": user.password,
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
}
