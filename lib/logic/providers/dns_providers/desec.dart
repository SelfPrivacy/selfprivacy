import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desec/desec_api.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/desec_dns_info.dart';
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
  String get howToRegistar => 'how_fix_domain_desec';

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
  Future<GenericResult<List<ServerDomain>>> domainList() async {
    List<ServerDomain> domains = [];
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
        .map<ServerDomain>(
          (final el) => el.toServerDomain(),
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
      bulkRecords.add(DesecDnsRecord.fromDnsRecord(record, domain.domainName));
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
      final desecRecord = DesecDnsRecord.fromDnsRecord(
        record,
        domain.domainName,
      );
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
        records.add(record.toDnsRecord(domain.domainName));
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
      records: [DesecDnsRecord.fromDnsRecord(record, domain.domainName)],
    );

    return GenericResult(
      success: result.success,
      data: null,
    );
  }
}
