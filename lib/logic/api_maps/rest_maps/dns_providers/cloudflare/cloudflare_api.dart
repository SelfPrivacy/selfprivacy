import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/cloudflare_dns_info.dart';

class CloudflareApi extends RestApiMap {
  CloudflareApi({
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
    String message = '';
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/user/tokens/verify',
        options: Options(
          followRedirects: false,
          validateStatus: (final status) =>
              status != null && (status >= 200 || status == 401),
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
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

  Future<GenericResult<List<CloudflareZone>>> getZones() async {
    final String url = '$rootAddress/zones';
    List<CloudflareZone> domains = [];

    late final Response? response;
    final Dio client = await getClient();
    try {
      response = await client.get(
        url,
        queryParameters: {'per_page': 50},
      );
      domains = response.data['result']!
          .map<CloudflareZone>(
            (final json) => CloudflareZone.fromJson(json),
          )
          .toList();
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

  Future<GenericResult<void>> createMultipleDnsRecords({
    required final String zoneId,
    required final List<CloudflareDnsRecord> records,
  }) async {
    final List<Future> allCreateFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final CloudflareDnsRecord record in records) {
        allCreateFutures.add(
          client.post(
            '/zones/$zoneId/dns_records',
            data: record.toJson(),
          ),
        );
      }
      await Future.wait(allCreateFutures);
    } on DioException catch (e) {
      print(e.message);
      rethrow;
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

  Future<GenericResult<void>> removeSimilarRecords({
    required final String zoneId,
    required final List<CloudflareDnsRecord> records,
  }) async {
    final String url = '/zones/$zoneId/dns_records';

    final Dio client = await getClient();
    try {
      final List<Future> allDeleteFutures = <Future>[];

      for (final record in records) {
        allDeleteFutures.add(
          client.delete('$url/${record.id}'),
        );
      }
      await Future.wait(allDeleteFutures);
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

  Future<GenericResult<List<CloudflareDnsRecord>>> getDnsRecords({
    required final String zoneId,
  }) async {
    Response response;
    List<CloudflareDnsRecord> allRecords = [];

    final String url = '/zones/$zoneId/dns_records';
    final Dio client = await getClient();
    try {
      response = await client.get(url);
      allRecords = response.data['result']!
          .map<CloudflareDnsRecord>(
            (final json) => CloudflareDnsRecord.fromJson(json),
          )
          .toList();
    } catch (e) {
      print(e);
      return GenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return GenericResult(data: allRecords, success: true);
  }
}
