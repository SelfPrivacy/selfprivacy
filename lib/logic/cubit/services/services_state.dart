part of 'services_cubit.dart';

@immutable
class ServicesState extends Equatable{
  ServicesState(this.all);

  final List<Service> all;

  ServicesState updateElement(Service service, StateType newState) {
    var newList = [...all];
    var index = newList.indexOf(service);
    newList[index] = service.updateState(newState);
    return ServicesState(newList);
  }

  List<Service> get connected => all
      .where((service) => service.state != StateType.uninitialized)
      .toList();

  List<Service> get uninitialized => all
      .where((service) => service.state == StateType.uninitialized)
      .toList();

  @override
  List<Object> get props => all;
}
