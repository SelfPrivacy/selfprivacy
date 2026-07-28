import 'package:flutter_test/flutter_test.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_api_map.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';

class _TokenBearingApi extends GraphQLApiMap {
  @override
  final String? rootAddress = 'example.org';
  @override
  final bool hasLogger = false;
  @override
  final bool isWithToken = true;
  @override
  final String customToken = '';
}

void main() {
  test('a client that carries a token cannot opt out of verification', () {
    expect(
      _TokenBearingApi().getClient(tlsPolicy: TlsPolicy.allowUnverified),
      throwsStateError,
    );
  });

  test('the readiness probe refuses to run on a token-bearing client', () {
    expect(
      ServerApi(isWithToken: true, overrideDomain: 'example.org').probe(),
      throwsStateError,
    );
  });
}
