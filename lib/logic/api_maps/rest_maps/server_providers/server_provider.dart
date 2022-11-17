import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/metrics.dart';
import 'package:selfprivacy/logic/models/server_basic_info.dart';
import 'package:selfprivacy/logic/models/server_metadata.dart';
import 'package:selfprivacy/logic/models/server_provider_location.dart';
import 'package:selfprivacy/logic/models/server_type.dart';

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
  Future<List<ServerProviderLocation>> getAvailableLocations();
  Future<List<ServerType>> getServerTypesByLocation({
    required final ServerProviderLocation location,
  });

  Future<ServerHostingDetails> restart();
  Future<ServerHostingDetails> powerOn();

  Future<void> deleteServer({required final String domainName});
  Future<ServerHostingDetails?> createServer({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
    required final String serverType,
  });
  Future<void> createReverseDns({
    required final ServerHostingDetails serverDetails,
    required final ServerDomain domain,
  });

  Future<bool> isApiTokenValid(final String token);
  ProviderApiTokenValidation getApiTokenValidation();
  Future<List<ServerMetadataEntity>> getMetadata(final int serverId);
  Future<ServerMetrics?> getMetrics(
    final int serverId,
    final DateTime start,
    final DateTime end,
  );

  /// Provider name key which lets infect understand what kind of installation
  /// it requires, for example 'digitaloceal' for Digital Ocean
  String get infectProviderName;

  /// Actual provider name to render on information page for user,
  /// for example 'Digital Ocean' for Digital Ocean
  String get appearanceProviderName;

  /// Whether we request for staging temprorary certificates.
  /// Hardcode to 'true' in the middle of testing to not
  /// get your domain banned but constant certificate renewal
  String get stagingAcme => 'false';
}
