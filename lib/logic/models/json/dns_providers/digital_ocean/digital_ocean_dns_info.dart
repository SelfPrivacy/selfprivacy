import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

part 'digital_ocean_dns_info.g.dart';
part 'digital_ocean_dns_adapter.dart';

/// https://docs.digitalocean.com/reference/api/api-reference/#tag/Domains
@JsonSerializable()
class DigitalOceanDomain {
  DigitalOceanDomain({required this.name, this.ttl});

  factory DigitalOceanDomain.fromServerDomain(
    final ServerDomain serverDomain,
  ) => _fromServerDomain(serverDomain);

  /// The name of the domain itself.
  /// This should follow the standard domain format of domain.TLD.
  ///
  /// For instance, example.com is a valid domain name.
  final String name;

  /// This value is the time to live for the records on this domain, in seconds.
  ///
  /// This defines the time frame that clients can cache queried information before a refresh should be requested.
  final int? ttl;

  static DigitalOceanDomain fromJson(final Map<String, dynamic> json) =>
      _$DigitalOceanDomainFromJson(json);
  ServerDomain toServerDomain() => _toServerDomain(this);
}

/// https://docs.digitalocean.com/reference/api/api-reference/#tag/Domain-Records
@JsonSerializable()
class DigitalOceanDnsRecord {
  DigitalOceanDnsRecord({
    required this.id,
    required this.name,
    required this.type,
    required this.ttl,
    required this.data,
    this.priority,
    this.flags,
    this.tag,
  });

  factory DigitalOceanDnsRecord.fromDnsRecord(
    final DnsRecord dnsRecord,
    final String rootDomain,
  ) => _fromDnsRecord(dnsRecord, rootDomain);

  /// A unique identifier for each domain record.
  final int? id;

  /// The host name, alias, or service being defined by the record.
  final String name;

  /// The type of the DNS record. For example: A, CNAME, TXT, ...
  final String type;

  /// This value is the time to live for the record, in seconds.
  ///
  /// This defines the time frame that clients can cache queried information before a refresh should be requested.
  final int ttl;

  /// Variable data depending on record type.
  ///
  /// For example, the "data" value for an A record would be the IPv4 address to which the domain will be mapped.
  /// For a CAA record, it would contain the domain name of the CA being granted permission to issue certificates.
  final String data;

  /// The priority for SRV and MX records.
  final int? priority;

  /// The flags for CAA records.
  final int? flags;

  /// The tag for CAA records.
  final String? tag;

  static DigitalOceanDnsRecord fromJson(final Map<String, dynamic> json) =>
      _$DigitalOceanDnsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$DigitalOceanDnsRecordToJson(this);
  DnsRecord toDnsRecord(final String rootDomain) =>
      _toDnsRecord(this, rootDomain);
}
