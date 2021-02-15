import 'dart:io';
import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';

class BackblazeApi extends ApiMap {
  BackblazeApi([String token]) {
    if (token != null) {
      loggedClient.options = BaseOptions(
        headers: {'Authorization': 'Basic $token'},
        baseUrl: rootAddress,
      );
    }
  }

  @override
  String rootAddress =
      'https://api.backblazeb2.com/b2api/v2/b2_authorize_account';

  Future<bool> isValid(String token) async {
    var options = Options(
      headers: {'Authorization': 'Basic $token'},
      validateStatus: (status) {
        return status == HttpStatus.ok || status == HttpStatus.unauthorized;
      },
    );

    Response response = await loggedClient.get(rootAddress, options: options);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }
}