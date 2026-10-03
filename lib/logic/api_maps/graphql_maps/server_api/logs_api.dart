part of 'server_api.dart';

mixin LogsApi on GraphQLApiMap {
  Future<(List<ServerLogEntry>, ServerLogsPageMeta)> getServerLogs({
    required final int limit,
    final String? upCursor,
    final String? downCursor,
    final String? slice,
    final String? unit,
  }) async {
    final client = await getClient();
    final response = await client.query$Logs(
      Options$Query$Logs(
        variables: Variables$Query$Logs(
          upCursor: upCursor,
          downCursor: downCursor,
          limit: limit,
          filterBySlice: slice,
          filterByUnit: unit,
        ),
      ),
    );
    final page = requireServerApiData(response).logs.paginated;
    return (
      List<ServerLogEntry>.unmodifiable(
        page.entries.map(ServerLogEntry.fromGraphQL),
      ),
      ServerLogsPageMeta.fromGraphQL(page.pageMeta),
    );
  }

  // See the note on `getServerJobsStream` for why this is a manual
  // StreamController rather than an `async*` generator.
  Stream<ServerLogEntry> getServerLogsStream() {
    late StreamController<ServerLogEntry> controller;
    GraphQLClient? client;
    StreamSubscription<QueryResult<Subscription$LogEntries>>? inner;

    controller = StreamController<ServerLogEntry>(
      onListen: () async {
        try {
          client = await getSubscriptionClient();
          inner = client!.subscribe$LogEntries().listen(
            (final response) {
              if (controller.isClosed) {
                return;
              }
              controller.add(
                ServerLogEntry.fromGraphQL(response.parsedData!.logEntries),
              );
            },
            onError: (final Object e, final StackTrace s) {
              if (!controller.isClosed) {
                controller.addError(e, s);
              }
            },
            onDone: () {
              if (!controller.isClosed) {
                unawaited(controller.close());
              }
            },
          );
        } catch (e, s) {
          if (!controller.isClosed) {
            controller.addError(e, s);
            await controller.close();
          }
        }
      },
      onCancel: () {
        unawaited(inner?.cancel());
        unawaited(client?.link.dispose());
      },
    );

    return controller.stream;
  }
}
