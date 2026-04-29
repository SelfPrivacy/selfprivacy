import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/porkbun/porkbun_api.dart';
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
  Future<GenericResult<void>> createDomainRecords({
    required List<DnsRecord> records,
    required ServerDomain domain,
  }) {
    // TODO: implement createDomainRecords
    throw UnimplementedError();
  }

  @override
  Future<GenericResult<List<ServerDomain>>> domainList() {
    // TODO: implement domainList
    throw UnimplementedError();
  }

  @override
  Future<GenericResult<List<DnsRecord>>> getDnsRecords({
    required ServerDomain domain,
  }) {
    // TODO: implement getDnsRecords
    throw UnimplementedError();
  }

  @override
  // TODO: implement howToRegister
  String get howToRegister => throw UnimplementedError();

  @override
  // TODO: implement isAuthorized
  bool get isAuthorized => throw UnimplementedError();

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required List<DnsRecord> records,
    required ServerDomain domain,
  }) {
    // TODO: implement removeDomainRecords
    throw UnimplementedError();
  }

  @override
  Future<GenericResult<void>> setDnsRecord(
    DnsRecord record,
    ServerDomain domain,
  ) {
    // TODO: implement setDnsRecord
    throw UnimplementedError();
  }

  @override
  Future<GenericResult<bool>> tryInitApiByToken(String token) {
    // TODO: implement tryInitApiByToken
    throw UnimplementedError();
  }

  @override
  // TODO: implement type
  DnsProviderType get type => throw UnimplementedError();

  @override
  Future<GenericResult<void>> updateDnsRecords({
    required List<DnsRecord> newRecords,
    required ServerDomain domain,
    List<DnsRecord>? oldRecords,
  }) {
    // TODO: implement updateDnsRecords
    throw UnimplementedError();
  }
}
