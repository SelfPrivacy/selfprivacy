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
