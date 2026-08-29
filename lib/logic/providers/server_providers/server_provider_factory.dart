import 'package:selfprivacy/logic/api_maps/rest_maps/rest_api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_providers/digital_ocean.dart';
import 'package:selfprivacy/logic/providers/server_providers/hetzner.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider.dart';

class UnknownProviderException implements Exception {
  UnknownProviderException(this.message);
  final String message;
}

class ServerProviderFactory {
  static ServerProvider createServerProviderInterface(
    final ServerProviderSettings settings, {
    final RestApiClientFactory? clientFactory,
  }) {
    switch (settings.provider) {
      case ServerProviderType.hetzner:
        return settings.isAuthorized
            ? HetznerServerProvider.load(
                isAuthorized: settings.isAuthorized,
                token: settings.token,
                clientFactory: clientFactory,
              )
            : HetznerServerProvider(clientFactory: clientFactory);
      case ServerProviderType.digitalOcean:
        return settings.isAuthorized
            ? DigitalOceanServerProvider.load(
                isAuthorized: settings.isAuthorized,
                token: settings.token,
                clientFactory: clientFactory,
              )
            : DigitalOceanServerProvider(clientFactory: clientFactory);
      case ServerProviderType.unknown:
        throw UnknownProviderException('Unknown server provider');
    }
  }
}
