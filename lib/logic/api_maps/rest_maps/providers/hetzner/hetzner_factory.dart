import 'package:selfprivacy/logic/api_maps/rest_maps/providers/hetzner/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/providers/provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/providers/provider_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/providers/volume_provider.dart';

class HetznerApiFactory extends ProviderApiFactory
    with VolumeProviderApiFactory {
  @override
  ProviderApi getProvider({
    final ProviderApiSettings settings = const ProviderApiSettings(),
  }) =>
      HetznerApi(
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
      );

  @override
  VolumeProviderApi getVolumeProvider({
    final ProviderApiSettings settings = const ProviderApiSettings(),
  }) =>
      HetznerApi(
        hasLogger: settings.hasLogger,
        isWithToken: settings.isWithToken,
      );
}
