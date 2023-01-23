import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_api_settings.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/server_provider_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/volume_provider.dart';

class DigitalOceanApiFactory extends ServerProviderApiFactory
    with VolumeProviderApiFactory {
  DigitalOceanApiFactory({this.region});

  final String? region;

  @override
  ServerProviderApi getServerProvider({
    final ServerProviderApiSettings settings =
        const ServerProviderApiSettings(),
  }) =>
      DigitalOceanApi(
        region: settings.region ?? region,
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
      );

  @override
  VolumeProviderApi getVolumeProvider({
    final ServerProviderApiSettings settings =
        const ServerProviderApiSettings(),
  }) =>
      DigitalOceanApi(
        region: settings.region ?? region,
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
      );
}
