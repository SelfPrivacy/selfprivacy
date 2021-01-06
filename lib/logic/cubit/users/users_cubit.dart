import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/user.dart';
export 'package:provider/provider.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersState([]));

  void add(User user) {
    var users = state.users;
    users.add(user);

    emit(UsersState(users));
  }

  void remove(User user) {
    var users = state.users;
    users.remove(user);

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
