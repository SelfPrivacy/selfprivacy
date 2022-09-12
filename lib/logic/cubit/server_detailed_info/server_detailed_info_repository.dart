import 'package:selfprivacy/logic/api_maps/rest_maps/server_providers/hetzner/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/server.dart';
import 'package:selfprivacy/logic/models/json/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/json/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

class ServerDetailsRepository {
  HetznerApi hetzner = HetznerApi();
  ServerApi server = ServerApi();

  Future<ServerDetailsRepositoryDto> load() async => ServerDetailsRepositoryDto(
        autoUpgradeSettings: await server.getAutoUpgradeSettings(),
        hetznerServerInfo: await hetzner.getInfo(),
        serverTimezone: await server.getServerTimezone(),
      );
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
