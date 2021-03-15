import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/state_types.dart';

enum ServiceTypes {
  messanger,
  mail,
  passwordManager,
  github,
  cloud,
}

class Service extends Equatable {
  const Service({required this.state, required this.type});

  final StateType state;
  final ServiceTypes type;

  Service updateState(StateType newState) => Service(
        state: newState,
        type: type,
      );

  @override
  List<Object?> get props => [state, type];
}
