import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/connection/sync/server_command_coordinator.dart';

ServerConnection seededConnection(final ServerApi api) {
  final origin = ServerStateOrigin('fixture-server');
  return ServerConnection(api: api, origin: origin, currentOrigin: () => origin)
    ..setVersion(Version(3, 6, 0));
}
