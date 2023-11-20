import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/digital_ocean_dns/digital_ocean_dns_api.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/digital_ocean_dns_info.dart';
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
  }) async =>
      _adapter.api().createMultipleDnsRecords(
            domainName: domain.domainName,
            records: getProjectDnsRecords(
              domain.domainName,
              ip4,
            )
                .map<DigitalOceanDnsRecord>(
                  (final e) => DigitalOceanDnsRecord(
                    name: e.name ?? '',
                    id: null,
                    data: e.content ?? '',
                    ttl: e.ttl,
                    type: e.type,
                    priority: e.priority,
                  ),
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
      records.add(
        DnsRecord(
          name: rawRecord.name,
          type: rawRecord.type,
          content: rawRecord.data,
          ttl: rawRecord.ttl,
          proxied: false,
        ),
      );
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
          DigitalOceanDnsRecord(
            data: record.content ?? '',
            id: null,
            name: record.name ?? '',
            ttl: record.ttl,
            type: record.type,
            priority: record.priority,
          ),
        ],
      );

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

  List<DnsRecord> getProjectDnsRecords(
    final String? domainName,
    final String? ip4,
  ) {
    final DnsRecord domainA = DnsRecord(type: 'A', name: '@', content: ip4);

    final DnsRecord mx = DnsRecord(type: 'MX', name: '@', content: '@');
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
      name: '@',
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
      vpn,
    ];
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
        name: '@',
        content: ip4,
        description: 'record.root',
        displayName: domainName,
      ),
      DesiredDnsRecord(
        name: 'api',
        content: ip4,
        description: 'record.api',
        displayName: 'api.$domainName',
      ),
      DesiredDnsRecord(
        name: 'cloud',
        content: ip4,
        description: 'record.cloud',
        displayName: 'cloud.$domainName',
      ),
      DesiredDnsRecord(
        name: 'git',
        content: ip4,
        description: 'record.git',
        displayName: 'git.$domainName',
      ),
      DesiredDnsRecord(
        name: 'meet',
        content: ip4,
        description: 'record.meet',
        displayName: 'meet.$domainName',
      ),
      DesiredDnsRecord(
        name: 'social',
        content: ip4,
        description: 'record.social',
        displayName: 'social.$domainName',
      ),
      DesiredDnsRecord(
        name: 'password',
        content: ip4,
        description: 'record.password',
        displayName: 'password.$domainName',
      ),
      DesiredDnsRecord(
        name: 'vpn',
        content: ip4,
        description: 'record.vpn',
        displayName: 'vpn.$domainName',
      ),
      const DesiredDnsRecord(
        name: '@',
        content: '@',
        description: 'record.mx',
        type: 'MX',
        category: DnsRecordsCategory.email,
      ),
      const DesiredDnsRecord(
        name: '_dmarc',
        content: 'v=DMARC1; p=none',
        description: 'record.dmarc',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: '@',
        content: 'v=spf1 a mx ip4:$ip4 -all',
        description: 'record.spf',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      if (dkimPublicKey != null)
        DesiredDnsRecord(
          name: 'selector._domainkey',
          content: dkimPublicKey,
          description: 'record.dkim',
          type: 'TXT',
          category: DnsRecordsCategory.email,
        ),
    ];
  }
}
