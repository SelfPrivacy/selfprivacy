import 'dart:async';
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
import 'package:selfprivacy/logic/operations/operation_queue.dart';
import 'package:selfprivacy/logic/operations/secret_recipient.dart';

class _MockTlsContext extends Mock implements TlsContext {}

void main() {
  late _MockTlsContext tlsContext;
  late List<http.BaseRequest> requests;
  late http.Client httpClient;
  late Map<String, dynamic> responseBody;
  var domain = 'first.example';
  var token = 'first-token';
  var locale = 'en';
  late List<ConsoleLog> logs;

  GraphQLTransport transport({
    final GraphQLTokenProvider? tokenProvider,
    final GraphQLAuthFailureHandler? onAuthFailure,
    final TlsPolicy tlsPolicy = TlsPolicy.strict,
    final void Function(GraphQLTransportEvent)? onEvent,
    final void Function()? beforeRequest,
  }) => GraphQLTransport(
    domainProvider: () => domain,
    tokenProvider: tokenProvider,
    onAuthFailure: onAuthFailure,
    localeProvider: () => locale,
    tlsContext: tlsContext,
    tlsPolicy: tlsPolicy,
    consoleLog: (final log) => logs.add(log),
    onEvent: onEvent,
    beforeRequest: beforeRequest,
  );

  Future<QueryResult<Object?>> query(final GraphQLTransport transport) =>
      transport.client().query<Object?>(
        QueryOptions<Object?>(
          document: parseString('query { api { version } }'),
        ),
      );

  setUpAll(() => registerFallbackValue(TlsPolicy.strict));

  setUp(() {
    domain = 'first.example';
    token = 'first-token';
    locale = 'en';
    logs = [];
    tlsContext = _MockTlsContext();
    requests = [];
    responseBody = {
      'data': {
        'api': {'version': '3.9.0'},
      },
    };
    httpClient = MockClient((final request) async {
      requests.add(request);
      return http.Response(
        jsonEncode(responseBody),
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

  test(
    'recipient cancellation after preparation prevents HTTP dispatch and logging',
    () async {
      final recipient = SecretRecipient();
      final prepared = Completer<void>();
      final graphQLTransport = transport(tokenProvider: () => token);
      final pending = recipient.protect(() async {
        await prepared.future;
        return query(graphQLTransport);
      });
      final rejected = expectLater(pending, throwsA(isA<OperationNotSent>()));
      recipient.dispose();
      prepared.complete();
      await rejected;
      expect(requests, isEmpty);
      expect(logs, isEmpty);
    },
  );

  test(
    'reports protected request lifecycle without exposing payloads',
    () async {
      final events = <GraphQLTransportEvent>[];
      await query(transport(tokenProvider: () => token, onEvent: events.add));
      await Future<void>.delayed(Duration.zero);
      expect(events, [
        GraphQLTransportEvent.requestStarted,
        GraphQLTransportEvent.protectedSuccess,
        GraphQLTransportEvent.requestFinished,
      ]);
    },
  );

  test('refuses gated dispatch before any network request', () async {
    final events = <GraphQLTransportEvent>[];
    final result = await query(
      transport(
        beforeRequest: () => throw const GraphQLDispatchDeferred(),
        onEvent: events.add,
      ),
    );
    expect(result.hasException, isTrue);
    expect(requests, isEmpty);
    expect(events, isEmpty);
  });

  test('public request success is not proof of authentication', () async {
    final events = <GraphQLTransportEvent>[];
    await transport(
      tokenProvider: () => token,
      onEvent: events.add,
    ).client().query<Object?>(
      QueryOptions<Object?>(
        document: parseString('query { api { version } }'),
        context: const Context().withEntry(const PublicGraphQLRequest()),
      ),
    );
    expect(events, contains(GraphQLTransportEvent.reachable));
    expect(events, isNot(contains(GraphQLTransportEvent.protectedSuccess)));
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
    var authFailures = 0;
    final strict = transport(
      tokenProvider: () => token,
      onAuthFailure: () => authFailures++,
    );
    final unverified = strict.withTlsPolicy(TlsPolicy.allowUnverified);

    domain = 'second.example';
    token = 'rotated-token';
    locale = 'de';

    expect(unverified.domain, 'second.example');
    expect(unverified.token, 'rotated-token');
    expect(unverified.localeProvider(), 'de');
    expect(unverified.tlsPolicy, TlsPolicy.allowUnverified);
    unverified.onAuthFailure?.call();
    expect(authFailures, 1);
  });

  test('builds anonymous and authenticated subscription clients', () {
    expect(transport().subscriptionClient(), isA<GraphQLClient>());
    expect(
      transport(tokenProvider: () => token).subscriptionClient(),
      isA<GraphQLClient>(),
    );
  });

  test('logs ordinary requests, responses and GraphQL errors', () async {
    responseBody['errors'] = [
      {'message': 'access denied'},
    ];
    await query(transport());
    expect(logs.whereType<GraphQlRequestConsoleLog>(), hasLength(1));
    expect(
      logs.whereType<GraphQlResponseConsoleLog>().single.rawResponse,
      contains('access denied'),
    );
    expect(
      logs.whereType<ManualConsoleLog>().single.content,
      contains('access denied'),
    );
  });

  test(
    'sensitive failures keep auth callbacks but not free-form errors',
    () async {
      var authFailures = 0;
      responseBody = {
        'errors': [
          {
            'message': 'secret-sentinel',
            'extensions': {
              'code': 'UNAUTHENTICATED',
              'detail': 'secret-sentinel',
            },
          },
        ],
      };
      final result = await transport(onAuthFailure: () => authFailures++)
          .client()
          .query<Object?>(
            QueryOptions(
              document: parseString('query Sensitive { api { version } }'),
              context: sensitiveGraphQLContext,
              variables: const {'key': 'secret-sentinel'},
            ),
          );
      expect(authFailures, 1);
      expect(result.exception?.graphqlErrors.single.message, 'secret-sentinel');
      expect(logs, hasLength(2));
      for (final log in logs) {
        expect(log, isNot(isA<LogWithRawResponse>()));
        expect(log.content, isNot(contains('secret-sentinel')));
        expect(log.shareableData, isNot(contains('secret-sentinel')));
        expect(log.content, contains('Sensitive'));
      }
    },
  );

  test('reports coded authentication errors without consuming them', () async {
    var authFailures = 0;
    responseBody = {
      'data': null,
      'errors': [
        {
          'message': 'Authentication failed',
          'extensions': {'code': 'UNAUTHENTICATED'},
        },
        {
          'message': 'Authentication also failed',
          'extensions': {'code': 'UNAUTHENTICATED'},
        },
      ],
    };

    final result = await query(transport(onAuthFailure: () => authFailures++));

    expect(authFailures, 1);
    expect(result.exception?.graphqlErrors, hasLength(2));
    expect(
      result.exception?.graphqlErrors.first.message,
      'Authentication failed',
    );
  });

  test('reports legacy authentication errors without a code', () async {
    var authFailures = 0;
    responseBody = {
      'data': null,
      'errors': [
        {'message': 'You must be authenticated to access this resource.'},
      ],
    };

    await query(transport(onAuthFailure: () => authFailures++));

    expect(authFailures, 1);
  });

  test(
    'does not use the legacy message when another code is present',
    () async {
      var authFailures = 0;
      responseBody = {
        'data': null,
        'errors': [
          {
            'message': 'You must be authenticated to access this resource.',
            'extensions': {'code': 'FORBIDDEN'},
          },
        ],
      };

      await query(transport(onAuthFailure: () => authFailures++));

      expect(authFailures, 0);
    },
  );

  test('ignores unrelated GraphQL errors', () async {
    var authFailures = 0;
    responseBody = {
      'data': null,
      'errors': [
        {'message': 'Service failed'},
      ],
    };

    await query(transport(onAuthFailure: () => authFailures++));

    expect(authFailures, 0);
  });

  test('builds a subscription client with auth failure handling', () {
    final graphQLClient = transport(
      tokenProvider: () => token,
      onAuthFailure: () {},
    ).subscriptionClient();

    expect(graphQLClient, isA<GraphQLClient>());
  });
}
