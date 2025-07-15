import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/ssh_settings.dart';

class SystemSettings {
  SystemSettings({
    required this.sshSettings,
    required this.autoUpgradeSettings,
    required this.timezone,
  });

  SystemSettings.fromGraphQL(final Query$SystemSettings$system system)
    : this(
        sshSettings: SshSettings.fromGraphQL(system.settings.ssh),
        autoUpgradeSettings: AutoUpgradeSettings.fromGraphQL(
          system.settings.autoUpgrade,
        ),
        timezone: system.settings.timezone,
      );

  final SshSettings sshSettings;
  final AutoUpgradeSettings autoUpgradeSettings;
  final String timezone;
}
