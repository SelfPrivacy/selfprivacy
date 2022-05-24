part of 'dns_records_cubit.dart';

enum DnsRecordsStatus {
  uninitialized,
  refreshing,
  good,
  error,
}

enum DnsRecordsCategory {
  services,
  email,
  other,
}

class DnsRecordsState extends ServerInstallationDependendState {
  const DnsRecordsState({
    this.dnsState = DnsRecordsStatus.uninitialized,
    this.dnsRecords = const [],
  });

  final DnsRecordsStatus dnsState;
  final List<DesiredDnsRecord> dnsRecords;

  @override
  List<Object> get props => [
        dnsState,
        dnsRecords,
      ];

  DnsRecordsState copyWith({
    DnsRecordsStatus? dnsState,
    List<DesiredDnsRecord>? dnsRecords,
  }) {
    return DnsRecordsState(
      dnsState: dnsState ?? this.dnsState,
      dnsRecords: dnsRecords ?? this.dnsRecords,
    );
  }
}

class DesiredDnsRecord {
  const DesiredDnsRecord({
    required this.name,
    this.type = 'A',
    required this.content,
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
    String? name,
    String? type,
    String? content,
    String? description,
    DnsRecordsCategory? category,
    bool? isSatisfied,
  }) {
    return DesiredDnsRecord(
      name: name ?? this.name,
      type: type ?? this.type,
      content: content ?? this.content,
      description: description ?? this.description,
      category: category ?? this.category,
      isSatisfied: isSatisfied ?? this.isSatisfied,
    );
  }
}
