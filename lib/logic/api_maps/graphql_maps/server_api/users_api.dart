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

  Future<ServerMutationResult<User>> createUser(
    final String username,
    final String? displayName,
    final List<String>? directMemberOf,
  ) async {
    final client = await getClient();
    final response = await client.mutate$CreateUser(
      Options$Mutation$CreateUser(
        variables: Variables$Mutation$CreateUser(
          user: Input$UserMutationInput(
            username: username,
            displayName: displayName,
            directmemberof: directMemberOf,
          ),
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.users.createUser,
      decodePayload: (final mutation) =>
          mutation.user == null ? null : User.fromGraphQL(mutation.user!),
    );
  }

  Future<ServerMutationResult<User>> updateUser(
    final String username,
    final String? displayName,
    final List<String>? directMemberOf,
  ) async {
    final client = await getClient();
    final response = await client.mutate$UpdateUser(
      Options$Mutation$UpdateUser(
        variables: Variables$Mutation$UpdateUser(
          user: Input$UserMutationInput(
            username: username,
            displayName: displayName,
            directmemberof: directMemberOf,
          ),
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.users.updateUser,
      decodePayload: (final mutation) =>
          mutation.user == null ? null : User.fromGraphQL(mutation.user!),
    );
  }

  Future<ServerMutationResult<void>> deleteUser(final String username) async {
    final client = await getClient();
    final response = await client.mutate$DeleteUser(
      Options$Mutation$DeleteUser(
        variables: Variables$Mutation$DeleteUser(username: username),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.users.deleteUser,
    );
  }

  Future<ServerMutationResult<User>> addSshKey(
    final String username,
    final String sshKey,
  ) async {
    final client = await getClient();
    final response = await client.mutate$AddSshKey(
      Options$Mutation$AddSshKey(
        variables: Variables$Mutation$AddSshKey(
          sshInput: Input$SshMutationInput(username: username, sshKey: sshKey),
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.users.addSshKey,
      decodePayload: (final mutation) =>
          mutation.user == null ? null : User.fromGraphQL(mutation.user!),
    );
  }

  Future<ServerMutationResult<User>> removeSshKey(
    final String username,
    final String sshKey,
  ) async {
    final client = await getClient();
    final response = await client.mutate$RemoveSshKey(
      Options$Mutation$RemoveSshKey(
        variables: Variables$Mutation$RemoveSshKey(
          sshInput: Input$SshMutationInput(username: username, sshKey: sshKey),
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) => data.users.removeSshKey,
      decodePayload: (final mutation) =>
          mutation.user == null ? null : User.fromGraphQL(mutation.user!),
    );
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

  Future<ServerMutationResult<void>> deleteEmailPassword(
    final String username,
    final String uuid,
  ) async {
    final client = await getClient();
    final response = await client.mutate$DeleteEmailPassword(
      Options$Mutation$DeleteEmailPassword(
        variables: Variables$Mutation$DeleteEmailPassword(
          username: username,
          uuid: uuid,
        ),
        errorPolicy: ErrorPolicy.all,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    return decodeServerMutation(
      response,
      select: (final data) =>
          data.emailPasswordMetadataMutations.deleteEmailPassword,
    );
  }
}
