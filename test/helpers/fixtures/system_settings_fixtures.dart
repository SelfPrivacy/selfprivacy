import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';
import 'package:selfprivacy/logic/models/system_settings.dart';

SystemSettings aSystemSettings({
  final String timezone = 'Europe/Helsinki',
  final bool autoUpgrade = true,
  final bool allowReboot = false,
  final bool ssh = true,
}) => SystemSettings(
  timezone: timezone,
  autoUpgradeSettings: AutoUpgradeSettings(
    enable: autoUpgrade,
    allowReboot: allowReboot,
  ),
  sshSettings: SshSettings(enable: ssh),
);
