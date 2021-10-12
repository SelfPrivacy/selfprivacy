import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/logic/models/user.dart';
export 'package:provider/provider.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersState(<User>[]));
  Box<User> box = Hive.box<User>(BNames.users);

  void load() async {
    var loadedUsers = box.values.toList();
   
    if (loadedUsers.isNotEmpty) {
      emit(UsersState(loadedUsers));
    }
  }

  void addUsers(List<User> users) async {
    var newUserList = <User>[...state.users, ...users];

    await box.addAll(users);
    emit(UsersState(newUserList));
  }

  void remove(User user) async {
    var users = [...state.users];
    var index = users.indexOf(user);
    users.remove(user);
    await box.deleteAt(index);

    emit(UsersState(users));
  }
}
