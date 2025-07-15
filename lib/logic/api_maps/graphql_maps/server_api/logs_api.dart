part of 'server_api.dart';

mixin LogsApi on GraphQLApiMap {
  Future<(List<ServerLogEntry>, ServerLogsPageMeta)> getServerLogs({
    required final int limit,
    final String? upCursor,
    final String? downCursor,
    final String? slice,
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
      );
      final query = Options$Query$Logs(variables: variables);
      response = await client.query$Logs(query);
      if (response.hasException) {
        print(response.exception.toString());
      }
      if (response.parsedData == null) {
        return (logsList, pageMeta);
      }
      logsList =
          response.parsedData?.logs.paginated.entries
              .map<ServerLogEntry>(
                (final log) => ServerLogEntry.fromGraphQL(log),
              )
              .toList() ??
          [];
      pageMeta = ServerLogsPageMeta.fromGraphQL(
        response.parsedData!.logs.paginated.pageMeta,
      );
    } catch (e) {
      print(e);
    }

    return (logsList, pageMeta);
  }

  Stream<ServerLogEntry> getServerLogsStream() async* {
    final GraphQLClient client = await getSubscriptionClient();
    final subscription = client.subscribe$LogEntries();
    await for (final response in subscription) {
      final log = ServerLogEntry.fromGraphQL(response.parsedData!.logEntries);
      yield log;
    }
  }
}
