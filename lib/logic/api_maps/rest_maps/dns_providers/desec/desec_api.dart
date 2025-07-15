// ignore_for_file: unnecessary_lambdas

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/desec_dns_info.dart';
import 'package:selfprivacy/utils/app_logger.dart';

class DesecApi extends RestApiMap {
  DesecApi({
    this.token = '',
    this.hasLogger = false,
    this.isWithToken = true,
    this.customToken,
  }) : assert(
         !isWithToken || token.isNotEmpty,
         'Desec API requires a token to be set when isWithToken is true.',
       );

  @override
  final bool hasLogger;
  @override
  final bool isWithToken;

  final String token;
  final String? customToken;

  static final logger = const AppLogger(name: 'desec_api_map').log;

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(
      baseUrl: rootAddress,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
    );
    if (isWithToken) {
      assert(
        token.isNotEmpty,
        'Desec API requires a token to be set when isWithToken is true.',
      );
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
    String? message;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '',
        options: Options(
          followRedirects: false,
          validateStatus:
              (final status) =>
                  status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Token $token'},
        ),
      );
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      logger('Error validating Desec API token', error: e);
      isValid = false;
      message = e.toString();
    } finally {
      close(client);
    }

    if (response == null) {
      return GenericResult(data: isValid, success: false, message: message);
    }

    message = response.statusMessage;

    if (response.statusCode == HttpStatus.ok) {
      isValid = true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      message = 'initializing.provider_bad_key_error';
      isValid = false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }

    return GenericResult(data: isValid, success: true, message: message);
  }

  Future<GenericResult<List<DesecDomain>>> getDomains() async {
    List<DesecDomain> domains = [];

    late final Response? response;
    final Dio client = await getClient();
    try {
      response = await client.get('');
      await Future.delayed(const Duration(seconds: 1));
      domains =
          // ignore: avoid_dynamic_calls
          response.data!
              .map<DesecDomain>((final e) => DesecDomain.fromJson(e))
              .toList();
    } catch (e) {
      logger('Error fetching Desec domains', error: e);
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

  Future<GenericResult<void>> createMultipleDnsRecords({
    required final String domainName,
    required final List<DesecDnsRecord> records,
  }) async {
    final String url = '/$domainName/rrsets/';

    final Dio client = await getClient();
    try {
      await client.post(
        url,
        data: records.map((final rec) => rec.toJson()).toList(),
      );
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      logger('Error creating multiple Desec DNS records', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<void>> putRecords({
    required final String domainName,
    required final List<DesecDnsRecord> records,
  }) async {
    final String url = '/$domainName/rrsets/';

    final Dio client = await getClient();
    try {
      await client.put(
        url,
        data: records.map((final rec) => rec.toJson()).toList(),
      );
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      logger('Error updating Desec DNS records', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<List<DesecDnsRecord>>> getDnsRecords(
    final String domainName,
  ) async {
    Response? response;
    List<DesecDnsRecord> allRecords = [];

    final String url = '/$domainName/rrsets/';

    final Dio client = await getClient();
    try {
      response = await client.get(url);
      await Future.delayed(const Duration(seconds: 1));
      allRecords =
          // ignore: avoid_dynamic_calls
          response.data!
              .map<DesecDnsRecord>((final e) => DesecDnsRecord.fromJson(e))
              .toList();
    } catch (e) {
      logger('Error fetching Desec DNS records for $domainName', error: e);
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
}
