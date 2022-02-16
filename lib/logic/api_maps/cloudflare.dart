import 'dart:io';

import 'package:dio/dio.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';
import 'package:selfprivacy/logic/models/dns_records.dart';

class CloudflareApi extends ApiMap {
  CloudflareApi({this.hasLoger = false, this.isWithToken = true});

  BaseOptions get options {
    var options = BaseOptions(baseUrl: rootAddress);
    if (isWithToken) {
      var token = getIt<ApiConfigModel>().cloudFlareKey;
      assert(token != null);
      options.headers = {'Authorization': 'Bearer $token'};
    }

    if (validateStatus != null) {
      options.validateStatus = validateStatus!;
    }
    return options;
  }

  @override
  String rootAddress = 'https://api.cloudflare.com/client/v4';

  Future<bool> isValid(String token) async {
    validateStatus = (status) {
      return status == HttpStatus.ok || status == HttpStatus.unauthorized;
    };

    var client = await getClient();
    Response response = await client.get('/user/tokens/verify',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    close(client);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

  Future<String> getZoneId(String domain) async {
    validateStatus = (status) {
      return status == HttpStatus.ok || status == HttpStatus.forbidden;
    };
    var client = await getClient();
    Response response = await client.get(
      '/zones',
      queryParameters: {'name': domain},
    );

    close(client);

    return response.data['result'][0]['id'];
  }

  Future<void> removeSimilarRecords({
    String? ip4,
    required CloudFlareDomain cloudFlareDomain,
  }) async {
    var domainName = cloudFlareDomain.domainName;
    var domainZoneId = cloudFlareDomain.zoneId;

    var url = '/zones/$domainZoneId/dns_records';

    var client = await getClient();
    Response response = await client.get(url);

    List records = response.data['result'] ?? [];
    var allDeleteFutures = <Future>[];

    for (var record in records) {
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
    required CloudFlareDomain cloudFlareDomain,
  }) async {
    var domainName = cloudFlareDomain.domainName;
    var domainZoneId = cloudFlareDomain.zoneId;

    var url = '/zones/$domainZoneId/dns_records';

    var client = await getClient();
    Response response = await client.get(url);

    List records = response.data['result'] ?? [];
    var allRecords = <DnsRecord>[];

    for (var record in records) {
      if (record['zone_name'] == domainName) {
        allRecords.add(DnsRecord(
          name: record['name'],
          type: record['type'],
          content: record['content'],
          ttl: record['ttl'],
          proxied: record['proxied'],
        ));
      }
    }

    close(client);
    return allRecords;
  }

  Future<void> createMultipleDnsRecords({
    String? ip4,
    required CloudFlareDomain cloudFlareDomain,
  }) async {
    var domainName = cloudFlareDomain.domainName;
    var domainZoneId = cloudFlareDomain.zoneId;
    var listDnsRecords = projectDnsRecords(domainName, ip4);

    var url = '$rootAddress/zones/$domainZoneId/dns_records';

    var allCreateFutures = <Future>[];
    var client = await getClient();

    for (var record in listDnsRecords) {
      allCreateFutures.add(
        client.post(
          url,
          data: record.toJson(),
        ),
      );
    }

    await Future.wait(allCreateFutures);
    close(client);
  }

  List<DnsRecord> projectDnsRecords(String? domainName, String? ip4) {
    var domainA = DnsRecord(type: 'A', name: domainName, content: ip4);

    var mx = DnsRecord(type: 'MX', name: '@', content: domainName);
    var apiA = DnsRecord(type: 'A', name: 'api', content: ip4);
    var cloudA = DnsRecord(type: 'A', name: 'cloud', content: ip4);
    var gitA = DnsRecord(type: 'A', name: 'git', content: ip4);
    var meetA = DnsRecord(type: 'A', name: 'meet', content: ip4);
    var passwordA = DnsRecord(type: 'A', name: 'password', content: ip4);
    var socialA = DnsRecord(type: 'A', name: 'social', content: ip4);
    var vpn = DnsRecord(type: 'A', name: 'vpn', content: ip4);

    var txt1 = DnsRecord(
      type: 'TXT',
      name: '_dmarc',
      content: 'v=DMARC1; p=none',
      ttl: 18000,
    );

    var txt2 = DnsRecord(
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
      String dkimRecordString, CloudFlareDomain cloudFlareDomain) async {
    final domainZoneId = cloudFlareDomain.zoneId;
    final url = '$rootAddress/zones/$domainZoneId/dns_records';

    final dkimRecord = DnsRecord(
      type: 'TXT',
      name: 'selector._domainkey',
      content: dkimRecordString,
      ttl: 18000,
    );

    var client = await getClient();
    await client.post(
      url,
      data: dkimRecord.toJson(),
    );

    client.close();
  }

  Future<List<String>> domainList() async {
    var url = '$rootAddress/zones?per_page=50';
    var client = await getClient();

    var response = await client.get(
      url,
      queryParameters: {'per_page': 50},
    );

    close(client);
    return response.data['result']
        .map<String>((el) => el['name'] as String)
        .toList();
  }

  @override
  final bool hasLoger;

  @override
  final bool isWithToken;
}
