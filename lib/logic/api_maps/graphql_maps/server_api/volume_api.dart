part of 'server_api.dart';

mixin VolumeApi on GraphQLApiMap {
  Future<List<ServerDiskVolume>> getServerDiskVolumes() async {
    QueryResult<Query$GetServerDiskVolumes> response;
    List<ServerDiskVolume> volumes = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetServerDiskVolumes();
      if (response.hasException) {
        logger(
          'Exception in GraphQL GetServerDiskVolumes request: ${response.exception}',
          error: response.exception,
        );
      }
      volumes =
          response.parsedData?.storage.volumes
              .map<ServerDiskVolume>(ServerDiskVolume.fromGraphQL)
              .toList() ??
          [];
    } catch (e) {
      logger('Error in GraphQL GetServerDiskVolumes request: $e', error: e);
    }

    return volumes;
  }

  Future<void> mountVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$MountVolume(name: volumeName);
      final mountVolumeMutation = Options$Mutation$MountVolume(
        variables: variables,
      );
      await client.mutate$MountVolume(mountVolumeMutation);
    } catch (e) {
      logger('Error in GraphQL MountVolume request: $e', error: e);
    }
  }

  Future<void> unmountVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$UnmountVolume(name: volumeName);
      final unmountVolumeMutation = Options$Mutation$UnmountVolume(
        variables: variables,
      );
      await client.mutate$UnmountVolume(unmountVolumeMutation);
    } catch (e) {
      logger('Error in GraphQL UnmountVolume request: $e', error: e);
    }
  }

  Future<void> resizeVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$ResizeVolume(name: volumeName);
      final resizeVolumeMutation = Options$Mutation$ResizeVolume(
        variables: variables,
      );
      await client.mutate$ResizeVolume(resizeVolumeMutation);
    } catch (e) {
      logger('Error in GraphQL ResizeVolume request: $e', error: e);
    }
  }

  Future<GenericResult<String?>> migrateToBinds(
    final Map<String, String> serviceToDisk,
    final String fallbackDrive,
  ) async {
    GenericResult<String?>? mutation;

    try {
      final GraphQLClient client = await getClient();
      final input = Input$MigrateToBindsInput(
        bitwardenBlockDevice: serviceToDisk['bitwarden'] ?? fallbackDrive,
        emailBlockDevice: serviceToDisk['email'] ?? fallbackDrive,
        giteaBlockDevice: serviceToDisk['gitea'] ?? fallbackDrive,
        nextcloudBlockDevice: serviceToDisk['nextcloud'] ?? fallbackDrive,
        pleromaBlockDevice: serviceToDisk['pleroma'] ?? fallbackDrive,
      );
      final variables = Variables$Mutation$MigrateToBinds(input: input);
      final migrateMutation = Options$Mutation$MigrateToBinds(
        variables: variables,
      );
      final QueryResult<Mutation$MigrateToBinds> result = await client
          .mutate$MigrateToBinds(migrateMutation);
      mutation =
          mutation = GenericResult(
            success: true,
            code: result.parsedData!.storage.migrateToBinds.code,
            message: result.parsedData!.storage.migrateToBinds.message,
            data: result.parsedData!.storage.migrateToBinds.job?.uid,
          );
    } catch (e) {
      logger('Error in GraphQL MigrateToBinds request: $e', error: e);
      mutation = GenericResult(
        success: false,
        code: 0,
        message: e.toString(),
        data: null,
      );
    }

    return mutation;
  }
}
