import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:selfprivacy/config/hive_config.dart';

class DeveloperSettingsModel {
  Box get _box => Hive.box(BNames.appSettingsBox);

  bool get stagingAcme =>
      _box.get(BNames.stagingAcme, defaultValue: false) as bool;

  Future<void> setStagingAcme({required final bool enabled}) =>
      _box.put(BNames.stagingAcme, enabled);

  bool allowCustomSshKeyDuringSetup = false;

  String? unverifiedTlsHost;

  void clear() {
    allowCustomSshKeyDuringSetup = false;
    unverifiedTlsHost = null;
  }
}
