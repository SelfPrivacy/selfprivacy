import 'package:selfprivacy/logic/api_maps/generic_result.dart';
import 'package:selfprivacy/logic/models/callback_dialogue_branching.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/launch_installation_data.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/price.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';

export 'package:selfprivacy/logic/api_maps/generic_result.dart';
export 'package:selfprivacy/logic/models/launch_installation_data.dart';

abstract class ServerProvider {
  ServerProviderType get type;
  Future<GenericResult<List<ServerBasicInfo>>> getServers();
  Future<GenericResult<bool>> trySetServerLocation(final String location);
  Future<GenericResult<bool>> tryInitApiByToken(final String token);
  Future<GenericResult<List<ServerProviderLocation>>> getAvailableLocations();
  Future<GenericResult<List<ServerType>>> getServerTypes({
    required final ServerProviderLocation location,
  });

  Future<GenericResult<CallbackDialogueBranching?>> deleteServer(
    final String hostname,
  );
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

  Future<GenericResult<Price?>> getPricePerGb();
  Future<GenericResult<List<ServerVolume>>> getVolumes({final String? status});
  Future<GenericResult<ServerVolume?>> createVolume();
  Future<GenericResult<void>> deleteVolume(final ServerVolume volume);
  Future<GenericResult<bool>> resizeVolume(
    final ServerVolume volume,
    final DiskSize size,
  );
  Future<GenericResult<bool>> attachVolume(
    final ServerVolume volume,
    final int serverId,
  );
  Future<GenericResult<bool>> detachVolume(final ServerVolume volume);
  Future<GenericResult<List<ServerMetadataEntity>>> getMetadata(
    final int serverId,
  );
  GenericResult<bool> get success => GenericResult(success: true, data: true);
}
