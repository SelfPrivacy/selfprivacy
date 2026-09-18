part of 'server_api.dart';

mixin BackupsApi on GraphQLApiMap {
  Future<List<Backup>> getBackups() async {
    final client = await getClient();
    return requireServerApiData(
      await client.query$AllBackupSnapshots(),
    ).backup.allSnapshots.map(Backup.fromGraphQL).toList();
  }

  Future<BackupConfiguration> getBackupsConfiguration() async {
    final client = await getClient();
    return BackupConfiguration.fromGraphQL(
      requireServerApiData(
        await client.query$BackupConfiguration(
          Options$Query$BackupConfiguration(context: sensitiveGraphQLContext),
        ),
      ).backup.configuration,
    );
  }

  Future<ServerMutationResult<void>> forceBackupListReload() async {
    final client = await getClient();
    final response = await client.mutate$ForceSnapshotsReload(
      Options$Mutation$ForceSnapshotsReload(
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.backup.forceSnapshotsReload,
    );
  }

  Future<ServerMutationResult<ServerJob>> startBackup(
    final String serviceId,
  ) async {
    final client = await getClient();
    final response = await client.mutate$StartBackup(
      Options$Mutation$StartBackup(
        variables: Variables$Mutation$StartBackup(serviceId: serviceId),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.backup.startBackup,
      decodePayload: (final mutation) =>
          mutation.job == null ? null : ServerJob.fromGraphQL(mutation.job!),
    );
  }

  Future<ServerMutationResult<BackupConfiguration>> setAutobackupPeriod({
    final int? period,
  }) async {
    final client = await getClient();
    final response = await client.mutate$SetAutobackupPeriod(
      Options$Mutation$SetAutobackupPeriod(
        variables: Variables$Mutation$SetAutobackupPeriod(period: period),
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.backup.setAutobackupPeriod,
      decodePayload: (final mutation) => mutation.configuration == null
          ? null
          : BackupConfiguration.fromGraphQL(mutation.configuration!),
    );
  }

  Future<ServerMutationResult<BackupConfiguration>> setAutobackupQuotas(
    final AutobackupQuotas quotas,
  ) async {
    final client = await getClient();
    final response = await client.mutate$setAutobackupQuotas(
      Options$Mutation$setAutobackupQuotas(
        variables: Variables$Mutation$setAutobackupQuotas(
          quotas: Input$AutobackupQuotasInput(
            last: quotas.last,
            daily: quotas.daily,
            weekly: quotas.weekly,
            monthly: quotas.monthly,
            yearly: quotas.yearly,
          ),
        ),
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.backup.setAutobackupQuotas,
      decodePayload: (final mutation) => mutation.configuration == null
          ? null
          : BackupConfiguration.fromGraphQL(mutation.configuration!),
    );
  }

  Future<ServerMutationResult<BackupConfiguration>> removeRepository() async {
    final client = await getClient();
    final response = await client.mutate$RemoveRepository(
      Options$Mutation$RemoveRepository(
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.backup.removeRepository,
      decodePayload: (final mutation) => mutation.configuration == null
          ? null
          : BackupConfiguration.fromGraphQL(mutation.configuration!),
    );
  }

  Future<ServerMutationResult<BackupConfiguration>> initializeRepository(
    final InitializeRepositoryInput input,
  ) async {
    final client = await getClient();
    final response = await client.mutate$InitializeRepository(
      Options$Mutation$InitializeRepository(
        variables: Variables$Mutation$InitializeRepository(
          repository: Input$InitializeRepositoryInput(
            locationId: input.locationId,
            locationName: input.locationName,
            login: input.login,
            password: input.password,
            provider: input.provider.toGraphQL(),
          ),
        ),
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.backup.initializeRepository,
      decodePayload: (final mutation) => mutation.configuration == null
          ? null
          : BackupConfiguration.fromGraphQL(mutation.configuration!),
    );
  }

  Future<ServerMutationResult<ServerJob>> restoreBackup(
    final String snapshotId,
    final BackupRestoreStrategy strategy,
  ) async {
    final client = await getClient();
    final response = await client.mutate$RestoreBackup(
      Options$Mutation$RestoreBackup(
        variables: Variables$Mutation$RestoreBackup(
          snapshotId: snapshotId,
          strategy: strategy.toGraphQL,
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.backup.restoreBackup,
      decodePayload: (final mutation) =>
          mutation.job == null ? null : ServerJob.fromGraphQL(mutation.job!),
    );
  }

  Future<ServerMutationResult<void>> forgetSnapshot(
    final String snapshotId,
  ) async {
    final client = await getClient();
    final response = await client.mutate$ForgetSnapshot(
      Options$Mutation$ForgetSnapshot(
        variables: Variables$Mutation$ForgetSnapshot(snapshotId: snapshotId),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.backup.forgetSnapshot,
    );
  }
}
