import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:selfprivacy/logic/models/service.dart';
import 'package:selfprivacy/logic/models/state_types.dart';

export 'package:provider/provider.dart';
export 'package:selfprivacy/logic/models/state_types.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesState(all));

  void connect(Service service) {
    var newState = state.updateElement(service, StateType.stable);
    emit(newState);
  }
}

final all = ServiceTypes.values
    .map(
      (type) => Service(
        state: StateType.uninitialized,
        type: type,
      ),
    )
    .toList();
