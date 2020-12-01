part of 'services_cubit.dart';

@immutable
class ServicesState {
  ServicesState(this.all);

  final List<Service> all;

  ServicesState updateElement(Service service, ServiceStateType newState) {
    var newList = [...all];
    var index = newList.indexOf(service);
    newList[index] = service.updateState(newState);
    return ServicesState(newList);
  }

  List<Service> get connected => all
      .where((service) => service.state != ServiceStateType.uninitialized)
      .toList();

  List<Service> get uninitialized => all
      .where((service) => service.state == ServiceStateType.uninitialized)
      .toList();
}
