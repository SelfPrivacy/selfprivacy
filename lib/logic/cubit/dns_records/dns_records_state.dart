part of 'dns_records_cubit.dart';

enum DnsRecordsStatus { uninitialized, refreshing, good, error }

class DnsRecordsState extends ServerInstallationDependendState {
  const DnsRecordsState({
    this.dnsState = DnsRecordsStatus.uninitialized,
    this.dnsRecords = const [],
  });

  final DnsRecordsStatus dnsState;
  final List<DesiredDnsRecord> dnsRecords;

  @override
  List<Object> get props => [dnsState, dnsRecords];

  DnsRecordsState copyWith({
    final DnsRecordsStatus? dnsState,
    final List<DesiredDnsRecord>? dnsRecords,
  }) => DnsRecordsState(
    dnsState: dnsState ?? this.dnsState,
    dnsRecords: dnsRecords ?? this.dnsRecords,
  );
}
