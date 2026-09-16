import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';

import '../../../fakes/graphql/link_transport.dart';
import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  late Map<String, dynamic> data;
  late Map<String, dynamic> mutation;
  late List<Request> requests;

  setUp(() {
    data =
        loadJsonFixture('graphql/mutation_results.json')['DeleteDeviceApiToken']
            as Map<String, dynamic>;
    mutation =
        (data['api'] as Map<String, dynamic>)['deleteDeviceApiToken']
            as Map<String, dynamic>;
    requests = [];
  });

  ServerApi apiReturning({
    final List<GraphQLError> errors = const [],
    final bool withoutData = false,
    final Object? failure,
  }) => ServerApi(
    transport: transportWithLink(
      Link.function((final request, [final forward]) {
        requests.add(request);
        return failure != null
            ? Stream.error(failure)
            : Stream.value(
                Response(
                  response: const {},
                  data: withoutData ? null : data,
                  errors: errors,
                ),
              );
      }),
    ),
  );

  test(
    'device deletion preserves the acknowledgement and sends its identity',
    () async {
      final result = await apiReturning().deleteApiToken('Laptop');
      expect(result.outcome, ServerMutationOutcome.confirmed);
      expect(result.payload.status, ServerMutationPayloadStatus.notExpected);
      expect(result.code, 200);
      expect(result.message, 'Device deleted');
      expect(requests.single.variables, {'device': 'Laptop'});
    },
  );

  test('device deletion does not overwrite application rejection', () async {
    mutation['success'] = false;
    mutation['code'] = 404;
    mutation['message'] = 'Device not found';
    final result = await apiReturning().deleteApiToken('Laptop');
    expect(result.outcome, ServerMutationOutcome.rejected);
    expect(result.code, 404);
    expect(result.message, 'Device not found');
  });

  test('device deletion retains data and errors together', () async {
    final result = await apiReturning(
      errors: const [
        GraphQLError(
          message: 'Unrelated field unavailable',
          path: ['other', 'field'],
        ),
      ],
    ).deleteApiToken('Laptop');
    expect(result.outcome, ServerMutationOutcome.confirmed);
    expect(result.message, 'Device deleted');
    expect(result.diagnostics, contains(ServerMutationDiagnostic.graphql));
  });

  test('device deletion treats malformed metadata as indeterminate', () async {
    mutation['code'] = 'invalid';
    final result = await apiReturning().deleteApiToken('Laptop');
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    expect(result.code, isNull);
    expect(
      result.diagnostics,
      contains(ServerMutationDiagnostic.unreadableResponse),
    );
  });

  test('device deletion with no acknowledgement is indeterminate', () async {
    final result = await apiReturning(
      withoutData: true,
    ).deleteApiToken('Laptop');
    expect(result.outcome, ServerMutationOutcome.indeterminate);
  });

  test('device deletion recognizes authentication rejection', () async {
    final result = await apiReturning(
      withoutData: true,
      errors: const [
        GraphQLError(
          message: 'Unauthenticated',
          extensions: {'code': 'UNAUTHENTICATED'},
        ),
      ],
    ).deleteApiToken('Laptop');
    expect(result.outcome, ServerMutationOutcome.rejected);
  });

  test('device deletion does not replay a resolver failure', () async {
    final result = await apiReturning(
      withoutData: true,
      errors: const [
        GraphQLError(
          message: 'Internal error',
          path: ['api', 'deleteDeviceApiToken'],
        ),
      ],
    ).deleteApiToken('Laptop');
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    expect(requests, hasLength(1));
  });

  test('device deletion does not replay a lost response', () async {
    final result = await apiReturning(
      failure: StateError('connection lost'),
    ).deleteApiToken('Laptop');
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    expect(result.diagnostics, contains(ServerMutationDiagnostic.transport));
    expect(requests, hasLength(1));
  });

  test('device deletion does not populate the GraphQL cache', () async {
    final api = apiReturning();
    await api.deleteApiToken('Laptop');
    expect(api.transport.client().cache.store.toMap(), isEmpty);
  });
}
