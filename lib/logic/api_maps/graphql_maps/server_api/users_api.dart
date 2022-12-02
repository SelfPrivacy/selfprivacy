part of 'server_api.dart';

mixin UsersApi on ApiMap {
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

  Future<APIGenericResult<User?>> createUser(
    final String username,
    final String password,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$CreateUser(
        user: Input$UserMutationInput(username: username, password: password),
      );
      final mutation = Options$Mutation$CreateUser(variables: variables);
      final response = await client.mutate$CreateUser(mutation);
      return APIGenericResult(
        success: true,
        code: response.parsedData?.createUser.code ?? 500,
        message: response.parsedData?.createUser.message,
        data: response.parsedData?.createUser.user != null
            ? User.fromGraphQL(response.parsedData!.createUser.user!)
            : null,
      );
    } catch (e) {
      print(e);
      return APIGenericResult(
        success: false,
        code: 0,
        message: e.toString(),
        data: null,
      );
    }
  }

  Future<APIGenericResult<bool>> deleteUser(
    final String username,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$DeleteUser(username: username);
      final mutation = Options$Mutation$DeleteUser(variables: variables);
      final response = await client.mutate$DeleteUser(mutation);
      return APIGenericResult(
        data: response.parsedData?.deleteUser.success ?? false,
        success: true,
        code: response.parsedData?.deleteUser.code ?? 500,
        message: response.parsedData?.deleteUser.message,
      );
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: false,
        success: false,
        code: 500,
        message: e.toString(),
      );
    }
  }

  Future<APIGenericResult<User?>> updateUser(
    final String username,
    final String password,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$UpdateUser(
        user: Input$UserMutationInput(username: username, password: password),
      );
      final mutation = Options$Mutation$UpdateUser(variables: variables);
      final response = await client.mutate$UpdateUser(mutation);
      return APIGenericResult(
        success: true,
        code: response.parsedData?.updateUser.code ?? 500,
        message: response.parsedData?.updateUser.message,
        data: response.parsedData?.updateUser.user != null
            ? User.fromGraphQL(response.parsedData!.updateUser.user!)
            : null,
      );
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<APIGenericResult<User?>> addSshKey(
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
      return APIGenericResult(
        success: true,
        code: response.parsedData?.addSshKey.code ?? 500,
        message: response.parsedData?.addSshKey.message,
        data: response.parsedData?.addSshKey.user != null
            ? User.fromGraphQL(response.parsedData!.addSshKey.user!)
            : null,
      );
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<APIGenericResult<User?>> removeSshKey(
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
      return APIGenericResult(
        success: response.parsedData?.removeSshKey.success ?? false,
        code: response.parsedData?.removeSshKey.code ?? 500,
        message: response.parsedData?.removeSshKey.message,
        data: response.parsedData?.removeSshKey.user != null
            ? User.fromGraphQL(response.parsedData!.removeSshKey.user!)
            : null,
      );
    } catch (e) {
      print(e);
      return APIGenericResult(
        data: null,
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }
}
