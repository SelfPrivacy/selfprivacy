import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
export 'package:selfprivacy/logic/api_maps/generic_result.dart';

abstract class DnsProvider {
  /// Returns an assigned enum value, respectively to which
  /// provider implements [DnsProvider] interface.
  DnsProviderType get type;

  /// Returns a full url to a guide on how to setup
  /// DNS provider nameservers
  String get howToRegistar;

  /// Tries to access an account linked to the provided token.
  ///
  /// To generate a token for your account follow instructions of your
  /// DNS provider respectfully.
  ///
  /// If success, saves it for future usage.
  Future<GenericResult<bool>> tryInitApiByToken(final String token);

  /// Returns list of all available domain entries assigned to the account.
  Future<GenericResult<List<ServerDomain>>> domainList();

  /// Tries to create domain records
  /// by our records list.
  ///
  /// Doesn't check for duplication, cleaning has
  /// to be done beforehand by [removeDomainRecords]
  Future<GenericResult<void>> createDomainRecords({
    required final List<DnsRecord> records,
    required final ServerDomain domain,
  });

  /// Tries to remove all records of requested
  /// domain that match our records list.
  Future<GenericResult<void>> removeDomainRecords({
    required final List<DnsRecord> records,
    required final ServerDomain domain,
  });

  /// Returns list of all [DnsRecord] entries assigned to requested domain.
  Future<GenericResult<List<DnsRecord>>> getDnsRecords({
    required final ServerDomain domain,
  });

  /// Tries to create or update a domain record needed
  /// on requested domain.
  ///
  /// Doesn't check for duplication, cleaning has
  /// to be done beforehand by [removeDomainRecords]
  Future<GenericResult<void>> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  );
}
