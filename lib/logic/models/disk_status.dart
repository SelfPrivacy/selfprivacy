import 'package:selfprivacy/logic/models/disk_size.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/json/server_disk_volume.dart';

class DiskVolume {
  DiskVolume({
    this.name = '',
    this.sizeTotal = const DiskSize(byte: 0),
    this.sizeUsed = const DiskSize(byte: 0),
    this.root = false,
    this.isResizable = false,
    this.providerVolume,
  });

  DiskVolume.fromServerAndDiskVolume(
    final ServerDiskVolume volume,
    final ServerProviderVolume? providerVolume,
  ) : this(
        name: volume.name,
        sizeTotal: DiskSize(
          byte: volume.totalSpace == 'None' ? 0 : int.parse(volume.totalSpace),
        ),
        sizeUsed: DiskSize(
          byte: volume.usedSpace == 'None' ? 0 : int.parse(volume.usedSpace),
        ),
        root: volume.root,
        isResizable: providerVolume != null,
        providerVolume: providerVolume,
      );

  /// Get the display name of the volume
  ///
  /// If it is sda1 and root the name is "System disk"
  /// If there is a mapping to providerVolume, the name is "Expandable volume"
  /// Otherwise the name is the name of the volume
  String get displayName {
    if (root) {
      return 'System disk';
    } else if (providerVolume != null) {
      return 'Expandable volume';
    } else {
      return name;
    }
  }

  DiskSize sizeUsed;
  DiskSize sizeTotal;
  String name;
  bool root;
  bool isResizable;
  ServerProviderVolume? providerVolume;

  /// from 0.0 to 1.0
  double get percentage =>
      sizeTotal.byte == 0 ? 0 : sizeUsed.byte / sizeTotal.byte;
  bool get isDiskOkay =>
      percentage < 0.8 && sizeTotal.gibibyte - sizeUsed.gibibyte > 2.0;

  DiskVolume copyWith({
    final DiskSize? sizeUsed,
    final DiskSize? sizeTotal,
    final String? name,
    final bool? root,
    final bool? isResizable,
    final ServerDiskVolume? serverDiskVolume,
    final ServerProviderVolume? providerVolume,
  }) => DiskVolume(
    sizeUsed: sizeUsed ?? this.sizeUsed,
    sizeTotal: sizeTotal ?? this.sizeTotal,
    name: name ?? this.name,
    root: root ?? this.root,
    isResizable: isResizable ?? this.isResizable,
    providerVolume: providerVolume ?? this.providerVolume,
  );
}

class DiskStatus {
  DiskStatus() {
    diskVolumes = [];
  }

  DiskStatus.fromVolumes(
    final List<ServerDiskVolume> serverVolumes,
    final List<ServerProviderVolume> providerVolumes,
  ) {
    diskVolumes =
        serverVolumes.map((final ServerDiskVolume volume) {
          ServerProviderVolume? providerVolume;

          for (final ServerProviderVolume iterableProviderVolume
              in providerVolumes) {
            if (iterableProviderVolume.linuxDevice == null ||
                volume.model == null ||
                volume.serial == null) {
              continue;
            }

            final String deviceId =
                iterableProviderVolume.linuxDevice!.split('/').last;
            if (deviceId.contains(volume.model!) &&
                deviceId.contains(volume.serial!)) {
              providerVolume = iterableProviderVolume;
              break;
            }
          }

          final DiskVolume diskVolume = DiskVolume.fromServerAndDiskVolume(
            volume,
            providerVolume,
          );

          return diskVolume;
        }).toList();
  }

  bool get isDiskOkay => diskVolumes.every((final volume) => volume.isDiskOkay);

  List<DiskVolume> diskVolumes = [];
}
