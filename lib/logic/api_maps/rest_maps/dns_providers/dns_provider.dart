import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

class DomainNotFoundException implements Exception {
  DomainNotFoundException(this.message);
  final String message;
}

abstract class DnsProviderApi extends ApiMap {
  Future<List<DnsRecord>> getDnsRecords({
    required final ServerDomain domain,
  });
  Future<void> removeSimilarRecords({
    required final ServerDomain domain,
    final String? ip4,
  });
  Future<void> createMultipleDnsRecords({
    required final ServerDomain domain,
    final String? ip4,
  });
  Future<void> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  );
  Future<String?> getZoneId(final String domain);
  Future<List<String>> domainList();

  Future<bool> isApiTokenValid(final String token);
  RegExp getApiTokenValidation();
}
