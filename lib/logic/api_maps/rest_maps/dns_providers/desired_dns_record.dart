enum DnsRecordsCategory { services, email, other }

class DesiredDnsRecord {
  const DesiredDnsRecord({
    required this.name,
    required this.content,
    this.type = 'A',
    this.description = '',
    this.isSatisfied = false,
    this.displayName,
  });

  final String name;
  final String type;
  final String content;
  final String description;
  final String? displayName;
  final bool isSatisfied;

  DnsRecordsCategory get category {
    switch (type) {
      case 'A':
        return DnsRecordsCategory.services;
      case 'CAA':
        return DnsRecordsCategory.other;
      default:
        return DnsRecordsCategory.email;
    }
  }

  DesiredDnsRecord copyWith({
    final String? name,
    final String? type,
    final String? content,
    final String? description,
    final String? displayName,
    final bool? isSatisfied,
  }) => DesiredDnsRecord(
    name: name ?? this.name,
    type: type ?? this.type,
    content: content ?? this.content,
    description: description ?? this.description,
    isSatisfied: isSatisfied ?? this.isSatisfied,
    displayName: displayName ?? this.displayName,
  );
}
