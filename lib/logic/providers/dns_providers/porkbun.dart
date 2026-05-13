import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/porkbun/porkbun_api.dart';
import 'package:selfprivacy/logic/models/hive/dns_provider_credential.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/json/dns_providers/porkbun/porkbun_dns_info.dart';
import 'package:selfprivacy/logic/models/json/dns_records.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

class ApiAdapter {
  ApiAdapter({
    final bool isWithToken = true,
    final String? token,
    final String? tokenId,
  }) : _api = PorkbunApi(
         isWithToken: isWithToken,
         token: token ?? '',
         tokenId: tokenId ?? '',
       );

  PorkbunApi api({final bool getInitialized = true}) =>
      getInitialized ? _api : PorkbunApi(isWithToken: false);

  final PorkbunApi _api;
}

class PorkbunDnsProvider extends DnsProvider {
  PorkbunDnsProvider() : _adapter = ApiAdapter(isWithToken: false);
  PorkbunDnsProvider.load({
    required final bool isAuthorized,
    final String? token,
    final String? tokenId,
  }) : _adapter = ApiAdapter(
         isWithToken: isAuthorized,
         token: token,
         tokenId: tokenId,
       );

  final ApiAdapter _adapter;

  @override
  bool get isAuthorized => _adapter.api().isWithToken;

  @override
  DnsProviderType get type => DnsProviderType.porkbun;

  @override
  // TODO(inexcode): implement howToRegister
  String get howToRegister => throw UnimplementedError();

  @override
  Future<GenericResult<bool>> tryInitApiByToken(
    final DnsProviderCredential credential,
  ) async {
    if (credential.tokenId == null) {
      return GenericResult(
        success: false,
        data: false,
        message: 'Token ID is required for Porkbun',
      );
    }
    final api = _adapter.api(getInitialized: false);
    return api.isApiTokenValid(credential.token, credential.tokenId ?? '');
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
    records: records
        .map<PorkbunDnsRecord>(
          (final e) => PorkbunDnsRecord.fromDnsRecord(e, domain.domainName),
        )
        .toList(),
  );

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required final List<DnsRecord> records,
    required final ServerDomain domain,
  }) async {
    final result = await _adapter.api().getDnsRecords(
      domainName: domain.domainName,
    );
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: null,
        code: result.code,
        message: result.message,
      );
    }

    final List<PorkbunDnsRecord> selfprivacyRecords = records
        .map(
          (final record) =>
              PorkbunDnsRecord.fromDnsRecord(record, domain.domainName),
        )
        .toList();

    final List<PorkbunDnsRecord> porkbunRecords = result.data
      ..removeWhere(
        (final porkbunRecord) => !selfprivacyRecords.any(
          (final selfprivacyRecord) =>
              selfprivacyRecord.type == porkbunRecord.type &&
              selfprivacyRecord.name == porkbunRecord.name,
        ),
      );

    return _adapter.api().removeRecords(
      domainName: domain.domainName,
      records: porkbunRecords,
    );
  }

  @override
  Future<GenericResult<void>> updateDnsRecords({
    required final List<DnsRecord> newRecords,
    required final ServerDomain domain,
    final List<DnsRecord>? oldRecords,
  }) async {
    final result = await _adapter.api().getDnsRecords(
      domainName: domain.domainName,
    );
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: null,
        code: result.code,
        message: result.message,
      );
    }

    final List<PorkbunDnsRecord> newSelfprivacyRecords = newRecords
        .map(
          (final record) =>
              PorkbunDnsRecord.fromDnsRecord(record, domain.domainName),
        )
        .toList();

    final List<PorkbunDnsRecord>? oldSelfprivacyRecords = oldRecords
        ?.map(
          (final record) =>
              PorkbunDnsRecord.fromDnsRecord(record, domain.domainName),
        )
        .toList();

    final List<PorkbunDnsRecord> porkbunRecords = result.data;

    final List<PorkbunDnsRecord> recordsToDelete = newSelfprivacyRecords
        .where(
          (final newRecord) => porkbunRecords.any(
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
              (final oldRecord) => !newSelfprivacyRecords.any(
                (final newRecord) =>
                    newRecord.type == oldRecord.type &&
                    newRecord.name == oldRecord.name,
              ),
            )
            .toList(),
      );
    }

    if (recordsToDelete.isNotEmpty) {
      final deleteResult = await _adapter.api().removeRecords(
        domainName: domain.domainName,
        records: recordsToDelete,
      );
      if (!deleteResult.success) {
        return deleteResult;
      }
    }

    return _adapter.api().createMultipleDnsRecords(
      domainName: domain.domainName,
      records: newSelfprivacyRecords,
    );
  }

  @override
  Future<GenericResult<List<DnsRecord>>> getDnsRecords({
    required final ServerDomain domain,
  }) {
    final List<DnsRecord> records = [];
    return _adapter.api().getDnsRecords(domainName: domain.domainName).then((
      final result,
    ) {
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
        return GenericResult(
          success: false,
          data: records,
          message: e.toString(),
        );
      }

      return GenericResult(success: true, data: records);
    });
  }

  @override
  Future<GenericResult<bool>> validateDomainAccess(
    final String domainName,
  ) async {
    final result = await _adapter.api().getDnsRecords(domainName: domainName);
    if (!result.success &&
        (result.message?.startsWith('DOMAIN_IS_NOT_OPTED_IN') ?? false)) {
      return GenericResult(
        success: false,
        data: false,
        message: 'initializing.porkbun_domain_not_opted_in',
      );
    }
    return GenericResult(success: result.success, data: result.success);
  }

  @override
  Future<GenericResult<void>> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  ) => _adapter.api().createMultipleDnsRecords(
    domainName: domain.domainName,
    records: [PorkbunDnsRecord.fromDnsRecord(record, domain.domainName)],
  );
}
