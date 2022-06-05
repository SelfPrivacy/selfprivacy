// ignore_for_file: always_specify_types

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';

export 'package:provider/provider.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    required final bool isDarkModeOn,
    required final bool isOnboardingShowing,
  }) : super(
          AppSettingsState(
            isDarkModeOn: isDarkModeOn,
            isOnboardingShowing: isOnboardingShowing,
          ),
        );

  Box box = Hive.box(BNames.appSettingsBox);

  void load() {
    final bool? isDarkModeOn = box.get(BNames.isDarkModeOn);
    final bool? isOnboardingShowing = box.get(BNames.isOnboardingShowing);
    emit(state.copyWith(
      isDarkModeOn: isDarkModeOn,
      isOnboardingShowing: isOnboardingShowing,
    ),);
  }

  void updateDarkMode({required final bool isDarkModeOn}) {
    box.put(BNames.isDarkModeOn, isDarkModeOn);
    emit(state.copyWith(isDarkModeOn: isDarkModeOn));
  }

  void turnOffOnboarding() {
    box.put(BNames.isOnboardingShowing, false);

    emit(state.copyWith(isOnboardingShowing: false));
  }
}
