// ignore_for_file: always_specify_types

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

class DomainNotFoundException implements Exception {
  DomainNotFoundException(this.message);
  final String message;
}

class CloudflareApi extends ApiMap {

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
    final BaseOptions options = BaseOptions(baseUrl: rootAddress);
    if (isWithToken) {
      final String? token = getIt<ApiConfigModel>().cloudFlareKey;
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

  Future<bool> isValid(final String token) async {
    validateStatus = (final status) => status == HttpStatus.ok || status == HttpStatus.unauthorized;

    final Dio client = await getClient();
    final Response response = await client.get('/user/tokens/verify',
        options: Options(headers: {'Authorization': 'Bearer $token'}),);

    close(client);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

  Future<String> getZoneId(final String domain) async {
    validateStatus = (final status) => status == HttpStatus.ok || status == HttpStatus.forbidden;
    final Dio client = await getClient();
    final Response response = await client.get(
      '/zones',
      queryParameters: {'name': domain},
    );

    close(client);

    if (response.data['result'].isEmpty) {
      throw DomainNotFoundException('No domains found');
    } else {
      return response.data['result'][0]['id'];
    }
  }

  Future<void> removeSimilarRecords({
    required final ServerDomain cloudFlareDomain,
    final String? ip4,
  }) async {
    final String domainName = cloudFlareDomain.domainName;
    final String domainZoneId = cloudFlareDomain.zoneId;

    final String url = '/zones/$domainZoneId/dns_records';

    final Dio client = await getClient();
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
    close(client);
  }

  Future<List<DnsRecord>> getDnsRecords({
    required final ServerDomain cloudFlareDomain,
  }) async {
    final String domainName = cloudFlareDomain.domainName;
    final String domainZoneId = cloudFlareDomain.zoneId;

    final String url = '/zones/$domainZoneId/dns_records';

    final Dio client = await getClient();
    final Response response = await client.get(url);

    final List records = response.data['result'] ?? [];
    final List<DnsRecord> allRecords = <DnsRecord>[];

    for (final record in records) {
      if (record['zone_name'] == domainName) {
        allRecords.add(DnsRecord(
          name: record['name'],
          type: record['type'],
          content: record['content'],
          ttl: record['ttl'],
          proxied: record['proxied'],
        ),);
      }
    }

    close(client);
    return allRecords;
  }

  Future<void> createMultipleDnsRecords({
    required final ServerDomain cloudFlareDomain,
    final String? ip4,
  }) async {
    final String domainName = cloudFlareDomain.domainName;
    final String domainZoneId = cloudFlareDomain.zoneId;
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
    } finally {
      close(client);
    }
  }

  List<DnsRecord> projectDnsRecords(final String? domainName, final String? ip4) {
    final DnsRecord domainA = DnsRecord(type: 'A', name: domainName, content: ip4);

    final DnsRecord mx = DnsRecord(type: 'MX', name: '@', content: domainName);
    final DnsRecord apiA = DnsRecord(type: 'A', name: 'api', content: ip4);
    final DnsRecord cloudA = DnsRecord(type: 'A', name: 'cloud', content: ip4);
    final DnsRecord gitA = DnsRecord(type: 'A', name: 'git', content: ip4);
    final DnsRecord meetA = DnsRecord(type: 'A', name: 'meet', content: ip4);
    final DnsRecord passwordA = DnsRecord(type: 'A', name: 'password', content: ip4);
    final DnsRecord socialA = DnsRecord(type: 'A', name: 'social', content: ip4);
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

  Future<void> setDkim(
      final String dkimRecordString, final ServerDomain cloudFlareDomain,) async {
    final String domainZoneId = cloudFlareDomain.zoneId;
    final String url = '$rootAddress/zones/$domainZoneId/dns_records';

    final DnsRecord dkimRecord = DnsRecord(
      type: 'TXT',
      name: 'selector._domainkey',
      content: dkimRecordString,
      ttl: 18000,
    );

    final Dio client = await getClient();
    await client.post(
      url,
      data: dkimRecord.toJson(),
    );

    client.close();
  }

  Future<List<String>> domainList() async {
    final String url = '$rootAddress/zones';
    final Dio client = await getClient();

    final Response response = await client.get(
      url,
      queryParameters: {'per_page': 50},
    );

    close(client);
    return response.data['result']
        .map<String>((final el) => el['name'] as String)
        .toList();
  }
}
