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
              serverInstallationCubit.state.serverDomain?.domainName,
              '',
              '',
            ),
      ),
    );

    if (serverInstallationCubit.state is ServerInstallationFinished) {
      final ServerDomain? domain = serverInstallationCubit.state.serverDomain;
      final String? ipAddress =
          serverInstallationCubit.state.serverDetails?.ip4;
      if (domain == null && ipAddress == null) {
        emit(const DnsRecordsState());
        return;
      }

      final foundRecords = await ApiController.currentDnsProviderApiFactory!
          .getDnsProvider()
          .validateDnsRecords(
            domain!,
            ipAddress!,
            extractDkimRecord(await api.getDnsRecords())?.content ?? '',
          );

      if (!foundRecords.success || foundRecords.data.isEmpty) {
        emit(const DnsRecordsState());
        return;
      }

      emit(
        DnsRecordsState(
          dnsRecords: foundRecords.data,
          dnsState: foundRecords.data.any((final r) => r.isSatisfied == false)
              ? DnsRecordsStatus.error
              : DnsRecordsStatus.good,
        ),
      );
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
