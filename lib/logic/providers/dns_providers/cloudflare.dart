import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/cloudflare/cloudflare_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/cloudflare_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

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
  Future<GenericResult<List<String>>> domainList() async {
    List<String> domains = [];
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
    final syncZoneIdResult = await syncZoneId(domain.domainName);
    if (!syncZoneIdResult.success) {
      return syncZoneIdResult;
    }

    final records = getProjectDnsRecords(domain.domainName, ip4);
    return _adapter.api().createMultipleDnsRecords(
          zoneId: _adapter.cachedZoneId,
          records: records
              .map<CloudflareDnsRecord>(
                (final rec) => CloudflareDnsRecord(
                  content: rec.content,
                  name: rec.name,
                  type: rec.type,
                  zoneName: domain.domainName,
                  id: null,
                  ttl: rec.ttl,
                ),
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
      records.add(
        DnsRecord(
          name: rawRecord.name,
          type: rawRecord.type,
          content: rawRecord.content,
          ttl: rawRecord.ttl,
        ),
      );
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
      records: [
        CloudflareDnsRecord(
          content: record.content,
          id: null,
          name: record.name,
          type: record.type,
          zoneName: domain.domainName,
          ttl: record.ttl,
        ),
      ],
    );
  }

  @override
  Future<GenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String ip4,
    final String dkimPublicKey,
  ) async {
    final GenericResult<List<DnsRecord>> records =
        await getDnsRecords(domain: domain);
    final List<DesiredDnsRecord> foundRecords = [];
    try {
      final List<DesiredDnsRecord> desiredRecords =
          getDesiredDnsRecords(domain.domainName, ip4, dkimPublicKey);
      for (final DesiredDnsRecord record in desiredRecords) {
        if (record.description == 'record.dkim') {
          final DnsRecord foundRecord = records.data.firstWhere(
            (final r) => (r.name == record.name) && r.type == record.type,
            orElse: () => DnsRecord(
              name: record.name,
              type: record.type,
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
          final String content = record.content.replaceAll(RegExp(r'\s+'), '');
          if (foundContent == content) {
            foundRecords.add(record.copyWith(isSatisfied: true));
          } else {
            foundRecords.add(record.copyWith(isSatisfied: false));
          }
        } else {
          if (records.data.any(
            (final r) =>
                (r.name == record.name) &&
                r.type == record.type &&
                r.content == record.content,
          )) {
            foundRecords.add(record.copyWith(isSatisfied: true));
          } else {
            foundRecords.add(record.copyWith(isSatisfied: false));
          }
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

  @override
  List<DesiredDnsRecord> getDesiredDnsRecords(
    final String? domainName,
    final String? ip4,
    final String? dkimPublicKey,
  ) {
    if (domainName == null || ip4 == null) {
      return [];
    }
    return [
      DesiredDnsRecord(
        name: domainName,
        content: ip4,
        description: 'record.root',
      ),
      DesiredDnsRecord(
        name: 'api.$domainName',
        content: ip4,
        description: 'record.api',
      ),
      DesiredDnsRecord(
        name: 'cloud.$domainName',
        content: ip4,
        description: 'record.cloud',
      ),
      DesiredDnsRecord(
        name: 'git.$domainName',
        content: ip4,
        description: 'record.git',
      ),
      DesiredDnsRecord(
        name: 'meet.$domainName',
        content: ip4,
        description: 'record.meet',
      ),
      DesiredDnsRecord(
        name: 'social.$domainName',
        content: ip4,
        description: 'record.social',
      ),
      DesiredDnsRecord(
        name: 'password.$domainName',
        content: ip4,
        description: 'record.password',
      ),
      DesiredDnsRecord(
        name: 'vpn.$domainName',
        content: ip4,
        description: 'record.vpn',
      ),
      DesiredDnsRecord(
        name: domainName,
        content: domainName,
        description: 'record.mx',
        type: 'MX',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: '_dmarc.$domainName',
        content: 'v=DMARC1; p=none',
        description: 'record.dmarc',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: domainName,
        content: 'v=spf1 a mx ip4:$ip4 -all',
        description: 'record.spf',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      if (dkimPublicKey != null)
        DesiredDnsRecord(
          name: 'selector._domainkey.$domainName',
          content: dkimPublicKey,
          description: 'record.dkim',
          type: 'TXT',
          category: DnsRecordsCategory.email,
        ),
    ];
  }

  List<DnsRecord> getProjectDnsRecords(
    final String? domainName,
    final String? ip4,
  ) {
    final DnsRecord domainA =
        DnsRecord(type: 'A', name: domainName, content: ip4);

    final DnsRecord mx = DnsRecord(type: 'MX', name: '@', content: domainName);
    final DnsRecord apiA = DnsRecord(type: 'A', name: 'api', content: ip4);
    final DnsRecord cloudA = DnsRecord(type: 'A', name: 'cloud', content: ip4);
    final DnsRecord gitA = DnsRecord(type: 'A', name: 'git', content: ip4);
    final DnsRecord meetA = DnsRecord(type: 'A', name: 'meet', content: ip4);
    final DnsRecord passwordA =
        DnsRecord(type: 'A', name: 'password', content: ip4);
    final DnsRecord socialA =
        DnsRecord(type: 'A', name: 'social', content: ip4);
    final DnsRecord vpn = DnsRecord(type: 'A', name: 'vpn', content: ip4);

    final DnsRecord txt1 = DnsRecord(
      type: 'TXT',
      name: '_dmarc',
      content: 'v=DMARC1; p=none',
      ttl: 18000,
    );

    final DnsRecord txt2 = DnsRecord(
      type: 'TXT',
      name: domainName,
      content: 'v=spf1 a mx ip4:$ip4 -all',
      ttl: 18000,
    );

    return <DnsRecord>[
      domainA,
      apiA,
      cloudA,
      gitA,
      meetA,
      passwordA,
      socialA,
      mx,
      txt1,
      txt2,
      vpn
    ];
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
