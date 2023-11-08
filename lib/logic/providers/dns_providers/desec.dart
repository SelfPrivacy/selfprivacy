import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desec/desec_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/desec_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/utils/network_utils.dart';

class ApiAdapter {
  ApiAdapter({final bool isWithToken = true})
      : _api = DesecApi(
          isWithToken: isWithToken,
        );

  DesecApi api({final bool getInitialized = true}) => getInitialized
      ? _api
      : DesecApi(
          isWithToken: false,
        );

  final DesecApi _api;
}

class DesecDnsProvider extends DnsProvider {
  DesecDnsProvider() : _adapter = ApiAdapter();
  DesecDnsProvider.load(
    final bool isAuthotized,
  ) : _adapter = ApiAdapter(
          isWithToken: isAuthotized,
        );

  ApiAdapter _adapter;

  @override
  DnsProviderType get type => DnsProviderType.desec;

  @override
  Future<GenericResult<bool>> tryInitApiByToken(final String token) async {
    final api = _adapter.api(getInitialized: false);
    final result = await api.isApiTokenValid(token);
    if (!result.data || !result.success) {
      return result;
    }

    _adapter = ApiAdapter(isWithToken: true);
    return result;
  }

  @override
  Future<GenericResult<List<String>>> domainList() async {
    List<String> domains = [];
    final result = await _adapter.api().getDomains();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: domains,
        code: result.code,
        message: result.message,
      );
    }

    domains = result.data
        .map<String>(
          (final el) => el.name,
        )
        .toList();

    return GenericResult(
      success: true,
      data: domains,
    );
  }

  @override
  Future<GenericResult<void>> createDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final List<DnsRecord> listDnsRecords = getProjectDnsRecords(
      domain.domainName,
      ip4,
    );

    final List<DesecDnsRecord> bulkRecords = [];
    for (final DnsRecord record in listDnsRecords) {
      bulkRecords.add(DesecDnsRecord.fromDnsRecord(record));
    }

    return _adapter.api().createMultipleDnsRecords(
          domainName: domain.domainName,
          records: bulkRecords,
        );
  }

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final List<DnsRecord> listDnsRecords = getProjectDnsRecords(
      domain.domainName,
      ip4,
    );

    final List<DesecDnsRecord> bulkRecords = [];
    for (final DnsRecord record in listDnsRecords) {
      final desecRecord = DesecDnsRecord.fromDnsRecord(record);
      bulkRecords.add(
        DesecDnsRecord(
          subname: desecRecord.subname,
          type: desecRecord.type,
          ttl: desecRecord.ttl,
          records: [],
        ),
      );
    }
    bulkRecords.add(
      DesecDnsRecord(
        subname: 'selector._domainkey',
        type: 'TXT',
        ttl: 18000,
        records: [],
      ),
    );

    return _adapter.api().removeSimilarRecords(
          domainName: domain.domainName,
          records: bulkRecords,
        );
  }

  @override
  Future<GenericResult<List<DnsRecord>>> getDnsRecords({
    required final ServerDomain domain,
  }) async {
    final List<DnsRecord> records = [];
    final result = await _adapter.api().getDnsRecords(domain.domainName);
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: records,
        code: result.code,
        message: result.message,
      );
    }

    try {
      for (final record in result.data) {
        final String? content =
            record.records.isEmpty ? null : record.records[0];
        records.add(
          DnsRecord(
            name: record.subname,
            type: record.type,
            content: content,
            ttl: record.ttl,
          ),
        );
      }
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: records,
        message: e.toString(),
      );
    }

    return GenericResult(success: true, data: records);
  }

  @override
  Future<GenericResult<void>> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  ) async {
    final result = await _adapter.api().createMultipleDnsRecords(
      domainName: domain.domainName,
      records: [DesecDnsRecord.fromDnsRecord(record)],
    );

    return GenericResult(
      success: result.success,
      data: null,
    );
  }

  @override
  Future<GenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String ip4,
    final String dkimPublicKey,
    final List<DnsRecord> pendingDnsRecords,
  ) async {
    final result = await _adapter.api().getDnsRecords(domain.domainName);
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: [],
        code: result.code,
        message: result.message,
      );
    }

    final records = result.data;
    final List<DesiredDnsRecord> foundRecords = [];
    try {
      for (final DnsRecord pendingDnsRecord in pendingDnsRecords) {
        final record = DesecDnsRecord.fromDnsRecord(pendingDnsRecord);
        if (record.subname == 'selector._domainkey') {
          final DesecDnsRecord foundRecord = records.firstWhere(
            (final r) =>
                ('${r.subname}.${domain.domainName}' == record.subname) &&
                r.type == record.type,
            orElse: () => DesecDnsRecord(
              subname: record.subname,
              type: record.type,
              records: [],
              ttl: record.ttl,
            ),
          );
          final desecRecords = foundRecord.records;
          final content = desecRecords.isEmpty ? '' : desecRecords[0];
          final String foundContent = content.replaceAll(RegExp(r'\s+'), '');
          final String desiredContent =
              record.records[0].replaceAll(RegExp(r'\s+'), '');
          foundRecords.add(
            DesiredDnsRecord(
              name: record.subname,
              content: record.records[0],
              isSatisfied: foundContent == desiredContent,
            ),
          );
        } else {
          final foundMatch = records.any(
            (final r) =>
                ('${r.subname}.${domain.domainName}' == record.subname ||
                    record.subname == '') &&
                r.type == record.type &&
                r.records[0] == record.records[0],
          );
          foundRecords.add(
            DesiredDnsRecord(
              name: record.subname,
              content: record.records[0],
              isSatisfied: foundMatch,
            ),
          );
        }
      }
    } catch (e) {
      print(e);
      return GenericResult(
        data: [],
        success: false,
        message: e.toString(),
      );
    }
    return GenericResult(
      data: foundRecords,
      success: true,
    );
  }
}
