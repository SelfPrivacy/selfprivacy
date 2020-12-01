import 'package:equatable/equatable.dart';

enum ServiceStateType { uninitialized, stable, warning }
enum ServiceTypes {
  messanger,
  mail,
  passwordManager,
  backup,
  github,
  cloud,
}

class Service extends Equatable {
  const Service({this.state, this.type});

  final ServiceStateType state;
  final ServiceTypes type;

  Service updateState(ServiceStateType newState) => Service(
        state: newState,
        type: type,
      );

  @override
  List<Object> get props => [state, type];
}
