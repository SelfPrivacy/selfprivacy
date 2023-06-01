import 'package:selfprivacy/logic/api_maps/api_generic_result.dart';
import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';

export 'package:selfprivacy/logic/api_maps/api_generic_result.dart';

class ProviderApiTokenValidation {
  ProviderApiTokenValidation({
    required this.length,
    required this.regexp,
  });
  final int length;
  final RegExp regexp;
}

abstract class ServerProviderApi extends ApiMap {
  Future<List<ServerBasicInfo>> getServers();
  Future<APIGenericResult<List<ServerProviderLocation>>>
      getAvailableLocations();
  Future<APIGenericResult<List<ServerType>>> getServerTypesByLocation({
    required final ServerProviderLocation location,
  });

  Future<ServerHostingDetails> restart();
  Future<ServerHostingDetails> powerOn();

  Future<APIGenericResult<bool>> deleteServer({
    required final String domainName,
  });
  Future<APIGenericResult<ServerHostingDetails?>> createServer({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
    required final String serverType,
    required final DnsProvider dnsProvider,
  });
  Future<APIGenericResult<void>> createReverseDns({
    required final ServerHostingDetails serverDetails,
    required final ServerDomain domain,
  });

  Future<APIGenericResult<bool>> isApiTokenValid(final String token);
  ProviderApiTokenValidation getApiTokenValidation();
  Future<List<ServerMetadataEntity>> getMetadata(final int serverId);
  Future<ServerMetrics?> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
  );

  String dnsProviderToInfectName(final DnsProvider dnsProvider) {
    String dnsProviderType;
    switch (dnsProvider) {
      case DnsProvider.desec:
        dnsProviderType = 'DESEC';
        break;
      case DnsProvider.cloudflare:
      default:
        dnsProviderType = 'CLOUDFLARE';
        break;
    }
    return dnsProviderType;
  }

  /// Provider name key which lets infect understand what kind of installation
  /// it requires, for example 'digitaloceal' for Digital Ocean
  String get infectProviderName;

  /// Actual provider name to render on information page for user,
  /// for example 'Digital Ocean' for Digital Ocean
  String get displayProviderName;
}
