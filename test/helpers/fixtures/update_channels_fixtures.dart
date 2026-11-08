import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_settings.graphql.dart';
import 'package:selfprivacy/logic/models/update_channels.dart';

import 'json_fixture.dart';

UpdateChannels anUpdateChannels({final bool custom = false}) =>
    UpdateChannels.fromGraphQL(
      Query$GetUpdateChannels.fromJson(
        custom
            ? loadJsonFixture('graphql/custom_update_channels.json')
            : loadJsonFixture('graphql/domain_reads.json')['GetUpdateChannels']
                  as Map<String, dynamic>,
      ).system.updates,
    );

const testUpdateChannel = UpdateChannel(
  id: 'test-channel',
  updateUrl: 'https://example.org/test',
  name: 'Test channel',
  description: 'Test registry entry',
);
