import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

class DiskVolume {
  DiskSize sizeUsed = DiskSize();
  DiskSize sizeTotal = DiskSize();
  String name = '';
  bool root = false;
  bool isResizable = true;
  ServerDiskVolume? serverDiskVolume;
  ServerVolume? providerVolume;

  /// from 0.0 to 1.0
  double get percentage => sizeTotal.byte == 0 ? 0 : sizeUsed.byte / sizeTotal.byte;
  bool get isDiskOkay => percentage < 0.8 && sizeTotal.gibibyte - sizeUsed.gibibyte > 2.0;
}

class DiskStatus {

  DiskStatus.fromVolumes(
    final List<ServerDiskVolume> serverVolumes,
    final List<ServerVolume> providerVolumes,
  ) {
    diskVolumes = serverVolumes.map((
      final ServerDiskVolume volume,
    ) {
      final DiskVolume diskVolume = DiskVolume();
      diskVolume.sizeUsed = DiskSize(
        byte: volume.usedSpace == 'None' ? 0 : int.parse(volume.usedSpace),
      );
      diskVolume.sizeTotal = DiskSize(
        byte: volume.totalSpace == 'None' ? 0 : int.parse(volume.totalSpace),
      );
      diskVolume.serverDiskVolume = volume;

      for (final ServerVolume providerVolume in providerVolumes) {
        if (providerVolume.linuxDevice == null ||
            volume.model == null ||
            volume.serial == null) {
          continue;
        }

        final String deviceId = providerVolume.linuxDevice!.split('/').last;
        if (deviceId.contains(volume.model!) &&
            deviceId.contains(volume.serial!)) {
          diskVolume.providerVolume = providerVolume;
          break;
        }
      }

      diskVolume.name = volume.name;
      diskVolume.root = volume.root;

      return diskVolume;
    }).toList();
  }
  DiskStatus() {
    diskVolumes = [];
  }

  bool get isDiskOkay => diskVolumes.every((final volume) => volume.isDiskOkay);

  List<DiskVolume> diskVolumes = [];
}
