import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_creator.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';

class ApiController {
  static VolumeProviderApiFactory? get currentVolumeProviderApiFactory =>
      _volumeProviderApiFactory;
  static DnsProviderApiFactory? get currentDnsProviderApiFactory =>
      _dnsProviderApiFactory;
  static ServerProviderApiFactory? get currentServerProviderApiFactory =>
      _serverProviderApiFactory;

  static void initVolumeProviderApiFactory(
    final ServerProviderSettings settings,
  ) {
    _volumeProviderApiFactory =
        VolumeApiFactoryCreator.createVolumeProviderApiFactory(settings);
  }

  static void initDnsProviderApiFactory(
    final DnsProviderFactorySettings settings,
  ) {
    _dnsProviderApiFactory =
        ApiFactoryCreator.createDnsProviderApiFactory(settings);
  }

  static void initServerProviderApiFactory(
    final ServerProviderSettings settings,
  ) {
    _serverProviderApiFactory =
        ApiFactoryCreator.createServerProviderApiFactory(settings);
  }

  static void clearProviderApiFactories() {
    _volumeProviderApiFactory = null;
    _dnsProviderApiFactory = null;
    _serverProviderApiFactory = null;
  }

  static VolumeProviderApiFactory? _volumeProviderApiFactory;
  static DnsProviderApiFactory? _dnsProviderApiFactory;
  static ServerProviderApiFactory? _serverProviderApiFactory;
}
