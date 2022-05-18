import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:selfprivacy/config/hive_config.dart';

export 'package:provider/provider.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    required bool isDarkModeOn,
    required bool isOnboardingShowing,
  }) : super(
          AppSettingsState(
            isDarkModeOn: isDarkModeOn,
            isOnboardingShowing: isOnboardingShowing,
          ),
        );

  Box box = Hive.box(BNames.appSettingsBox);

  void load() {
    bool? isDarkModeOn = box.get(BNames.isDarkModeOn);
    bool? isOnboardingShowing = box.get(BNames.isOnboardingShowing);
    emit(state.copyWith(
      isDarkModeOn: isDarkModeOn,
      isOnboardingShowing: isOnboardingShowing,
    ));
  }

  void updateDarkMode({required bool isDarkModeOn}) {
    box.put(BNames.isDarkModeOn, isDarkModeOn);
    emit(state.copyWith(isDarkModeOn: isDarkModeOn));
  }

  void turnOffOnboarding() {
    box.put(BNames.isOnboardingShowing, false);

    emit(state.copyWith(isOnboardingShowing: false));
  }
}
