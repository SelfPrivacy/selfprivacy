import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/digital_ocean_dns/digital_ocean_dns_api.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/digital_ocean_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

class ApiAdapter {
  ApiAdapter({final bool isWithToken = true})
      : _api = DigitalOceanDnsApi(
          isWithToken: isWithToken,
        );

  DigitalOceanDnsApi api({final bool getInitialized = true}) => getInitialized
      ? _api
      : DigitalOceanDnsApi(
          isWithToken: false,
        );

  final DigitalOceanDnsApi _api;
}

class DigitalOceanDnsProvider extends DnsProvider {
  DigitalOceanDnsProvider() : _adapter = ApiAdapter();
  DigitalOceanDnsProvider.load(
    final bool isAuthorized,
  ) : _adapter = ApiAdapter(
          isWithToken: isAuthorized,
        );

  ApiAdapter _adapter;

  @override
  DnsProviderType get type => DnsProviderType.digitalOcean;

  @override
  String get howToRegistar => 'how_fix_domain_digital_ocean';

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
    required final List<DnsRecord> records,
    required final ServerDomain domain,
  }) async =>
      _adapter.api().createMultipleDnsRecords(
            domainName: domain.domainName,
            records: records
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

    final List<DigitalOceanDnsRecord> selfprivacyRecords = records
        .map(
          (final record) => DigitalOceanDnsRecord.fromDnsRecord(
            record,
            domain.domainName,
          ),
        )
        .toList();

    final List<DigitalOceanDnsRecord> oceanRecords = result.data;

    /// Remove all records that do not match with SelfPrivacy
    oceanRecords.removeWhere(
      (final oceanRecord) => !selfprivacyRecords.any(
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
  ) async =>
      _adapter.api().createMultipleDnsRecords(
        domainName: domain.domainName,
        records: [
          DigitalOceanDnsRecord.fromDnsRecord(
            record,
            domain.domainName,
          ),
        ],
      );
}
