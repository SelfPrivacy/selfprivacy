import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/launch_installation_data.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';

export 'package:selfprivacy/logic/api_maps/generic_result.dart';
export 'package:selfprivacy/logic/models/launch_installation_data.dart';

abstract class ServerProvider {
  Future<GenericResult<bool>> trySetServerLocation(final String location);
  Future<GenericResult<bool>> tryInitApiByToken(final String token);
  Future<GenericResult<List<ServerProviderLocation>>> getAvailableLocations();
  Future<GenericResult<List<ServerType>>> getServerTypes({
    required final ServerProviderLocation location,
  });
  Future<GenericResult<CallbackDialogueBranching?>> launchInstallation(
    final LaunchInstallationData installationData,
  );
  Future<GenericResult<DateTime?>> powerOn(final int serverId);
  Future<GenericResult<DateTime?>> restart(final int serverId);
  Future<GenericResult<ServerMetrics?>> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
  );

  GenericResult<bool> get success => GenericResult(success: true, data: true);
}
