import 'package:selfprivacy/logic/providers/provider_settings.dart';
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
    final ServerProviderSettings settings,
  ) {
    switch (settings.provider) {
      case ServerProviderType.hetzner:
        return HetznerApiFactory(region: settings.location);
      case ServerProviderType.digitalOcean:
        return DigitalOceanApiFactory(region: settings.location);
      case ServerProviderType.unknown:
        throw UnknownApiProviderException('Unknown server provider');
    }
  }

  static DnsProviderApiFactory createDnsProviderApiFactory(
    final DnsProviderSettings settings,
  ) {
    switch (settings.provider) {
      case DnsProviderType.cloudflare:
        return CloudflareApiFactory();
      case DnsProviderType.digitalOcean:
        return DigitalOceanDnsApiFactory();
      case DnsProviderType.unknown:
        throw UnknownApiProviderException('Unknown DNS provider');
    }
  }
}

class VolumeApiFactoryCreator {
  static VolumeProviderApiFactory createVolumeProviderApiFactory(
    final ServerProviderSettings settings,
  ) {
    switch (settings.provider) {
      case ServerProviderType.hetzner:
        return HetznerApiFactory();
      case ServerProviderType.digitalOcean:
        return DigitalOceanApiFactory();
      case ServerProviderType.unknown:
        throw UnknownApiProviderException('Unknown volume provider');
    }
  }
}
