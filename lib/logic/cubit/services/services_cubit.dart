import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:selfprivacy/logic/models/service.dart';
export 'package:provider/provider.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesState(all));

  void connect(Service service) {
    var newState = state.updateElement(service, ServiceStateType.stable);
    emit(newState);
  }
}

final all = ServiceTypes.values
    .map(
      (type) => Service(
        state: ServiceStateType.uninitialized,
        type: type,
      ),
    )
    .toList();
