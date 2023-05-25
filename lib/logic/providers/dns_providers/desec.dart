import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desec/desec_api.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
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
  Future<GenericResult<String?>> getZoneId(final String domain) async =>
      GenericResult(
        data: domain,
        success: true,
      );

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final List<DnsRecord> listDnsRecords = projectDnsRecords(
      domain.domainName,
      ip4,
    );

    final List<dynamic> bulkRecords = [];
    for (final DnsRecord record in listDnsRecords) {
      bulkRecords.add(
        {
          'subname': record.name,
          'type': record.type,
          'ttl': record.ttl,
          'records': [],
        },
      );
    }
    bulkRecords.add(
      {
        'subname': 'selector._domainkey',
        'type': 'TXT',
        'ttl': 18000,
        'records': [],
      },
    );

    return _adapter.api().updateRecords(
          domain: domain,
          records: bulkRecords,
        );
  }

  @override
  Future<GenericResult<List<DnsRecord>>> getDnsRecords({
    required final ServerDomain domain,
  }) async {
    final List<DnsRecord> records = [];
    final result = await _adapter.api().getDnsRecords(domain: domain);
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
        final String? content = (record['records'] is List<dynamic>)
            ? record['records'][0]
            : record['records'];
        records.add(
          DnsRecord(
            name: record['subname'],
            type: record['type'],
            content: content,
            ttl: record['ttl'],
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
  Future<GenericResult<void>> createDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {
    final List<DnsRecord> listDnsRecords = projectDnsRecords(
      domain.domainName,
      ip4,
    );

    final List<dynamic> bulkRecords = [];
    for (final DnsRecord record in listDnsRecords) {
      bulkRecords.add(
        {
          'subname': record.name,
          'type': record.type,
          'ttl': record.ttl,
          'records': [extractContent(record)],
        },
      );
    }

    return _adapter.api().createRecords(
          domain: domain,
          records: bulkRecords,
        );
  }

  @override
  Future<GenericResult<void>> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  ) async {
    final result = await _adapter.api().createRecords(
      domain: domain,
      records: [
        {
          'subname': record.name,
          'type': record.type,
          'ttl': record.ttl,
          'records': [extractContent(record)],
        },
      ],
    );

    return GenericResult(
      success: true,
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
          (final el) => el['name'] as String,
        )
        .toList();

    return GenericResult(
      success: true,
      data: domains,
    );
  }
}
