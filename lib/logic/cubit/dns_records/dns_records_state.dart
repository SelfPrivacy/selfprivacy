// ignore_for_file: always_specify_types

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
    final DnsRecordsStatus? dnsState,
    final List<DesiredDnsRecord>? dnsRecords,
  }) => DnsRecordsState(
      dnsState: dnsState ?? this.dnsState,
      dnsRecords: dnsRecords ?? this.dnsRecords,
    );
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
  }) => DesiredDnsRecord(
      name: name ?? this.name,
      type: type ?? this.type,
      content: content ?? this.content,
      description: description ?? this.description,
      category: category ?? this.category,
      isSatisfied: isSatisfied ?? this.isSatisfied,
    );
}
