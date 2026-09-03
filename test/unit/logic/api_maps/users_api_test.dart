import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';

class _UsersApi extends GraphQLApiMap with UsersApi {
  _UsersApi(this.client);

  final GraphQLClient client;

  @override
  final String? rootAddress = 'example.test';

  @override
  final bool hasLogger = false;

  @override
  final bool isWithToken = false;

  @override
  final String apiToken = '';

  @override
  Future<GraphQLClient> getClient({
    final TlsPolicy tlsPolicy = TlsPolicy.strict,
  }) async => client;
}

GraphQLClient _clientReturning(final Map<String, dynamic> data) =>
    GraphQLClient(
      cache: GraphQLCache(),
      link: Link.function(
        (final Request request, [final NextLink? forward]) =>
            Stream.value(Response(data: data, response: const {})),
      ),
    );

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
  test('createUser preserves mutation failure', () async {
    final api = _UsersApi(_clientReturning(_failedMutation('createUser')));

    final result = await api.createUser('alice', null, const []);

    expect(result.success, isFalse);
    expect(result.code, 400);
    expect(result.message, 'rejected');
    expect(result.data, isNull);
  });

  test('updateUser preserves mutation failure', () async {
    final api = _UsersApi(_clientReturning(_failedMutation('updateUser')));

    final result = await api.updateUser('alice', null, const []);

    expect(result.success, isFalse);
    expect(result.code, 400);
    expect(result.message, 'rejected');
    expect(result.data, isNull);
  });

  test('deleteUser preserves mutation failure', () async {
    final api = _UsersApi(_clientReturning(_failedMutation('deleteUser')));

    final result = await api.deleteUser('alice');

    expect(result.success, isFalse);
    expect(result.code, 400);
    expect(result.message, 'rejected');
    expect(result.data, isFalse);
  });

  test('addSshKey preserves mutation failure', () async {
    final api = _UsersApi(_clientReturning(_failedMutation('addSshKey')));

    final result = await api.addSshKey('alice', 'ssh-ed25519 key');

    expect(result.success, isFalse);
    expect(result.code, 400);
    expect(result.message, 'rejected');
    expect(result.data, isNull);
  });
}
