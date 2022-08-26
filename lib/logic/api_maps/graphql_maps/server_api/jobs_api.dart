part of 'server.dart';

mixin JobsApi on ApiMap {
  Future<List<ServerJob>> getServerJobs() async {
    QueryResult response;
    List<ServerJob> jobs = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetApiJobs();
      if (response.hasException) {
        print(response.exception.toString());
      }
      jobs = response.data!['jobs']
          .map<ServerJob>((final e) => ServerJob.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }

    return jobs;
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
