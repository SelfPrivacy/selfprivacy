import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_controller.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';

import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/utils/network_utils.dart';

part 'dns_records_state.dart';

class DnsRecordsCubit
    extends ServerInstallationDependendCubit<DnsRecordsState> {
  DnsRecordsCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(
          serverInstallationCubit,
          const DnsRecordsState(dnsState: DnsRecordsStatus.refreshing),
        );

  final ServerApi api = ServerApi();

  @override
  Future<void> load() async {
    emit(
      DnsRecordsState(
        dnsState: DnsRecordsStatus.refreshing,
        dnsRecords: ApiController.currentDnsProviderApiFactory!
            .getDnsProvider()
            .getDesiredDnsRecords(
              domainName:
                  serverInstallationCubit.state.serverDomain?.domainName,
              dkimPublicKey: '',
              ipAddress: '',
            ),
      ),
    );

    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final ServerDomain? domain = serverInstallationCubit.state.serverDomain;
      final String? ipAddress =
          serverInstallationCubit.state.serverDetails?.ip4;
      if (domain != null && ipAddress != null) {
        final List<DnsRecord> records = await ApiController
            .currentDnsProviderApiFactory!
            .getDnsProvider()
            .getDnsRecords(domain: domain);
        final String? dkimPublicKey =
            extractDkimRecord(await api.getDnsRecords())?.content;
        final List<DesiredDnsRecord> desiredRecords = ApiController
            .currentDnsProviderApiFactory!
            .getDnsProvider()
            .getDesiredDnsRecords(
              domainName: domain.domainName,
              ipAddress: ipAddress,
              dkimPublicKey: dkimPublicKey,
            );
        final List<DesiredDnsRecord> foundRecords = [];
        for (final DesiredDnsRecord desiredRecord in desiredRecords) {
          if (desiredRecord.description == 'record.dkim') {
            final DnsRecord foundRecord = records.firstWhere(
              (final r) =>
                  r.name == desiredRecord.name && r.type == desiredRecord.type,
              orElse: () => DnsRecord(
                name: desiredRecord.name,
                type: desiredRecord.type,
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
                desiredRecord.content.replaceAll(RegExp(r'\s+'), '');
            if (foundContent == content) {
              foundRecords.add(desiredRecord.copyWith(isSatisfied: true));
            } else {
              foundRecords.add(desiredRecord.copyWith(isSatisfied: false));
            }
          } else {
            if (records.any(
              (final r) =>
                  r.name == desiredRecord.name &&
                  r.type == desiredRecord.type &&
                  r.content == desiredRecord.content,
            )) {
              foundRecords.add(desiredRecord.copyWith(isSatisfied: true));
            } else {
              foundRecords.add(desiredRecord.copyWith(isSatisfied: false));
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
    final DnsProviderApi dnsProviderApi =
        ApiController.currentDnsProviderApiFactory!.getDnsProvider();
    await dnsProviderApi.removeSimilarRecords(domain: domain!);
    await dnsProviderApi.createMultipleDnsRecords(
      domain: domain,
      ip4: ipAddress,
    );

    final List<DnsRecord> records = await api.getDnsRecords();
    final DnsRecord? dkimRecord = extractDkimRecord(records);
    if (dkimRecord != null) {
      await dnsProviderApi.setDnsRecord(dkimRecord, domain);
    }

    await load();
  }
}
