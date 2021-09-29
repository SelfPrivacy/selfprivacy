import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';

export 'package:selfprivacy/logic/cubit/app_config/app_config_cubit.dart';

part 'authentication_dependend_state.dart';

abstract class AppConfigDependendCubit<T extends AppConfigDependendState>
    extends Cubit<T> {
  AppConfigDependendCubit(
    this.appConfigCubit,
    T initState,
  ) : super(initState) {
    authCubitSubscription = appConfigCubit.stream.listen(checkAuthStatus);
    checkAuthStatus(appConfigCubit.state);
  }

  void checkAuthStatus(AppConfigState state) {
    if (state is AppConfigFinished) {
      load();
    } else if (state is AppConfigEmpty) {
      clear();
    }
  }

  late StreamSubscription authCubitSubscription;
  final AppConfigCubit appConfigCubit;

  void load();
  void clear();

  @override
  Future<void> close() {
    authCubitSubscription.cancel();
    return super.close();
  }
}
