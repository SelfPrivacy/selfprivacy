import 'package:selfprivacy/logic/api_maps/rest_maps/api_factory_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/cloudflare/cloudflare_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/digital_ocean_dns/digital_ocean_dns_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class UnknownApiProviderException implements Exception {
  UnknownApiProviderException(this.message);
  final String message;
}

class ApiFactoryCreator {
  static ServerProviderApiFactory createServerProviderApiFactory(
    final ServerProviderApiFactorySettings settings,
  ) {
    switch (settings.provider) {
      case ServerProvider.hetzner:
        return HetznerApiFactory(region: settings.location);
      case ServerProvider.digitalOcean:
        return DigitalOceanApiFactory(region: settings.location);
      case ServerProvider.unknown:
        throw UnknownApiProviderException('Unknown server provider');
    }
  }

  static DnsProviderApiFactory createDnsProviderApiFactory(
    final DnsProviderApiFactorySettings settings,
  ) {
    switch (settings.provider) {
      case DnsProvider.cloudflare:
        return CloudflareApiFactory();
      case DnsProvider.digitalOcean:
        return DigitalOceanDnsApiFactory();
      case DnsProvider.unknown:
        throw UnknownApiProviderException('Unknown DNS provider');
    }
  }
}

class VolumeApiFactoryCreator {
  static VolumeProviderApiFactory createVolumeProviderApiFactory(
    final ServerProviderApiFactorySettings settings,
  ) {
    switch (settings.provider) {
      case ServerProvider.hetzner:
        return HetznerApiFactory();
      case ServerProvider.digitalOcean:
        return DigitalOceanApiFactory();
      case ServerProvider.unknown:
        throw UnknownApiProviderException('Unknown volume provider');
    }
  }
}
