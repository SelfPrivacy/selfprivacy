enum ServerMutationOutcome { confirmed, rejected, indeterminate }

enum ServerMutationPayloadStatus { available, notExpected, missing, unreadable }

class ServerMutationPayload<T> {
  const ServerMutationPayload.available(this.value)
    : status = ServerMutationPayloadStatus.available;

  const ServerMutationPayload.notExpected()
    : status = ServerMutationPayloadStatus.notExpected,
      value = null;

  const ServerMutationPayload.missing()
    : status = ServerMutationPayloadStatus.missing,
      value = null;

  const ServerMutationPayload.unreadable()
    : status = ServerMutationPayloadStatus.unreadable,
      value = null;

  final ServerMutationPayloadStatus status;
  final T? value;

  @override
  String toString() => 'ServerMutationPayload(${status.name})';
}

enum ServerMutationDiagnostic {
  transport,
  graphql,
  unauthenticated,
  validation,
  missingResponse,
  unreadableResponse,
  missingPayload,
}

class ServerMutationResult<T> {
  ServerMutationResult({
    required this.outcome,
    required this.payload,
    this.code,
    this.message,
    final Iterable<ServerMutationDiagnostic> diagnostics = const [],
  }) : diagnostics = List.unmodifiable(diagnostics);

  final ServerMutationOutcome outcome;
  final ServerMutationPayload<T> payload;
  final int? code;
  final String? message;
  final List<ServerMutationDiagnostic> diagnostics;

  @override
  String toString() =>
      'ServerMutationResult(${outcome.name}, ${payload.status.name}, '
      '$diagnostics)';
}
