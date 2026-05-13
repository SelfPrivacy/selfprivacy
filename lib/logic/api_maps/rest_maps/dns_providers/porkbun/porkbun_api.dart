// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/porkbun/porkbun_dns_info.dart';
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

  Future<GenericResult<bool>> isApiTokenValid(
    final String token,
    final String tokenId,
  ) async {
    bool isValid = false;
    Response? response;
    String? message;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/ping',
        options: Options(
          followRedirects: false,
          validateStatus: (final status) =>
              status != null && (status >= 200 || status == 400),
          headers: {'X-API-Key': tokenId, 'X-Secret-API-Key': token},
        ),
      );
    } catch (e) {
      logger('Error validating Porkbun API token', error: e);
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
      final responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        isValid = responseData['credentialsValid'] as bool? ?? false;
      } else {
        message = 'Unexpected response format';
        isValid = false;
      }
    } else if (response.statusCode == HttpStatus.badRequest) {
      message = 'initializing.provider_bad_key_error';
      isValid = false;
    } else {
      message = 'Unexpected response status: ${response.statusCode}';
      isValid = false;
    }

    return GenericResult(success: true, data: isValid, message: message);
  }

  Future<GenericResult<List<PorkbunDomain>>> getDomains() async {
    List<PorkbunDomain> domains = [];

    late final Response response;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/domain/listAll',
        queryParameters: {'start': 0, 'includeLabels': false},
      );
      domains = response.data['domains']!
          .map<PorkbunDomain>(
            // ignore: unnecessary_lambdas
            (final e) => PorkbunDomain.fromJson(e),
          )
          .toList();
    } catch (e) {
      logger('Error fetching Porkbun domains', error: e);
      return GenericResult(
        success: false,
        data: domains,
        code: response.statusCode,
        message: response.statusMessage ?? e.toString(),
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
    required final List<PorkbunDnsRecord> records,
  }) async {
    final List<Future> allCreateFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final PorkbunDnsRecord record in records) {
        allCreateFutures.add(
          client.post('/dns/create/$domainName', data: record.toJson()),
        );
      }
      await Future.wait(allCreateFutures);
    } on DioException catch (e) {
      logger('DioException while creating Porkbun DNS records', error: e);
      rethrow;
    } catch (e) {
      logger('Error creating Porkbun DNS records', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<void>> removeRecords({
    required final String domainName,
    required final List<PorkbunDnsRecord> records,
  }) async {
    final List<Future> allDeleteFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final PorkbunDnsRecord record in records) {
        allDeleteFutures.add(
          client.post('/dns/delete/$domainName/${record.id}'),
        );
      }
      await Future.wait(allDeleteFutures);
    } on DioException catch (e) {
      logger('DioException while deleting Porkbun DNS records', error: e);
      rethrow;
    } catch (e) {
      logger('Error deleting Porkbun DNS records', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<List<PorkbunDnsRecord>>> getDnsRecords({
    required final String domainName,
  }) async {
    List<PorkbunDnsRecord> records = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/dns/retrieve/$domainName');
      records = response.data['records']!
          .map<PorkbunDnsRecord>(
            // ignore: unnecessary_lambdas
            (final e) => PorkbunDnsRecord.fromJson(e),
          )
          .toList();

      return GenericResult(
        success: true,
        data: records,
        code: response.statusCode,
        message: response.statusMessage,
      );
    } catch (e) {
      logger('Error fetching Porkbun DNS records', error: e);
      return GenericResult(
        success: false,
        data: records,
        message: e.toString(),
      );
    } finally {
      close(client);
    }
  }
}
