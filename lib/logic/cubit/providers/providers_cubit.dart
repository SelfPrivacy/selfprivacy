import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/provider.dart';
import 'package:selfprivacy/logic/models/state_types.dart';

export 'package:selfprivacy/logic/models/state_types.dart';
export 'package:provider/provider.dart';

part 'providers_state.dart';

class ProvidersCubit extends Cubit<ProvidersState> {
  ProvidersCubit() : super(ProvidersState(all));

  void connect(ProviderModel provider) {
    var newState = state.updateElement(provider, StateType.stable);
    emit(newState);
  }
}

final all = ProviderType.values
    .map(
      (type) => ProviderModel(
        state: StateType.uninitialized,
        type: type,
      ),
    )
    .toList();
