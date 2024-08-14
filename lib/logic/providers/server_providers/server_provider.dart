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
  /// Returns an assigned enum value, respectively to which
  /// provider implements [ServerProvider] interface.
  ServerProviderType get type;

  bool get isAuthorized;

  /// Returns [ServerBasicInfo] of all available machines
  /// assigned to the authorized user.
  ///
  /// Only with public IPv4 addresses.
  Future<GenericResult<List<ServerBasicInfo>>> getServers();

  /// Returns actual [ServerType] of the
  /// requested server entry assigned
  /// to the authorized user.
  Future<GenericResult<ServerType?>> getServerType(final int serverId);

  /// Tries to launch installation of SelfPrivacy on
  /// the requested server entry for the authorized account.
  /// Depending on a server provider, the algorithm
  /// and instructions vary drastically.
  ///
  /// If successly launched, stores new server information.
  ///
  /// If failure, returns error dialogue information to
  /// write in ServerInstallationState.
  Future<GenericResult<CallbackDialogueBranching?>> launchInstallation(
    final LaunchInstallationData installationData,
  );

  /// Tries to delete the requested server entry
  /// from the authorized account, including all assigned
  /// storage extensions.
  ///
  /// If failure, returns error dialogue information to
  /// write in ServerInstallationState.
  Future<GenericResult<CallbackDialogueBranching?>> deleteServer(
    final String hostname,
  );

  /// Tries to access an account linked to the provided token.
  ///
  /// To generate a token for your account follow instructions of your
  /// server provider respectfully.
  Future<GenericResult<bool>> tryInitApiByToken(final String token);

  /// Returns all available server locations
  /// of the authorized user's server provider.
  Future<GenericResult<List<ServerProviderLocation>>> getAvailableLocations();

  /// Returns [ServerType] of all available
  /// machine configurations available to the authorized account
  /// within the requested provider location,
  /// accessed from [getAvailableLocations].
  Future<GenericResult<List<ServerType>>> getServerTypes({
    required final ServerProviderLocation location,
  });

  /// Tries to power on the requested accessible machine.
  ///
  /// If success, returns [DateTime] of when the server
  /// answered the request.
  Future<GenericResult<DateTime?>> powerOn(final int serverId);

  /// Tries to restart the requested accessible machine.
  ///
  /// If success, returns [DateTime] of when the server
  /// answered the request.
  Future<GenericResult<DateTime?>> restart(final int serverId);

  /// Returns [Price] information map of all additional resources, excluding
  /// main server type pricing
  Future<GenericResult<AdditionalPricing?>> getAdditionalPricing(
    final String location,
  );

  /// Returns [ServerProviderVolume] of all available volumes
  /// assigned to the authorized user and attached to active machine.
  Future<GenericResult<List<ServerProviderVolume>>> getVolumes({
    final String? status,
  });

  /// Tries to create an empty unattached [ServerProviderVolume].
  ///
  /// If success, returns this volume information.
  Future<GenericResult<ServerProviderVolume?>> createVolume(
    final int gb,
    final String location,
  );

  /// Tries to delete the requested accessible [ServerProviderVolume].
  Future<GenericResult<void>> deleteVolume(final ServerProviderVolume volume);

  /// Tries to resize the requested accessible [ServerProviderVolume]
  /// to the provided size **(not by!)**, must be greater than current size.
  Future<GenericResult<bool>> resizeVolume(
    final ServerProviderVolume volume,
    final DiskSize size,
  );

  /// Tries to attach the requested accessible [ServerProviderVolume]
  /// to an accessible machine by the provided identificator.
  Future<GenericResult<bool>> attachVolume(
    final ServerProviderVolume volume,
    final int serverId,
  );

  /// Tries to attach the requested accessible [ServerProviderVolume]
  /// from any machine.
  Future<GenericResult<bool>> detachVolume(final ServerProviderVolume volume);

  /// Returns metadata of an accessible machine by the provided identificator
  /// to show on ServerDetailsScreen.
  Future<GenericResult<List<ServerMetadataEntity>>> getMetadata(
    final int serverId,
    final String location,
  );

  /// Returns information about cpu and bandwidth load within the provided
  /// time period of the requested accessible machine.
  Future<GenericResult<ServerMetrics?>> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
  );

  GenericResult<bool> get success => GenericResult(success: true, data: true);
}
