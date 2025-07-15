// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/cloudflare_dns_info.dart';
import 'package:selfprivacy/utils/app_logger.dart';

class CloudflareApi extends RestApiMap {
  CloudflareApi({
    this.token = '',
    this.hasLogger = false,
    this.isWithToken = true,
    this.customToken,
  }) : assert(
         !isWithToken || token.isNotEmpty,
         'Cloudflare API requires a token to be set when isWithToken is true.',
       );

  @override
  final bool hasLogger;
  @override
  final bool isWithToken;

  final String token;
  final String? customToken;

  static final logger = const AppLogger(name: 'cloudflare_api_map').log;

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
        'Cloudflare API requires a token to be set when isWithToken is true.',
      );
      options.headers = {'Authorization': 'Bearer $token'};
    }

    if (customToken != null) {
      options.headers = {'Authorization': 'Bearer $customToken'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }
    return options;
  }

  @override
  String rootAddress = 'https://api.cloudflare.com/client/v4';

  Future<GenericResult<bool>> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    String? message;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/user/tokens/verify',
        options: Options(
          followRedirects: false,
          validateStatus:
              (final status) =>
                  status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      logger('Error in Cloudflare isApiTokenValid request: $e', error: e);
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

  Future<GenericResult<List<CloudflareZone>>> getZones() async {
    final String url = '$rootAddress/zones';
    List<CloudflareZone> domains = [];

    late final Response? response;
    final Dio client = await getClient();
    try {
      response = await client.get(url, queryParameters: {'per_page': 50});
      domains =
          response.data['result']!
              .map<CloudflareZone>(
                // ignore: unnecessary_lambdas
                (final json) => CloudflareZone.fromJson(json),
              )
              .toList();
    } catch (e) {
      logger('Error in Cloudflare getZones request: $e', error: e);
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
    required final String zoneId,
    required final List<CloudflareDnsRecord> records,
  }) async {
    final List<Future> allCreateFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final CloudflareDnsRecord record in records) {
        allCreateFutures.add(
          client.post('/zones/$zoneId/dns_records', data: record.toJson()),
        );
      }
      await Future.wait(allCreateFutures);
    } on DioException catch (e) {
      logger(
        'Error in Cloudflare createMultipleDnsRecords request: ${e.message}',
        error: e,
      );
      rethrow;
    } catch (e) {
      logger(
        'Error in Cloudflare createMultipleDnsRecords request: $e',
        error: e,
      );
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<void>> removeSimilarRecords({
    required final String zoneId,
    required final List<CloudflareDnsRecord> records,
  }) async {
    final String url = '/zones/$zoneId/dns_records';

    final Dio client = await getClient();
    try {
      final List<Future> allDeleteFutures = <Future>[];

      for (final record in records) {
        allDeleteFutures.add(client.delete('$url/${record.id}'));
      }
      await Future.wait(allDeleteFutures);
    } catch (e) {
      logger('Error in Cloudflare removeSimilarRecords request: $e', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<List<CloudflareDnsRecord>>> getDnsRecords({
    required final String zoneId,
  }) async {
    Response response;
    List<CloudflareDnsRecord> allRecords = [];

    final String url = '/zones/$zoneId/dns_records';
    final Dio client = await getClient();
    try {
      response = await client.get(url);
      allRecords =
          response.data['result']!
              .map<CloudflareDnsRecord>(
                // ignore: unnecessary_lambdas
                (final json) => CloudflareDnsRecord.fromJson(json),
              )
              .toList();
    } catch (e) {
      logger('Error in Cloudflare getDnsRecords request: $e', error: e);
      return GenericResult(data: [], success: false, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(data: allRecords, success: true);
  }
}
