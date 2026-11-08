import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/logic/bloc/server_settings/server_settings_bloc.dart';
import 'package:selfprivacy/logic/connection/cache/cached_value.dart';
import 'package:selfprivacy/logic/cubit/client_jobs/client_jobs_cubit.dart';
import 'package:selfprivacy/logic/models/job_draft.dart';
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

class _ServerSettings extends StatelessWidget {
  const _ServerSettings();

  @override
  Widget build(final BuildContext context) {
    final bloc = context.read<ServerSettingsBloc>();
    final serverDetailsState = context.watch<ServerSettingsBloc>().state;
    final snapshot = serverDetailsState.settings;
    if (serverDetailsState is ServerSettingsDetached) {
      return Text('basis.loading'.tr());
    }
    if (snapshot.support == DomainSupport.unsupported ||
        (snapshot.data == null && snapshot.lastError != null)) {
      return Text(
        (snapshot.support == DomainSupport.unsupported
                ? 'basis.feature_unsupported'
                : 'basis.network_error')
            .tr(),
      );
    }
    if (snapshot.data == null) {
      return BrandLoader.horizontal();
    }
    final allowAutoUpgrade = serverDetailsState.autoUpgrade!;
    final rebootAfterUpgrade = serverDetailsState.allowReboot!;
    final enableSsh = serverDetailsState.sshEnabled!;

    return Column(
      children: [
        SwitchListTile.adaptive(
          value: allowAutoUpgrade,
          onChanged: serverDetailsState.canEditSettings
              ? (final switched) =>
                    bloc.add(AutoUpgradeChanged(enabled: switched))
              : null,
          title: Text(
            'server.allow_autoupgrade'.tr(),
            style: TextStyle(
              fontStyle:
                  allowAutoUpgrade != snapshot.data!.autoUpgradeSettings.enable
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.allow_autoupgrade_hint'.tr(),
            style: TextStyle(
              fontStyle:
                  allowAutoUpgrade != snapshot.data!.autoUpgradeSettings.enable
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
        ),
        SwitchListTile.adaptive(
          value: rebootAfterUpgrade,
          onChanged: serverDetailsState.canEditSettings
              ? (final switched) =>
                    bloc.add(RebootAfterUpgradeChanged(enabled: switched))
              : null,
          title: Text(
            'server.reboot_after_upgrade'.tr(),
            style: TextStyle(
              fontStyle:
                  rebootAfterUpgrade !=
                      snapshot.data!.autoUpgradeSettings.allowReboot
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.reboot_after_upgrade_hint'.tr(),
            style: TextStyle(
              fontStyle:
                  rebootAfterUpgrade !=
                      snapshot.data!.autoUpgradeSettings.allowReboot
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
        ),
        ListTile(
          title: Text('server.server_timezone'.tr()),
          subtitle: Text(serverDetailsState.timezone!),
          onTap: serverDetailsState.canEditSettings
              ? () async {
                  await context.pushRoute(const SelectTimezoneRoute());
                }
              : null,
        ),
        SwitchListTile.adaptive(
          value: enableSsh,
          onChanged: serverDetailsState.canEditSettings
              ? (final switched) =>
                    bloc.add(SshSettingChanged(enabled: switched))
              : null,
          title: Text(
            'server.enable_ssh'.tr(),
            style: TextStyle(
              fontStyle: enableSsh != snapshot.data!.sshSettings.enable
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
          subtitle: Text(
            'server.enable_ssh_hint'.tr(),
            style: TextStyle(
              fontStyle: enableSsh != snapshot.data!.sshSettings.enable
                  ? FontStyle.italic
                  : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}
