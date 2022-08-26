import 'package:easy_localization/easy_localization.dart';

class DiskSize {
  DiskSize({final this.byte = 0});

  int byte;

  double asKb() => byte / 1024.0;
  double asMb() => byte / 1024.0 / 1024.0;
  double asGb() => byte / 1024.0 / 1024.0 / 1024.0;

  @override
  String toString() {
    if (byte < 1024) {
      return '${byte.toStringAsFixed(0)} ${tr('bytes')}';
    } else if (byte < 1024 * 1024) {
      return 'providers.storage.kb'.tr(args: [asKb().toStringAsFixed(1)]);
    } else if (byte < 1024 * 1024 * 1024) {
      return 'providers.storage.mb'.tr(args: [asMb().toStringAsFixed(1)]);
    } else {
      return 'providers.storage.gb'.tr(args: [asGb().toStringAsFixed(1)]);
    }
  }
}
