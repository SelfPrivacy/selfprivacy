import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desec/desec_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desired_dns_record.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/desec_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

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
    final List<DnsRecord> listDnsRecords = projectDnsRecords(
      domain.domainName,
      ip4,
    );

    final List<DesecDnsRecord> bulkRecords = [];
    for (final DnsRecord record in listDnsRecords) {
      bulkRecords.add(
        DesecDnsRecord(
          subname: record.name ?? '',
          type: record.type,
          ttl: record.ttl,
          records: [extractContent(record) ?? ''],
        ),
      );
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
    final List<DnsRecord> listDnsRecords = projectDnsRecords(
      domain.domainName,
      ip4,
    );

    final List<DesecDnsRecord> bulkRecords = [];
    for (final DnsRecord record in listDnsRecords) {
      bulkRecords.add(
        DesecDnsRecord(
          subname: record.name ?? '',
          type: record.type,
          ttl: record.ttl,
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
      records: [
        DesecDnsRecord(
          subname: record.name ?? '',
          type: record.type,
          ttl: record.ttl,
          records: [extractContent(record) ?? ''],
        ),
      ],
    );

    return GenericResult(
      success: result.success,
      data: null,
    );
  }

  String? extractContent(final DnsRecord record) {
    String? content = record.content;
    if (record.type == 'TXT' && content != null && !content.startsWith('"')) {
      content = '"$content"';
    }

    return content;
  }

  @override
  Future<GenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String ip4,
    final String dkimPublicKey,
  ) async {
    final result = await getDnsRecords(domain: domain);
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
      final List<DesiredDnsRecord> desiredRecords =
          getDesiredDnsRecords(domain.domainName, ip4, dkimPublicKey);
      for (final DesiredDnsRecord record in desiredRecords) {
        if (record.description == 'record.dkim') {
          final DnsRecord foundRecord = records.firstWhere(
            (final r) =>
                ('${r.name}.${domain.domainName}' == record.name) &&
                r.type == record.type,
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
          if (records.any(
            (final r) =>
                ('${r.name}.${domain.domainName}' == record.name ||
                    record.name == '') &&
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

  List<DnsRecord> projectDnsRecords(
    final String? domainName,
    final String? ip4,
  ) {
    final DnsRecord domainA = DnsRecord(type: 'A', name: '', content: ip4);

    final DnsRecord mx =
        DnsRecord(type: 'MX', name: '', content: '10 $domainName.');
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
      content: '"v=DMARC1; p=none"',
      ttl: 18000,
    );

    final DnsRecord txt2 = DnsRecord(
      type: 'TXT',
      name: '',
      content: '"v=spf1 a mx ip4:$ip4 -all"',
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
        name: '',
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
        name: '',
        content: '10 $domainName.',
        description: 'record.mx',
        type: 'MX',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: '_dmarc.$domainName',
        content: '"v=DMARC1; p=none"',
        description: 'record.dmarc',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      DesiredDnsRecord(
        name: '',
        content: '"v=spf1 a mx ip4:$ip4 -all"',
        description: 'record.spf',
        type: 'TXT',
        category: DnsRecordsCategory.email,
      ),
      if (dkimPublicKey != null)
        DesiredDnsRecord(
          name: 'selector._domainkey.$domainName',
          content: '"$dkimPublicKey"',
          description: 'record.dkim',
          type: 'TXT',
          category: DnsRecordsCategory.email,
        ),
    ];
  }

  @override
  Future<GenericResult<String?>> getZoneId(final String domain) async =>
      GenericResult(
        data: domain,
        success: true,
      );
}
