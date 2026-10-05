import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/operations/configuration/apply_changes_operation.dart';

import 'fixtures/server_fixtures.dart';

ServerConnection seededConnection(final ServerApi api) => ServerConnection(
  api: api,
  serverId: 'fixture-server',
  isAttached: () => true,
)..cache.setVersion(Version(3, 6, 0));

ApplyChangesOperation configurationOperation(
  final ServerConnection connection,
) => ApplyChangesOperation(
  users: connection.users,
  settings: connection.settings,
  services: connection.services,
  jobs: connection.jobs,
  volumes: connection.volumes,
  readDns: () => connection.api.getDnsRecords(),
  dnsProvider: null,
  domain: aServer().domain,
);
