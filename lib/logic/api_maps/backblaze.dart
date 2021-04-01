import 'dart:io';
import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';

class BackblazeApi extends ApiMap {
  BackblazeApi({this.hasLoger = false, this.isWithToken = true});

  BaseOptions get options {
    var options = BaseOptions(baseUrl: rootAddress);
    if (isWithToken) {
      var backblazeCredential = getIt<ApiConfigModel>().backblazeCredential;
      var token = backblazeCredential!.applicationKey;
      options.headers = {'Authorization': 'Basic $token'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }

    return options;
  }

  @override
  String rootAddress = 'https://api.backblazeb2.com/b2api/v2/';

  Future<bool> isValid(String encodedApiKey) async {
    var client = await getClient();
    Response response = await client.get(
      'b2_authorize_account',
      options: Options(headers: {'Authorization': 'Basic $encodedApiKey'}),
    );
    close(client);
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

  @override
  bool hasLoger;

  @override
  bool isWithToken;
}
