import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/utils/app_logger.dart';

class PorkbunApi extends RestApiMap {
  PorkbunApi({
    this.token = '',
    this.tokenId = '',
    this.hasLogger = false,
    this.isWithToken = true,
  }) : assert(
         !isWithToken || (token.isNotEmpty && tokenId.isNotEmpty),
         'Porkbun API requires both token and tokenId to be set when isWithToken is true.',
       );

  @override
  final bool hasLogger;
  @override
  final bool isWithToken;

  final String token;
  final String tokenId;

  static final logger = const AppLogger(name: 'porkbun_dns_api_map').log;

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(
      baseUrl: rootAddress,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    if (isWithToken) {
      assert(
        token.isNotEmpty && tokenId.isNotEmpty,
        'Porkbun API requires both token and tokenId to be set when isWithToken is true.',
      );
      options.headers = {'X-API-Key': tokenId, 'X-Secret-API-Key': token};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }

    return options;
  }

  @override
  String rootAddress = 'https://api.porkbun.com/api/json/v3';
}
