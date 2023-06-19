import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

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

  Future<GenericResult<List<dynamic>>> getZones(final String domain) async {
    List zones = [];

    late final Response? response;
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/zones',
        queryParameters: {'name': domain},
      );
      zones = response.data['result'];
    } catch (e) {
      print(e);
      GenericResult(
        success: false,
        data: zones,
        code: response?.statusCode,
        message: response?.statusMessage,
      );
    } finally {
      close(client);
    }

    return GenericResult(success: true, data: zones);
  }

  Future<GenericResult<void>> removeSimilarRecords({
    required final ServerDomain domain,
    required final List records,
  }) async {
    final String domainZoneId = domain.zoneId;
    final String url = '/zones/$domainZoneId/dns_records';

    final Dio client = await getClient();
    try {
      final List<Future> allDeleteFutures = <Future>[];

      for (final record in records) {
        allDeleteFutures.add(
          client.delete('$url/${record["id"]}'),
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

  Future<GenericResult<List>> getDnsRecords({
    required final ServerDomain domain,
  }) async {
    Response response;
    final String domainName = domain.domainName;
    final String domainZoneId = domain.zoneId;
    final List allRecords = [];

    final String url = '/zones/$domainZoneId/dns_records';

    final Dio client = await getClient();
    try {
      response = await client.get(url);
      final List records = response.data['result'] ?? [];

      for (final record in records) {
        if (record['zone_name'] == domainName) {
          allRecords.add(record);
        }
      }
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

  Future<GenericResult<void>> createMultipleDnsRecords({
    required final ServerDomain domain,
    required final List<DnsRecord> records,
  }) async {
    final String domainZoneId = domain.zoneId;
    final List<Future> allCreateFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final DnsRecord record in records) {
        allCreateFutures.add(
          client.post(
            '/zones/$domainZoneId/dns_records',
            data: record.toJson(),
          ),
        );
      }
      await Future.wait(allCreateFutures);
    } on DioError catch (e) {
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

  Future<GenericResult<List>> getDomains() async {
    final String url = '$rootAddress/zones';
    List domains = [];

    late final Response? response;
    final Dio client = await getClient();
    try {
      response = await client.get(
        url,
        queryParameters: {'per_page': 50},
      );
      domains = response.data['result'];
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
