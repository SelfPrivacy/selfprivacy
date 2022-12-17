import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/digital_ocean_dns/digital_ocean_dns.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_factory.dart';

class DigitalOceanDnsApiFactory extends DnsProviderApiFactory {
  @override
  DnsProviderApi getDnsProvider({
    final DnsProviderApiSettings settings = const DnsProviderApiSettings(),
  }) =>
      DigitalOceanDnsApi(
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
        customToken: settings.customToken,
      );
}
