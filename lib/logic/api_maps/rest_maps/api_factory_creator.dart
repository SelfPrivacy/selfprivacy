import 'package:selfprivacy/logic/api_maps/rest_maps/providers/hetzner/hetzner_factory.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/providers/provider_factory.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';

class ApiFactoryCreator {
  static ProviderApiFactory createProviderApiFactory(
    final ServerProvider provider,
  ) {
    switch (provider) {
      case ServerProvider.hetzner:
      case ServerProvider.unknown: // ?? :)
        return HetznerApiFactory();
    }
  }

  // createDnsApiFactory

  // createStorageApiFactory

  // etc . . .
}

class VolumeApiFactoryCreator {
  static VolumeProviderApiFactory createVolumeProviderApiFactory(
    final ServerProvider provider,
  ) {
    switch (provider) {
      case ServerProvider.hetzner:
      case ServerProvider.unknown: // ?? :)
        return HetznerApiFactory();
    }
  }

  // createDnsApiFactory

  // createStorageApiFactory

  // etc . . .
}
