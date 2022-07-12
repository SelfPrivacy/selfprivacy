import 'package:selfprivacy/logic/api_maps/rest_maps/providers/provider.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';

abstract class VolumeProviderApi extends ProviderApi {
  VolumeProviderApi({
    final super.hasLogger = false,
    final super.isWithToken = true,
  });

  Future<ServerVolume?> createVolume();
  Future<List<ServerVolume>> getVolumes({final String? status});
  Future<ServerVolume?> getVolume(final int id);
  Future<bool> attachVolume(final int volumeId, final int serverId);
  Future<bool> detachVolume(final int volumeId);
  Future<bool> resizeVolume(final int volumeId, final int sizeGb);
  Future<void> deleteVolume(final int id);
}
