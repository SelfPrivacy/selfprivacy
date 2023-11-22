import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/digital_ocean_dns/digital_ocean_dns_api.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/digital_ocean_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/utils/network_utils.dart';

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
    final bool isAuthotized,
  ) : _adapter = ApiAdapter(
          isWithToken: isAuthotized,
        );

  ApiAdapter _adapter;

  @override
  DnsProviderType get type => DnsProviderType.digitalOcean;

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
  }) async =>
      _adapter.api().createMultipleDnsRecords(
            domainName: domain.domainName,
            records: getProjectDnsRecords(
              domain.domainName,
              ip4,
            )
                .map<DigitalOceanDnsRecord>(
                  (final e) =>
                      DigitalOceanDnsRecord.fromDnsRecord(e, domain.domainName),
                )
                .toList(),
          );

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
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

    const ignoreType = 'SOA';
    final List<DigitalOceanDnsRecord> filteredRecords = [];
    for (final record in result.data) {
      if (record.type != ignoreType) {
        filteredRecords.add(record);
      }
    }

    return _adapter.api().removeSimilarRecords(
          domainName: domain.domainName,
          records: filteredRecords,
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
        final record = DigitalOceanDnsRecord.fromDnsRecord(
          pendingDnsRecord,
          domain.domainName,
        );
        if (record.name == 'selector._domainkey') {
          final DigitalOceanDnsRecord foundRecord = records.firstWhere(
            (final r) => (r.name == record.name) && r.type == record.type,
            orElse: () => DigitalOceanDnsRecord(
              id: null,
              name: record.name,
              type: record.type,
              data: '',
              ttl: 800,
            ),
          );
          // remove all spaces and tabulators from
          // the foundRecord.content and the record.content
          // to compare them
          final String foundContent =
              foundRecord.data.replaceAll(RegExp(r'\s+'), '');
          final String content = record.data.replaceAll(RegExp(r'\s+'), '');
          foundRecords.add(
            DesiredDnsRecord(
              name: record.name,
              description: record.name == '@' ? domain.domainName : record.name,
              content: record.data,
              isSatisfied: foundContent == content,
              type: record.type,
              category: DnsRecordsCategory.email,
            ),
          );
        } else {
          final foundMatch = records.any(
            (final r) =>
                r.name == record.name &&
                r.type == record.type &&
                r.data == record.data,
          );
          foundRecords.add(
            DesiredDnsRecord(
              name: record.name,
              description: record.name == '@' ? domain.domainName : record.name,
              content: record.data,
              isSatisfied: foundMatch,
              type: record.type,
              category: record.type == 'A'
                  ? DnsRecordsCategory.services
                  : DnsRecordsCategory.email,
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
