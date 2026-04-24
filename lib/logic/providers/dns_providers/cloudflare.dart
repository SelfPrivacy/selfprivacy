import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/cloudflare/cloudflare_api.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/cloudflare_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

class ApiAdapter {
  ApiAdapter({
    final bool isWithToken = true,
    final String? token,
    this.cachedDomain = '',
    this.cachedZoneId = '',
  }) : _api = CloudflareApi(isWithToken: isWithToken, token: token ?? '');

  CloudflareApi api({final bool getInitialized = true}) =>
      getInitialized ? _api : CloudflareApi(isWithToken: false);

  final CloudflareApi _api;
  final String cachedZoneId;
  final String cachedDomain;
}

class CloudflareDnsProvider extends DnsProvider {
  CloudflareDnsProvider() : _adapter = ApiAdapter(isWithToken: false);
  CloudflareDnsProvider.load({
    required final bool isAuthorized,
    final String? token,
  }) : _adapter = ApiAdapter(isWithToken: isAuthorized, token: token);

  ApiAdapter _adapter;

  @override
  bool get isAuthorized => _adapter.api().isWithToken;

  @override
  DnsProviderType get type => DnsProviderType.cloudflare;

  @override
  String get howToRegister => 'how_fix_domain_cloudflare';

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
    final result = await _adapter.api().getZones();
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
  }) async {
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return syncZoneIdResult;
    }

    return _adapter.api().createMultipleDnsRecords(
      zoneId: _adapter.cachedZoneId,
      records:
          records
              .map<CloudflareDnsRecord>(
                (final rec) =>
                    CloudflareDnsRecord.fromDnsRecord(rec, domain.domainName),
              )
              .toList(),
    );
  }

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required final List<DnsRecord> records,
    required final ServerDomain domain,
  }) async {
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return syncZoneIdResult;
    }

    final result = await _adapter.api().getDnsRecords(
      zoneId: _adapter.cachedZoneId,
    );
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: null,
        code: result.code,
        message: result.message,
      );
    }

    final List<CloudflareDnsRecord> selfprivacyRecords =
        records
            .map(
              (final record) =>
                  CloudflareDnsRecord.fromDnsRecord(record, domain.domainName),
            )
            .toList();

    final List<CloudflareDnsRecord> cloudflareRecords =
        result.data
          /// Remove all records that do not match with SelfPrivacy
          ..removeWhere(
            (final cloudflareRecord) =>
                !selfprivacyRecords.any(
                  (final selfprivacyRecord) =>
                      selfprivacyRecord.type == cloudflareRecord.type &&
                      selfprivacyRecord.name == cloudflareRecord.name,
                ),
          );

    return _adapter.api().removeSimilarRecords(
      zoneId: _adapter.cachedZoneId,
      records: cloudflareRecords,
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
    final result = await _adapter.api().getDnsRecords(
      zoneId: _adapter.cachedZoneId,
    );
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

    return GenericResult(success: result.success, data: records);
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
  Future<GenericResult<void>> updateDnsRecords({
    required final List<DnsRecord> newRecords,
    required final ServerDomain domain,
    final List<DnsRecord>? oldRecords,
  }) async {
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return syncZoneIdResult;
    }

    final result = await _adapter.api().getDnsRecords(
      zoneId: _adapter.cachedZoneId,
    );
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: false,
        data: null,
        code: result.code,
        message: result.message,
      );
    }

    final List<CloudflareDnsRecord> newSelfprivacyRecords =
        newRecords
            .map(
              (final record) =>
                  CloudflareDnsRecord.fromDnsRecord(record, domain.domainName),
            )
            .toList();

    final List<CloudflareDnsRecord>? oldSelfprivacyRecords =
        oldRecords
            ?.map(
              (final record) =>
                  CloudflareDnsRecord.fromDnsRecord(record, domain.domainName),
            )
            .toList();

    final List<CloudflareDnsRecord> cloudflareRecords = result.data;

    final List<CloudflareDnsRecord> recordsToDelete =
        newSelfprivacyRecords
            .where(
              (final newRecord) => cloudflareRecords.any(
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
      await _adapter.api().removeSimilarRecords(
        records:
            cloudflareRecords
                .where(
                  (final record) => recordsToDelete.any(
                    (final recordToDelete) =>
                        recordToDelete.type == record.type &&
                        recordToDelete.name == record.name,
                  ),
                )
                .toList(),
        zoneId: _adapter.cachedZoneId,
      );
    }

    return _adapter.api().createMultipleDnsRecords(
      zoneId: _adapter.cachedZoneId,
      records: newSelfprivacyRecords,
    );
  }

  Future<GenericResult<void>> syncZoneId(final String domain) async {
    if (domain == _adapter.cachedDomain && _adapter.cachedZoneId.isNotEmpty) {
      return GenericResult(success: true, data: null);
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
      token: _adapter.api().token,
      cachedDomain: domain,
      cachedZoneId: getZoneIdResult.data!,
    );

    return GenericResult(success: true, data: null);
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
