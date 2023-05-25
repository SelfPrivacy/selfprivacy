import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/cloudflare/cloudflare_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_factory.dart';

class CloudflareApiFactory extends DnsProviderApiFactory {
  @override
  DnsProviderApi getDnsProvider({
    final DnsProviderApiSettings settings = const DnsProviderApiSettings(),
  }) =>
      CloudflareApi(
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
        customToken: settings.customToken,
      );
}
