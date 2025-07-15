part of 'app_settings.dart';

class _ThemePicker extends StatelessWidget {
  const _ThemePicker({super.key});

  @override
  Widget build(final BuildContext context) {
    final appController = InheritedAppController.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile.adaptive(
          title: Text('application_settings.system_theme_mode_title'.tr()),
          subtitle: Text(
            'application_settings.system_theme_mode_description'.tr(),
          ),
          value: appController.systemThemeModeActive,
          onChanged: appController.setSystemThemeModeFlag,
        ),
        SwitchListTile.adaptive(
          title: Text('application_settings.dark_theme_title'.tr()),
          subtitle: Text('application_settings.change_application_theme'.tr()),
          value: appController.darkThemeModeActive,
          onChanged:
              appController.systemThemeModeActive
                  ? null
                  : appController.setDarkThemeModeFlag,
        ),
      ],
    );
  }
}
