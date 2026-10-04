import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/lifecycle/server_state_origin.dart';
import 'package:selfprivacy/logic/connection/server_connection.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_job_workflow.dart';

import 'fixtures/server_fixtures.dart';

ServerConnection seededConnection(final ServerApi api) {
  final origin = ServerStateOrigin('fixture-server');
  return ServerConnection(api: api, origin: origin, currentOrigin: () => origin)
    ..cache.setVersion(Version(3, 6, 0));
}

ClientJobWorkflow clientJobWorkflow(final ServerConnection connection) =>
    ClientJobWorkflow(
      users: connection.users,
      settings: connection.settings,
      services: connection.services,
      jobs: connection.jobs,
      volumes: connection.volumes,
      readDns: connection.api.getDnsRecords,
      dnsProvider: null,
      domain: aServer().domain,
    );
