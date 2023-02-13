import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
export 'package:selfprivacy/logic/api_maps/generic_result.dart';

class ProviderApiTokenValidation {
  ProviderApiTokenValidation({
    required this.length,
    required this.regexp,
  });
  final int length;
  final RegExp regexp;
}

abstract class ServerProviderApi extends ApiMap {
  String dnsProviderToInfectName(final DnsProviderType dnsProvider) {
    String dnsProviderType;
    switch (dnsProvider) {
      case DnsProviderType.digitalOcean:
        dnsProviderType = 'DIGITALOCEAN';
        break;
      case DnsProviderType.cloudflare:
      default:
        dnsProviderType = 'CLOUDFLARE';
        break;
    }
    return dnsProviderType;
  }

  /// Provider name key which lets infect understand what kind of installation
  /// it requires, for example 'digitaloceal' for Digital Ocean
  String get infectProviderName;

  /// Actual provider name to render on information page for user,
  /// for example 'Digital Ocean' for Digital Ocean
  String get displayProviderName;
}
