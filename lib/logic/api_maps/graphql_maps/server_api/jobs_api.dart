part of 'server_api.dart';

mixin JobsApi on GraphQLApiMap {
  Future<ServerJob?> getServerJob(final String uid) async {
    final client = await getClient();
    final response = await client.query$GetApiJob(
      Options$Query$GetApiJob(
        variables: Variables$Query$GetApiJob(jobId: uid),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    final job = requireServerApiData(response).jobs.getJob;
    if (response.data?['jobs'] case final Map<String, dynamic> jobs
        when jobs.containsKey('getJob')) {
      return job == null ? null : ServerJob.fromGraphQL(job);
    }
    throw const MissingServerApiData();
  }

  Future<List<ServerJob>> getServerJobs() async {
    final client = await getClient();
    return requireServerApiData(
      await client.query$GetApiJobs(),
    ).jobs.getJobs.map(ServerJob.fromGraphQL).toList();
  }

  // Backed by a manual StreamController so we get a deterministic onCancel
  // hook. An `async*` + `await for` body would park forever if the upstream
  // subscription stops emitting (which happens after a token rotation —
  // the server invalidates the old session), preventing the `finally` block
  // from ever running the WebSocketLink disposal.
  Stream<List<ServerJob>> getServerJobsStream({
    final Future<Duration?>? Function(int?, String?)? onConnectionLost,
    final void Function({required bool connected})? onConnectionState,
  }) {
    late StreamController<List<ServerJob>> controller;
    GraphQLClient? client;
    StreamSubscription<QueryResult<Subscription$JobUpdates>>? inner;

    controller = StreamController<List<ServerJob>>(
      onListen: () async {
        try {
          client = await getSubscriptionClient(
            onConnectionLost: onConnectionLost,
            onConnectionState: onConnectionState,
          );
          inner = client!.subscribe$JobUpdates().listen(
            (final response) {
              if (controller.isClosed) {
                return;
              }
              try {
                controller.add(
                  requireServerApiData(
                    response,
                  ).jobUpdates.map(ServerJob.fromGraphQL).toList(),
                );
              } catch (e, s) {
                controller.addError(e, s);
              }
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
        unawaited(client?.link.dispose());
      },
    );

    return controller.stream;
  }

  Future<ServerMutationResult<void>> removeApiJob(final String uid) async {
    final client = await getClient();
    final response = await client.mutate$RemoveJob(
      Options$Mutation$RemoveJob(
        variables: Variables$Mutation$RemoveJob(jobId: uid),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.jobs.removeJob,
    );
  }
}
