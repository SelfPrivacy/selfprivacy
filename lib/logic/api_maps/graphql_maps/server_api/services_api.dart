part of 'server_api.dart';

mixin ServicesApi on GraphQLApiMap {
  Future<List<Service>> getAllServices() async {
    QueryResult<Query$AllServices> response;
    List<Service> services = [];
    try {
      final GraphQLClient client = await getClient();
      response = await client.query$AllServices();
      if (response.hasException) {
        logger(
          'Exception in GraphQL GetAllServices request: ${response.exception}',
          error: response.exception,
        );
      }
      services =
          response.parsedData?.services.allServices
              .map<Service>(Service.fromGraphQL)
              .toList() ??
          [];
    } catch (e) {
      logger('Error in GraphQL GetAllServices request: $e', error: e);
    }
    return services;
  }

  Future<GenericResult<bool>> enableService(final String serviceId) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$EnableService(serviceId: serviceId);
      final mutation = Options$Mutation$EnableService(variables: variables);
      final response = await client.mutate$EnableService(mutation);
      return GenericResult(
        data: response.parsedData?.services.enableService.success ?? false,
        success: true,
        code: response.parsedData?.services.enableService.code ?? 0,
        message: response.parsedData?.services.enableService.message,
      );
    } catch (e) {
      logger('Error in GraphQL EnableService request: $e', error: e);
      return GenericResult(
        data: false,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<void>> disableService(final String serviceId) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$DisableService(serviceId: serviceId);
      final mutation = Options$Mutation$DisableService(variables: variables);
      final response = await client.mutate$DisableService(mutation);
      return GenericResult(
        data: null,
        success: response.parsedData?.services.disableService.success ?? false,
        code: response.parsedData?.services.disableService.code ?? 0,
        message: response.parsedData?.services.disableService.message,
      );
    } catch (e) {
      logger('Error in GraphQL DisableService request: $e', error: e);
      return GenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<bool>> stopService(final String serviceId) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$StopService(serviceId: serviceId);
      final mutation = Options$Mutation$StopService(variables: variables);
      final response = await client.mutate$StopService(mutation);
      return GenericResult(
        data: response.parsedData?.services.stopService.success ?? false,
        success: true,
        code: response.parsedData?.services.stopService.code ?? 0,
        message: response.parsedData?.services.stopService.message,
      );
    } catch (e) {
      logger('Error in GraphQL StopService request: $e', error: e);
      return GenericResult(
        data: false,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult> startService(final String serviceId) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$StartService(serviceId: serviceId);
      final mutation = Options$Mutation$StartService(variables: variables);
      final response = await client.mutate$StartService(mutation);
      return GenericResult(
        data: null,
        success: response.parsedData?.services.startService.success ?? false,
        code: response.parsedData?.services.startService.code ?? 0,
        message: response.parsedData?.services.startService.message,
      );
    } catch (e) {
      logger('Error in GraphQL StartService request: $e', error: e);
      return GenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<bool>> restartService(final String serviceId) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$RestartService(serviceId: serviceId);
      final mutation = Options$Mutation$RestartService(variables: variables);
      final response = await client.mutate$RestartService(mutation);
      return GenericResult(
        data: response.parsedData?.services.restartService.success ?? false,
        success: true,
        code: response.parsedData?.services.restartService.code ?? 0,
        message: response.parsedData?.services.restartService.message,
      );
    } catch (e) {
      logger('Error in GraphQL RestartService request: $e', error: e);
      return GenericResult(
        data: false,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<ServerJob?>> moveService(
    final String serviceId,
    final String destination,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$MoveService(
        input: Input$MoveServiceInput(
          serviceId: serviceId,
          location: destination,
        ),
      );
      final mutation = Options$Mutation$MoveService(variables: variables);
      final response = await client.mutate$MoveService(mutation);
      final jobJson = response.parsedData?.services.moveService.job?.toJson();
      return GenericResult(
        success: true,
        code: response.parsedData?.services.moveService.code ?? 0,
        message: response.parsedData?.services.moveService.message,
        data: jobJson != null ? ServerJob.fromJson(jobJson) : null,
      );
    } catch (e) {
      logger('Error in GraphQL MoveService request: $e', error: e);
      return GenericResult(
        success: false,
        code: 0,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<GenericResult> setServiceConfiguration(
    final String serviceId,
    final Map<String, dynamic> settings,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$SetServiceConfiguration(
        input: Input$SetServiceConfigurationInput(
          serviceId: serviceId,
          configuration: settings,
        ),
      );
      final mutation = Options$Mutation$SetServiceConfiguration(
        variables: variables,
      );
      final response = await client.mutate$SetServiceConfiguration(mutation);
      return GenericResult(
        data: null,
        success:
            response.parsedData?.services.setServiceConfiguration.success ??
            false,
        code: response.parsedData?.services.setServiceConfiguration.code ?? 0,
        message: response.parsedData?.services.setServiceConfiguration.message,
      );
    } catch (e) {
      logger('Error in GraphQL SetServiceConfiguration request: $e', error: e);
      return GenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }
}
