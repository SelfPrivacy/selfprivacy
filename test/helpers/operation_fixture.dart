import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/connection/server_connection_hub.dart';
import 'package:selfprivacy/logic/get_it/resources_model.dart';

import 'fixtures/server_fixtures.dart';

class _Resources extends Mock implements ResourcesModel {}

ServerConnectionHub fixtureHub(final ServerApi api) {
  final resources = _Resources();
  when(() => resources.servers).thenReturn([aServer()]);
  when(() => resources.statusStream).thenAnswer((_) => const Stream.empty());
  final hub = ServerConnectionHub(
    resourcesModel: resources,
    createApi: (_, _, _) => api,
  );
  hub.active!.cache.setVersion(Version(3, 6, 0));
  addTearDown(hub.dispose);
  return hub;
}
