import 'package:json_annotation/json_annotation.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

part 'porkbun_dns_info.g.dart';
part 'porkbun_dns_adapter.dart';

@JsonSerializable()
class PorkbunDomain {
  PorkbunDomain({
    required this.domain,
    required this.autoRenew,
    required this.createDate,
    required this.expireDate,
    required this.notLocal,
    required this.securityLock,
    required this.status,
    required this.tld,
    required this.whoisPrivacy,
  });

  final String domain;

  /// 1 if auto-renew is enabled, 0 otherwise
  final int autoRenew;

  /// Format: "2026-04-08 12:36:31"
  final String createDate;

  /// Format: "2026-04-08 12:36:31"
  final String expireDate;

  /// 1 if the domain is externally managed (not authoritative), 0 otherwise
  final int notLocal;

  /// 1 if transfer lock is enabled, 0 otherwise
  final int securityLock;

  /// Domain registration status (e.g. ACTIVE)
  final String status;

  final String tld;

  /// 1 if WHOIS privacy is enabled, 0 otherwise
  final int whoisPrivacy;

  static PorkbunDomain fromJson(final Map<String, dynamic> json) =>
      _$PorkbunDomainFromJson(json);
  ServerDomain toServerDomain() => _toServerDomain(this);
}

@JsonSerializable()
class PorkbunDnsRecord {
  PorkbunDnsRecord({
    required this.content,
    required this.name,
    required this.ttl,
    required this.type,
    this.id,
    this.notes,
    this.prio,
  });

  factory PorkbunDnsRecord.fromDnsRecord(
    final DnsRecord dnsRecord,
    final String domainName,
  ) => _fromDnsRecord(dnsRecord, domainName);

  /// Record value
  final String content;

  /// Numeric record ID
  final String? id;

  /// When fetching: Fully-qualified record name
  /// When creating/updating: Subdomain for the record (e.g. 'www', '*' for wildcard, blank for root). Do not include the domain name itself.
  final String name;

  /// Optional notes attached to the record. Null if not set.
  final String? notes;

  /// Priority (used for MX, SRV records). Null if not applicable.
  final String? prio;

  /// Time to live in seconds
  final String ttl;

  /// DNS record type
  /// Available types: A, AAAA, MX, CNAME, ALIAS, NS, TXT, SRV, CAA, TLSA, SSHFP
  final String type;

  static PorkbunDnsRecord fromJson(final Map<String, dynamic> json) =>
      _$PorkbunDnsRecordFromJson(json);
  Map<String, dynamic> toJson() => _$PorkbunDnsRecordToJson(this);
  DnsRecord toDnsRecord(final String domainName) =>
      _toDnsRecord(this, domainName);
}
