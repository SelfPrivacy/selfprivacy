part of 'server_api.dart';

mixin ServerActionsApi on GraphQLApiMap {
  Future<ServerMutationResult<void>> reboot() async {
    final client = await getClient();
    final response = await client.mutate$RebootSystem(
      Options$Mutation$RebootSystem(
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    return decodeServerMutation(
      response,
      select: (final data) => data.system.rebootSystem,
    );
  }

  Future<ServerMutationResult<void>> pullConfigurationUpdate() async {
    final client = await getClient();
    final response = await client.mutate$PullRepositoryChanges(
      Options$Mutation$PullRepositoryChanges(
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    return decodeServerMutation(
      response,
      select: (final data) => data.system.pullRepositoryChanges,
    );
  }

  Future<ServerMutationResult<ServerJob>> upgrade() async {
    final client = await getClient();
    final response = await client.mutate$RunSystemUpgrade(
      Options$Mutation$RunSystemUpgrade(
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (_needsLegacyJobFallback(response)) {
      return decodeServerMutation(
        await client.mutate$RunSystemUpgradeFallback(
          Options$Mutation$RunSystemUpgradeFallback(
            errorPolicy: ErrorPolicy.all,
            fetchPolicy: FetchPolicy.noCache,
          ),
        ),
        select: (final data) => data.system.runSystemUpgrade,
      );
    }
    return decodeServerMutation(
      response,
      select: (final data) => data.system.runSystemUpgrade,
      decodePayload: (final mutation) =>
          mutation.job == null ? null : ServerJob.fromGraphQL(mutation.job!),
    );
  }

  Future<ServerMutationResult<ServerJob>> apply() async {
    final client = await getClient();
    final response = await client.mutate$RunSystemRebuild(
      Options$Mutation$RunSystemRebuild(
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (_needsLegacyJobFallback(response)) {
      return decodeServerMutation(
        await client.mutate$RunSystemRebuildFallback(
          Options$Mutation$RunSystemRebuildFallback(
            errorPolicy: ErrorPolicy.all,
            fetchPolicy: FetchPolicy.noCache,
          ),
        ),
        select: (final data) => data.system.runSystemRebuild,
      );
    }
    return decodeServerMutation(
      response,
      select: (final data) => data.system.runSystemRebuild,
      decodePayload: (final mutation) =>
          mutation.job == null ? null : ServerJob.fromGraphQL(mutation.job!),
    );
  }

  Future<ServerMutationResult<ServerJob>> collectNixGarbage() async {
    final client = await getClient();
    final response = await client.mutate$NixCollectGarbage(
      Options$Mutation$NixCollectGarbage(
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );

    return decodeServerMutation(
      response,
      select: (final data) => data.system.nixCollectGarbage,
      decodePayload: (final mutation) =>
          mutation.job == null ? null : ServerJob.fromGraphQL(mutation.job!),
    );
  }
}

bool _needsLegacyJobFallback(final QueryResult response) {
  final exception = response.exception;
  if (response.data != null || exception?.linkException != null) {
    return false;
  }
  final errors = exception?.graphqlErrors ?? const <GraphQLError>[];
  return errors.isNotEmpty &&
      errors.every(
        (final error) =>
            (error.path == null || error.path!.isEmpty) &&
            (error.extensions?['code'] == null ||
                error.extensions?['code'] == 'GRAPHQL_VALIDATION_FAILED') &&
            const {
              "Cannot query field 'job' on type 'GenericMutationReturn'.",
              'Cannot query field "job" on type "GenericMutationReturn".',
            }.contains(error.message),
      );
}
