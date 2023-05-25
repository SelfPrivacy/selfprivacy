import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/cloudflare/cloudflare_api.dart';
import 'package:selfprivacy/logic/providers/dns_providers/dns_provider.dart';

class ApiAdapter {
  ApiAdapter({final bool isWithToken = true})
      : _api = CloudflareApi(
          isWithToken: isWithToken,
        );

  CloudflareApi api({final bool getInitialized = true}) => getInitialized
      ? _api
      : CloudflareApi(
          isWithToken: false,
        );

  final CloudflareApi _api;
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
  Future<GenericResult<String?>> getZoneId(final String domain) async {
    String? id;
    final result = await _adapter.api().getZones(domain);
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: id,
        code: result.code,
        message: result.message,
      );
    }

    id = result.data[0]['id'];

    return GenericResult(success: true, data: id);
  }

  @override
  Future<GenericResult<void>> removeDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
  }) async {}
  Future<GenericResult<List<DnsRecord>>> getDnsRecords({
    required final ServerDomain domain,
  });
  Future<GenericResult<void>> createDomainRecords({
    required final ServerDomain domain,
    final String? ip4,
  });
  Future<GenericResult<void>> setDnsRecord(
    final DnsRecord record,
    final ServerDomain domain,
  );
  Future<GenericResult<List<String>>> domainList();
  Future<GenericResult<List<DesiredDnsRecord>>> validateDnsRecords(
    final ServerDomain domain,
    final String ip4,
    final String dkimPublicKey,
  );
  List<DesiredDnsRecord> getDesiredDnsRecords(
    final String? domainName,
    final String? ip4,
    final String? dkimPublicKey,
  );
}
