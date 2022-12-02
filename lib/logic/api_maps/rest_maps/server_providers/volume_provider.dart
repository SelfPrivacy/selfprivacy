import 'package:selfprivacy/logic/api_maps/api_generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/price.dart';

export 'package:selfprivacy/logic/api_maps/api_generic_result.dart';

mixin VolumeProviderApi on ApiMap {
  Future<APIGenericResult<ServerVolume?>> createVolume();
  Future<List<ServerVolume>> getVolumes({final String? status});
  Future<APIGenericResult<bool>> attachVolume(
    final ServerVolume volume,
    final int serverId,
  );
  Future<bool> detachVolume(final ServerVolume volume);
  Future<bool> resizeVolume(final ServerVolume volume, final DiskSize size);
  Future<void> deleteVolume(final ServerVolume volume);
  Future<Price?> getPricePerGb();
}
