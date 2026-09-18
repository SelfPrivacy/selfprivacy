part of 'server_api.dart';

mixin VolumeApi on GraphQLApiMap {
  Future<List<ServerDiskVolume>> getServerDiskVolumes() async {
    final client = await getClient();
    return requireServerApiData(
      await client.query$GetServerDiskVolumes(),
    ).storage.volumes.map(ServerDiskVolume.fromGraphQL).toList();
  }

  Future<ServerMutationResult<void>> mountVolume(
    final String volumeName,
  ) async {
    final client = await getClient();
    final response = await client.mutate$MountVolume(
      Options$Mutation$MountVolume(
        variables: Variables$Mutation$MountVolume(name: volumeName),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    return decodeServerMutation(
      response,
      select: (final data) => data.storage.mountVolume,
    );
  }

  Future<ServerMutationResult<void>> unmountVolume(
    final String volumeName,
  ) async {
    final client = await getClient();
    final response = await client.mutate$UnmountVolume(
      Options$Mutation$UnmountVolume(
        variables: Variables$Mutation$UnmountVolume(name: volumeName),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    return decodeServerMutation(
      response,
      select: (final data) => data.storage.unmountVolume,
    );
  }

  Future<ServerMutationResult<void>> resizeVolume(
    final String volumeName,
  ) async {
    final client = await getClient();
    final response = await client.mutate$ResizeVolume(
      Options$Mutation$ResizeVolume(
        variables: Variables$Mutation$ResizeVolume(name: volumeName),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    return decodeServerMutation(
      response,
      select: (final data) => data.storage.resizeVolume,
    );
  }

  Future<ServerMutationResult<ServerJob>> migrateToBinds(
    final Map<String, String> serviceToDisk,
    final String fallbackDrive,
  ) async {
    final client = await getClient();
    final response = await client.mutate$MigrateToBinds(
      Options$Mutation$MigrateToBinds(
        variables: Variables$Mutation$MigrateToBinds(
          input: Input$MigrateToBindsInput(
            bitwardenBlockDevice: serviceToDisk['bitwarden'] ?? fallbackDrive,
            emailBlockDevice: serviceToDisk['email'] ?? fallbackDrive,
            giteaBlockDevice: serviceToDisk['gitea'] ?? fallbackDrive,
            nextcloudBlockDevice: serviceToDisk['nextcloud'] ?? fallbackDrive,
            pleromaBlockDevice: serviceToDisk['pleroma'] ?? fallbackDrive,
          ),
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    return decodeServerMutation(
      response,
      select: (final data) => data.storage.migrateToBinds,
      decodePayload: (final mutation) =>
          mutation.job == null ? null : ServerJob.fromGraphQL(mutation.job!),
    );
  }
}
