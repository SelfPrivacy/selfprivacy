import 'package:selfprivacy/logic/api_maps/rest_maps/providers/provider.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/providers/volume_provider.dart';

class ProviderApiSettings {
  const ProviderApiSettings({this.hasLogger = false, this.isWithToken = true});
  final bool hasLogger;
  final bool isWithToken;
}

abstract class ProviderApiFactory {
  ServerProviderApi getProvider({
    final ProviderApiSettings settings = const ProviderApiSettings(),
  });
}

mixin VolumeProviderApiFactory {
  VolumeProviderApi getVolumeProvider({
    final ProviderApiSettings settings = const ProviderApiSettings(),
  });
}
