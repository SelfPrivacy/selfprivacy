import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/price.dart';

mixin VolumeProviderApi on ApiMap {
  Future<ServerVolume?> createVolume();
  Future<List<ServerVolume>> getVolumes({final String? status});
  Future<bool> attachVolume(final ServerVolume volume, final int serverId);
  Future<bool> detachVolume(final ServerVolume volume);
  Future<bool> resizeVolume(final ServerVolume volume, final int sizeGb);
  Future<void> deleteVolume(final ServerVolume volume);
  Future<Price?> getPricePerGb();
}
