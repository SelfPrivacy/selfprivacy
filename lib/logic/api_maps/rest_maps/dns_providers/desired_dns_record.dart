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
    this.displayName,
  });

  final String name;
  final String type;
  final String content;
  final String description;
  final String? displayName;
  final DnsRecordsCategory category;
  final bool isSatisfied;

  DesiredDnsRecord copyWith({
    final String? name,
    final String? type,
    final String? content,
    final String? description,
    final String? displayName,
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
        displayName: displayName ?? this.displayName,
      );
}
