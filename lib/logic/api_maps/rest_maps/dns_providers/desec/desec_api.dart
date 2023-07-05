import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class DesecApi extends RestApiMap {
  DesecApi({
    this.hasLogger = false,
    this.isWithToken = true,
    this.customToken,
  });
  @override
  final bool hasLogger;
  @override
  final bool isWithToken;

  final String? customToken;

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(
      baseUrl: rootAddress,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    if (isWithToken) {
      final String? token = getIt<ApiConfigModel>().dnsProviderKey;
      assert(token != null);
      options.headers = {'Authorization': 'Token $token'};
    }

    if (customToken != null) {
      options.headers = {'Authorization': 'Token $customToken'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }
    return options;
  }

  @override
  String rootAddress = 'https://desec.io/api/v1/domains/';

  Future<GenericResult<bool>> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    String message = '';
    final Dio client = await getClient();
    try {
      response = await client.get(
        '',
        options: Options(
          followRedirects: false,
          validateStatus: (final status) =>
              status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Token $token'},
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print(e);
      isValid = false;
      message = e.toString();
    } finally {
      close(client);
    }

    if (response == null) {
      return GenericResult(
        data: isValid,
        success: false,
        message: message,
      );
    }

    if (response.statusCode == HttpStatus.ok) {
      isValid = true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      isValid = false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }

    return GenericResult(
      data: isValid,
      success: true,
      message: response.statusMessage,
    );
  }

  Future<GenericResult<void>> updateRecords({
    required final ServerDomain domain,
    required final List<dynamic> records,
  }) async {
    final String domainName = domain.domainName;
    final String url = '/$domainName/rrsets/';

    final Dio client = await getClient();
    try {
      await client.put(url, data: records);
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<List<dynamic>>> getDnsRecords({
    required final ServerDomain domain,
  }) async {
    Response? response;
    final String domainName = domain.domainName;
    List allRecords = [];

    final String url = '/$domainName/rrsets/';

    final Dio client = await getClient();
    try {
      response = await client.get(url);
      await Future.delayed(const Duration(seconds: 1));
      allRecords = response.data;
    } catch (e) {
      print(e);
      return GenericResult(
        data: allRecords,
        success: false,
        message: e.toString(),
        code: response?.statusCode,
      );
    } finally {
      close(client);
    }

    return GenericResult(data: allRecords, success: true);
  }

  Future<GenericResult<void>> createRecords({
    required final ServerDomain domain,
    required final List<dynamic> records,
  }) async {
    final String domainName = domain.domainName;
    final String url = '/$domainName/rrsets/';

    final Dio client = await getClient();
    try {
      await client.post(url, data: records);
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<List>> getDomains() async {
    List domains = [];

    late final Response? response;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '',
      );
      await Future.delayed(const Duration(seconds: 1));
      domains = response.data;
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: domains,
        code: response?.statusCode,
        message: response?.statusMessage,
      );
    } finally {
      close(client);
    }

    return GenericResult(
      success: true,
      data: domains,
      code: response.statusCode,
      message: response.statusMessage,
    );
  }
}