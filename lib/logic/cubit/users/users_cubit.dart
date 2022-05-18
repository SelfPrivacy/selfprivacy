import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/cubit/app_config_dependent/authentication_dependend_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/models/hive/user.dart';

import '../../api_maps/server.dart';

export 'package:provider/provider.dart';

part 'users_state.dart';

class UsersCubit extends ServerInstallationDependendCubit<UsersState> {
  UsersCubit(ServerInstallationCubit serverInstallationCubit)
      : super(
            serverInstallationCubit,
            UsersState(
                <User>[], User(login: 'root'), User(login: 'loading...')));
  Box<User> box = Hive.box<User>(BNames.users);
  Box serverInstallationBox = Hive.box(BNames.serverInstallation);

  final api = ServerApi();

  Future<void> load() async {
    if (serverInstallationCubit.state is ServerInstallationFinished) {
      var loadedUsers = box.values.toList();
      final primaryUser = serverInstallationBox.get(BNames.rootUser,
          defaultValue: User(login: 'loading...'));
      List<String> rootKeys = [
        ...serverInstallationBox.get(BNames.rootKeys, defaultValue: [])
      ];
      if (loadedUsers.isNotEmpty) {
        emit(UsersState(
            loadedUsers, User(login: 'root', sshKeys: rootKeys), primaryUser));
      }

      final usersFromServer = await api.getUsersList();
      if (usersFromServer.isSuccess) {
        final updatedList =
            mergeLocalAndServerUsers(loadedUsers, usersFromServer.data);
        emit(UsersState(
            updatedList, User(login: 'root', sshKeys: rootKeys), primaryUser));
      }

      final usersWithSshKeys = await loadSshKeys(state.users);
      // Update the users it the box
      box.clear();
      box.addAll(usersWithSshKeys);

      final rootUserWithSshKeys = (await loadSshKeys([state.rootUser])).first;
      serverInstallationBox.put(BNames.rootKeys, rootUserWithSshKeys.sshKeys);
      final primaryUserWithSshKeys =
          (await loadSshKeys([state.primaryUser])).first;
      serverInstallationBox.put(BNames.rootUser, primaryUserWithSshKeys);
      emit(UsersState(
          usersWithSshKeys, rootUserWithSshKeys, primaryUserWithSshKeys));
    }
  }

  List<User> mergeLocalAndServerUsers(
      List<User> localUsers, List<String> serverUsers) {
    // If local user not exists on server, add it with isFoundOnServer = false
    // If server user not exists on local, add it

    List<User> mergedUsers = [];
    List<String> serverUsersCopy = List.from(serverUsers);

    for (var localUser in localUsers) {
      if (serverUsersCopy.contains(localUser.login)) {
        mergedUsers.add(User(
          login: localUser.login,
          isFoundOnServer: true,
          password: localUser.password,
          sshKeys: localUser.sshKeys,
        ));
        serverUsersCopy.remove(localUser.login);
      } else {
        mergedUsers.add(User(
          login: localUser.login,
          isFoundOnServer: false,
          password: localUser.password,
          note: localUser.note,
        ));
      }
    }

    for (var serverUser in serverUsersCopy) {
      mergedUsers.add(User(
        login: serverUser,
        isFoundOnServer: true,
      ));
    }

    return mergedUsers;
  }

  Future<List<User>> loadSshKeys(List<User> users) async {
    List<User> updatedUsers = [];

    for (var user in users) {
      if (user.isFoundOnServer ||
          user.login == 'root' ||
          user.login == state.primaryUser.login) {
        final sshKeys = await api.getUserSshKeys(user);
        print('sshKeys for $user: ${sshKeys.data}');
        if (sshKeys.isSuccess) {
          updatedUsers.add(User(
            login: user.login,
            isFoundOnServer: true,
            password: user.password,
            sshKeys: sshKeys.data,
            note: user.note,
          ));
        } else {
          updatedUsers.add(User(
            login: user.login,
            isFoundOnServer: true,
            password: user.password,
            note: user.note,
          ));
        }
      } else {
        updatedUsers.add(User(
          login: user.login,
          isFoundOnServer: false,
          password: user.password,
          note: user.note,
        ));
      }
    }
    return updatedUsers;
  }

  Future<void> refresh() async {
    List<User> updatedUsers = List<User>.from(state.users);
    final usersFromServer = await api.getUsersList();
    if (usersFromServer.isSuccess) {
      updatedUsers =
          mergeLocalAndServerUsers(updatedUsers, usersFromServer.data);
    }
    final usersWithSshKeys = await loadSshKeys(updatedUsers);
    box.clear();
    box.addAll(usersWithSshKeys);
    final rootUserWithSshKeys = (await loadSshKeys([state.rootUser])).first;
    serverInstallationBox.put(BNames.rootKeys, rootUserWithSshKeys.sshKeys);
    final primaryUserWithSshKeys =
        (await loadSshKeys([state.primaryUser])).first;
    serverInstallationBox.put(BNames.rootUser, primaryUserWithSshKeys);
    emit(UsersState(
        usersWithSshKeys, rootUserWithSshKeys, primaryUserWithSshKeys));
    return;
  }

  Future<void> createUser(User user) async {
    // If user exists on server, do nothing
    if (state.users.any((u) => u.login == user.login && u.isFoundOnServer)) {
      return;
    }
    // If user is root or primary user, do nothing
    if (user.login == 'root' || user.login == state.primaryUser.login) {
      return;
    }
    // If API returned error, do nothing
    final result = await api.createUser(user);
    if (!result.isSuccess) {
      return;
    }

    var loadedUsers = List<User>.from(state.users);
    loadedUsers.add(result.data);
    await box.clear();
    await box.addAll(loadedUsers);
    emit(state.copyWith(users: loadedUsers));
  }

  Future<void> deleteUser(User user) async {
    // If user is primary or root, don't delete
    if (user.login == state.primaryUser.login || user.login == 'root') {
      return;
    }
    var loadedUsers = List<User>.from(state.users);
    final result = await api.deleteUser(user);
    if (result) {
      loadedUsers.removeWhere((u) => u.login == user.login);
      await box.clear();
      await box.addAll(loadedUsers);
      emit(state.copyWith(users: loadedUsers));
    }
  }

  Future<void> addSshKey(User user, String publicKey) async {
    // If adding root key, use api.addRootSshKey
    // Otherwise, use api.addUserSshKey
    if (user.login == 'root') {
      final result = await api.addRootSshKey(publicKey);
      if (result.isSuccess) {
        // Add ssh key to the array of root keys
        final rootKeys = serverInstallationBox
            .get(BNames.rootKeys, defaultValue: []) as List<String>;
        rootKeys.add(publicKey);
        serverInstallationBox.put(BNames.rootKeys, rootKeys);
        emit(state.copyWith(
          rootUser: User(
            login: state.rootUser.login,
            isFoundOnServer: true,
            password: state.rootUser.password,
            sshKeys: rootKeys,
            note: state.rootUser.note,
          ),
        ));
      }
    } else {
      final result = await api.addUserSshKey(user, publicKey);
      if (result.isSuccess) {
        // If it is primary user, update primary user
        if (user.login == state.primaryUser.login) {
          List<String> primaryUserKeys =
              List<String>.from(state.primaryUser.sshKeys);
          primaryUserKeys.add(publicKey);
          final updatedUser = User(
            login: state.primaryUser.login,
            isFoundOnServer: true,
            password: state.primaryUser.password,
            sshKeys: primaryUserKeys,
            note: state.primaryUser.note,
          );
          serverInstallationBox.put(BNames.rootUser, updatedUser);
          emit(state.copyWith(
            primaryUser: updatedUser,
          ));
        } else {
          // If it is not primary user, update user
          List<String> userKeys = List<String>.from(user.sshKeys);
          userKeys.add(publicKey);
          final updatedUser = User(
            login: user.login,
            isFoundOnServer: true,
            password: user.password,
            sshKeys: userKeys,
            note: user.note,
          );
          await box.putAt(box.values.toList().indexOf(user), updatedUser);
          emit(state.copyWith(
            users: box.values.toList(),
          ));
        }
      }
    }
  }

  Future<void> deleteSshKey(User user, String publicKey) async {
    // All keys are deleted via api.deleteUserSshKey

    final result = await api.deleteUserSshKey(user, publicKey);
    if (result.isSuccess) {
      // If it is root user, delete key from root keys
      // If it is primary user, update primary user
      // If it is not primary user, update user

      if (user.login == 'root') {
        final rootKeys = serverInstallationBox
            .get(BNames.rootKeys, defaultValue: []) as List<String>;
        rootKeys.remove(publicKey);
        serverInstallationBox.put(BNames.rootKeys, rootKeys);
        emit(state.copyWith(
          rootUser: User(
            login: state.rootUser.login,
            isFoundOnServer: true,
            password: state.rootUser.password,
            sshKeys: rootKeys,
            note: state.rootUser.note,
          ),
        ));
        return;
      }
      if (user.login == state.primaryUser.login) {
        List<String> primaryUserKeys =
            List<String>.from(state.primaryUser.sshKeys);
        primaryUserKeys.remove(publicKey);
        final updatedUser = User(
          login: state.primaryUser.login,
          isFoundOnServer: true,
          password: state.primaryUser.password,
          sshKeys: primaryUserKeys,
          note: state.primaryUser.note,
        );
        serverInstallationBox.put(BNames.rootUser, updatedUser);
        emit(state.copyWith(
          primaryUser: updatedUser,
        ));
        return;
      }
      List<String> userKeys = List<String>.from(user.sshKeys);
      userKeys.remove(publicKey);
      final updatedUser = User(
        login: user.login,
        isFoundOnServer: true,
        password: user.password,
        sshKeys: userKeys,
        note: user.note,
      );
      await box.putAt(box.values.toList().indexOf(user), updatedUser);
      emit(state.copyWith(
        users: box.values.toList(),
      ));
    }
  }

  @override
  void clear() async {
    emit(UsersState(<User>[], User(login: 'root'), User(login: 'loading...')));
  }
}
