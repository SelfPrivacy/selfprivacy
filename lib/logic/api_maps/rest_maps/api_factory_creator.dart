import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/cloudflare/cloudflare_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/dns_providers/dns_provider_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';

class UnknownApiProviderException implements Exception {
  UnknownApiProviderException(this.message);
  final String message;
}

class ApiFactoryCreator {
  static ServerProviderApiFactory createServerProviderApiFactory(
    final ServerProvider provider,
  ) {
    switch (provider) {
      case ServerProvider.hetzner:
        return HetznerApiFactory();
      case ServerProvider.digitalOcean:
        return DigitalOceanApiFactory();
      case ServerProvider.unknown:
        throw UnknownApiProviderException('Unknown server provider');
    }
  }

  static DnsProviderApiFactory createDnsProviderApiFactory(
    final DnsProvider provider,
  ) {
    switch (provider) {
      case DnsProvider.cloudflare:
        return CloudflareApiFactory();
      case DnsProvider.unknown:
        throw UnknownApiProviderException('Unknown DNS provider');
    }
  }
}

class VolumeApiFactoryCreator {
  static VolumeProviderApiFactory createVolumeProviderApiFactory(
    final ServerProvider provider,
  ) {
    switch (provider) {
      case ServerProvider.hetzner:
        return HetznerApiFactory();
      case ServerProvider.digitalOcean:
        return DigitalOceanApiFactory();
      case ServerProvider.unknown:
        throw UnknownApiProviderException('Unknown volume provider');
    }
  }
}
