import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/price.dart';

mixin VolumeProviderApi on ApiMap {
  Future<ServerVolume?> createVolume();
  Future<List<ServerVolume>> getVolumes({final String? status});
  Future<ServerVolume?> getVolume(final int id);
  Future<bool> attachVolume(final int volumeId, final int serverId);
  Future<bool> detachVolume(final int volumeId);
  Future<bool> resizeVolume(final int volumeId, final int sizeGb);
  Future<void> deleteVolume(final int id);
  Future<Price?> getPricePerGb();
}
