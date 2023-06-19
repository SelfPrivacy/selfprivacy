import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

class DigitalOceanDnsApi extends ApiMap {
  DigitalOceanDnsApi({
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
  String rootAddress = 'https://api.digitalocean.com/v2';

  Future<GenericResult<bool>> isApiTokenValid(final String token) async {
    bool isValid = false;
    Response? response;
    String message = '';
    final Dio client = await getClient();
    try {
      response = await client.get(
        '/account',
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

  Future<GenericResult<void>> removeSimilarRecords({
    required final ServerDomain domain,
    required final List records,
  }) async {
    final String domainName = domain.domainName;

    final Dio client = await getClient();
    try {
      final List<Future> allDeleteFutures = [];
      for (final record in records) {
        allDeleteFutures.add(
          client.delete("/domains/$domainName/records/${record['id']}"),
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
    List allRecords = [];

    /// Default amount is 20, but we will eventually overflow it,
    /// so I hardcode it to the maximum available amount in advance just in case
    ///
    /// https://docs.digitalocean.com/reference/api/api-reference/#operation/domains_list_records
    const int amountPerPage = 200;
    final String url = '/domains/$domainName/records?per_page=$amountPerPage';

    final Dio client = await getClient();
    try {
      response = await client.get(url);
      allRecords = response.data['domain_records'] ?? [];
    } catch (e) {
      print(e);
      GenericResult(
        data: allRecords,
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
    final String domainName = domain.domainName;
    final List<Future> allCreateFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final DnsRecord record in records) {
        allCreateFutures.add(
          client.post(
            '/domains/$domainName/records',
            data: {
              'type': record.type,
              'name': record.name,
              'data': record.content,
              'ttl': record.ttl,
              'priority': record.priority,
            },
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

  Future<GenericResult<List>> domainList() async {
    List domains = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/domains');
      domains = response.data['domains'];
    } catch (e) {
      print(e);
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
}
