import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selfprivacy/config/get_it_config.dart';

export 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

part 'server_connection_dependent_state.dart';

abstract class ServerConnectionDependentCubit<
    T extends ServerInstallationDependendState> extends Cubit<T> {
  ServerConnectionDependentCubit(
    super.initState,
  ) {
    final connectionRepository = getIt<ApiConnectionRepository>();

    apiStatusSubscription =
        connectionRepository.connectionStatusStream.listen(checkAuthStatus);
    checkAuthStatus(connectionRepository.connectionStatus);
  }

  void checkAuthStatus(final ConnectionStatus state) {
    switch (state) {
      case ConnectionStatus.nonexistent:
        clear();
        isLoaded = false;
        break;
      case ConnectionStatus.connected:
        if (!isLoaded) {
          load();
          isLoaded = true;
        }
        break;
      default:
        break;
    }
  }

  late StreamSubscription apiStatusSubscription;
  bool isLoaded = false;

  void load();
  void clear();

  @override
  Future<void> close() {
    apiStatusSubscription.cancel();
    return super.close();
  }
}
