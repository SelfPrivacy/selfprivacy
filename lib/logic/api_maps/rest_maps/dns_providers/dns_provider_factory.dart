import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_api_settings.dart';

abstract class DnsProviderApiFactory {
  DnsProviderApi getDnsProvider({
    final DnsProviderApiSettings settings,
  });
}
