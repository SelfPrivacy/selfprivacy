part of 'server_api.dart';

mixin ServerActionsApi on GraphQLApiMap {
  Future<bool> _commonBoolRequest(final Function graphQLMethod) async {
    QueryResult response;
    bool result = false;

    try {
      response = await graphQLMethod();
      if (response.hasException) {
        print(response.exception.toString());
        result = false;
      } else {
        result = true;
      }
    } catch (e) {
      print(e);
    }

    return result;
  }

  Future<GenericResult<DateTime?>> reboot() async {
    DateTime? time;
    try {
      final GraphQLClient client = await getClient();
      final response = await client.mutate$RebootSystem();
      if (response.hasException) {
        print(response.exception.toString());
      }
      if (response.parsedData!.system.rebootSystem.success) {
        time = DateTime.now().toUtc();
      }
    } catch (e) {
      print(e);
      return GenericResult(data: time, success: false);
    }

    return GenericResult(data: time, success: true);
  }

  Future<bool> pullConfigurationUpdate() async {
    try {
      final GraphQLClient client = await getClient();
      return await _commonBoolRequest(
        () async => client.mutate$PullRepositoryChanges(),
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> upgrade() async {
    try {
      final GraphQLClient client = await getClient();
      return _commonBoolRequest(
        () async => client.mutate$RunSystemUpgrade(),
      );
    } catch (e) {
      return false;
    }
  }

  Future<void> apply() async {
    try {
      final GraphQLClient client = await getClient();
      await client.mutate$RunSystemRebuild();
    } catch (e) {
      print(e);
    }
  }
}
