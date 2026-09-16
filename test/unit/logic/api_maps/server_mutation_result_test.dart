import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/backups.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/decode_server_mutation.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';

import '../../../helpers/fixtures/json_fixture.dart';

void main() {
  late Map<String, dynamic> data;
  late Map<String, dynamic> mutation;
  late Map<String, dynamic> job;

  setUp(() {
    data =
        loadJsonFixture('graphql/mutation_results.json')['StartBackup']
            as Map<String, dynamic>;
    mutation =
        (data['backup'] as Map<String, dynamic>)['startBackup']
            as Map<String, dynamic>;
    job = mutation['job'] as Map<String, dynamic>;
  });

  QueryResult<Mutation$StartBackup> response({
    final List<GraphQLError> errors = const [],
    final LinkException? linkException,
    final bool withoutData = false,
  }) => QueryResult(
    options: Options$Mutation$StartBackup(
      variables: Variables$Mutation$StartBackup(serviceId: 'outline'),
    ),
    source: QueryResultSource.network,
    data: withoutData ? null : data,
    exception: errors.isEmpty && linkException == null
        ? null
        : OperationException(
            graphqlErrors: errors,
            linkException: linkException,
          ),
  );

  ServerMutationResult<Fragment$basicApiJobsFields> decode({
    final List<GraphQLError> errors = const [],
    final LinkException? linkException,
    final bool withoutData = false,
  }) => decodeServerMutation(
    response(
      errors: errors,
      linkException: linkException,
      withoutData: withoutData,
    ),
    select: (final data) => data.backup.startBackup,
    decodePayload: (final mutation) => mutation.job,
  );

  test('preserves confirmation and the generated payload type', () {
    final result = decode();
    expect(result.outcome, ServerMutationOutcome.confirmed);
    expect(result.payload.status, ServerMutationPayloadStatus.available);
    expect(result.payload.value!.uid, 'job-backup-outline');
    expect(result.code, 200);
    expect(result.message, '');
    expect(result.diagnostics, isEmpty);
  });

  test('preserves a returned payload on rejection', () {
    mutation['success'] = false;
    mutation['code'] = 400;
    mutation['message'] = 'Backup failed';
    final result = decode();
    expect(result.outcome, ServerMutationOutcome.rejected);
    expect(result.payload.value!.uid, 'job-backup-outline');
    expect(result.code, 400);
    expect(result.message, 'Backup failed');
  });

  test('preserves nullable fields in an available payload', () {
    final result = decode();
    expect(result.payload.status, ServerMutationPayloadStatus.available);
    expect(result.payload.value!.finishedAt, isNull);
    expect(result.payload.value!.error, isNull);
  });

  for (final success in [true, false]) {
    test('parsed acknowledgement $success survives a nullable missing job', () {
      mutation['success'] = success;
      mutation['job'] = null;
      final result = decode();
      expect(
        result.outcome,
        success
            ? ServerMutationOutcome.confirmed
            : ServerMutationOutcome.rejected,
      );
      expect(result.payload.status, ServerMutationPayloadStatus.missing);
      expect(result.diagnostics, [ServerMutationDiagnostic.missingPayload]);
    });

    test('does not salvage acknowledgement $success from a malformed job', () {
      mutation['success'] = success;
      job['progress'] = 'secret-invalid-value';
      final result = decode();
      expect(result.outcome, ServerMutationOutcome.indeterminate);
      expect(result.payload.status, ServerMutationPayloadStatus.unreadable);
      expect(result.code, isNull);
      expect(result.message, isNull);
      expect(result.diagnostics, [ServerMutationDiagnostic.unreadableResponse]);
      expect(result.toString(), isNot(contains('secret-invalid-value')));
    });
  }

  test('invalid dates produce an indeterminate outcome', () {
    job['createdAt'] = 'invalid date';
    final result = decode();
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    expect(result.diagnostics, [ServerMutationDiagnostic.unreadableResponse]);
  });

  for (final field in ['code', 'message', 'success']) {
    test('missing required $field does not preserve partial data', () {
      mutation.remove(field);
      final result = decode();
      expect(result.outcome, ServerMutationOutcome.indeterminate);
      expect(result.code, isNull);
      expect(result.message, isNull);
      expect(result.payload.value, isNull);
      expect(result.diagnostics, [ServerMutationDiagnostic.unreadableResponse]);
    });
  }

  test('malformed metadata makes the entire result indeterminate', () {
    mutation['code'] = '200';
    mutation['message'] = 42;
    expect(decode().outcome, ServerMutationOutcome.indeterminate);
  });

  for (final success in [null, 'true', 1]) {
    test('does not infer success from payload when success is $success', () {
      mutation['success'] = success;
      final result = decode();
      expect(result.outcome, ServerMutationOutcome.indeterminate);
      expect(result.payload.value, isNull);
    });
  }

  test('missing mutation envelope is indeterminate', () {
    data['backup'] = null;
    expect(decode().outcome, ServerMutationOutcome.indeterminate);
  });

  test('missing response has no fabricated metadata', () {
    final result = decode(withoutData: true);
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    expect(result.payload.status, ServerMutationPayloadStatus.missing);
    expect(result.code, isNull);
    expect(result.message, isNull);
    expect(result.diagnostics, [ServerMutationDiagnostic.missingResponse]);
  });

  test('retains GraphQL errors with successfully parsed data', () {
    final result = decode(
      errors: const [
        GraphQLError(message: 'Failure', path: ['other', 'field']),
      ],
    );
    expect(result.outcome, ServerMutationOutcome.confirmed);
    expect(result.payload.status, ServerMutationPayloadStatus.available);
    expect(result.diagnostics, [ServerMutationDiagnostic.graphql]);
  });

  test('nullable job failure keeps the parsed acknowledgement', () {
    mutation['job'] = null;
    final result = decode(
      errors: const [
        GraphQLError(
          message: 'Job unavailable',
          path: ['backup', 'startBackup', 'job'],
        ),
      ],
    );
    expect(result.outcome, ServerMutationOutcome.confirmed);
    expect(result.payload.status, ServerMutationPayloadStatus.missing);
    expect(result.diagnostics, [
      ServerMutationDiagnostic.graphql,
      ServerMutationDiagnostic.missingPayload,
    ]);
  });

  test('non-null acknowledgement failure does not salvage the payload', () {
    mutation['success'] = null;
    final result = decode(
      errors: const [
        GraphQLError(
          message: 'Failure',
          path: ['backup', 'startBackup', 'success'],
        ),
      ],
    );
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    expect(result.payload.value, isNull);
    expect(result.diagnostics, [
      ServerMutationDiagnostic.graphql,
      ServerMutationDiagnostic.unreadableResponse,
    ]);
  });

  for (final error in const [
    GraphQLError(message: 'No access', extensions: {'code': 'UNAUTHENTICATED'}),
    GraphQLError(message: 'You must be authenticated to access this resource.'),
    GraphQLError(
      message: 'Invalid query',
      extensions: {'code': 'GRAPHQL_VALIDATION_FAILED'},
    ),
    GraphQLError(
      message: 'Invalid query',
      extensions: {'code': 'GRAPHQL_PARSE_FAILED'},
    ),
  ]) {
    test('recognizes request rejection: $error', () {
      expect(
        decode(errors: [error], withoutData: true).outcome,
        ServerMutationOutcome.rejected,
      );
    });
  }

  for (final error in const [
    GraphQLError(message: 'Internal error'),
    GraphQLError(
      message: 'You must be authenticated to access this resource.',
      extensions: {'code': 'FUTURE_CODE'},
    ),
    GraphQLError(
      message: 'Validation',
      path: ['backup', 'startBackup'],
      extensions: {'code': 'GRAPHQL_VALIDATION_FAILED'},
    ),
    GraphQLError(
      message: 'No access',
      path: ['backup', 'startBackup', 'job'],
      extensions: {'code': 'UNAUTHENTICATED'},
    ),
  ]) {
    test('keeps unfamiliar or execution errors indeterminate: $error', () {
      expect(
        decode(errors: [error], withoutData: true).outcome,
        ServerMutationOutcome.indeterminate,
      );
    });
  }

  test('a mixed error set does not prove rejection', () {
    final result = decode(
      withoutData: true,
      errors: const [
        GraphQLError(
          message: 'No access',
          extensions: {'code': 'UNAUTHENTICATED'},
        ),
        GraphQLError(message: 'Resolver failed'),
      ],
    );
    expect(result.outcome, ServerMutationOutcome.indeterminate);
  });

  test(
    'validation code with malformed execution data does not prove rejection',
    () {
      mutation.remove('success');
      final result = decode(
        errors: const [
          GraphQLError(
            message: 'Validation',
            extensions: {'code': 'GRAPHQL_VALIDATION_FAILED'},
          ),
        ],
      );
      expect(result.outcome, ServerMutationOutcome.indeterminate);
    },
  );

  test('transport failure does not prove rejection or leak diagnostics', () {
    final result = decode(
      withoutData: true,
      linkException: UnknownException(
        'secret transport error',
        StackTrace.current,
      ),
      errors: const [
        GraphQLError(
          message: 'No access',
          extensions: {'code': 'UNAUTHENTICATED'},
        ),
      ],
    );
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    expect(result.diagnostics, contains(ServerMutationDiagnostic.transport));
    expect(result.toString(), isNot(contains('secret transport error')));
  });

  test('diagnostics are immutable and stringification omits secrets', () {
    final diagnostics = [ServerMutationDiagnostic.graphql];
    final result = ServerMutationResult(
      outcome: ServerMutationOutcome.confirmed,
      payload: const ServerMutationPayload.available('secret payload'),
      message: 'secret message',
      diagnostics: diagnostics,
    );
    diagnostics.clear();
    expect(result.diagnostics, [ServerMutationDiagnostic.graphql]);
    expect(result.diagnostics.clear, throwsUnsupportedError);
    expect(result.toString(), isNot(contains('secret')));
    expect(result.payload.toString(), isNot(contains('secret')));
    expect(result.payload.value, 'secret payload');
  });

  test(
    'mapping format errors are indeterminate; programming errors propagate',
    () {
      final result = decodeServerMutation(
        response(),
        select: (final data) => data.backup.startBackup,
        decodePayload: (_) => throw const FormatException('secret'),
      );
      expect(result.outcome, ServerMutationOutcome.indeterminate);
      expect(result.diagnostics, [ServerMutationDiagnostic.unreadableResponse]);
      expect(
        () => decodeServerMutation(
          response(),
          select: (final data) => data.backup.startBackup,
          decodePayload: (_) => throw StateError('programming error'),
        ),
        throwsStateError,
      );
    },
  );

  test('does not recover a typed payload from malformed data', () {
    mutation['code'] = 'invalid';
    var called = false;
    final result = decodeServerMutation(
      response(),
      select: (final data) {
        called = true;
        return data.backup.startBackup;
      },
    );
    expect(result.outcome, ServerMutationOutcome.indeterminate);
    expect(called, isFalse);
    expect(result.payload.status, ServerMutationPayloadStatus.notExpected);
  });
}
