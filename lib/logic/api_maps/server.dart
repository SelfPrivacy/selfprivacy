import 'package:dio/dio.dart';

import 'api_map.dart';

class ServerApi extends ApiMap {
  ServerApi([String token]) {
    if (token != null) {
      loggedClient.options =
          BaseOptions(headers: {'Authorization': 'Bearer $token'});
    }
  }
}
