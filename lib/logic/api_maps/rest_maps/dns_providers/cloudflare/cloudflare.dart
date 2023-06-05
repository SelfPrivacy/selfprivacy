import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/utils/network_utils.dart';

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
    final List<DnsRecord> listDnsRecords = projectDnsRecords(domainName, ip4);
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

  List<DnsRecord> projectDnsRecords(
    final String? domainName,
    final String? ip4,
  ) {
    final DnsRecord domainA =
        DnsRecord(type: 'A', name: domainName, content: ip4);

    final DnsRecord mx = DnsRecord(type: 'MX', name: '@', content: domainName);
    final DnsRecord apiA = DnsRecord(type: 'A', name: 'api', content: ip4);
    final DnsRecord cloudA = DnsRecord(type: 'A', name: 'cloud', content: ip4);
    final DnsRecord gitA = DnsRecord(type: 'A', name: 'git', content: ip4);
    final DnsRecord meetA = DnsRecord(type: 'A', name: 'meet', content: ip4);
    final DnsRecord passwordA =
        DnsRecord(type: 'A', name: 'password', content: ip4);
    final DnsRecord socialA =
        DnsRecord(type: 'A', name: 'social', content: ip4);
    final DnsRecord vpn = DnsRecord(type: 'A', name: 'vpn', content: ip4);

    final DnsRecord txt1 = DnsRecord(
      type: 'TXT',
      name: '_dmarc',
      content: 'v=DMARC1; p=none',
      ttl: 18000,
    );

    final DnsRecord txt2 = DnsRecord(
      type: 'TXT',
      name: domainName,
      content: 'v=spf1 a mx ip4:$ip4 -all',
      ttl: 18000,
    );

    return <DnsRecord>[
      domainA,
      apiA,
      cloudA,
      gitA,
      meetA,
      passwordA,
      socialA,
      mx,
      txt1,
      txt2,
      vpn
    ];
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

  @override
  Future<APIGenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String ip4,
    final String dkimPublicKey,
  ) async {
    final List<DnsRecord> records = await getDnsRecords(domain: domain);
    final List<DesiredDnsRecord> foundRecords = [];
    try {
      final List<DesiredDnsRecord> desiredRecords =
          getDesiredDnsRecords(domain.domainName, ip4, dkimPublicKey);
      for (final DesiredDnsRecord record in desiredRecords) {
        if (record.description == 'record.dkim') {
          final DnsRecord foundRecord = records.firstWhere(
            (final r) => (r.name == record.name) && r.type == record.type,
            orElse: () => DnsRecord(
              name: record.name,
              type: record.type,
              content: '',
              ttl: 800,
              proxied: false,
            ),
          );
          // remove all spaces and tabulators from
          // the foundRecord.content and the record.content
          // to compare them
          final String? foundContent =
              foundRecord.content?.replaceAll(RegExp(r'\s+'), '');
          final String content = record.content.replaceAll(RegExp(r'\s+'), '');
          if (foundContent == content) {
            foundRecords.add(record.copyWith(isSatisfied: true));
          } else {
            foundRecords.add(record.copyWith(isSatisfied: false));
          }
        } else {
          if (records.any(
            (final r) =>
                (r.name == record.name) &&
                r.type == record.type &&
                r.content == record.content,
          )) {
            foundRecords.add(record.copyWith(isSatisfied: true));
          } else {
            foundRecords.add(record.copyWith(isSatisfied: false));
          }
        }
      }
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    }
    return APIGenericResult(
      data: foundRecords,
      success: true,
    );
  }

  @override
  List<DesiredDnsRecord> getDesiredDnsRecords(
    final String? domainName,
    final String? ip4,
    final String? dkimPublicKey,
  ) {
    if (domainName == null || ip4 == null) {
      return [];
    }
    return [
      DesiredDnsRecord(
        name: domainName,
        content: ip4,
        description: 'record.root',
      ),
      DesiredDnsRecord(
        name: 'api.$domainName',
        content: ip4,
        description: 'record.api',
      ),
      DesiredDnsRecord(
        name: 'cloud.$domainName',
        content: ip4,
        description: 'record.cloud',
      ),
      DesiredDnsRecord(
        name: 'git.$domainName',
        content: ip4,
        description: 'record.git',
      ),
      DesiredDnsRecord(
        name: 'meet.$domainName',
        content: ip4,
        description: 'record.meet',
      ),
      DesiredDnsRecord(
        name: 'social.$domainName',
        content: ip4,
        description: 'record.social',
      ),
      DesiredDnsRecord(
        name: 'password.$domainName',
        content: ip4,
        description: 'record.password',
      ),
      DesiredDnsRecord(
        name: 'vpn.$domainName',
        content: ip4,
        description: 'record.vpn',
      ),
      DesiredDnsRecord(
        name: domainName,
        content: domainName,
        description: 'record.mx',
        type: 'MX',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: '_dmarc.$domainName',
        content: 'v=DMARC1; p=none',
        description: 'record.dmarc',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: domainName,
        content: 'v=spf1 a mx ip4:$ip4 -all',
        description: 'record.spf',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      if (dkimPublicKey != null)
        DesiredDnsRecord(
          name: 'selector._domainkey.$domainName',
          content: dkimPublicKey,
          description: 'record.dkim',
          type: 'TXT',
          category: DnsRecordsCategory.email,
        ),
    ];
  }
}
