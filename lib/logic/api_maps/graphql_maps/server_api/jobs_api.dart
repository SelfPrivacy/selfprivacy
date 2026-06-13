part of 'server_api.dart';

mixin JobsApi on GraphQLApiMap {
  Future<List<ServerJob>?> getServerJobs() async {
    QueryResult<Query$GetApiJobs> response;
    List<ServerJob>? jobsList;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiJobs();
      if (response.hasException) {
        logger(response.exception.toString());
      }
      jobsList = response.parsedData?.jobs.getJobs
          .map<ServerJob>(ServerJob.fromGraphQL)
          .toList();
    } catch (e) {
      logger("Couldn't get server jobs", error: e);
    }

    return jobsList;
  }

  // Backed by a manual StreamController so we get a deterministic onCancel
  // hook. An `async*` + `await for` body would park forever if the upstream
  // subscription stops emitting (which happens after a token rotation —
  // the server invalidates the old session), preventing the `finally` block
  // from ever running the WebSocketLink disposal.
  Stream<List<ServerJob>?> getServerJobsStream({
    final Future<Duration?>? Function(int?, String?)? onConnectionLost,
  }) {
    late StreamController<List<ServerJob>?> controller;
    GraphQLClient? client;
    StreamSubscription<QueryResult<Subscription$JobUpdates>>? inner;

    controller = StreamController<List<ServerJob>?>(
      onListen: () async {
        try {
          client = await getSubscriptionClient(
            onConnectionLost: onConnectionLost,
          );
          inner = client!.subscribe$JobUpdates().listen(
            (final response) {
              if (controller.isClosed) {
                return;
              }
              controller.add(
                response.parsedData?.jobUpdates
                    .map<ServerJob>(ServerJob.fromGraphQL)
                    .toList(),
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
        // Cancelling the inner subscription only sends SubscriptionComplete
        // over the socket; the link stays open (auto-reconnecting) until
        // disposed.
        unawaited(inner?.cancel());
        // dispose()'s synchronous prelude cancels the reconnect/ping timers
        // and closes the message subject — that's the cleanup we actually
        // care about. The trailing WS close-frame await may hang on an
        // invalidated session, but it's a TCP-level cleanup the OS will
        // reap, not a leaked link.
        unawaited((client?.link as WebSocketLink?)?.dispose());
      },
    );

    return controller.stream;
  }

  Future<GenericResult<bool>> removeApiJob(final String uid) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$RemoveJob(jobId: uid);
      final mutation = Options$Mutation$RemoveJob(variables: variables);
      final response = await client.mutate$RemoveJob(mutation);
      return GenericResult(
        data: response.parsedData?.jobs.removeJob.success ?? false,
        success: true,
        code: response.parsedData?.jobs.removeJob.code ?? 0,
        message: response.parsedData?.jobs.removeJob.message,
      );
    } catch (e) {
      logger("Couldn't remove the API job", error: e);
      return GenericResult(
        data: false,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }
}
