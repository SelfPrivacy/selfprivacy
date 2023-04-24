import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_creator.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_factory.dart';

class ApiController {
  static DnsProviderApiFactory? get currentDnsProviderApiFactory =>
      _dnsProviderApiFactory;

  static void initDnsProviderApiFactory(
    final DnsProviderFactorySettings settings,
  ) {
    _dnsProviderApiFactory =
        ApiFactoryCreator.createDnsProviderApiFactory(settings);
  }

  static void clearProviderApiFactories() {
    _dnsProviderApiFactory = null;
  }

  static DnsProviderApiFactory? _dnsProviderApiFactory;
}
