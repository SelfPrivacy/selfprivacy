import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';

class AutoUpgradeSettings {
  AutoUpgradeSettings({required this.enable, required this.allowReboot});

  AutoUpgradeSettings.fromGraphQL(
    final Query$SystemSettings$system$settings$autoUpgrade autoUpgrade,
  ) : this(enable: autoUpgrade.enable, allowReboot: autoUpgrade.allowReboot);

  final bool enable;
  final bool allowReboot;
}
