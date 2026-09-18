part of 'server_api.dart';

mixin UsersApi on GraphQLApiMap {
  Future<List<User>> getAllUsers() async {
    final client = await getClient();
    final data = requireServerApiData(await client.query$AllUsers());
    final users = data.users.allUsers.map(User.fromGraphQL).toList();
    final rootUser = data.users.rootUser;
    if (rootUser != null) {
      users.add(User.fromGraphQL(rootUser));
    }
    return users;
  }

  Future<List<String>> getAllGroups() async {
    final client = await getClient();
    return requireServerApiData(
      await client.query$AllGroups(),
    ).groups.allGroups.map((final group) => group.name).toList();
  }

  Future<User?> getUser(final String login) async {
    QueryResult<Query$GetUser> response;
    User? user;
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Query$GetUser(username: login);
      response = await client.query$GetUser(
        Options$Query$GetUser(variables: variables),
      );
      if (response.hasException) {
        logger(
          'Exception in GraphQL GetUser request: ${response.exception}',
          error: response.exception,
        );
      }
      final responseUser = response.parsedData?.users.getUser;
      if (responseUser != null) {
        user = User.fromGraphQL(responseUser);
      }
    } catch (e) {
      logger('Error in GraphQL GetUser request: $e', error: e);
    }
    return user;
  }

  Future<GenericResult<User?>> createUser(
    final String username,
    final String? displayName,
    final List<String>? directMemberOf,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$CreateUser(
        user: Input$UserMutationInput(
          username: username,
          displayName: displayName,
          directmemberof: directMemberOf,
        ),
      );
      final mutation = Options$Mutation$CreateUser(variables: variables);
      final response = await client.mutate$CreateUser(mutation);
      final parsed = response.parsedData?.users.createUser;
      return GenericResult(
        success: parsed?.success ?? false,
        code: parsed?.code ?? 500,
        message: parsed?.message,
        data: parsed?.user != null ? User.fromGraphQL(parsed!.user!) : null,
      );
    } catch (e) {
      logger('Error in GraphQL CreateUser request: $e', error: e);
      return GenericResult(
        success: false,
        code: 0,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<GenericResult<User?>> updateUser(
    final String username,
    final String? displayName,
    final List<String>? directMemberOf,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$UpdateUser(
        user: Input$UserMutationInput(
          username: username,
          displayName: displayName,
          directmemberof: directMemberOf,
        ),
      );
      final mutation = Options$Mutation$UpdateUser(variables: variables);
      final response = await client.mutate$UpdateUser(mutation);
      final parsed = response.parsedData?.users.updateUser;
      return GenericResult(
        success: parsed?.success ?? false,
        code: parsed?.code ?? 500,
        message: parsed?.message,
        data: parsed?.user != null ? User.fromGraphQL(parsed!.user!) : null,
      );
    } catch (e) {
      logger('Error in GraphQL UpdateUser request: $e', error: e);
      return GenericResult(
        success: false,
        code: 0,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<GenericResult<bool>> deleteUser(final String username) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$DeleteUser(username: username);
      final mutation = Options$Mutation$DeleteUser(variables: variables);
      final response = await client.mutate$DeleteUser(mutation);
      final parsed = response.parsedData?.users.deleteUser;
      return GenericResult(
        data: parsed?.success ?? false,
        success: parsed?.success ?? false,
        code: parsed?.code ?? 500,
        message: parsed?.message,
      );
    } catch (e) {
      logger('Error in GraphQL DeleteUser request: $e', error: e);
      return GenericResult(
        data: false,
        success: false,
        code: 500,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<User?>> addSshKey(
    final String username,
    final String sshKey,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$AddSshKey(
        sshInput: Input$SshMutationInput(username: username, sshKey: sshKey),
      );
      final mutation = Options$Mutation$AddSshKey(variables: variables);
      final response = await client.mutate$AddSshKey(mutation);
      final parsed = response.parsedData?.users.addSshKey;
      return GenericResult(
        success: parsed?.success ?? false,
        code: parsed?.code ?? 500,
        message: parsed?.message,
        data: parsed?.user != null ? User.fromGraphQL(parsed!.user!) : null,
      );
    } catch (e) {
      logger('Error in GraphQL AddSshKey request: $e', error: e);
      return GenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<User?>> removeSshKey(
    final String username,
    final String sshKey,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$RemoveSshKey(
        sshInput: Input$SshMutationInput(username: username, sshKey: sshKey),
      );
      final mutation = Options$Mutation$RemoveSshKey(variables: variables);
      final response = await client.mutate$RemoveSshKey(mutation);
      return GenericResult(
        success: response.parsedData?.users.removeSshKey.success ?? false,
        code: response.parsedData?.users.removeSshKey.code ?? 500,
        message: response.parsedData?.users.removeSshKey.message,
        data: response.parsedData?.users.removeSshKey.user != null
            ? User.fromGraphQL(response.parsedData!.users.removeSshKey.user!)
            : null,
      );
    } catch (e) {
      logger('Error in GraphQL RemoveSshKey request: $e', error: e);
      return GenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<ServerMutationResult<String>> generatePasswordResetLink(
    final String username,
  ) async {
    final client = await getClient();
    final response = await client.mutate$GeneratePasswordResetLink(
      Options$Mutation$GeneratePasswordResetLink(
        variables: Variables$Mutation$GeneratePasswordResetLink(
          username: username,
        ),
        context: sensitiveGraphQLContext,
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.users.generatePasswordResetLink,
      decodePayload: (final mutation) =>
          nonEmptySecret(mutation.passwordResetLink),
    );
  }

  Future<GenericResult<bool>> deleteEmailPassword(
    final String username,
    final String uuid,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$DeleteEmailPassword(
        username: username,
        uuid: uuid,
      );
      final mutation = Options$Mutation$DeleteEmailPassword(
        variables: variables,
      );
      final response = await client.mutate$DeleteEmailPassword(mutation);
      final parsed = response
          .parsedData
          ?.emailPasswordMetadataMutations
          .deleteEmailPassword;
      return GenericResult(
        success: parsed?.success ?? false,
        code: parsed?.code ?? 500,
        message: parsed?.message,
        data: parsed?.success ?? false,
      );
    } catch (e) {
      logger('Error in GraphQL DeleteEmailPassword request: $e', error: e);
      return GenericResult(
        data: false,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }
}
