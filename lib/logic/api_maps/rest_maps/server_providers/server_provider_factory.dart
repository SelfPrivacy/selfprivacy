import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';

abstract class ServerProviderApiFactory {
  ServerProviderApi getServerProvider({
    required final ServerProviderApiSettings settings,
  });
}

mixin VolumeProviderApiFactory {
  VolumeProviderApi getVolumeProvider({
    required final ServerProviderApiSettings settings,
  });
}
