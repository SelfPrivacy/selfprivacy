import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

import 'package:selfprivacy/logic/api_maps/cloudflare.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';

part 'dns_records_state.dart';

class DnsRecordsCubit
    extends ServerInstallationDependendCubit<DnsRecordsState> {
  DnsRecordsCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(
          serverInstallationCubit,
          const DnsRecordsState(dnsState: DnsRecordsStatus.refreshing),
        );

  final ServerApi api = ServerApi();
  final CloudflareApi cloudflare = CloudflareApi();

  @override
  Future<void> load() async {
    emit(
      DnsRecordsState(
        dnsState: DnsRecordsStatus.refreshing,
        dnsRecords: _getDesiredDnsRecords(
          serverInstallationCubit.state.serverDomain?.domainName,
          '',
          '',
        ),
      ),
    );
    print('Loading DNS status');
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final ServerDomain? domain = serverInstallationCubit.state.serverDomain;
      final String? ipAddress =
          serverInstallationCubit.state.serverDetails?.ip4;
      if (domain != null && ipAddress != null) {
        final List<DnsRecord> records =
            await cloudflare.getDnsRecords(cloudFlareDomain: domain);
        final String? dkimPublicKey = await api.getDkim();
        final List<DesiredDnsRecord> desiredRecords =
            _getDesiredDnsRecords(domain.domainName, ipAddress, dkimPublicKey);
        final List<DesiredDnsRecord> foundRecords = [];
        for (final DesiredDnsRecord record in desiredRecords) {
          if (record.description ==
              'providers.domain.record_description.dkim') {
            final DnsRecord foundRecord = records.firstWhere(
              (final r) => r.name == record.name && r.type == record.type,
              orElse: () => DnsRecord(
                name: record.name,
                type: record.type,
                content: '',
                ttl: 800,
                proxied: false,
              ),
            );
            // remove all spaces and tabulators from
            // the foundRecord.content and the record.content
            // to compare them
            final String? foundContent =
                foundRecord.content?.replaceAll(RegExp(r'\s+'), '');
            final String content =
                record.content.replaceAll(RegExp(r'\s+'), '');
            if (foundContent == content) {
              foundRecords.add(record.copyWith(isSatisfied: true));
            } else {
              foundRecords.add(record.copyWith(isSatisfied: false));
            }
          } else {
            if (records.any(
              (final r) =>
                  r.name == record.name &&
                  r.type == record.type &&
                  r.content == record.content,
            )) {
              foundRecords.add(record.copyWith(isSatisfied: true));
            } else {
              foundRecords.add(record.copyWith(isSatisfied: false));
            }
          }
        }
        emit(
          DnsRecordsState(
            dnsRecords: foundRecords,
            dnsState: foundRecords.any((final r) => r.isSatisfied == false)
                ? DnsRecordsStatus.error
                : DnsRecordsStatus.good,
          ),
        );
      } else {
        emit(const DnsRecordsState());
      }
    }
  }

  @override
  void onChange(final Change<DnsRecordsState> change) {
    // print(change);
    super.onChange(change);
  }

  @override
  Future<void> clear() async {
    emit(const DnsRecordsState(dnsState: DnsRecordsStatus.error));
  }

  Future<void> refresh() async {
    emit(state.copyWith(dnsState: DnsRecordsStatus.refreshing));
    await load();
  }

  Future<void> fix() async {
    emit(state.copyWith(dnsState: DnsRecordsStatus.refreshing));
    final ServerDomain? domain = serverInstallationCubit.state.serverDomain;
    final String? ipAddress = serverInstallationCubit.state.serverDetails?.ip4;
    final String? dkimPublicKey = await api.getDkim();
    await cloudflare.removeSimilarRecords(cloudFlareDomain: domain!);
    await cloudflare.createMultipleDnsRecords(
      cloudFlareDomain: domain,
      ip4: ipAddress,
    );
    await cloudflare.setDkim(dkimPublicKey ?? '', domain);
    await load();
  }

  List<DesiredDnsRecord> _getDesiredDnsRecords(
    final String? domainName,
    final String? ipAddress,
    final String? dkimPublicKey,
  ) {
    if (domainName == null || ipAddress == null || dkimPublicKey == null) {
      return [];
    }
    return [
      DesiredDnsRecord(
        name: domainName,
        content: ipAddress,
        description: 'providers.domain.record_description.root',
      ),
      DesiredDnsRecord(
        name: 'api.$domainName',
        content: ipAddress,
        description: 'providers.domain.record_description.api',
      ),
      DesiredDnsRecord(
        name: 'cloud.$domainName',
        content: ipAddress,
        description: 'providers.domain.record_description.cloud',
      ),
      DesiredDnsRecord(
        name: 'git.$domainName',
        content: ipAddress,
        description: 'providers.domain.record_description.git',
      ),
      DesiredDnsRecord(
        name: 'meet.$domainName',
        content: ipAddress,
        description: 'providers.domain.record_description.meet',
      ),
      DesiredDnsRecord(
        name: 'social.$domainName',
        content: ipAddress,
        description: 'providers.domain.record_description.social',
      ),
      DesiredDnsRecord(
        name: 'password.$domainName',
        content: ipAddress,
        description: 'providers.domain.record_description.password',
      ),
      DesiredDnsRecord(
        name: 'vpn.$domainName',
        content: ipAddress,
        description: 'providers.domain.record_description.vpn',
      ),
      DesiredDnsRecord(
        name: domainName,
        content: domainName,
        description: 'providers.domain.record_description.mx',
        type: 'MX',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: '_dmarc.$domainName',
        content: 'v=DMARC1; p=none',
        description: 'providers.domain.record_description.dmarc',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: domainName,
        content: 'v=spf1 a mx ip4:$ipAddress -all',
        description: 'providers.domain.record_description.spf',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: 'selector._domainkey.$domainName',
        content: dkimPublicKey,
        description: 'providers.domain.record_description.dkim',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
    ];
  }
}
