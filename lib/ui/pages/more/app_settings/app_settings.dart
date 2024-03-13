import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/app_settings/app_settings_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/ui/components/buttons/dialog_action_button.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';

@RoutePage()
class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(final BuildContext context) {
    final bool isDarkModeOn =
        context.watch<AppSettingsCubit>().state.isDarkModeOn;

    final bool isSystemDarkModeOn =
        context.watch<AppSettingsCubit>().state.isAutoDarkModeOn;

    return BrandHeroScreen(
      hasBackButton: true,
      hasFlashButton: false,
      bodyPadding: const EdgeInsets.symmetric(vertical: 16),
      heroTitle: 'application_settings.title'.tr(),
      children: [
        SwitchListTile.adaptive(
          title: Text('application_settings.system_dark_theme_title'.tr()),
          subtitle:
              Text('application_settings.system_dark_theme_description'.tr()),
          value: isSystemDarkModeOn,
          onChanged: (final value) => context
              .read<AppSettingsCubit>()
              .updateAutoDarkMode(isAutoDarkModeOn: !isSystemDarkModeOn),
        ),
        SwitchListTile.adaptive(
          title: Text('application_settings.dark_theme_title'.tr()),
          subtitle: Text('application_settings.dark_theme_description'.tr()),
          value: Theme.of(context).brightness == Brightness.dark,
          onChanged: isSystemDarkModeOn
              ? null
              : (final value) => context
                  .read<AppSettingsCubit>()
                  .updateDarkMode(isDarkModeOn: !isDarkModeOn),
        ),
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'application_settings.dangerous_settings'.tr(),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
        const _ResetAppTile(),
        // const Divider(height: 0),
        _deleteServer(context),
      ],
    );
  }

  Widget _deleteServer(final BuildContext context) {
    final bool isDisabled =
        context.watch<ServerInstallationCubit>().state.serverDetails == null;
    return ListTile(
      title: Text('application_settings.delete_server_title'.tr()),
      subtitle: Text('application_settings.delete_server_description'.tr()),
      textColor: isDisabled
          ? Theme.of(context).colorScheme.onBackground.withOpacity(0.5)
          : Theme.of(context).colorScheme.onBackground,
      onTap: isDisabled
          ? null
          : () {
              showDialog(
                context: context,
                builder: (final _) => AlertDialog(
                  title: Text('modals.are_you_sure'.tr()),
                  content: Text('modals.delete_server_volume'.tr()),
                  actions: [
                    DialogActionButton(
                      text: 'modals.yes'.tr(),
                      isRed: true,
                      onPressed: () async {
                        unawaited(
                          showDialog(
                            context: context,
                            builder: (final context) => Container(
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(),
                            ),
                          ),
                        );
                        await context
                            .read<ServerInstallationCubit>()
                            .serverDelete();
                        if (!mounted) {
                          return;
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                    DialogActionButton(
                      text: 'basis.cancel'.tr(),
                    ),
                  ],
                ),
              );
            },
    );
  }
}

class _ResetAppTile extends StatelessWidget {
  const _ResetAppTile();

  @override
  Widget build(final BuildContext context) => ListTile(
        title: Text('application_settings.reset_config_title'.tr()),
        subtitle: Text('application_settings.reset_config_description'.tr()),
        onTap: () {
          showDialog(
            context: context,
            builder: (final _) => AlertDialog(
              title: Text('modals.are_you_sure'.tr()),
              content: Text('modals.purge_all_keys'.tr()),
              actions: [
                DialogActionButton(
                  text: 'modals.purge_all_keys_confirm'.tr(),
                  isRed: true,
                  onPressed: () {
                    context.read<ServerInstallationCubit>().clearAppConfig();
                    Navigator.of(context).pop();
                  },
                ),
                DialogActionButton(
                  text: 'basis.cancel'.tr(),
                ),
              ],
            ),
          );
        },
      );
}
