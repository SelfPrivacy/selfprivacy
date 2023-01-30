import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/digital_ocean.dart';
import 'package:selfprivacy/logic/providers/server_providers/hetzner.dart';

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
        return HetznerServerProvider();
      case ServerProviderType.digitalOcean:
        return DigitalOceanServerProvider();
      case ServerProviderType.unknown:
        throw UnknownProviderException('Unknown server provider');
    }
  }
}
