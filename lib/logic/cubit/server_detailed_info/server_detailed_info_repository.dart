import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

class ServerDetailsRepository {
  ServerApi server = ServerApi();

  Future<ServerDetailsRepositoryDto> load() async {
    final serverProviderApi = ProvidersController.currentServerProvider;
    final settings = await server.getSystemSettings();
    final serverId = getIt<ApiConfigModel>().serverDetails!.id;
    final metadata = await serverProviderApi?.getMetadata(serverId);

    return ServerDetailsRepositoryDto(
      autoUpgradeSettings: settings.autoUpgradeSettings,
      metadata: metadata!.data,
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
    required this.metadata,
    required this.serverTimezone,
    required this.autoUpgradeSettings,
  });
  final List<ServerMetadataEntity> metadata;
  final TimeZoneSettings serverTimezone;
  final AutoUpgradeSettings autoUpgradeSettings;
}
