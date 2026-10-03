import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';

import '../../../fakes/graphql/link_transport.dart';

void main() {
  test('GraphQL-wrapped dispatch deferral is not an empty log page', () async {
    final api = ServerApi(
      transport: transportWithLink(
        Link.function(
          (_, [final forward]) => Stream.error(const GraphQLDispatchDeferred()),
        ),
      ),
    );
    await expectLater(
      api.getServerLogs(limit: 50),
      throwsA(isA<GraphQLDispatchDeferred>()),
    );
  });
}
