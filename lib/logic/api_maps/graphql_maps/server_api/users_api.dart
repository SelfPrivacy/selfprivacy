part of 'server_api.dart';

mixin UsersApi on GraphQLApiMap {
  Future<List<User>> getAllUsers() async {
    QueryResult<Query$AllUsers> response;
    List<User> users = [];
    try {
      final GraphQLClient client = await getClient();
      response = await client.query$AllUsers();
      if (response.hasException) {
        print(response.exception.toString());
      }
      users = response.parsedData?.users.allUsers
              .map<User>((final user) => User.fromGraphQL(user))
              .toList() ??
          [];
      final rootUser = response.parsedData?.users.rootUser;
      if (rootUser != null) {
        users.add(User.fromGraphQL(rootUser));
      }
    } catch (e) {
      print(e);
    }
    return users;
  }

  Future<User?> getUser(final String login) async {
    QueryResult<Query$GetUser> response;
    User? user;
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Query$GetUser(username: login);
      response = await client
          .query$GetUser(Options$Query$GetUser(variables: variables));
      if (response.hasException) {
        print(response.exception.toString());
      }
      final responseUser = response.parsedData?.users.getUser;
      if (responseUser != null) {
        user = User.fromGraphQL(responseUser);
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<GenericResult<User?>> createUser(final String username) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$CreateUser(
        user: Input$UserMutationInput(username: username),
      );
      final mutation = Options$Mutation$CreateUser(variables: variables);
      final response = await client.mutate$CreateUser(mutation);
      return GenericResult(
        success: true,
        code: response.parsedData?.users.createUser.code ?? 500,
        message: response.parsedData?.users.createUser.message,
        data: response.parsedData?.users.createUser.user != null
            ? User.fromGraphQL(response.parsedData!.users.createUser.user!)
            : null,
      );
    } catch (e) {
      print(e);
      return GenericResult(
        success: false,
        code: 0,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<GenericResult<bool>> deleteUser(
    final String username,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$DeleteUser(username: username);
      final mutation = Options$Mutation$DeleteUser(variables: variables);
      final response = await client.mutate$DeleteUser(mutation);
      return GenericResult(
        data: response.parsedData?.users.deleteUser.success ?? false,
        success: true,
        code: response.parsedData?.users.deleteUser.code ?? 500,
        message: response.parsedData?.users.deleteUser.message,
      );
    } catch (e) {
      print(e);
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
        sshInput: Input$SshMutationInput(
          username: username,
          sshKey: sshKey,
        ),
      );
      final mutation = Options$Mutation$AddSshKey(variables: variables);
      final response = await client.mutate$AddSshKey(mutation);
      return GenericResult(
        success: true,
        code: response.parsedData?.users.addSshKey.code ?? 500,
        message: response.parsedData?.users.addSshKey.message,
        data: response.parsedData?.users.addSshKey.user != null
            ? User.fromGraphQL(response.parsedData!.users.addSshKey.user!)
            : null,
      );
    } catch (e) {
      print(e);
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
        sshInput: Input$SshMutationInput(
          username: username,
          sshKey: sshKey,
        ),
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
      print(e);
      return GenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<GenericResult<String?>> generatePasswordResetLink(
    final String username,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$GeneratePasswordResetLink(
        username: username,
      );
      final mutation = Options$Mutation$GeneratePasswordResetLink(
        variables: variables,
      );
      final response = await client.mutate$GeneratePasswordResetLink(
        mutation,
      );
      final parsed = response.parsedData?.users.generatePasswordResetLink;
      return GenericResult(
        success: parsed?.success ?? false,
        code: parsed?.code ?? 500,
        message: parsed?.message,
        data: parsed?.passwordResetLink,
      );
    } catch (e) {
      print(e);
      return GenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }
}
