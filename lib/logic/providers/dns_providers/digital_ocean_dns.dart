import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/digital_ocean_dns/digital_ocean_dns_api.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/digital_ocean_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

class ApiAdapter {
  ApiAdapter({final bool isWithToken = true, final String? token})
    : _api = DigitalOceanDnsApi(isWithToken: isWithToken, token: token ?? '');

  DigitalOceanDnsApi api({final bool getInitialized = true}) =>
      getInitialized ? _api : DigitalOceanDnsApi(isWithToken: false);

  final DigitalOceanDnsApi _api;
}

class DigitalOceanDnsProvider extends DnsProvider {
  DigitalOceanDnsProvider() : _adapter = ApiAdapter(isWithToken: false);
  DigitalOceanDnsProvider.load({
    required final bool isAuthorized,
    final String? token,
  }) : _adapter = ApiAdapter(isWithToken: isAuthorized, token: token);

  final ApiAdapter _adapter;

  @override
  bool get isAuthorized => _adapter.api().isWithToken;

  @override
  DnsProviderType get type => DnsProviderType.digitalOcean;

  @override
  String get howToRegister => 'how_fix_domain_digital_ocean';

  @override
  Future<GenericResult<bool>> tryInitApiByToken(final String token) async {
    final api = _adapter.api(getInitialized: false);
    final result = await api.isApiTokenValid(token);
    if (!result.data || !result.success) {
      return result;
    }
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

    domains =
        result.data
            .map<ServerDomain>((final el) => el.toServerDomain())
            .toList();

    return GenericResult(success: true, data: domains);
  }

  @override
  Future<GenericResult<void>> createDomainRecords({
    required final List<DnsRecord> records,
    required final ServerDomain domain,
  }) => _adapter.api().createMultipleDnsRecords(
    domainName: domain.domainName,
    records:
        records
            .map<DigitalOceanDnsRecord>(
              (final e) =>
                  DigitalOceanDnsRecord.fromDnsRecord(e, domain.domainName),
            )
            .toList(),
  );

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required final List<DnsRecord> records,
    required final ServerDomain domain,
  }) async {
    final result = await _adapter.api().getDnsRecords(domain.domainName);
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: null,
        code: result.code,
        message: result.message,
      );
    }

    final List<DigitalOceanDnsRecord> selfprivacyRecords =
        records
            .map(
              (final record) => DigitalOceanDnsRecord.fromDnsRecord(
                record,
                domain.domainName,
              ),
            )
            .toList();

    final List<DigitalOceanDnsRecord> oceanRecords =
        result.data
          /// Remove all records that do not match with SelfPrivacy
          ..removeWhere(
            (final oceanRecord) =>
                !selfprivacyRecords.any(
                  (final selfprivacyRecord) =>
                      selfprivacyRecord.type == oceanRecord.type &&
                      selfprivacyRecord.name == oceanRecord.name,
                ),
          );

    return _adapter.api().removeSimilarRecords(
      domainName: domain.domainName,
      records: oceanRecords,
    );
  }

  @override
  Future<GenericResult<void>> updateDnsRecords({
    required final List<DnsRecord> newRecords,
    required final ServerDomain domain,
    final List<DnsRecord>? oldRecords,
  }) async {
    final result = await _adapter.api().getDnsRecords(domain.domainName);
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: null,
        code: result.code,
        message: result.message,
      );
    }

    final List<DigitalOceanDnsRecord> newSelfprivacyRecords =
        newRecords
            .map(
              (final record) => DigitalOceanDnsRecord.fromDnsRecord(
                record,
                domain.domainName,
              ),
            )
            .toList();

    final List<DigitalOceanDnsRecord>? oldSelfprivacyRecords =
        oldRecords
            ?.map(
              (final record) => DigitalOceanDnsRecord.fromDnsRecord(
                record,
                domain.domainName,
              ),
            )
            .toList();

    final List<DigitalOceanDnsRecord> oceanRecords = result.data;

    final List<DigitalOceanDnsRecord> recordsToDelete =
        newSelfprivacyRecords
            .where(
              (final newRecord) => oceanRecords.any(
                (final oldRecord) =>
                    newRecord.type == oldRecord.type &&
                    newRecord.name == oldRecord.name,
              ),
            )
            .toList();

    if (oldSelfprivacyRecords != null) {
      recordsToDelete.addAll(
        oldSelfprivacyRecords
            .where(
              (final oldRecord) =>
                  !newSelfprivacyRecords.any(
                    (final newRecord) =>
                        newRecord.type == oldRecord.type &&
                        newRecord.name == oldRecord.name,
                  ),
            )
            .toList(),
      );
    }

    if (recordsToDelete.isNotEmpty) {
      return _adapter.api().removeSimilarRecords(
        domainName: domain.domainName,
        records: recordsToDelete,
      );
    }

    return _adapter.api().createMultipleDnsRecords(
      domainName: domain.domainName,
      records: newSelfprivacyRecords,
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

    for (final rawRecord in result.data) {
      records.add(rawRecord.toDnsRecord(domain.domainName));
    }

    return GenericResult(data: records, success: true);
  }

  @override
  Future<GenericResult<void>> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  ) => _adapter.api().createMultipleDnsRecords(
    domainName: domain.domainName,
    records: [DigitalOceanDnsRecord.fromDnsRecord(record, domain.domainName)],
  );
}
