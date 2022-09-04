part of 'server.dart';

class UserMutationResult extends GenericMutationResult {
  UserMutationResult({
    required final super.success,
    required final super.code,
    final super.message,
    this.user,
  });
  final User? user;
}

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
      users = response.parsedData?.users.allUsers.map<User>((final user) => User.fromGraphQL(user)).toList() ?? [];
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
      response = await client.query$GetUser(Options$Query$GetUser(variables: variables));
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

  Future<UserMutationResult> createUser(
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
      return UserMutationResult(
        success: response.parsedData?.createUser.success ?? false,
        code: response.parsedData?.createUser.code ?? 500,
        message: response.parsedData?.createUser.message,
        user: response.parsedData?.createUser.user != null ? User.fromGraphQL(response.parsedData!.createUser.user!) : null,
      );
    } catch (e) {
      print(e);
      return UserMutationResult(
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<GenericMutationResult> deleteUser(
    final String username,
  ) async {
    try {
      final GraphQLClient client = await getClient();
      final variables = Variables$Mutation$DeleteUser(username: username);
      final mutation = Options$Mutation$DeleteUser(variables: variables);
      final response = await client.mutate$DeleteUser(mutation);
      return GenericMutationResult(
        success: response.parsedData?.deleteUser.success ?? false,
        code: response.parsedData?.deleteUser.code ?? 500,
        message: response.parsedData?.deleteUser.message,
      );
    } catch (e) {
      print(e);
      return GenericMutationResult(
        success: false,
        code: 500,
        message: e.toString(),
      );
    }
  }

  Future<UserMutationResult> updateUser(
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
      return UserMutationResult(
        success: response.parsedData?.updateUser.success ?? false,
        code: response.parsedData?.updateUser.code ?? 500,
        message: response.parsedData?.updateUser.message,
        user: response.parsedData?.updateUser.user != null ? User.fromGraphQL(response.parsedData!.updateUser.user!) : null,
      );
    } catch (e) {
      print(e);
      return UserMutationResult(
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<UserMutationResult> addSshKey(
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
      return UserMutationResult(
        success: response.parsedData?.addSshKey.success ?? false,
        code: response.parsedData?.addSshKey.code ?? 500,
        message: response.parsedData?.addSshKey.message,
        user: response.parsedData?.addSshKey.user != null ? User.fromGraphQL(response.parsedData!.addSshKey.user!) : null,
      );
    } catch (e) {
      print(e);
      return UserMutationResult(
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }

  Future<UserMutationResult> removeSshKey(
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
      return UserMutationResult(
        success: response.parsedData?.removeSshKey.success ?? false,
        code: response.parsedData?.removeSshKey.code ?? 500,
        message: response.parsedData?.removeSshKey.message,
        user: response.parsedData?.removeSshKey.user != null ? User.fromGraphQL(response.parsedData!.removeSshKey.user!) : null,
      );
    } catch (e) {
      print(e);
      return UserMutationResult(
        success: false,
        code: 0,
        message: e.toString(),
      );
    }
  }
}
