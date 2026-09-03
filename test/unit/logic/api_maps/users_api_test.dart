import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';

class _UsersApi extends GraphQLApiMap with UsersApi {
  _UsersApi(super.transport);
}

class _MockGraphQLTransport extends Mock implements GraphQLTransport {}

GraphQLClient _clientReturning(final Map<String, dynamic> data) =>
    GraphQLClient(
      cache: GraphQLCache(),
      link: Link.function(
        (final Request request, [final NextLink? forward]) =>
            Stream.value(Response(data: data, response: const {})),
      ),
    );

GraphQLTransport _transportReturning(final Map<String, dynamic> data) {
  final transport = _MockGraphQLTransport();
  when(transport.client).thenReturn(_clientReturning(data));
  return transport;
}

Map<String, dynamic> _failedMutation(final String name) => {
  '__typename': 'Mutation',
  'users': {
    '__typename': 'UsersMutations',
    name: {
      '__typename': name == 'deleteUser'
          ? 'GenericMutationReturn'
          : 'UserMutationReturn',
      'success': false,
      'code': 400,
      'message': 'rejected',
      if (name != 'deleteUser') 'user': null,
    },
  },
};

void main() {
  test('delegates subscription client creation to the transport', () async {
    final transport = _MockGraphQLTransport();
    final client = _clientReturning(const {});
    Future<Duration?> onConnectionLost(
      final int? code,
      final String? reason,
    ) async => null;
    when(
      () => transport.subscriptionClient(onConnectionLost: onConnectionLost),
    ).thenReturn(client);

    final api = _UsersApi(transport);

    expect(
      await api.getSubscriptionClient(onConnectionLost: onConnectionLost),
      same(client),
    );
  });

  test('createUser preserves mutation failure', () async {
    final api = _UsersApi(_transportReturning(_failedMutation('createUser')));

    final result = await api.createUser('alice', null, const []);

    expect(result.success, isFalse);
    expect(result.code, 400);
    expect(result.message, 'rejected');
    expect(result.data, isNull);
  });

  test('updateUser preserves mutation failure', () async {
    final api = _UsersApi(_transportReturning(_failedMutation('updateUser')));

    final result = await api.updateUser('alice', null, const []);

    expect(result.success, isFalse);
    expect(result.code, 400);
    expect(result.message, 'rejected');
    expect(result.data, isNull);
  });

  test('deleteUser preserves mutation failure', () async {
    final api = _UsersApi(_transportReturning(_failedMutation('deleteUser')));

    final result = await api.deleteUser('alice');

    expect(result.success, isFalse);
    expect(result.code, 400);
    expect(result.message, 'rejected');
    expect(result.data, isFalse);
  });

  test('addSshKey preserves mutation failure', () async {
    final api = _UsersApi(_transportReturning(_failedMutation('addSshKey')));

    final result = await api.addSshKey('alice', 'ssh-ed25519 key');

    expect(result.success, isFalse);
    expect(result.code, 400);
    expect(result.message, 'rejected');
    expect(result.data, isNull);
  });
}
