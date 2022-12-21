import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

class CloudflareApi extends DnsProviderApi {
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
  RegExp getApiTokenValidation() =>
      RegExp(r'\s+|[!$%^&*()@+|~=`{}\[\]:<>?,.\/]');

  @override
  BaseOptions get options {
    final BaseOptions options = BaseOptions(baseUrl: rootAddress);
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

  @override
  Future<APIGenericResult<bool>> isApiTokenValid(final String token) async {
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
      return APIGenericResult(
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

    return APIGenericResult(
      data: isValid,
      success: true,
      message: response.statusMessage,
    );
  }

  @override
  Future<String?> getZoneId(final String domain) async {
    String? zoneId;

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        '/zones',
        queryParameters: {'name': domain},
      );
      zoneId = response.data['result'][0]['id'];
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return zoneId;
  }

  @override
  Future<APIGenericResult<void>> removeSimilarRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final String domainName = domain.domainName;
    final String domainZoneId = domain.zoneId;

    final String url = '/zones/$domainZoneId/dns_records';

    final Dio client = await getClient();
    try {
      final Response response = await client.get(url);

      final List records = response.data['result'] ?? [];
      final List<Future> allDeleteFutures = <Future>[];

      for (final record in records) {
        if (record['zone_name'] == domainName) {
          allDeleteFutures.add(
            client.delete('$url/${record["id"]}'),
          );
        }
      }
      await Future.wait(allDeleteFutures);
    } catch (e) {
      print(e);
      return APIGenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(success: true, data: null);
  }

  @override
  Future<List<DnsRecord>> getDnsRecords({
    required final ServerDomain domain,
  }) async {
    Response response;
    final String domainName = domain.domainName;
    final String domainZoneId = domain.zoneId;
    final List<DnsRecord> allRecords = <DnsRecord>[];

    final String url = '/zones/$domainZoneId/dns_records';

    final Dio client = await getClient();
    try {
      response = await client.get(url);
      final List records = response.data['result'] ?? [];

      for (final record in records) {
        if (record['zone_name'] == domainName) {
          allRecords.add(
            DnsRecord(
              name: record['name'],
              type: record['type'],
              content: record['content'],
              ttl: record['ttl'],
              proxied: record['proxied'],
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return allRecords;
  }

  @override
  Future<APIGenericResult<void>> createMultipleDnsRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final String domainName = domain.domainName;
    final String domainZoneId = domain.zoneId;
    final List<DnsRecord> listDnsRecords =
        getProjectDnsRecords(domainName, ip4);
    final List<Future> allCreateFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final DnsRecord record in listDnsRecords) {
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
      return APIGenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    } finally {
      close(client);
    }

    return APIGenericResult(success: true, data: null);
  }

  @override
  Future<void> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  ) async {
    final String domainZoneId = domain.zoneId;
    final String url = '$rootAddress/zones/$domainZoneId/dns_records';

    final Dio client = await getClient();
    try {
      await client.post(
        url,
        data: record.toJson(),
      );
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }
  }

  @override
  Future<List<String>> domainList() async {
    final String url = '$rootAddress/zones';
    List<String> domains = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get(
        url,
        queryParameters: {'per_page': 50},
      );
      domains = response.data['result']
          .map<String>((final el) => el['name'] as String)
          .toList();
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return domains;
  }
}
