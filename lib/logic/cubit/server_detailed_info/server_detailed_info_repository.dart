import 'package:selfprivacy/logic/api_maps/hetzner.dart';
import 'package:selfprivacy/logic/api_maps/server.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/hetzner_server_info.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';

class ServerDetailsRepository {
  var hetznerAPi = HetznerApi();
  var selfprivacyServer = ServerApi();

  Future<_ServerDetailsRepositoryDto> load() async {
    print('load');
    return _ServerDetailsRepositoryDto(
      autoUpgradeSettings: await selfprivacyServer.getAutoUpgradeSettings(),
      hetznerServerInfo: await hetznerAPi.getInfo(),
      serverTimezone: await selfprivacyServer.getServerTimezone(),
    );
  }
}

class _ServerDetailsRepositoryDto {
  final HetznerServerInfo hetznerServerInfo;

  final TimeZoneSettings serverTimezone;

  final AutoUpgradeSettings autoUpgradeSettings;

  _ServerDetailsRepositoryDto({
    required this.hetznerServerInfo,
    required this.serverTimezone,
    required this.autoUpgradeSettings,
  });
}
