part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  UsersState({
    required final List<User> users,
  }) : _hashCode = Object.hashAll(users);

  final int _hashCode;

  List<User> get users =>
      getIt<ApiConnectionRepository>().apiData.users.data ?? const [];

  User get rootUser =>
      users.firstWhere((final user) => user.type == UserType.root);

  User get primaryUser =>
      users.firstWhere((final user) => user.type == UserType.primary);

  List<User> get normalUsers =>
      users.where((final user) => user.type == UserType.normal).toList();

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

  bool isLoginRegistered(final String login) =>
      users.any((final User user) => user.login == login);

  bool get isEmpty => users.isEmpty;
}

class UsersInitial extends UsersState {
  UsersInitial() : super(users: const []);

  @override
  List<Object> get props => [_hashCode];
}

class UsersRefreshing extends UsersState {
  UsersRefreshing({required super.users});

  @override
  List<Object> get props => [_hashCode];
}

class UsersLoaded extends UsersState {
  UsersLoaded({required super.users});

  @override
  List<Object> get props => [_hashCode];
}
