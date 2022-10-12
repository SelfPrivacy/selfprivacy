import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/price.dart';

mixin VolumeProviderApi on ApiMap {
  Future<ServerVolume?> createVolume();
  Future<List<ServerVolume>> getVolumes({final String? status});
  Future<ServerVolume?> getVolume(final String volumeId);
  Future<bool> attachVolume(final String volumeId, final int serverId);
  Future<bool> detachVolume(final String volumeId);
  Future<bool> resizeVolume(final String volumeId, final int sizeGb);
  Future<void> deleteVolume(final String volumeId);
  Future<Price?> getPricePerGb();
}
