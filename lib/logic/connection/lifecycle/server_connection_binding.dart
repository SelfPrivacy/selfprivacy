import 'package:selfprivacy/logic/models/hive/server.dart';

class ServerConnectionBinding {
  ServerConnectionBinding(final Server server)
    : serverId = server.uuid,
      domain = server.domain.domainName,
      token = server.hostingDetails.apiToken;

  final String serverId;
  final String domain;
  final String? token;

  bool matches(final Server? server) =>
      server != null &&
      server.uuid == serverId &&
      server.domain.domainName == domain &&
      server.hostingDetails.apiToken == token;
}
