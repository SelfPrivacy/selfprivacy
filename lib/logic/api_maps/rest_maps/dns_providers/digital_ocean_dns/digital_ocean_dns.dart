import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

class DigitalOceanDnsApi extends DnsProviderApi {
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
  String rootAddress = 'https://api.digitalocean.com/v2';

  @override
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

  @override
  // TODO: Remove from DnsProviderInterface, stub for now
  Future<String?> getZoneId(final String domain) async => domain;

  @override
  Future<GenericResult<void>> removeSimilarRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final String domainName = domain.domainName;

    final Dio client = await getClient();
    try {
      const String ignoreType = 'SOA';
      final List<Future> allDeleteFutures = [];
      final List<DnsRecord> records = await getDnsRecords(domain: domain);
      for (final record in records) {
        if (record.type != ignoreType) {
          allDeleteFutures.add(
            client.delete('/domains/$domainName/records/${record.id}'),
          );
        }
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

  @override
  Future<List<DnsRecord>> getDnsRecords({
    required final ServerDomain domain,
  }) async {
    Response response;
    final String domainName = domain.domainName;
    final List<DnsRecord> allRecords = <DnsRecord>[];

    /// Default amount is 20, but we will eventually overflow it,
    /// so I hardcode it to the maximum available amount in advance just in case
    ///
    /// https://docs.digitalocean.com/reference/api/api-reference/#operation/domains_list_records
    const int amountPerPage = 200;
    final String url = '/domains/$domainName/records?per_page=$amountPerPage';

    final Dio client = await getClient();
    try {
      response = await client.get(url);
      final List records = response.data['domain_records'] ?? [];

      for (final record in records) {
        allRecords.add(
          DnsRecord(
            id: record['id'],
            name: record['name'],
            type: record['type'],
            content: record['data'],
            ttl: record['ttl'],
            proxied: false,
          ),
        );
      }
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }

    return allRecords;
  }

  @override
  List<DesiredDnsRecord> getDesiredDnsRecords({
    final String? domainName,
    final String? ipAddress,
    final String? dkimPublicKey,
  }) {
    if (domainName == null || ipAddress == null) {
      return [];
    }
    return [
      DesiredDnsRecord(
        name: '@',
        content: ipAddress,
        description: 'record.root',
        displayName: domainName,
      ),
      DesiredDnsRecord(
        name: 'api',
        content: ipAddress,
        description: 'record.api',
        displayName: 'api.$domainName',
      ),
      DesiredDnsRecord(
        name: 'cloud',
        content: ipAddress,
        description: 'record.cloud',
        displayName: 'cloud.$domainName',
      ),
      DesiredDnsRecord(
        name: 'git',
        content: ipAddress,
        description: 'record.git',
        displayName: 'git.$domainName',
      ),
      DesiredDnsRecord(
        name: 'meet',
        content: ipAddress,
        description: 'record.meet',
        displayName: 'meet.$domainName',
      ),
      DesiredDnsRecord(
        name: 'social',
        content: ipAddress,
        description: 'record.social',
        displayName: 'social.$domainName',
      ),
      DesiredDnsRecord(
        name: 'password',
        content: ipAddress,
        description: 'record.password',
        displayName: 'password.$domainName',
      ),
      DesiredDnsRecord(
        name: 'vpn',
        content: ipAddress,
        description: 'record.vpn',
        displayName: 'vpn.$domainName',
      ),
      const DesiredDnsRecord(
        name: '@',
        content: '@',
        description: 'record.mx',
        type: 'MX',
        category: DnsRecordsCategory.email,
      ),
      const DesiredDnsRecord(
        name: '_dmarc',
        content: 'v=DMARC1; p=none',
        description: 'record.dmarc',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: '@',
        content: 'v=spf1 a mx ip4:$ipAddress -all',
        description: 'record.spf',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      if (dkimPublicKey != null)
        DesiredDnsRecord(
          name: 'selector._domainkey',
          content: dkimPublicKey,
          description: 'record.dkim',
          type: 'TXT',
          category: DnsRecordsCategory.email,
        ),
    ];
  }

  @override
  Future<GenericResult<void>> createMultipleDnsRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final String domainName = domain.domainName;
    final List<DnsRecord> dnsRecords = getProjectDnsRecords(domainName, ip4);
    final List<Future> allCreateFutures = <Future>[];

    final Dio client = await getClient();
    try {
      for (final DnsRecord record in dnsRecords) {
        allCreateFutures.add(
          client.post(
            '/domains/$domainName/records',
            data: {
              'type': record.type,
              'name': record.name == domainName ? '@' : record.name,
              'data': record.type == 'MX' ? '@' : record.content,
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

  @override
  Future<void> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  ) async {
    final Dio client = await getClient();
    try {
      final domainName = domain.domainName;
      await client.post(
        '/domains/$domainName/records',
        data: {
          'type': record.type,
          'name': record.name,
          'data': record.content,
          'ttl': record.ttl,
          'priority': record.priority,
        },
      );
    } catch (e) {
      print(e);
    } finally {
      close(client);
    }
  }

  @override
  Future<List<String>> domainList() async {
    List<String> domains = [];

    final Dio client = await getClient();
    try {
      final Response response = await client.get('/domains');
      domains = response.data['domains']
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
