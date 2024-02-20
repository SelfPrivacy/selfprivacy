import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/models/auto_upgrade_settings.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/timezone_settings.dart';
import 'package:selfprivacy/logic/providers/providers_controller.dart';

class ServerDetailsRepository {
  ServerApi server = ServerApi();

  Future<ServerDetailsRepositoryDto> load() async {
    final settings = await server.getSystemSettings();
    return ServerDetailsRepositoryDto(
      autoUpgradeSettings: settings.autoUpgradeSettings,
      metadata: await metadata,
      serverTimezone: TimeZoneSettings.fromString(
        settings.timezone,
      ),
    );
  }

  Future<List<ServerMetadataEntity>> get metadata async {
    List<ServerMetadataEntity> data = [];

    final serverProviderApi = ProvidersController.currentServerProvider;
    final dnsProviderApi = ProvidersController.currentDnsProvider;
    if (serverProviderApi != null && dnsProviderApi != null) {
      final serverId = getIt<ApiConfigModel>().serverDetails?.id ?? 0;
      final metadataResult = await serverProviderApi.getMetadata(serverId);
      metadataResult.data.add(
        ServerMetadataEntity(
          trId: 'server.dns_provider',
          value: dnsProviderApi.type.displayName,
          type: MetadataType.other,
        ),
      );

      data = metadataResult.data;
    }

    return data;
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
