class DiskVolume {
  int gbUsed = 0;
  int gbTotal = 0;
  String name = '';
  bool root = false;

  /// from 0.0 to 1.0
  double percentage = 0.0;
}

class DiskStatus {
  bool isDiskOkay = false;
  List<DiskVolume> diskVolumes = [];
}
