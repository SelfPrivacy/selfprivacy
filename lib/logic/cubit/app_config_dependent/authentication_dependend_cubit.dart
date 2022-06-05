// ignore_for_file: always_specify_types

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

export 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';

part 'authentication_dependend_state.dart';

abstract class ServerInstallationDependendCubit<
    T extends ServerInstallationDependendState> extends Cubit<T> {
  ServerInstallationDependendCubit(
    this.serverInstallationCubit,
    final T initState,
  ) : super(initState) {
    authCubitSubscription =
        serverInstallationCubit.stream.listen(checkAuthStatus);
    checkAuthStatus(serverInstallationCubit.state);
  }

  void checkAuthStatus(final ServerInstallationState state) {
    if (state is ServerInstallationFinished) {
      load();
    } else if (state is ServerInstallationEmpty) {
      clear();
    }
  }

  late StreamSubscription authCubitSubscription;
  final ServerInstallationCubit serverInstallationCubit;

  void load();
  void clear();

  @override
  Future<void> close() {
    authCubitSubscription.cancel();
    return super.close();
  }
}
