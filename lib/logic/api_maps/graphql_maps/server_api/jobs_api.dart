part of 'server_api.dart';

mixin JobsApi on GraphQLApiMap {
  Future<List<ServerJob>> getServerJobs() async {
    QueryResult<Query$GetApiJobs> response;
    List<ServerJob> jobsList = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiJobs();
      if (response.hasException) {
        print(response.exception.toString());
      }
      jobsList = jobsList = response.parsedData?.jobs.getJobs
              .map<ServerJob>((final job) => ServerJob.fromGraphQL(job))
              .toList() ??
          [];
    } catch (e) {
      print(e);
    }

    return jobsList;
  }

  Stream<List<ServerJob>> getServerJobsStream() async* {
    final GraphQLClient client = await getSubscriptionClient();
    final subscription = client.subscribe$JobUpdates();
    await for (final response in subscription) {
      final jobsList = response.parsedData?.jobUpdates
              .map<ServerJob>((final job) => ServerJob.fromGraphQL(job))
              .toList() ??
          [];
      yield jobsList;
    }
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
      print(e);
      return GenericResult(
        data: false,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }
}
