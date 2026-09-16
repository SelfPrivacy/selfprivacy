import 'package:graphql/client.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/schema/server_api.graphql.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_mutation_result.dart';

ServerMutationResult<T> decodeServerMutation<
  D extends Object,
  M extends Fragment$basicMutationReturnFields,
  T
>(
  final QueryResult<D> response, {
  required final M Function(D) select,
  final T? Function(M)? decodePayload,
}) {
  final exception = response.exception;
  final errors = exception?.graphqlErrors ?? const <GraphQLError>[];
  final diagnostics = [
    if (exception?.linkException != null) ServerMutationDiagnostic.transport,
    if (errors.isNotEmpty) ServerMutationDiagnostic.graphql,
  ];

  ServerMutationResult<T> failed(final ServerMutationDiagnostic issue) {
    final rejection = response.data == null && exception?.linkException == null
        ? _requestRejection(errors)
        : null;
    return ServerMutationResult(
      outcome: rejection == null
          ? ServerMutationOutcome.indeterminate
          : ServerMutationOutcome.rejected,
      payload: decodePayload == null
          ? ServerMutationPayload<T>.notExpected()
          : issue == ServerMutationDiagnostic.missingResponse
          ? ServerMutationPayload<T>.missing()
          : ServerMutationPayload<T>.unreadable(),
      diagnostics: [...diagnostics, issue, ?rejection],
    );
  }

  try {
    final data = response.parsedData;
    if (data == null) {
      return failed(ServerMutationDiagnostic.missingResponse);
    }
    final mutation = select(data);
    final value = decodePayload?.call(mutation);
    return ServerMutationResult(
      outcome: mutation.success
          ? ServerMutationOutcome.confirmed
          : ServerMutationOutcome.rejected,
      payload: decodePayload == null
          ? ServerMutationPayload<T>.notExpected()
          : value == null
          ? ServerMutationPayload<T>.missing()
          : ServerMutationPayload.available(value),
      code: mutation.code,
      message: mutation.message,
      diagnostics: [
        ...diagnostics,
        if (decodePayload != null && value == null)
          ServerMutationDiagnostic.missingPayload,
      ],
    );
  } on FormatException {
    return failed(ServerMutationDiagnostic.unreadableResponse);
  } on TypeError {
    return failed(ServerMutationDiagnostic.unreadableResponse);
  }
}

ServerMutationDiagnostic? _requestRejection(final List<GraphQLError> errors) {
  if (errors.isEmpty ||
      errors.any((final error) => error.path?.isNotEmpty ?? false)) {
    return null;
  }
  if (errors.every(_isAuthenticationRejection)) {
    return ServerMutationDiagnostic.unauthenticated;
  }
  if (errors.every(
    (final error) => const {
      'GRAPHQL_VALIDATION_FAILED',
      'GRAPHQL_PARSE_FAILED',
    }.contains(error.extensions?['code']),
  )) {
    return ServerMutationDiagnostic.validation;
  }
  return null;
}

bool _isAuthenticationRejection(final GraphQLError error) {
  final code = error.extensions?['code'];
  return code == 'UNAUTHENTICATED' ||
      (code == null &&
          error.message ==
              'You must be authenticated to access this resource.');
}
