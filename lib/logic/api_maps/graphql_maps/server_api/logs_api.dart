part of 'server_api.dart';

mixin LogsApi on GraphQLApiMap {
  Future<(List<ServerLogEntry>, ServerLogsPageMeta)> getServerLogs({
    required final int limit,
    final String? upCursor,
    final String? downCursor,
    final String? slice,
    final String? unit,
  }) async {
    QueryResult<Query$Logs> response;
    List<ServerLogEntry> logsList = [];
    ServerLogsPageMeta pageMeta = const ServerLogsPageMeta(
      downCursor: null,
      upCursor: null,
    );

    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Query$Logs(
        upCursor: upCursor,
        downCursor: downCursor,
        limit: limit,
        filterBySlice: slice,
        filterByUnit: unit,
      );
      final query = Options$Query$Logs(variables: variables);
      response = await client.query$Logs(query);
      if (response.hasException) {
        logger(response.exception.toString());
      }
      if (response.parsedData == null) {
        return (logsList, pageMeta);
      }
      logsList =
          response.parsedData?.logs.paginated.entries
              .map<ServerLogEntry>(ServerLogEntry.fromGraphQL)
              .toList() ??
          [];
      pageMeta = ServerLogsPageMeta.fromGraphQL(
        response.parsedData!.logs.paginated.pageMeta,
      );
    } catch (e) {
      logger("Couldn't load server logs", error: e);
    }

    return (logsList, pageMeta);
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
              if (controller.isClosed) return;
              controller.add(
                ServerLogEntry.fromGraphQL(response.parsedData!.logEntries),
              );
            },
            onError: (final Object e, final StackTrace s) {
              if (!controller.isClosed) controller.addError(e, s);
            },
            onDone: () {
              if (!controller.isClosed) controller.close();
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
        unawaited((client?.link as WebSocketLink?)?.dispose());
      },
    );

    return controller.stream;
  }
}
