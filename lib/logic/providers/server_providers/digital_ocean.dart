import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/digital_ocean/digital_ocean_api.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';
import 'package:selfprivacy/logic/providers/server_provider.dart';

class ApiAdapter {
  ApiAdapter({final String? region, final bool isWithToken = true})
      : _api = DigitalOceanApi(
          region: region,
          isWithToken: isWithToken,
        );

  DigitalOceanApi api({final bool getInitialized = true}) => getInitialized
      ? _api
      : DigitalOceanApi(
          region: _api.region,
          isWithToken: false,
        );

  final DigitalOceanApi _api;
}

class DigitalOceanServerProvider extends ServerProvider {
  DigitalOceanServerProvider() : _adapter = ApiAdapter();
  DigitalOceanServerProvider.load(
    final ServerType serverType,
    final bool isAuthotized,
  ) : _adapter = ApiAdapter(
          isWithToken: isAuthotized,
          region: serverType.location.identifier,
        );

  ApiAdapter _adapter;

  @override
  Future<GenericResult<bool>> trySetServerLocation(
    final String location,
  ) async {
    final bool apiInitialized = _adapter.api().isWithToken;
    if (!apiInitialized) {
      return GenericResult(
        success: true,
        data: false,
        message: 'Not authorized!',
      );
    }

    _adapter = ApiAdapter(
      isWithToken: true,
      region: location,
    );
    return success;
  }

  @override
  Future<GenericResult<bool>> tryInitApiByToken(final String token) async {
    final api = _adapter.api(getInitialized: false);
    final result = await api.isApiTokenValid(token);
    if (!result.data || !result.success) {
      return result;
    }

    _adapter = ApiAdapter(region: api.region, isWithToken: true);
    return result;
  }

  String? getEmojiFlag(final String query) {
    String? emoji;

    switch (query.toLowerCase().substring(0, 3)) {
      case 'fra':
        emoji = '🇩🇪';
        break;

      case 'ams':
        emoji = '🇳🇱';
        break;

      case 'sgp':
        emoji = '🇸🇬';
        break;

      case 'lon':
        emoji = '🇬🇧';
        break;

      case 'tor':
        emoji = '🇨🇦';
        break;

      case 'blr':
        emoji = '🇮🇳';
        break;

      case 'nyc':
      case 'sfo':
        emoji = '🇺🇸';
        break;
    }

    return emoji;
  }

  @override
  Future<GenericResult<List<ServerProviderLocation>>>
      getAvailableLocations() async {
    final List<ServerProviderLocation> locations = [];
    final result = await _adapter.api().getAvailableLocations();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: locations,
        code: result.code,
        message: result.message,
      );
    }

    final List rawLocations = result.data;
    for (final rawLocation in rawLocations) {
      ServerProviderLocation? location;
      try {
        location = ServerProviderLocation(
          title: rawLocation['slug'],
          description: rawLocation['name'],
          flag: getEmojiFlag(rawLocation['slug']),
          identifier: rawLocation['slug'],
        );
      } catch (e) {
        continue;
      }
      locations.add(location);
    }

    return GenericResult(success: true, data: locations);
  }

  @override
  Future<GenericResult<List<ServerType>>> getServerTypes({
    required final ServerProviderLocation location,
  }) async {
    final List<ServerType> types = [];
    final result = await _adapter.api().getAvailableServerTypes();
    if (result.data.isEmpty || !result.success) {
      return GenericResult(
        success: result.success,
        data: types,
        code: result.code,
        message: result.message,
      );
    }

    final List rawTypes = result.data;
    for (final rawSize in rawSizes) {
      for (final rawRegion in rawSize['regions']) {
        final ramMb = rawSize['memory'].toDouble();
        if (rawRegion.toString() == location.identifier && ramMb > 1024) {
          types.add(
            ServerType(
              title: rawSize['description'],
              identifier: rawSize['slug'],
              ram: ramMb / 1024,
              cores: rawSize['vcpus'],
              disk: DiskSize(byte: rawSize['disk'] * 1024 * 1024 * 1024),
              price: Price(
                value: rawSize['price_monthly'],
                currency: 'USD',
              ),
              location: location,
            ),
          );
        }
      }
    }

    return GenericResult(success: true, data: types);
  }
}
