import 'package:selfprivacy/logic/api_maps/api_generic_result.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';

abstract class ServerProvider {
  Future<APIGenericResult<bool>> isApiTokenValid(final String apiToken);
  Future<APIGenericResult<List<ServerProviderLocation>>>
      getAvailableLocations();
  Future<APIGenericResult<List<ServerType>>> getServerTypes({
    required final ServerProviderLocation location,
  });
}
