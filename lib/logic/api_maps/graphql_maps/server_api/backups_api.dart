part of 'server_api.dart';

mixin BackupsApi on GraphQLApiMap {
  Future<List<Backup>> getBackups() async {
    List<Backup> backups;
    QueryResult<Query$AllBackupSnapshots> response;

    try {
      final GraphQLClient client = await getClient();
      response = await client.query$AllBackupSnapshots();
      if (response.hasException) {
        final message = response.exception.toString();
        print(message);
        backups = [];
      }
      final List<Backup> parsed = response.parsedData!.backup.allSnapshots
          .map(
            (
              final Query$AllBackupSnapshots$backup$allSnapshots snapshot,
            ) =>
                Backup.fromGraphQL(snapshot),
          )
          .toList();
      backups = parsed;
    } catch (e) {
      print(e);
      backups = [];
    }

    return backups;
  }

  Future<BackupConfiguration?> getBackupsConfiguration() async {
    BackupConfiguration? backupConfiguration;
    QueryResult<Query$BackupConfiguration> response;
    try {
      final GraphQLClient client = await getClient();
      response = await client.query$BackupConfiguration();
      if (response.hasException) {
        final message = response.exception.toString();
        print(message);
        backupConfiguration = null;
      }
      final BackupConfiguration parsed = BackupConfiguration.fromGraphQL(
        response.parsedData!.backup.configuration,
      );
      backupConfiguration = parsed;
    } catch (e) {
      print(e);
      backupConfiguration = null;
    }

    return backupConfiguration;
  }

  Future<GenericResult> forceBackupListReload() async {
    try {
      final GraphQLClient client = await getClient();
      await client.mutate$ForceSnapshotsReload();
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    }

    return GenericResult(
      success: true,
      data: null,
    );
  }

  Future<GenericResult> startBackup(final String serviceId) async {
    QueryResult<Mutation$StartBackup> response;
    GenericResult? result;

    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$StartBackup(serviceId: serviceId);
      final options = Options$Mutation$StartBackup(variables: variables);
      response = await client.mutate$StartBackup(options);
      if (response.hasException) {
        final message = response.exception.toString();
        print(message);
        result = GenericResult(
          success: false,
          data: null,
          message: message,
        );
      }
      result = GenericResult(
        success: true,
        data: null,
      );
    } catch (e) {
      print(e);
      result = GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    }

    return result;
  }

  Future<GenericResult> setAutobackupPeriod({final int? period}) async {
    QueryResult<Mutation$SetAutobackupPeriod> response;
    GenericResult? result;

    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$SetAutobackupPeriod(period: period);
      final options =
          Options$Mutation$SetAutobackupPeriod(variables: variables);
      response = await client.mutate$SetAutobackupPeriod(options);
      if (response.hasException) {
        final message = response.exception.toString();
        print(message);
        result = GenericResult(
          success: false,
          data: null,
          message: message,
        );
      }
      result = GenericResult(
        success: true,
        data: null,
      );
    } catch (e) {
      print(e);
      result = GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    }

    return result;
  }

  Future<GenericResult> removeRepository() async {
    try {
      final GraphQLClient client = await getClient();
      await client.mutate$RemoveRepository();
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    }

    return GenericResult(
      success: true,
      data: null,
    );
  }

  Future<GenericResult> initializeRepository(
    final InitializeRepositoryInput input,
  ) async {
    QueryResult<Mutation$InitializeRepository> response;
    GenericResult? result;

    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$InitializeRepository(
        repository: Input$InitializeRepositoryInput(
          locationId: input.locationId,
          locationName: input.locationName,
          login: input.login,
          password: input.password,
          provider: input.provider.toGraphQL(),
        ),
      );
      final options =
          Options$Mutation$InitializeRepository(variables: variables);
      response = await client.mutate$InitializeRepository(options);
      if (response.hasException) {
        final message = response.exception.toString();
        print(message);
        result = GenericResult(
          success: false,
          data: null,
          message: message,
        );
      }
      result = GenericResult(
        success: true,
        data: null,
      );
    } catch (e) {
      print(e);
      result = GenericResult(
        success: false,
        data: null,
        message: e.toString(),
      );
    }

    return result;
  }
}
