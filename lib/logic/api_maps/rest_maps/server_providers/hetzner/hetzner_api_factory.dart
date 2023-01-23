import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';

class HetznerApiFactory extends ServerProviderApiFactory
    with VolumeProviderApiFactory {
  HetznerApiFactory({this.region});

  final String? region;

  @override
  ServerProviderApi getServerProvider({
    final ServerProviderApiSettings settings =
        const ServerProviderApiSettings(),
  }) =>
      HetznerApi(
        region: settings.region ?? region,
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
      );

  @override
  VolumeProviderApi getVolumeProvider({
    final ServerProviderApiSettings settings =
        const ServerProviderApiSettings(),
  }) =>
      HetznerApi(
        region: settings.region ?? region,
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
      );
}
