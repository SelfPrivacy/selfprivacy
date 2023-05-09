import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/desec/desec.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_factory.dart';

class DesecApiFactory extends DnsProviderApiFactory {
  @override
  DnsProviderApi getDnsProvider({
    final DnsProviderApiSettings settings = const DnsProviderApiSettings(),
  }) =>
      DesecApi(
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
        customToken: settings.customToken,
      );
}
