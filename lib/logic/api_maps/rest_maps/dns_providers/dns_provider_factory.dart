import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/provider_api_settings.dart';

class DnsProviderApiSettings extends ProviderApiSettings {
  const DnsProviderApiSettings({
    final super.hasLogger = false,
    final super.isWithToken = true,
    final this.customToken,
  });
  final String? customToken;
}

abstract class DnsProviderApiFactory {
  DnsProviderApi getDnsProvider({
    final DnsProviderApiSettings settings = const DnsProviderApiSettings(),
  });
}
