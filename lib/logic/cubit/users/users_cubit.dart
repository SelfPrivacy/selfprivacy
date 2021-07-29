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

// final initMockUsers = <User>[
//   User(login: 'Heartbreaking.Goose', password: genPass()),
//   User(login: 'Alma.lawson', password: genPass()),
//   User(login: 'Bee.gees', password: genPass()),
//   User(login: 'Bim.jennings', password: genPass()),
//   User(login: 'Debra.holt', password: genPass()),
//   User(login: 'Georgia.young', password: genPass()),
//   User(login: 'Kenzi.lawson', password: genPass()),
//   User(login: 'Le.jennings', password: genPass()),
//   User(login: 'Kirill.Zh', password: genPass()),
//   User(login: 'Tina.Bolton', password: genPass()),
//   User(login: 'Rebekah.Lynn', password: genPass()),
//   User(login: 'Aleena.Armstrong', password: genPass()),
//   User(login: 'Rosemary.Williams', password: genPass()),
//   User(login: 'Sullivan.Nixon', password: genPass()),
//   User(login: 'Aleena.Armstrong', password: genPass()),
// ];
