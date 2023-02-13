import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';

export 'package:selfprivacy/logic/api_maps/generic_result.dart';

abstract class ServerProvider {
  Future<GenericResult<bool>> trySetServerType(final ServerType type);
  Future<GenericResult<bool>> tryInitApiByToken(final String token);
  Future<GenericResult<List<ServerProviderLocation>>> getAvailableLocations();
  Future<GenericResult<List<ServerType>>> getServerTypes({
    required final ServerProviderLocation location,
  });

  GenericResult<bool> get success => GenericResult(success: true, data: true);
}
