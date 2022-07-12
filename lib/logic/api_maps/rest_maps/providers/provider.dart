import 'package:selfprivacy/logic/api_maps/rest_maps/api_map.dart';
import 'package:selfprivacy/logic/models/hive/server_details.dart';
import 'package:selfprivacy/logic/models/hive/server_domain.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';
import 'package:selfprivacy/logic/models/json/provider_server_info.dart';

abstract class ProviderApi extends ApiMap {
  ProviderApi({this.hasLogger = false, this.isWithToken = true});
  @override
  bool hasLogger;
  @override
  bool isWithToken;

  Future<List<ProviderServerInfo>> getServers();

  Future<ServerHostingDetails> restart();
  Future<ServerHostingDetails> powerOn();

  Future<void> deleteServer({required final String domainName});
  Future<ServerHostingDetails?> createServer({
    required final String dnsApiToken,
    required final User rootUser,
    required final String domainName,
  });
  Future<void> createReverseDns({
    required final ServerHostingDetails serverDetails,
    required final ServerDomain domain,
  });

  Future<bool> isApiTokenValid(final String token);
  RegExp getApiTokenValidation();
}
