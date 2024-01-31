import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:material_color_utilities/material_color_utilities.dart'
    as color_utils;
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/hive_config.dart';
import 'package:selfprivacy/theming/factory/app_theme_factory.dart';

export 'package:provider/provider.dart';

part 'app_settings_state.dart';

class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit({
    required final bool isDarkModeOn,
    required final bool isAutoDarkModeOn,
    required final bool isOnboardingShowing,
  }) : super(
          AppSettingsState(
            isDarkModeOn: isDarkModeOn,
            isAutoDarkModeOn: isAutoDarkModeOn,
            isOnboardingShowing: isOnboardingShowing,
          ),
        );

  Box box = Hive.box(BNames.appSettingsBox);

  void load() async {
    final bool? isDarkModeOn = box.get(BNames.isDarkModeOn);
    final bool? isAutoDarkModeOn = box.get(BNames.isAutoDarkModeOn);
    final bool? isOnboardingShowing = box.get(BNames.isOnboardingShowing);
    emit(
      state.copyWith(
        isDarkModeOn: isDarkModeOn,
        isAutoDarkModeOn: isAutoDarkModeOn,
        isOnboardingShowing: isOnboardingShowing,
      ),
    );
    WidgetsFlutterBinding.ensureInitialized();
    final color_utils.CorePalette? colorPalette =
        await AppThemeFactory.getCorePalette();
    emit(
      state.copyWith(
        corePalette: colorPalette,
      ),
    );
  }

  void updateDarkMode({required final bool isDarkModeOn}) {
    box.put(BNames.isDarkModeOn, isDarkModeOn);
    emit(state.copyWith(isDarkModeOn: isDarkModeOn));
  }

  void updateAutoDarkMode({required final bool isAutoDarkModeOn}) {
    box.put(BNames.isAutoDarkModeOn, isAutoDarkModeOn);
    emit(state.copyWith(isAutoDarkModeOn: isAutoDarkModeOn));
  }

  void turnOffOnboarding({final bool isOnboardingShowing = false}) {
    box.put(BNames.isOnboardingShowing, isOnboardingShowing);

    emit(state.copyWith(isOnboardingShowing: isOnboardingShowing));
  }
}
