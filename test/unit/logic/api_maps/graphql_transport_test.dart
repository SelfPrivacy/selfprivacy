import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/graphql_transport.dart';
import 'package:selfprivacy/logic/api_maps/tls_policy.dart';
import 'package:selfprivacy/logic/models/console_log.dart';

class _MockTlsContext extends Mock implements TlsContext {}

void main() {
  late _MockTlsContext tlsContext;
  late List<http.BaseRequest> requests;
  late http.Client httpClient;
  var domain = 'first.example';
  var token = 'first-token';
  var locale = 'en';

  GraphQLTransport transport({
    final GraphQLTokenProvider? tokenProvider,
    final TlsPolicy tlsPolicy = TlsPolicy.strict,
  }) => GraphQLTransport(
    domainProvider: () => domain,
    tokenProvider: tokenProvider,
    localeProvider: () => locale,
    tlsContext: tlsContext,
    tlsPolicy: tlsPolicy,
    consoleLog: (_) {},
  );

  Future<void> query(final GraphQLTransport transport) => transport
      .client()
      .query(QueryOptions(document: parseString('query { api { version } }')));

  setUpAll(() => registerFallbackValue(TlsPolicy.strict));

  setUp(() {
    domain = 'first.example';
    token = 'first-token';
    locale = 'en';
    tlsContext = _MockTlsContext();
    requests = [];
    httpClient = MockClient((final request) async {
      requests.add(request);
      return http.Response(
        jsonEncode({
          'data': {
            'api': {'version': '3.9.0'},
          },
        }),
        200,
        headers: {'content-type': 'application/json'},
      );
    });
    when(
      () => tlsContext.clientFor(
        host: any(named: 'host'),
        policy: any(named: 'policy'),
      ),
    ).thenReturn(httpClient);
  });

  test('builds authenticated HTTP requests from current values', () async {
    final graphQLTransport = transport(tokenProvider: () => token);

    await query(graphQLTransport);
    domain = 'second.example';
    token = 'rotated-token';
    locale = 'de';
    await query(graphQLTransport);

    expect(requests[0].url, Uri.parse('https://api.first.example/graphql'));
    expect(requests[0].headers['Authorization'], 'Bearer first-token');
    expect(requests[0].headers['Accept-Language'], 'en');
    expect(requests[1].url, Uri.parse('https://api.second.example/graphql'));
    expect(requests[1].headers['Authorization'], 'Bearer rotated-token');
    expect(requests[1].headers['Accept-Language'], 'de');
  });

  test('omits authorization from anonymous HTTP requests', () async {
    await query(transport());

    expect(requests.single.headers, isNot(contains('Authorization')));
  });

  test('passes its TLS policy to the HTTP client', () async {
    await query(transport(tlsPolicy: TlsPolicy.allowUnverified));

    verify(
      () => tlsContext.clientFor(
        host: 'api.first.example',
        policy: TlsPolicy.allowUnverified,
      ),
    ).called(1);
  });

  test('refuses authenticated unverified clients', () {
    final unverified = transport(
      tokenProvider: () => token,
      tlsPolicy: TlsPolicy.allowUnverified,
    );

    expect(unverified.client, throwsStateError);
    expect(unverified.subscriptionClient, throwsStateError);
  });

  test('copies connection providers when its TLS policy changes', () {
    final strict = transport(tokenProvider: () => token);
    final unverified = strict.withTlsPolicy(TlsPolicy.allowUnverified);

    domain = 'second.example';
    token = 'rotated-token';
    locale = 'de';

    expect(unverified.domain, 'second.example');
    expect(unverified.token, 'rotated-token');
    expect(unverified.localeProvider(), 'de');
    expect(unverified.tlsPolicy, TlsPolicy.allowUnverified);
  });

  test('builds anonymous and authenticated subscription clients', () {
    expect(transport().subscriptionClient(), isA<GraphQLClient>());
    expect(
      transport(tokenProvider: () => token).subscriptionClient(),
      isA<GraphQLClient>(),
    );
  });

  test('logs parsed GraphQL errors', () {
    final logs = <ConsoleLog>[];
    final parser = ResponseLoggingParser(consoleLog: logs.add);

    final error = parser.parseError({'message': 'access denied'});

    expect(error.message, 'access denied');
    expect(logs.single, isA<ManualConsoleLog>());
    expect(logs.single.severity, ConsoleLogSeverity.warning);
    expect(logs.single.content, contains('access denied'));
  });
}
