import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/cubit/server_detailed_info/server_detailed_info_cubit.dart';
import 'package:selfprivacy/logic/models/job.dart';
import 'package:selfprivacy/ui/atoms/progress_indicators/brand_loader.dart';
import 'package:selfprivacy/ui/layouts/brand_hero_screen.dart';
import 'package:selfprivacy/ui/router/router.dart';
import 'package:selfprivacy/utils/breakpoints.dart';
import 'package:selfprivacy/utils/extensions/duration.dart';
import 'package:timezone/timezone.dart';

part 'select_timezone.dart';

@RoutePage()
class ServerSettingsPage extends StatefulWidget {
  const ServerSettingsPage({super.key});

  @override
  State<ServerSettingsPage> createState() => _ServerSettingsPageState();
}

class _ServerSettingsPageState extends State<ServerSettingsPage> {
  @override
  Widget build(final BuildContext context) => BrandHeroScreen(
    hasFlashButton: true,
    heroIcon: Icons.settings_outlined,
    heroTitle: 'server.settings'.tr(),
    children: const [_ServerSettings()],
  );
}

class _ServerSettings extends StatefulWidget {
  const _ServerSettings();

  @override
  State<_ServerSettings> createState() => _ServerSettingsState();
}

class _ServerSettingsState extends State<_ServerSettings> {
  bool? allowAutoUpgrade;
  bool? rebootAfterUpgrade;
  bool? enableSsh;

  @override
  Widget build(final BuildContext context) {
    final serverDetailsState = context.watch<ServerDetailsCubit>().state;
    if (serverDetailsState is ServerDetailsNotReady) {
      return Text('basis.loading'.tr());
    } else if (serverDetailsState is! Loaded) {
      return BrandLoader.horizontal();
    }
    if (allowAutoUpgrade == null || rebootAfterUpgrade == null) {
      allowAutoUpgrade = serverDetailsState.autoUpgradeSettings.enable;
      rebootAfterUpgrade = serverDetailsState.autoUpgradeSettings.allowReboot;
    }

    enableSsh ??= serverDetailsState.sshSettings.enable;

    return Column(
      children: [
        SwitchListTile.adaptive(
          value: allowAutoUpgrade ?? false,
          onChanged: (final switched) {
            context.read<JobsCubit>().addJob(
              ChangeAutoUpgradeSettingsJob(
                allowReboot: rebootAfterUpgrade ?? false,
                enable: switched,
              ),
            );
            setState(() {
              allowAutoUpgrade = switched;
            });
          },
          title: Text(
            'server.allow_autoupgrade'.tr(),
            style: TextStyle(
              fontStyle:
                  allowAutoUpgrade !=
                          serverDetailsState.autoUpgradeSettings.enable
                      ? FontStyle.italic
                      : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.allow_autoupgrade_hint'.tr(),
            style: TextStyle(
              fontStyle:
                  allowAutoUpgrade !=
                          serverDetailsState.autoUpgradeSettings.enable
                      ? FontStyle.italic
                      : FontStyle.normal,
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        SwitchListTile.adaptive(
          value: rebootAfterUpgrade ?? false,
          onChanged: (final switched) {
            context.read<JobsCubit>().addJob(
              ChangeAutoUpgradeSettingsJob(
                allowReboot: switched,
                enable: allowAutoUpgrade ?? false,
              ),
            );
            setState(() {
              rebootAfterUpgrade = switched;
            });
          },
          title: Text(
            'server.reboot_after_upgrade'.tr(),
            style: TextStyle(
              fontStyle:
                  rebootAfterUpgrade !=
                          serverDetailsState.autoUpgradeSettings.allowReboot
                      ? FontStyle.italic
                      : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.reboot_after_upgrade_hint'.tr(),
            style: TextStyle(
              fontStyle:
                  rebootAfterUpgrade !=
                          serverDetailsState.autoUpgradeSettings.allowReboot
                      ? FontStyle.italic
                      : FontStyle.normal,
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        ListTile(
          title: Text('server.server_timezone'.tr()),
          subtitle: Text(serverDetailsState.serverTimezone.toString()),
          onTap: () async {
            await context.pushRoute(const SelectTimezoneRoute());
          },
        ),
        SwitchListTile.adaptive(
          value: enableSsh ?? true,
          onChanged: (final switched) {
            context.read<JobsCubit>().addJob(
              ChangeSshSettingsJob(enable: switched),
            );
            setState(() {
              enableSsh = switched;
            });
          },
          title: Text(
            'server.enable_ssh'.tr(),
            style: TextStyle(
              fontStyle:
                  enableSsh != serverDetailsState.sshSettings.enable
                      ? FontStyle.italic
                      : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.enable_ssh_hint'.tr(),
            style: TextStyle(
              fontStyle:
                  enableSsh != serverDetailsState.sshSettings.enable
                      ? FontStyle.italic
                      : FontStyle.normal,
            ),
          ),
          activeColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}
