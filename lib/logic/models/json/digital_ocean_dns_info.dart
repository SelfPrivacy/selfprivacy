import 'package:json_annotation/json_annotation.dart';

part 'digital_ocean_dns_info.g.dart';

/// https://docs.digitalocean.com/reference/api/api-reference/#tag/Domains
@JsonSerializable()
class DigitalOceanDomain {
  DigitalOceanDomain({
    required this.name,
    this.ttl,
  });

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
  });

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

  static DigitalOceanDnsRecord fromJson(final Map<String, dynamic> json) =>
      _$DigitalOceanDnsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$DigitalOceanDnsRecordToJson(this);
}
