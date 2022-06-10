part of 'providers_cubit.dart';

class ProvidersState extends Equatable {
  const ProvidersState(this.all);

  final List<ProviderModel> all;

  ProvidersState updateElement(
    final ProviderModel provider,
    final StateType newState,
  ) {
    final List<ProviderModel> newList = [...all];
    final int index = newList.indexOf(provider);
    newList[index] = provider.updateState(newState);
    return ProvidersState(newList);
  }

  List<ProviderModel> get connected => all
      .where((final service) => service.state != StateType.uninitialized)
      .toList();

  List<ProviderModel> get uninitialized => all
      .where((final service) => service.state == StateType.uninitialized)
      .toList();

  bool get isFullyInitialized => uninitialized.isEmpty;

  @override
  List<Object> get props => all;
}

class InitialProviderState extends ProvidersState {
  InitialProviderState()
      : super(
          ProviderType.values
              .map(
                (final type) => ProviderModel(
                  state: StateType.uninitialized,
                  type: type,
                ),
              )
              .toList(),
        );
}
