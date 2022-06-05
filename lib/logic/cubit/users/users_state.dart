// ignore_for_file: always_specify_types

part of 'users_cubit.dart';

class UsersState extends ServerInstallationDependendState {
  const UsersState(this.users, this.rootUser, this.primaryUser);

  final List<User> users;
  final User rootUser;
  final User primaryUser;

  @override
  List<Object> get props => [users, rootUser, primaryUser];

  UsersState copyWith({
    final List<User>? users,
    final User? rootUser,
    final User? primaryUser,
  }) => UsersState(
      users ?? this.users,
      rootUser ?? this.rootUser,
      primaryUser ?? this.primaryUser,
    );

  bool isLoginRegistered(final String login) => users.any((final User user) => user.login == login) ||
        login == rootUser.login ||
        login == primaryUser.login;

  bool get isEmpty => users.isEmpty;
}
