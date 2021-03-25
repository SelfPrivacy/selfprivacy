import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';

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
      assert(domainName != null);

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
    client.close();
    return res;
  }

  String get rootAddress =>
      throw UnimplementedError('not used in with implementation');
}
