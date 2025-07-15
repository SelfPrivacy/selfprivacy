import 'package:cubit_form/cubit_form.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/cubit/server_connection_dependent/server_connection_dependent_cubit.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';
import 'package:selfprivacy/utils/app_logger.dart';
import 'package:selfprivacy/utils/network_utils.dart';

part 'dns_records_state.dart';

class DnsRecordsCubit extends ServerConnectionDependentCubit<DnsRecordsState> {
  DnsRecordsCubit()
    : super(const DnsRecordsState(dnsState: DnsRecordsStatus.refreshing));

  final ServerApi api = ServerApi();

  static final logger = const AppLogger(name: 'dns_records_cubit').log;

  @override
  Future<void> load() async {
    emit(
      const DnsRecordsState(
        dnsState: DnsRecordsStatus.refreshing,
        dnsRecords: [],
      ),
    );

    final ServerDomain? domain = getIt<ApiConnectionRepository>().serverDomain;
    final String? ipAddress =
        getIt<ApiConnectionRepository>().serverDetails?.ip4;

    if (domain == null || ipAddress == null) {
      emit(const DnsRecordsState());
      return;
    }

    final List<DnsRecord> allDnsRecords = await api.getDnsRecords();
    final foundRecords = await validateDnsRecords(
      domain,
      extractDkimRecord(allDnsRecords)?.content ?? '',
      allDnsRecords,
    );

    if (!foundRecords.success && foundRecords.message == 'link-local') {
      emit(
        DnsRecordsState(
          dnsState: DnsRecordsStatus.error,
          dnsRecords: foundRecords.data,
        ),
      );
      return;
    }

    if (!foundRecords.success || foundRecords.data.isEmpty) {
      emit(const DnsRecordsState());
      return;
    }

    emit(
      DnsRecordsState(
        dnsRecords: foundRecords.data,
        dnsState:
            foundRecords.data.any((final r) => !r.isSatisfied)
                ? DnsRecordsStatus.error
                : DnsRecordsStatus.good,
      ),
    );
  }

  /// Tries to check whether all known DNS records on the domain by ip4
  /// match expectations of SelfPrivacy in order to launch.
  ///
  /// Will return list of [DesiredDnsRecord] objects, which represent
  /// only those records which have successfully passed validation.
  Future<GenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String dkimPublicKey,
    final List<DnsRecord> pendingDnsRecords,
  ) async {
    final result = await ProvidersController.currentDnsProvider!.getDnsRecords(
      domain: domain,
    );
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: [],
        code: result.code,
        message: result.message,
      );
    }

    final List<DnsRecord> providerDnsRecords = result.data;
    final List<DesiredDnsRecord> foundRecords = [];
    try {
      for (final DnsRecord pendingDnsRecord in pendingDnsRecords) {
        if (pendingDnsRecord.type == 'AAAA' &&
            (pendingDnsRecord.content?.startsWith('fe80::') ?? false)) {
          continue;
        }
        if (pendingDnsRecord.name == 'selector._domainkey') {
          final foundRecord = providerDnsRecords.firstWhere(
            (final r) =>
                (r.name == pendingDnsRecord.name) &&
                r.type == pendingDnsRecord.type,
            orElse:
                () => DnsRecord(
                  displayName: pendingDnsRecord.displayName,
                  name: pendingDnsRecord.name,
                  type: pendingDnsRecord.type,
                  content: pendingDnsRecord.content,
                  ttl: pendingDnsRecord.ttl,
                ),
          );
          final String foundContent =
              foundRecord.content!.replaceAll(RegExp(r'\s+'), '').trim();
          final String desiredContent =
              pendingDnsRecord.content!.replaceAll(RegExp(r'\s+'), '').trim();
          final isSatisfied = (desiredContent == foundContent);
          foundRecords.add(
            DesiredDnsRecord(
              name: pendingDnsRecord.name!,
              displayName: pendingDnsRecord.displayName,
              content: pendingDnsRecord.content!,
              isSatisfied: isSatisfied,
              type: pendingDnsRecord.type,
            ),
          );
        } else {
          final foundMatch = providerDnsRecords.any(
            (final r) =>
                r.name == pendingDnsRecord.name &&
                r.type == pendingDnsRecord.type &&
                r.content == pendingDnsRecord.content,
          );
          foundRecords.add(
            DesiredDnsRecord(
              name: pendingDnsRecord.name!,
              displayName: pendingDnsRecord.displayName,
              content: pendingDnsRecord.content!,
              isSatisfied: foundMatch,
              type: pendingDnsRecord.type,
            ),
          );
        }
      }
    } catch (e) {
      logger('Error while validating DNS records: $e', error: e);
      return GenericResult(data: [], success: false, message: e.toString());
    }
    // If providerDnsRecords contains a link-local ipv6 record, return an error
    if (providerDnsRecords.any(
      (final r) =>
          r.type == 'AAAA' && (r.content?.trim().startsWith('fe80::') ?? false),
    )) {
      return GenericResult(
        data: foundRecords,
        success: false,
        message: 'link-local',
      );
    }
    return GenericResult(data: foundRecords, success: true);
  }

  @override
  void onChange(final Change<DnsRecordsState> change) {
    // print(change);
    super.onChange(change);
  }

  @override
  Future<void> clear() async {
    emit(const DnsRecordsState(dnsState: DnsRecordsStatus.uninitialized));
  }

  Future<void> refresh() async {
    emit(state.copyWith(dnsState: DnsRecordsStatus.refreshing));
    await load();
  }

  Future<void> fix() async {
    emit(state.copyWith(dnsState: DnsRecordsStatus.refreshing));
    final List<DnsRecord> records = await api.getDnsRecords();

    // If there are explicit link-local ipv6 records, remove them from the list
    records.removeWhere(
      (final r) =>
          r.type == 'AAAA' && (r.content?.trim().startsWith('fe80::') ?? false),
    );

    // If there are no AAAA records, make empty copies of A records
    if (!records.any((final r) => r.type == 'AAAA')) {
      final recordsToAdd =
          records
              .where((final r) => r.type == 'A')
              .map(
                (final r) =>
                    DnsRecord(name: r.name, type: 'AAAA', content: null),
              )
              .toList();
      records.addAll(recordsToAdd);
    }

    // TODO(NaiJi): Error handling?
    final ServerDomain? domain = getIt<ApiConnectionRepository>().serverDomain;
    await ProvidersController.currentDnsProvider!.removeDomainRecords(
      records: records,
      domain: domain!,
    );
    await ProvidersController.currentDnsProvider!.createDomainRecords(
      records: records.where((final r) => r.content != null).toList(),
      domain: domain,
    );

    await load();
  }
}
