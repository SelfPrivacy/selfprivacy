import 'dart:io';
import 'package:dio/dio.dart';
import 'package:selfprivacy/logic/api_maps/api_map.dart';
import 'package:selfprivacy/logic/models/cloudflare_domain.dart';
import 'package:selfprivacy/logic/models/dns_records.dart';

class CloudflareApi extends ApiMap {
  CloudflareApi([String? token]) {
    if (token != null) {
      loggedClient.options =
          BaseOptions(headers: {'Authorization': 'Bearer $token'});
    }
  }

  @override
  String? rootAddress = 'https://api.cloudflare.com/client/v4';

  Future<bool> isValid(String token) async {
    var url = '$rootAddress/user/tokens/verify';
    var options = Options(
      headers: {'Authorization': 'Bearer $token'},
      validateStatus: (status) {
        return status == HttpStatus.ok || status == HttpStatus.unauthorized;
      },
    );

    Response response = await loggedClient.get(url, options: options);

    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      return false;
    } else {
      throw Exception('code: ${response.statusCode}');
    }
  }

  Future<String?> getZoneId(String? token, String domain) async {
    var url = '$rootAddress/zones';

    var options = Options(
      headers: {'Authorization': 'Bearer $token'},
      validateStatus: (status) {
        return status == HttpStatus.ok || status == HttpStatus.forbidden;
      },
    );

    Response response = await loggedClient.get(
      url,
      options: options,
      queryParameters: {'name': domain},
    );

    try {
      return response.data['result'][0]['id'];
    } catch (error) {
      return null;
    }
  }

  Future<void> removeSimilarRecords({
    String? ip4,
    required CloudFlareDomain cloudFlareDomain,
  }) async {
    var domainName = cloudFlareDomain.domainName;
    var domainZoneId = cloudFlareDomain.zoneId;

    var url = '$rootAddress/zones/$domainZoneId/dns_records';

    var response = await loggedClient.get(url);
    List records = response.data['result'] ?? [];
    var allDeleteFutures = <Future>[];

    for (var record in records) {
      if (record['zone_name'] == domainName) {
        allDeleteFutures.add(
          loggedClient.delete('$url/${record["id"]}'),
        );
      }
    }
    await Future.wait(allDeleteFutures);
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

    for (var record in listDnsRecords) {
      allCreateFutures.add(
        loggedClient.post(
          url,
          data: record.toJson(),
        ),
      );
    }

    await Future.wait(allCreateFutures);
  }

  // setDkim(String dkimRecordString, String domainZoneId) {
  //   var txt3 = DnsRecords(
  //     type: 'TXT',
  //     name: 'selector._domainkey',
  //     content: dkimRecordString,
  //     ttl: 18000,
  //   );

  //   var url = '$rootAddress/zones/$domainZoneId/dns_records';
  //   loggedClient.post(
  //     url,
  //     data: txt3.toJson(),
  //   );
  // }

  List<DnsRecords> projectDnsRecords(String? domainName, String? ip4) {
    var domainA = DnsRecords(type: 'A', name: domainName, content: ip4);

    var mx = DnsRecords(type: 'MX', name: '@', content: domainName);
    var apiA = DnsRecords(type: 'A', name: 'api', content: ip4);
    var cloudA = DnsRecords(type: 'A', name: 'cloud', content: ip4);
    var gitA = DnsRecords(type: 'A', name: 'git', content: ip4);
    var meetA = DnsRecords(type: 'A', name: 'meet', content: ip4);
    var passwordA = DnsRecords(type: 'A', name: 'password', content: ip4);
    var socialA = DnsRecords(type: 'A', name: 'social', content: ip4);
    var vpn = DnsRecords(type: 'A', name: 'vpn', content: ip4);

    var txt1 = DnsRecords(
      type: 'TXT',
      name: '_dmarc',
      content: 'v=DMARC1; p=none',
      ttl: 18000,
    );

    var txt2 = DnsRecords(
      type: 'TXT',
      name: domainName,
      content: 'v=spf1 a mx ip4:$ip4 -all',
      ttl: 18000,
    );

    return <DnsRecords>[
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

  Future<List<String>> domainList() async {
    var url = '$rootAddress/zones?per_page=50';
    var response = await loggedClient.get(
      url,
      queryParameters: {'per_page': 50},
    );

    return response.data['result']
        .map<String>((el) => el['name'] as String)
        .toList();
  }
}
