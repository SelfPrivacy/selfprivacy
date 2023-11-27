import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
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
  Future<GenericResult<List<String>>> domainList();

  /// Tries to create all main domain records needed
  /// for SelfPrivacy to launch on requested domain by ip4.
  ///
  /// Doesn't check for duplication, cleaning has
  /// to be done beforehand by [removeDomainRecords]
  Future<GenericResult<void>> createDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
  });

  /// Tries to remove all domain records of requested domain by ip4.
  ///
  /// Will remove all entries, including the ones
  /// that weren't created by SelfPrivacy.
  Future<GenericResult<void>> removeDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
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

  /// Tries to check whether all known DNS records on the domain by ip4
  /// match expectations of SelfPrivacy in order to launch.
  ///
  /// Will return list of [DesiredDnsRecord] objects, which represent
  /// only those records which have successfully passed validation.
  Future<GenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String ip4,
    final String dkimPublicKey,
  );

  /// Will return list of [DesiredDnsRecord] objects, which represent
  /// samples of perfect DNS records we need to know about in order to launch
  /// SelfPrivacy application correctly.
  List<DesiredDnsRecord> getDesiredDnsRecords(
    final String? domainName,
    final String? ip4,
    final String? dkimPublicKey,
  );
}
