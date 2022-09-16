part of 'server.dart';

mixin VolumeApi on ApiMap {
  Future<List<ServerDiskVolume>> getServerDiskVolumes() async {
    QueryResult response;
    List<ServerDiskVolume> volumes = [];

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$GetServerDiskVolumes();
      if (response.hasException) {
        print(response.exception.toString());
      }
      volumes = response.data!['storage']['volumes']
          .map<ServerDiskVolume>((final e) => ServerDiskVolume.fromJson(e))
          .toList();
    } catch (e) {
      print(e);
    }

    return volumes;
  }

  Future<void> mountVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$MountVolume(name: volumeName);
      final mountVolumeMutation =
          Options$Mutation$MountVolume(variables: variables);
      await client.mutate$MountVolume(mountVolumeMutation);
    } catch (e) {
      print(e);
    }
  }

  Future<void> unmountVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$UnmountVolume(name: volumeName);
      final unmountVolumeMutation =
          Options$Mutation$UnmountVolume(variables: variables);
      await client.mutate$UnmountVolume(unmountVolumeMutation);
    } catch (e) {
      print(e);
    }
  }

  Future<void> resizeVolume(final String volumeName) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$ResizeVolume(name: volumeName);
      final resizeVolumeMutation =
          Options$Mutation$ResizeVolume(variables: variables);
      await client.mutate$ResizeVolume(resizeVolumeMutation);
    } catch (e) {
      print(e);
    }
  }

  Future<void> migrateToBinds(final Map<String, String> serviceToDisk) async {
    try {
      final GraphQLClient client = await getClient();
      final input = Input$MigrateToBindsInput(
        bitwardenBlockDevice: serviceToDisk['bitwarden']!,
        emailBlockDevice: serviceToDisk['mailserver']!,
        giteaBlockDevice: serviceToDisk['gitea']!,
        nextcloudBlockDevice: serviceToDisk['nextcloud']!,
        pleromaBlockDevice: serviceToDisk['pleroma']!,
      );
      final variables = Variables$Mutation$MigrateToBinds(input: input);
      final migrateMutation =
          Options$Mutation$MigrateToBinds(variables: variables);
      await client.mutate$MigrateToBinds(migrateMutation);
    } catch (e) {
      print(e);
    }
  }
}
