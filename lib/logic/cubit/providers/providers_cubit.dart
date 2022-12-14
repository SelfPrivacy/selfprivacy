import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/models/provider.dart';
import 'package:selfprivacy/logic/models/state_types.dart';

export 'package:selfprivacy/logic/models/state_types.dart';
export 'package:provider/provider.dart';

part 'providers_state.dart';

class ProvidersCubit extends Cubit<ProvidersState> {
  ProvidersCubit() : super(InitialProviderState());

  void connect(final ProviderModel provider) {
    final ProvidersState newState =
        state.updateElement(provider, StateType.stable);
    emit(newState);
  }
}
