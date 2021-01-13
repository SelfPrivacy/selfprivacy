import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';
export 'package:provider/provider.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    @required bool isDarkModeOn,
    @required bool isOnbordingShowing,
  }) : super(
          AppSettingsState(
            isDarkModeOn: isDarkModeOn,
            isOnbordingShowing: isOnbordingShowing,
          ),
        );

  Box box = Hive.box(BNames.appSettings);

  void load() {
    bool isDarkModeOn = box.get(BNames.isDarkModeOn);
    bool isOnbordingShowing = box.get(BNames.isOnbordingShowing);
    emit(state.copyWith(
      isDarkModeOn: isDarkModeOn,
      isOnbordingShowing: isOnbordingShowing,
    ));
  }

  void updateDarkMode({@required bool isDarkModeOn}) {
    box.put(BNames.isDarkModeOn, isDarkModeOn);

    emit(state.copyWith(isDarkModeOn: isDarkModeOn));
  }

  void turnOffOnboarding() {
    box.put(BNames.isOnbordingShowing, false);

    emit(state.copyWith(isOnbordingShowing: false));
  }
}
