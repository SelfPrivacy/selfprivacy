import 'package:selfprivacy/logic/models/json/dns_records.dart';

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
