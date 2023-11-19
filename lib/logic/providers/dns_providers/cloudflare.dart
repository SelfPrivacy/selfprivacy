import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/cloudflare/cloudflare_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/cloudflare_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';
import 'package:selfprivacy/utils/network_utils.dart';

class ApiAdapter {
  ApiAdapter({
    final bool isWithToken = true,
    this.cachedDomain = '',
    this.cachedZoneId = '',
  }) : _api = CloudflareApi(
          isWithToken: isWithToken,
        );

  CloudflareApi api({final bool getInitialized = true}) => getInitialized
      ? _api
      : CloudflareApi(
          isWithToken: false,
        );

  final CloudflareApi _api;
  final String cachedZoneId;
  final String cachedDomain;
}

class CloudflareDnsProvider extends DnsProvider {
  CloudflareDnsProvider() : _adapter = ApiAdapter();
  CloudflareDnsProvider.load(
    final bool isAuthotized,
  ) : _adapter = ApiAdapter(
          isWithToken: isAuthotized,
        );

  ApiAdapter _adapter;

  @override
  DnsProviderType get type => DnsProviderType.cloudflare;

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
    final result = await _adapter.api().getZones();
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
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return syncZoneIdResult;
    }

    final records = getProjectDnsRecords(domain.domainName, ip4);
    return _adapter.api().createMultipleDnsRecords(
          zoneId: _adapter.cachedZoneId,
          records: records
              .map<CloudflareDnsRecord>(
                (final rec) =>
                    CloudflareDnsRecord.fromDnsRecord(rec, domain.domainName),
              )
              .toList(),
        );
  }

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return syncZoneIdResult;
    }

    final result =
        await _adapter.api().getDnsRecords(zoneId: _adapter.cachedZoneId);
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: null,
        code: result.code,
        message: result.message,
      );
    }

    return _adapter.api().removeSimilarRecords(
          zoneId: _adapter.cachedZoneId,
          records: result.data,
        );
  }

  @override
  Future<GenericResult<List<DnsRecord>>> getDnsRecords({
    required final ServerDomain domain,
  }) async {
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return GenericResult(
        success: syncZoneIdResult.success,
        data: [],
        code: syncZoneIdResult.code,
        message: syncZoneIdResult.message,
      );
    }

    final List<DnsRecord> records = [];
    final result =
        await _adapter.api().getDnsRecords(zoneId: _adapter.cachedZoneId);
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: records,
        code: result.code,
        message: result.message,
      );
    }

    for (final rawRecord in result.data) {
      records.add(rawRecord.toDnsRecord());
    }

    return GenericResult(
      success: result.success,
      data: records,
    );
  }

  @override
  Future<GenericResult<void>> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  ) async {
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return syncZoneIdResult;
    }

    return _adapter.api().createMultipleDnsRecords(
      zoneId: _adapter.cachedZoneId,
      records: [CloudflareDnsRecord.fromDnsRecord(record, domain.domainName)],
    );
  }

  @override
  Future<GenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String ip4,
    final String dkimPublicKey,
    final List<DnsRecord> pendingDnsRecords,
  ) async {
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return GenericResult(
        success: syncZoneIdResult.success,
        data: [],
        code: syncZoneIdResult.code,
        message: syncZoneIdResult.message,
      );
    }
    final result =
        await _adapter.api().getDnsRecords(zoneId: _adapter.cachedZoneId);
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
        final record = CloudflareDnsRecord.fromDnsRecord(
          pendingDnsRecord,
          domain.domainName,
        );
        if (record.name == 'selector._domainkey') {
          final CloudflareDnsRecord foundRecord = records.firstWhere(
            (final r) => (r.name == record.name) && r.type == record.type,
            orElse: () => CloudflareDnsRecord(
              zoneName: domain.domainName,
              name: record.name,
              type: record.type,
              content: '',
              ttl: 800,
            ),
          );
          // remove all spaces and tabulators from
          // the foundRecord.content and the record.content
          // to compare them
          final String? foundContent =
              foundRecord.content?.replaceAll(RegExp(r'\s+'), '');
          final String content =
              record.content?.replaceAll(RegExp(r'\s+'), '') ?? '';
          foundRecords.add(
            DesiredDnsRecord(
              name: record.name ?? '',
              description: record.name?.split('.')[0] ?? '',
              content: record.content ?? '',
              isSatisfied: foundContent == content,
              type: record.type,
              category: DnsRecordsCategory.email,
            ),
          );
        } else {
          final foundMatch = records.any(
            (final r) =>
                (r.name == record.name) &&
                r.type == record.type &&
                r.content == record.content,
          );
          foundRecords.add(
            DesiredDnsRecord(
              name: record.name ?? '',
              description: record.name?.split('.')[0] ?? '',
              content: record.content ?? '',
              isSatisfied: foundMatch,
              type: record.type,
              category: record.type == 'A'
                  ? DnsRecordsCategory.services
                  : DnsRecordsCategory.other,
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

  Future<GenericResult<void>> syncZoneId(final String domain) async {
    if (domain == _adapter.cachedDomain && _adapter.cachedZoneId.isNotEmpty) {
      return GenericResult(
        success: true,
        data: null,
      );
    }

    final getZoneIdResult = await getZoneId(domain);
    if (!getZoneIdResult.success || getZoneIdResult.data == null) {
      return GenericResult(
        success: false,
        data: null,
        code: getZoneIdResult.code,
        message: getZoneIdResult.message,
      );
    }

    _adapter = ApiAdapter(
      isWithToken: true,
      cachedDomain: domain,
      cachedZoneId: getZoneIdResult.data!,
    );

    return GenericResult(
      success: true,
      data: null,
    );
  }

  Future<GenericResult<String?>> getZoneId(final String domain) async {
    String? id;
    final result = await _adapter.api().getZones();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: id,
        code: result.code,
        message: result.message,
      );
    }

    for (final availableDomain in result.data) {
      if (availableDomain.name == domain) {
        id = availableDomain.id;
      }
    }

    return GenericResult(success: id != null, data: id);
  }
}
