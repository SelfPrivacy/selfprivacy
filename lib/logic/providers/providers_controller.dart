import 'package:selfprivacy/logic/providers/provider_settings.dart';
import 'package:selfprivacy/logic/providers/server_provider.dart';
import 'package:selfprivacy/logic/providers/server_providers/server_provider_factory.dart';

class ProvidersController {
  static ServerProvider? get currentServerProvider => _serverProvider;

  static void initServerProvider(
    final ServerProviderSettings settings,
  ) {
    _serverProvider =
        ServerProviderFactory.createServerProviderInterface(settings);
  }

  static void clearProviders() {
    _serverProvider = null;
  }

  static ServerProvider? _serverProvider;
}
