part of 'server_api.dart';

mixin ServicesApi on GraphQLApiMap {
  Future<List<Service>> getAllServices() async {
    final client = await getClient();
    return requireServerApiData(
      await client.query$AllServices(
        Options$Query$AllServices(context: sensitiveGraphQLContext),
      ),
    ).services.allServices.map(Service.fromGraphQL).toList();
  }

  Future<ServerMutationResult<void>> enableService(
    final String serviceId,
  ) async {
    final client = await getClient();
    final response = await client.mutate$EnableService(
      Options$Mutation$EnableService(
        variables: Variables$Mutation$EnableService(serviceId: serviceId),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.services.enableService,
    );
  }

  Future<ServerMutationResult<void>> disableService(
    final String serviceId,
  ) async {
    final client = await getClient();
    final response = await client.mutate$DisableService(
      Options$Mutation$DisableService(
        variables: Variables$Mutation$DisableService(serviceId: serviceId),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.services.disableService,
    );
  }

  Future<ServerMutationResult<void>> stopService(final String serviceId) async {
    final client = await getClient();
    final response = await client.mutate$StopService(
      Options$Mutation$StopService(
        variables: Variables$Mutation$StopService(serviceId: serviceId),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.services.stopService,
    );
  }

  Future<ServerMutationResult<void>> startService(
    final String serviceId,
  ) async {
    final client = await getClient();
    final response = await client.mutate$StartService(
      Options$Mutation$StartService(
        variables: Variables$Mutation$StartService(serviceId: serviceId),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.services.startService,
    );
  }

  Future<ServerMutationResult<void>> restartService(
    final String serviceId,
  ) async {
    final client = await getClient();
    final response = await client.mutate$RestartService(
      Options$Mutation$RestartService(
        variables: Variables$Mutation$RestartService(serviceId: serviceId),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.services.restartService,
    );
  }

  Future<ServerMutationResult<ServerJob>> moveService(
    final String serviceId,
    final String destination,
  ) async {
    final client = await getClient();
    final response = await client.mutate$MoveService(
      Options$Mutation$MoveService(
        variables: Variables$Mutation$MoveService(
          input: Input$MoveServiceInput(
            serviceId: serviceId,
            location: destination,
          ),
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.services.moveService,
      decodePayload: (final mutation) =>
          mutation.job == null ? null : ServerJob.fromGraphQL(mutation.job!),
    );
  }

  Future<ServerMutationResult<void>> setServiceConfiguration(
    final String serviceId,
    final Map<String, dynamic> settings,
  ) async {
    final client = await getClient();
    final response = await client.mutate$SetServiceConfiguration(
      Options$Mutation$SetServiceConfiguration(
        variables: Variables$Mutation$SetServiceConfiguration(
          input: Input$SetServiceConfigurationInput(
            serviceId: serviceId,
            configuration: settings,
          ),
        ),
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.services.setServiceConfiguration,
    );
  }
}
