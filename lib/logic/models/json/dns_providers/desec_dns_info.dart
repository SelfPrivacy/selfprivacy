import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
part 'desec_dns_adapter.dart';
part 'desec_dns_info.g.dart';

/// https://desec.readthedocs.io/en/latest/dns/domains.html#domain-management
@JsonSerializable()
class DesecDomain {
  DesecDomain({required this.name, this.minimumTtl});

  factory DesecDomain.fromServerDomain(final ServerDomain serverDomain) =>
      _fromServerDomain(serverDomain);

  /// Restrictions on what is a valid domain name apply on
  /// a per-user basis.
  ///
  /// The maximum length is 191.
  final String name;

  /// Smallest TTL that can be used in an RRset.
  /// The value is set automatically by DESEC
  @JsonKey(name: 'minimum_ttl')
  final int? minimumTtl;

  static DesecDomain fromJson(final Map<String, dynamic> json) =>
      _$DesecDomainFromJson(json);
  ServerDomain toServerDomain() => _toServerDomain(this);
}

/// https://desec.readthedocs.io/en/latest/dns/rrsets.html#retrieving-and-creating-dns-records
@JsonSerializable()
class DesecDnsRecord {
  DesecDnsRecord({
    required this.subname,
    required this.type,
    required this.ttl,
    required this.records,
  });

  factory DesecDnsRecord.fromDnsRecord(
    final DnsRecord dnsRecord,
    final String domainName,
  ) => _fromDnsRecord(dnsRecord, domainName);

  /// Subdomain string which, together with domain, defines the RRset name.
  /// Typical examples are www or _443._tcp.
  final String subname;

  /// RRset type (uppercase). A broad range of record types is supported,
  /// with most DNSSEC-related types (and the SOA type) managed automagically
  /// by the backend.
  final String type;

  /// Time-to-live value, which dictates for how long resolvers may
  /// cache this RRset, measured in seconds.
  ///
  /// The smallest acceptable value is given by the domain’s minimum TTL setting.
  /// The maximum value is 86400 (one day).
  final int ttl;

  /// Array of record content strings.
  ///
  /// The maximum number of array elements is 4091,
  /// and the maximum length of the array is 64,000 (after JSON encoding).
  final List<String> records;

  static DesecDnsRecord fromJson(final Map<String, dynamic> json) =>
      _$DesecDnsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$DesecDnsRecordToJson(this);
  DnsRecord toDnsRecord(final String domainName) =>
      _toDnsRecord(this, domainName);
}
