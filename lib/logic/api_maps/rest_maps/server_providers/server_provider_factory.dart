import 'package:selfprivacy/logic/api_maps/rest_maps/provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';

abstract class ServerProviderApiFactory {
  ServerProviderApi getServerProvider({
    final ProviderApiSettings settings = const ProviderApiSettings(),
  });
}

mixin VolumeProviderApiFactory {
  VolumeProviderApi getVolumeProvider({
    final ProviderApiSettings settings = const ProviderApiSettings(),
  });
}
