import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:selfprivacy/config/brand_colors.dart';
import 'package:selfprivacy/config/get_it_config.dart';
import 'package:selfprivacy/logic/cubit/server_installation/server_installation_cubit.dart';
import 'package:selfprivacy/logic/cubit/backups/backups_cubit.dart';
import 'package:selfprivacy/logic/models/json/backup.dart';
import 'package:selfprivacy/logic/models/state_types.dart';
import 'package:selfprivacy/ui/components/action_button/action_button.dart';
import 'package:selfprivacy/ui/components/brand_alert/brand_alert.dart';
import 'package:selfprivacy/ui/components/brand_button/brand_button.dart';
import 'package:selfprivacy/ui/components/brand_hero_screen/brand_hero_screen.dart';
import 'package:selfprivacy/ui/components/brand_icons/brand_icons.dart';
import 'package:selfprivacy/ui/components/brand_text/brand_text.dart';

import '../../components/brand_cards/brand_cards.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class BackupDetails extends StatefulWidget {
  const BackupDetails({Key? key}) : super(key: key);

  @override
  _BackupDetailsState createState() => _BackupDetailsState();
}

class _BackupDetailsState extends State<BackupDetails>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var isReady = context.watch<ServerInstallationCubit>().state
        is ServerInstallationFinished;
    var isBackupInitialized = context.watch<BackupsCubit>().state.isInitialized;
    var backupStatus = context.watch<BackupsCubit>().state.status;
    var providerState = isReady && isBackupInitialized
        ? (backupStatus == BackupStatusEnum.error
            ? StateType.warning
            : StateType.stable)
        : StateType.uninitialized;
    var preventActions = context.watch<BackupsCubit>().state.preventActions;
    var backupProgress = context.watch<BackupsCubit>().state.progress;
    var backupError = context.watch<BackupsCubit>().state.error;
    var backups = context.watch<BackupsCubit>().state.backups;
    var refreshing = context.watch<BackupsCubit>().state.refreshing;

    return BrandHeroScreen(
      heroIcon: BrandIcons.save,
      heroTitle: 'providers.backup.card_title'.tr(),
      heroSubtitle: 'providers.backup.bottom_sheet.1'.tr(),
      children: [
        if (isReady && !isBackupInitialized)
          BrandButton.rised(
            onPressed: preventActions
                ? null
                : () async {
                    await context.read<BackupsCubit>().createBucket();
                  },
            text: 'providers.backup.initialize'.tr(),
          ),
        if (backupStatus == BackupStatusEnum.initializing)
          BrandText.body1('providers.backup.waitingForRebuild'.tr()),
        if (backupStatus != BackupStatusEnum.initializing &&
            backupStatus != BackupStatusEnum.noKey)
          BrandCards.outlined(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (backupStatus == BackupStatusEnum.initialized)
                  ListTile(
                    onTap: preventActions
                        ? null
                        : () async {
                            await context.read<BackupsCubit>().createBackup();
                          },
                    leading: const Icon(
                      Icons.add_circle_outline_rounded,
                    ),
                    title: Text(
                      'providers.backup.create_new'.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                if (backupStatus == BackupStatusEnum.backingUp)
                  ListTile(
                    title: Text(
                      'providers.backup.creating'.tr(
                          args: [(backupProgress * 100).round().toString()]),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: LinearProgressIndicator(
                      value: backupProgress,
                      backgroundColor: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                if (backupStatus == BackupStatusEnum.restoring)
                  ListTile(
                    title: Text(
                      'providers.backup.restoring'.tr(
                          args: [(backupProgress * 100).round().toString()]),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: LinearProgressIndicator(
                      backgroundColor: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                if (backupStatus == BackupStatusEnum.error)
                  ListTile(
                    leading: const Icon(
                      Icons.error_outline,
                      color: BrandColors.red1,
                    ),
                    title: Text(
                      'providers.backup.error_pending'.tr(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        // Card with a list of existing backups
        // Each list item has a date
        // When clicked, starts the restore action
        if (backupStatus != BackupStatusEnum.initializing &&
            backupStatus != BackupStatusEnum.noKey)
          BrandCards.outlined(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.refresh,
                  ),
                  title: Text(
                    'providers.backup.restore'.tr(),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                const Divider(
                  height: 1.0,
                ),
                if (backups.isEmpty)
                  ListTile(
                    leading: const Icon(
                      Icons.error_outline,
                    ),
                    title: Text('providers.backup.no_backups'.tr()),
                  ),
                if (backups.isNotEmpty)
                  Column(
                    children: backups.map((backup) {
                      return ListTile(
                        onTap: preventActions
                            ? null
                            : () {
                                var nav = getIt<NavigationService>();
                                nav.showPopUpDialog(BrandAlert(
                                  title: 'providers.backup.restoring'.tr(),
                                  contentText: 'providers.backup.restore_alert'
                                      .tr(args: [backup.time.toString()]),
                                  actions: [
                                    ActionButton(
                                      text: 'basis.cancel'.tr(),
                                    ),
                                    ActionButton(
                                      onPressed: () => {
                                        context
                                            .read<BackupsCubit>()
                                            .restoreBackup(backup.id)
                                      },
                                      text: 'modals.yes'.tr(),
                                    )
                                  ],
                                ));
                              },
                        title: Text(
                          '${MaterialLocalizations.of(context).formatShortDate(backup.time)} ${TimeOfDay.fromDateTime(backup.time).format(context)}',
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        BrandCards.outlined(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'providers.backup.refresh'.tr(),
                ),
                onTap: refreshing
                    ? null
                    : () => {context.read<BackupsCubit>().updateBackups()},
                enabled: !refreshing,
              ),
              if (providerState != StateType.uninitialized)
                Column(
                  children: [
                    const Divider(
                      height: 1.0,
                    ),
                    ListTile(
                      title: Text(
                        'providers.backup.refetchBackups'.tr(),
                      ),
                      onTap: preventActions
                          ? null
                          : () => {
                                context
                                    .read<BackupsCubit>()
                                    .forceUpdateBackups()
                              },
                    ),
                    const Divider(
                      height: 1.0,
                    ),
                    ListTile(
                      title: Text(
                        'providers.backup.reuploadKey'.tr(),
                      ),
                      onTap: preventActions
                          ? null
                          : () => {context.read<BackupsCubit>().reuploadKey()},
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (backupStatus == BackupStatusEnum.error)
          BrandText.body1(backupError.toString()),
      ],
    );
  }
}
