import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

class ServerDetailsRepository {
  HetznerApi hetzner = HetznerApi(region: 'fra1');
  ServerApi server = ServerApi();

  Future<ServerDetailsRepositoryDto> load() async {
    final settings = await server.getSystemSettings();
    return ServerDetailsRepositoryDto(
      autoUpgradeSettings: settings.autoUpgradeSettings,
      hetznerServerInfo: await hetzner.getInfo(),
      serverTimezone: TimeZoneSettings.fromString(
        settings.timezone,
      ),
    );
  }

  Future<void> setAutoUpgradeSettings(
    final AutoUpgradeSettings settings,
  ) async {
    await server.setAutoUpgradeSettings(settings);
  }

  Future<void> setTimezone(
    final String timezone,
  ) async {
    if (timezone.isNotEmpty) {
      await server.setTimezone(timezone);
    }
  }
}

class ServerDetailsRepositoryDto {
  ServerDetailsRepositoryDto({
    required this.hetznerServerInfo,
    required this.serverTimezone,
    required this.autoUpgradeSettings,
  });
  final HetznerServerInfo hetznerServerInfo;

  final TimeZoneSettings serverTimezone;

  final AutoUpgradeSettings autoUpgradeSettings;
}
