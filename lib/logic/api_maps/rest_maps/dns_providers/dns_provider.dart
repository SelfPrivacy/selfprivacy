import 'package:selfprivacy/logic/api_maps/api_generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/utils/network_utils.dart';

export 'package:selfprivacy/logic/api_maps/api_generic_result.dart';

class DomainNotFoundException implements Exception {
  DomainNotFoundException(this.message);
  final String message;
}

abstract class DnsProviderApi extends ApiMap {
  Future<List<DnsRecord>> getDnsRecords({
    required final ServerDomain domain,
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
  Future<APIGenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String ip4,
    final String dkimPublicKey,
  );
  List<DesiredDnsRecord> getDesiredDnsRecords(
    final String? domainName,
    final String? ip4,
    final String? dkimPublicKey,
  );
  Future<String?> getZoneId(final String domain);
  Future<List<String>> domainList();
  Future<APIGenericResult<bool>> isApiTokenValid(final String token);
  RegExp getApiTokenValidation();
}
