// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/digital_ocean_dns_info.dart';
import 'package:selfprivacy/utils/app_logger.dart';

class DigitalOceanDnsApi extends RestApiMap {
  DigitalOceanDnsApi({
    this.token = '',
    this.hasLogger = false,
    this.isWithToken = true,
    this.customToken,
  }) : assert(
         !isWithToken || token.isNotEmpty,
         'DigitalOcean API requires a token to be set when isWithToken is true.',
       );

  @override
  final bool hasLogger;
  @override
  final bool isWithToken;

  final String token;
  final String? customToken;

  static final logger = const AppLogger(name: 'digital_ocean_dns_api_map').log;

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
        'DigitalOcean API requires a token to be set when isWithToken is true.',
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
  String rootAddress = 'https://api.digitalocean.com/v2';

  Future<GenericResult<bool>> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    String? message;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/account',
        options: Options(
          followRedirects: false,
          validateStatus:
              (final status) =>
                  status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      logger('Error validating DigitalOcean DNS API token', error: e);
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

  Future<GenericResult<List<DigitalOceanDomain>>> getDomains() async {
    List<DigitalOceanDomain> domains = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/domains');
      domains =
          response.data['domains']!
              .map<DigitalOceanDomain>(
                // ignore: unnecessary_lambdas
                (final e) => DigitalOceanDomain.fromJson(e),
              )
              .toList();
    } catch (e) {
      logger('Error fetching DigitalOcean domains', error: e);
      return GenericResult(
        data: domains,
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(data: domains, success: true);
  }

  Future<GenericResult<void>> createMultipleDnsRecords({
    required final String domainName,
    required final List<DigitalOceanDnsRecord> records,
  }) async {
    final List<Future> allCreateFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final DigitalOceanDnsRecord record in records) {
        allCreateFutures.add(
          client.post('/domains/$domainName/records', data: record.toJson()),
        );
      }
      await Future.wait(allCreateFutures);
    } on DioException catch (e) {
      logger('DioException while creating multiple DNS records', error: e);
      rethrow;
    } catch (e) {
      logger('Error creating multiple DNS records', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<void>> removeSimilarRecords({
    required final String domainName,
    required final List<DigitalOceanDnsRecord> records,
  }) async {
    final Dio client = await getClient();
    try {
      final List<Future> allDeleteFutures = [];
      for (final record in records) {
        allDeleteFutures.add(
          client.delete('/domains/$domainName/records/${record.id}'),
        );
      }
      await Future.wait(allDeleteFutures);
    } catch (e) {
      logger('Error removing similar DNS records', error: e);
      return GenericResult(success: false, data: null, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: null);
  }

  Future<GenericResult<List<DigitalOceanDnsRecord>>> getDnsRecords(
    final String domainName,
  ) async {
    Response response;
    List<DigitalOceanDnsRecord> allRecords = [];

    /// Default amount is 20, but we will eventually overflow it,
    /// so I hardcode it to the maximum available amount in advance just in case
    ///
    /// https://docs.digitalocean.com/reference/api/api-reference/#operation/domains_list_records
    const int amountPerPage = 200;
    final String url = '/domains/$domainName/records?per_page=$amountPerPage';

    final Dio client = await getClient();
    try {
      response = await client.get(url);
      allRecords =
          response.data['domain_records']
              .map<DigitalOceanDnsRecord>(
                // ignore: unnecessary_lambdas
                (final e) => DigitalOceanDnsRecord.fromJson(e),
              )
              .toList() ??
          [];
    } catch (e) {
      logger('Error fetching DNS records for $domainName', error: e);
      GenericResult(data: allRecords, success: false, message: e.toString());
    } finally {
      close(client);
    }

    return GenericResult(data: allRecords, success: true);
  }
}
