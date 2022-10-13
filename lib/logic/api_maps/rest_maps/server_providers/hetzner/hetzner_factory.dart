import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';

class HetznerApiFactory extends ServerProviderApiFactory
    with VolumeProviderApiFactory {
  @override
  ServerProviderApi getServerProvider({
    required final ServerProviderApiSettings settings,
  }) =>
      HetznerApi(
        region: settings.region,
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
      );

  @override
  VolumeProviderApi getVolumeProvider({
    required final ServerProviderApiSettings settings,
  }) =>
      HetznerApi(
        region: settings.region,
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
      );
}
