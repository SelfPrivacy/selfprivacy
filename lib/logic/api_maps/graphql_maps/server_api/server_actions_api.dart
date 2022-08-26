part of 'server.dart';

mixin ServerActionsApi on ApiMap {
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

  Future<bool> reboot() async {
    try {
      final GraphQLClient client = await getClient();
      return await _commonBoolRequest(
        () async {
          await client.mutate$RebootSystem();
        },
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> pullConfigurationUpdate() async {
    try {
      final GraphQLClient client = await getClient();
      return await _commonBoolRequest(
        () async {
          await client.mutate$PullRepositoryChanges();
        },
      );
    } catch (e) {
      return false;
    }
  }

  Future<bool> upgrade() async {
    try {
      final GraphQLClient client = await getClient();
      return await _commonBoolRequest(
        () async {
          await client.mutate$RunSystemUpgrade();
        },
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
