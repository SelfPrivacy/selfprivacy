import 'package:selfprivacy/logic/api_maps/api_generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

export 'package:selfprivacy/logic/api_maps/api_generic_result.dart';
export 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';

class DomainNotFoundException implements Exception {
  DomainNotFoundException(this.message);
  final String message;
}

abstract class DnsProviderApi extends ApiMap {
  Future<List<DnsRecord>> getDnsRecords({
    required final ServerDomain domain,
  });
  List<DesiredDnsRecord> getDesiredDnsRecords({
    final String? domainName,
    final String? ipAddress,
    final String? dkimPublicKey,
  });
  Future<APIGenericResult<void>> removeSimilarRecords({
    required final ServerDomain domain,
    final String? ip4,
  });
  Future<APIGenericResult<void>> createMultipleDnsRecords({
    required final ServerDomain domain,
    final String? ip4,
  });
  Future<void> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  );
  Future<String?> getZoneId(final String domain);
  Future<List<String>> domainList();

  Future<APIGenericResult<bool>> isApiTokenValid(final String token);
  RegExp getApiTokenValidation();

  List<DnsRecord> getProjectDnsRecords(
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
}
