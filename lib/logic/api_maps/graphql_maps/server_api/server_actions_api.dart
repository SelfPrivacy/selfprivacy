part of 'server_api.dart';

mixin ServerActionsApi on GraphQLApiMap {
  Future<bool> _commonBoolRequest(final Function() graphQLMethod) async {
    QueryResult response;
    bool result = false;

    try {
      response = await graphQLMethod();
      if (response.hasException) {
        logger(
          'Exception in GraphQL request: ${response.exception}',
          error: response.exception,
        );
        result = false;
      } else {
        result = true;
      }
    } catch (e) {
      logger('Error in GraphQL request: $e', error: e);
    }

    return result;
  }

  Future<GenericResult<DateTime?>> reboot() async {
    DateTime? time;
    try {
      final GraphQLClient client = await getClient();
      final response = await client.mutate$RebootSystem();
      if (response.hasException) {
        logger(
          'Exception in GraphQL Reboot request: ${response.exception}',
          error: response.exception,
        );
      }
      if (response.parsedData!.system.rebootSystem.success) {
        return GenericResult(
          data: time,
          success: true,
          message: response.parsedData!.system.rebootSystem.message,
        );
      }
    } catch (e) {
      logger('Error in GraphQL Reboot request: $e', error: e);
      return GenericResult(data: time, success: false);
    }

    return GenericResult(data: time, success: true);
  }

  Future<bool> pullConfigurationUpdate() async {
    try {
      final GraphQLClient client = await getClient();
      return await _commonBoolRequest(client.mutate$PullRepositoryChanges);
    } catch (e) {
      return false;
    }
  }

  Future<GenericResult<ServerJob?>> upgrade() async {
    try {
      final GraphQLClient client = await getClient();
      final result = await client.mutate$RunSystemUpgrade();
      if (result.hasException) {
        final fallbackResult = await client.mutate$RunSystemUpgradeFallback();
        if (fallbackResult.parsedData!.system.runSystemUpgrade.success) {
          return GenericResult(
            success: true,
            data: null,
            message: fallbackResult.parsedData!.system.runSystemUpgrade.message,
          );
        } else {
          return GenericResult(
            success: false,
            message: fallbackResult.parsedData!.system.runSystemUpgrade.message,
            data: null,
          );
        }
      } else if (result.parsedData!.system.runSystemUpgrade.success &&
          result.parsedData!.system.runSystemUpgrade.job != null) {
        return GenericResult(
          success: true,
          data: ServerJob.fromGraphQL(
            result.parsedData!.system.runSystemUpgrade.job!,
          ),
          message: result.parsedData!.system.runSystemUpgrade.message,
        );
      } else {
        return GenericResult(
          success: false,
          message: result.parsedData!.system.runSystemUpgrade.message,
          data: null,
        );
      }
    } catch (e) {
      return GenericResult(success: false, message: e.toString(), data: null);
    }
  }

  Future<GenericResult<ServerJob?>> apply() async {
    try {
      final GraphQLClient client = await getClient();
      final result = await client.mutate$RunSystemRebuild();
      if (result.hasException) {
        final fallbackResult = await client.mutate$RunSystemRebuildFallback();
        if (fallbackResult.parsedData!.system.runSystemRebuild.success) {
          return GenericResult(
            success: true,
            data: null,
            message: fallbackResult.parsedData!.system.runSystemRebuild.message,
          );
        } else {
          return GenericResult(
            success: false,
            message: fallbackResult.parsedData!.system.runSystemRebuild.message,
            data: null,
          );
        }
      } else {
        if (result.parsedData!.system.runSystemRebuild.success &&
            result.parsedData!.system.runSystemRebuild.job != null) {
          return GenericResult(
            success: true,
            data: ServerJob.fromGraphQL(
              result.parsedData!.system.runSystemRebuild.job!,
            ),
            message: result.parsedData!.system.runSystemRebuild.message,
          );
        } else {
          return GenericResult(
            success: false,
            message: result.parsedData!.system.runSystemRebuild.message,
            data: null,
          );
        }
      }
    } catch (e) {
      logger('Error in GraphQL Apply request: $e', error: e);
      return GenericResult(success: false, message: e.toString(), data: null);
    }
  }

  Future<GenericResult<ServerJob?>> collectNixGarbage() async {
    try {
      final GraphQLClient client = await getClient();
      final result = await client.mutate$NixCollectGarbage();
      if (result.hasException) {
        return GenericResult(success: false, data: null);
      } else if (result.parsedData!.system.nixCollectGarbage.success &&
          result.parsedData!.system.nixCollectGarbage.job != null) {
        return GenericResult(
          success: true,
          data: ServerJob.fromGraphQL(
            result.parsedData!.system.nixCollectGarbage.job!,
          ),
          message: result.parsedData!.system.nixCollectGarbage.message,
        );
      } else {
        return GenericResult(
          success: false,
          message: result.parsedData!.system.nixCollectGarbage.message,
          data: null,
        );
      }
    } catch (e) {
      return GenericResult(success: false, message: e.toString(), data: null);
    }
  }
}
