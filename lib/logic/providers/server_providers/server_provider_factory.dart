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
    final ServerProviderSettings settings,
  ) {
    switch (settings.provider) {
      case ServerProviderType.hetzner:
        return settings.isAuthorized
            ? HetznerServerProvider.load(
              isAuthorized: settings.isAuthorized,
              token: settings.token,
            )
            : HetznerServerProvider();
      case ServerProviderType.digitalOcean:
        return settings.isAuthorized
            ? DigitalOceanServerProvider.load(
              isAuthorized: settings.isAuthorized,
              token: settings.token,
            )
            : DigitalOceanServerProvider();
      case ServerProviderType.unknown:
        throw UnknownProviderException('Unknown server provider');
    }
  }
}
