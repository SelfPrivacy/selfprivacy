import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
export 'package:provider/provider.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    bool isDarkModeOn,
  }) : super(
          AppSettingsState(isDarkModeOn: isDarkModeOn),
        );

  void update({@required bool isDarkModeOn}) {
    emit(AppSettingsState(isDarkModeOn: isDarkModeOn));
  }
}
