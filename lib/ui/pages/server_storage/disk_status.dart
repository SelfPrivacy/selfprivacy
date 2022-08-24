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
  double percentage = 0.0;
}

class DiskStatus {
  bool isDiskOkay = false;
  List<DiskVolume> diskVolumes = [];
}
