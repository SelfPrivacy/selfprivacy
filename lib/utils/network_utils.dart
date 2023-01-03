import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:url_launcher/url_launcher.dart';

enum DnsRecordsCategory {
  services,
  email,
  other,
}

class DesiredDnsRecord {
  const DesiredDnsRecord({
    required this.name,
    required this.content,
    this.type = 'A',
    this.description = '',
    this.category = DnsRecordsCategory.services,
    this.isSatisfied = false,
  });

  final String name;
  final String type;
  final String content;
  final String description;
  final DnsRecordsCategory category;
  final bool isSatisfied;

  DesiredDnsRecord copyWith({
    final String? name,
    final String? type,
    final String? content,
    final String? description,
    final DnsRecordsCategory? category,
    final bool? isSatisfied,
  }) =>
      DesiredDnsRecord(
        name: name ?? this.name,
        type: type ?? this.type,
        content: content ?? this.content,
        description: description ?? this.description,
        category: category ?? this.category,
        isSatisfied: isSatisfied ?? this.isSatisfied,
      );
}

List<DesiredDnsRecord> getDesiredDnsRecords(
  final String? domainName,
  final String? ipAddress,
  final String? dkimPublicKey,
) {
  if (domainName == null || ipAddress == null) {
    return [];
  }
  return [
    DesiredDnsRecord(
      name: domainName,
      content: ipAddress,
      description: 'record.root',
    ),
    DesiredDnsRecord(
      name: 'api.$domainName',
      content: ipAddress,
      description: 'record.api',
    ),
    DesiredDnsRecord(
      name: 'cloud.$domainName',
      content: ipAddress,
      description: 'record.cloud',
    ),
    DesiredDnsRecord(
      name: 'git.$domainName',
      content: ipAddress,
      description: 'record.git',
    ),
    DesiredDnsRecord(
      name: 'meet.$domainName',
      content: ipAddress,
      description: 'record.meet',
    ),
    DesiredDnsRecord(
      name: 'social.$domainName',
      content: ipAddress,
      description: 'record.social',
    ),
    DesiredDnsRecord(
      name: 'password.$domainName',
      content: ipAddress,
      description: 'record.password',
    ),
    DesiredDnsRecord(
      name: 'vpn.$domainName',
      content: ipAddress,
      description: 'record.vpn',
    ),
    DesiredDnsRecord(
      name: domainName,
      content: domainName,
      description: 'record.mx',
      type: 'MX',
      category: DnsRecordsCategory.email,
    ),
    DesiredDnsRecord(
      name: '_dmarc.$domainName',
      content: 'v=DMARC1; p=none',
      description: 'record.dmarc',
      type: 'TXT',
      category: DnsRecordsCategory.email,
    ),
    DesiredDnsRecord(
      name: domainName,
      content: 'v=spf1 a mx ip4:$ipAddress -all',
      description: 'record.spf',
      type: 'TXT',
      category: DnsRecordsCategory.email,
    ),
    if (dkimPublicKey != null)
      DesiredDnsRecord(
        name: 'selector._domainkey.$domainName',
        content: dkimPublicKey,
        description: 'record.dkim',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
  ];
}

DnsRecord? extractDkimRecord(final List<DnsRecord> records) {
  DnsRecord? dkimRecord;

  for (final DnsRecord record in records) {
    if (record.type == 'TXT' && record.name == 'selector._domainkey') {
      dkimRecord = record;
    }
  }

  return dkimRecord;
}

String getHostnameFromDomain(final String domain) {
  // Replace all non-alphanumeric characters with an underscore
  String hostname =
      domain.split('.')[0].replaceAll(RegExp(r'[^a-zA-Z0-9]'), '-');
  if (hostname.endsWith('-')) {
    hostname = hostname.substring(0, hostname.length - 1);
  }
  if (hostname.startsWith('-')) {
    hostname = hostname.substring(1);
  }
  if (hostname.isEmpty) {
    hostname = 'selfprivacy-server';
  }

  return hostname;
}

void launchURL(final url) async {
  try {
    final Uri uri = Uri.parse(url);
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    print(e);
  }
}
