import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/api_maps/graphql_maps/server_api/server_api.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

export 'package:provider/provider.dart';

part 'users_state.dart';

class UsersCubit extends ServerInstallationDependendCubit<UsersState> {
  UsersCubit(final ServerInstallationCubit serverInstallationCubit)
      : super(
          serverInstallationCubit,
          const UsersState(
            <User>[],
            false,
          ),
        );
  Box<User> box = Hive.box<User>(BNames.usersBox);
  Box serverInstallationBox = Hive.box(BNames.serverInstallationBox);

  final ServerApi api = ServerApi();

  @override
  Future<void> load() async {
    if (serverInstallationCubit.state is! ServerInstallationFinished) {
      return;
    }
    final List<User> loadedUsers = box.values.toList();
    if (loadedUsers.isNotEmpty) {
      emit(
        UsersState(
          loadedUsers,
          false,
        ),
      );
    }

    refresh();
  }

  Future<void> refresh() async {
    if (serverInstallationCubit.state is! ServerInstallationFinished) {
      return;
    }
    emit(state.copyWith(isLoading: true));
    final List<User> usersFromServer = await api.getAllUsers();
    if (usersFromServer.isNotEmpty) {
      emit(
        UsersState(
          usersFromServer,
          false,
        ),
      );
      // Update the users it the box
      await box.clear();
      await box.addAll(usersFromServer);
    } else {
      getIt<NavigationService>()
          .showSnackBar('users.could_not_fetch_users'.tr());
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> createUser(final User user) async {
    // If user exists on server, do nothing
    if (state.users
        .any((final User u) => u.login == user.login && u.isFoundOnServer)) {
      return;
    }
    final String? password = user.password;
    if (password == null) {
      getIt<NavigationService>()
          .showSnackBar('users.could_not_create_user'.tr());
      return;
    }
    // If API returned error, do nothing
    final APIGenericResult<User?> result =
        await api.createUser(user.login, password);
    if (result.data == null) {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'users.could_not_create_user'.tr());
      return;
    }

    final List<User> loadedUsers = List<User>.from(state.users);
    loadedUsers.add(result.data!);
    await box.clear();
    await box.addAll(loadedUsers);
    emit(state.copyWith(users: loadedUsers));
  }

  Future<void> deleteUser(final User user) async {
    // If user is primary or root, don't delete
    if (user.type != UserType.normal) {
      getIt<NavigationService>()
          .showSnackBar('users.could_not_delete_user'.tr());
      return;
    }
    final List<User> loadedUsers = List<User>.from(state.users);
    final APIGenericResult result = await api.deleteUser(user.login);
    if (result.success && result.data) {
      loadedUsers.removeWhere((final User u) => u.login == user.login);
      await box.clear();
      await box.addAll(loadedUsers);
      emit(state.copyWith(users: loadedUsers));
    }

    if (!result.success) {
      getIt<NavigationService>().showSnackBar('jobs.generic_error'.tr());
    }

    if (!result.data) {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'jobs.generic_error'.tr());
    }
  }

  Future<void> changeUserPassword(
    final User user,
    final String newPassword,
  ) async {
    if (user.type == UserType.root) {
      getIt<NavigationService>()
          .showSnackBar('users.could_not_change_password'.tr());
      return;
    }
    final APIGenericResult<User?> result =
        await api.updateUser(user.login, newPassword);
    if (result.data == null) {
      getIt<NavigationService>().showSnackBar(
        result.message ?? 'users.could_not_change_password'.tr(),
      );
    }
  }

  Future<void> addSshKey(final User user, final String publicKey) async {
    final APIGenericResult<User?> result =
        await api.addSshKey(user.login, publicKey);
    if (result.data != null) {
      final User updatedUser = result.data!;
      final int index =
          state.users.indexWhere((final User u) => u.login == user.login);
      await box.putAt(index, updatedUser);
      emit(
        state.copyWith(
          users: box.values.toList(),
        ),
      );
    } else {
      getIt<NavigationService>()
          .showSnackBar(result.message ?? 'users.could_not_add_ssh_key'.tr());
    }
  }

  Future<void> deleteSshKey(final User user, final String publicKey) async {
    final APIGenericResult<User?> result =
        await api.removeSshKey(user.login, publicKey);
    if (result.data != null) {
      final User updatedUser = result.data!;
      final int index =
          state.users.indexWhere((final User u) => u.login == user.login);
      await box.putAt(index, updatedUser);
      emit(
        state.copyWith(
          users: box.values.toList(),
        ),
      );
    }
  }

  @override
  void clear() async {
    emit(
      const UsersState(
        <User>[],
        false,
      ),
    );
  }
}
