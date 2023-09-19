part of 'users_cubit.dart';

class UsersState extends ServerInstallationDependendState {
  const UsersState(this.users, this.isLoading);

  final List<User> users;
  final bool isLoading;

  User get rootUser =>
      users.firstWhere((final user) => user.type == UserType.root);

  User get primaryUser =>
      users.firstWhere((final user) => user.type == UserType.primary);

  List<User> get normalUsers =>
      users.where((final user) => user.type == UserType.normal).toList();

  @override
  List<Object> get props => [users, isLoading];

  /// Makes a copy of existing users list, but places 'primary'
  /// to the beginning and sorts the rest alphabetically
  ///
  /// If found a 'root' user, it doesn't get copied into the result
  List<User> get orderedUsers {
    User? primaryUser;
    final List<User> normalUsers = [];
    for (final User user in users) {
      if (user.type == UserType.primary) {
        primaryUser = user;
        continue;
      }
      if (user.type == UserType.root) {
        continue;
      }
      normalUsers.add(user);
    }

    normalUsers.sort(
      (final User a, final User b) =>
          a.login.toLowerCase().compareTo(b.login.toLowerCase()),
    );

    return primaryUser == null ? normalUsers : [primaryUser] + normalUsers;
  }

  UsersState copyWith({
    final List<User>? users,
    final bool? isLoading,
  }) =>
      UsersState(
        users ?? this.users,
        isLoading ?? this.isLoading,
      );

  bool isLoginRegistered(final String login) =>
      users.any((final User user) => user.login == login);

  bool get isEmpty => users.isEmpty;
}
