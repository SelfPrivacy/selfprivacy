part of 'server.dart';

mixin JobsApi on ApiMap {
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

  Future<void> removeApiJob(final String uid) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$RemoveJob(jobId: uid);
      final mutation = Options$Mutation$RemoveJob(variables: variables);
      await client.mutate$RemoveJob(mutation);
    } catch (e) {
      print(e);
    }
  }
}
