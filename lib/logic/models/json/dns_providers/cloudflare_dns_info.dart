import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

part 'cloudflare_dns_info.g.dart';
part 'cloudflare_dns_adapter.dart';

/// https://developers.cloudflare.com/api/operations/zones-get
@JsonSerializable()
class CloudflareZone {
  CloudflareZone({required this.id, required this.name});

  /// Zone identifier
  ///
  /// `<= 32 characters`
  ///
  /// Example: 023e105f4ecef8ad9ca31a8372d0c353
  final String id;

  /// The domain name
  ///
  /// `<= 253 characters`
  ///
  /// Example: example.com
  final String name;

  static CloudflareZone fromJson(final Map<String, dynamic> json) =>
      _$CloudflareZoneFromJson(json);
  ServerDomain toServerDomain() => _toServerDomain(this);
}

/// https://developers.cloudflare.com/api/operations/dns-records-for-a-zone-list-dns-records
@JsonSerializable()
class CloudflareDnsRecord {
  CloudflareDnsRecord({
    required this.type,
    required this.name,
    this.content,
    this.data,
    this.ttl = 3600,
    this.priority = 10,
    this.id,
    this.comment = 'Created by SelfPrivacy app',
  });

  factory CloudflareDnsRecord.fromDnsRecord(
    final DnsRecord dnsRecord,
    final String rootDomain,
  ) => _fromDnsRecord(dnsRecord, rootDomain);

  /// Record identifier
  ///
  /// `<= 32 characters`
  /// Example: 023e105f4ecef8ad9ca31a8372d0c353
  final String? id;

  /// Record type.
  ///
  /// Example: A
  final String type;

  /// DNS record name (or @ for the zone apex) in Punycode.
  ///
  /// `<= 255 characters`
  ///
  /// Example: example.com
  final String? name;

  /// Valid DNS Record string content.
  ///
  /// Example: A valid IPv4 address "198.51.100.4"
  final String? content;

  /// Some record types require data object instead of the content.
  final Map<String, dynamic>? data;

  /// Time To Live (TTL) of the DNS record in seconds. Setting to 1 means 'automatic'.
  ///
  /// Value must be between 60 and 86400, with the minimum reduced to 30 for Enterprise zones.
  final int ttl;

  /// Required for MX, SRV and URI records; unused by other record types. Records with lower priorities are preferred.
  ///
  /// `>= 0 <= 65535`
  final int priority;

  /// Comments or notes about the DNS record. This field has no effect on DNS responses.
  final String comment;

  static CloudflareDnsRecord fromJson(final Map<String, dynamic> json) =>
      _$CloudflareDnsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$CloudflareDnsRecordToJson(this);
  DnsRecord toDnsRecord(final String domainName) =>
      _toDnsRecord(this, domainName);
}
